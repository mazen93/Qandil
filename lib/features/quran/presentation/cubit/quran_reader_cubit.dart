import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/result/result.dart';
import '../../data/repositories/quran_bundled_seed_loader.dart';
import '../../data/repositories/quran_local_repository_impl.dart';
import '../../domain/entities/quran_entities.dart';
import '../../domain/repositories/quran_repository.dart';
import '../../domain/services/arabic_search_normalizer.dart';
import 'quran_reader_state.dart';

/// Cubit coordinating the Phase 3 Quran Reader:
/// - Mushaf page view & Verse list view
/// - Navigation by Surah, Juz, Page, and Jump to Page
/// - Automatic saving & restoring of reading position in Drift (`reading_progress`)
/// - Khatmah planner calculation & persistence
/// - Verse inspection (Tafsir, Translation, Word-by-Word, Colored Bookmarks, Personal Notes)
/// - Normalized Arabic search (matching-only, never altering displayed text)
class QuranReaderCubit extends Cubit<QuranReaderState> {
  QuranReaderCubit({
    required QuranRepository repository,
    required AppDatabase database,
    QuranLocalRepositoryImpl? localRepository,
    this.enableBundledSeed = true,
  })  : _repository = repository,
        _database = database,
        _localRepository = localRepository,
        super(const QuranReaderState());

  final QuranRepository _repository;
  final AppDatabase _database;
  final QuranLocalRepositoryImpl? _localRepository;
  final bool enableBundledSeed;

  /// Initializes the reader: seeds bundled pre-production data if empty, restores
  /// the saved reading position from Drift, and loads chapters, catalogs, bookmarks, and current page verses.
  Future<void> initialize() async {
    emit(state.copyWith(isLoading: true));

    if (enableBundledSeed && _localRepository != null) {
      await QuranBundledSeedLoader.seedIfEmpty(_localRepository);
    }

    final savedProgress = await _database.getOrCreateReadingProgress();
    final bookmarksMap = await _loadBookmarksMap();

    final chaptersResult = await _repository.getChapters();
    final chapters = switch (chaptersResult) {
      Success(:final value) => value,
      FailureResult() => const <QuranChapter>[],
    };

    final tafsirListResult = await _repository.getTafsirList();
    final tafsirs = switch (tafsirListResult) {
      Success(:final value) => value,
      FailureResult() => const <TafsirResource>[],
    };

    final translationListResult =
        await _repository.getTranslationList(languageCode: 'en');
    final translations = switch (translationListResult) {
      Success(:final value) => value,
      FailureResult() => const <TranslationResource>[],
    };

    emit(
      state.copyWith(
        chapters: chapters,
        tafsirCatalog: tafsirs,
        translationCatalog: translations,
        bookmarksByVerseKey: bookmarksMap,
        currentSurahNumber: savedProgress.surahNumber,
        currentAyahNumber: savedProgress.ayahNumber,
        currentPageNumber: savedProgress.pageNumber,
        currentJuzNumber: savedProgress.juzNumber,
        khatmahTargetDays: savedProgress.khatmahTargetDays,
        khatmahStartDate: savedProgress.khatmahStartDate,
      ),
    );

    await goToPage(
      savedProgress.pageNumber,
      persistPosition: false,
    );
  }

  /// Switches between Mushaf Page View and Verse List View.
  void setViewMode(QuranReaderViewMode mode) {
    emit(state.copyWith(viewMode: mode));
  }

  /// Navigates to a specific Mushaf [pageNumber] (1..604) and automatically persists the reading position.
  Future<void> goToPage(
    int pageNumber, {
    bool persistPosition = true,
  }) async {
    final targetPage = pageNumber.clamp(1, 604);
    emit(state.copyWith(isLoading: true, currentPageNumber: targetPage));

    final result = await _repository.getVersesByPage(
      targetPage,
      includeWords: true,
      translationIds: [state.selectedTranslationId],
    );

    switch (result) {
      case Success(:final value):
        final firstVerse = value.isNotEmpty ? value.first : null;
        final surahNum = firstVerse?.chapterId ?? state.currentSurahNumber;
        final ayahNum = firstVerse?.verseNumber ?? 1;
        final juzNum = firstVerse?.juzNumber ?? state.currentJuzNumber;

        if (persistPosition) {
          await _database.saveReadingPosition(
            surahNumber: surahNum,
            ayahNumber: ayahNum,
            pageNumber: targetPage,
            juzNumber: juzNum,
          );
        }

        emit(
          state.copyWith(
            isLoading: false,
            currentPageVerses: value,
            currentSurahNumber: surahNum,
            currentAyahNumber: ayahNum,
            currentPageNumber: targetPage,
            currentJuzNumber: juzNum,
          ),
        );
      case FailureResult(:final failure):
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ),
        );
    }
  }

  /// Navigates to the starting page of [surahNumber] (or loads its verses directly).
  Future<void> goToSurah(int surahNumber) async {
    QuranChapter? matched;
    for (final c in state.chapters) {
      if (c.id == surahNumber) {
        matched = c;
        break;
      }
    }
    final targetPage = matched?.startPage ?? (surahNumber == 1 ? 1 : 2);
    await goToPage(targetPage);
  }

  /// Navigates to a specific [juzNumber] (1..30).
  Future<void> goToJuz(int juzNumber) async {
    final clampedJuz = juzNumber.clamp(1, 30);
    // Standard Madani Mushaf Juz start page formula: Juz 1 = p.1, Juz 2 = p.22, Juz N = (N-1)*20 + 2
    final approxPage = clampedJuz == 1 ? 1 : ((clampedJuz - 1) * 20 + 2);
    await goToPage(approxPage);
  }

  /// Updates and persists the user's Khatmah plan (`targetDays`).
  Future<void> updateKhatmahPlan({
    required int targetDays,
    DateTime? startDate,
  }) async {
    final clampedDays = targetDays.clamp(1, 365);
    final effectiveStart =
        startDate ?? state.khatmahStartDate ?? DateTime.now().toUtc();
    final updated = await _database.saveKhatmahPlan(
      targetDays: clampedDays,
      startDate: effectiveStart,
    );

    emit(
      state.copyWith(
        khatmahTargetDays: updated.khatmahTargetDays,
        khatmahStartDate: updated.khatmahStartDate,
      ),
    );
  }

  /// Loads Tafsir, Translation, Bookmark, and Personal Note details when a user taps a [verse].
  Future<void> loadVerseDetails(
    QuranVerse verse, {
    int? tafsirId,
    int? translationId,
  }) async {
    final effectiveTafsirId = tafsirId ?? state.selectedTafsirId;
    final effectiveTranslationId = translationId ?? state.selectedTranslationId;

    // Also record reading position at the tapped verse
    await _database.saveReadingPosition(
      surahNumber: verse.chapterId,
      ayahNumber: verse.verseNumber,
      pageNumber: verse.pageNumber,
      juzNumber: verse.juzNumber,
    );

    final tafsirResult = await _repository.getTafsirForVerse(
      tafsirId: effectiveTafsirId,
      verseKey: verse.verseKey,
    );
    final verseTafsir = switch (tafsirResult) {
      Success(:final value) => value,
      FailureResult() => null,
    };

    VerseTranslation? verseTranslation;
    for (final embedded in verse.translations) {
      if (embedded.translationId == effectiveTranslationId) {
        verseTranslation = embedded;
        break;
      }
    }
    if (verseTranslation == null) {
      final transResult = await _repository.getTranslationForVerse(
        translationId: effectiveTranslationId,
        verseKey: verse.verseKey,
      );
      if (transResult case Success(:final value)) {
        verseTranslation = value;
      }
    }

    final noteRow = await _database.getNoteForVerse(
      surahNumber: verse.chapterId,
      ayahNumber: verse.verseNumber,
    );

    emit(
      state.copyWith(
        currentSurahNumber: verse.chapterId,
        currentAyahNumber: verse.verseNumber,
        currentPageNumber: verse.pageNumber,
        currentJuzNumber: verse.juzNumber,
        selectedTafsirId: effectiveTafsirId,
        selectedTranslationId: effectiveTranslationId,
        activeVerseTafsir: verseTafsir,
        activeVerseTranslation: verseTranslation,
        activeVerseNote: noteRow?.content ?? '',
      ),
    );
  }

  /// Sets or updates a colored bookmark on [verse].
  Future<void> setBookmark({
    required QuranVerse verse,
    required String colorHex,
  }) async {
    await _database.upsertBookmark(
      surahNumber: verse.chapterId,
      ayahNumber: verse.verseNumber,
      pageNumber: verse.pageNumber,
      colorHex: colorHex,
    );
    final bookmarksMap = await _loadBookmarksMap();
    emit(state.copyWith(bookmarksByVerseKey: bookmarksMap));
  }

  /// Removes a bookmark from [verse].
  Future<void> removeBookmark(QuranVerse verse) async {
    await _database.deleteBookmarkForVerse(
      surahNumber: verse.chapterId,
      ayahNumber: verse.verseNumber,
    );
    final bookmarksMap = await _loadBookmarksMap();
    emit(state.copyWith(bookmarksByVerseKey: bookmarksMap));
  }

  /// Saves a personal note on [verse] in Drift.
  Future<void> saveNote({
    required QuranVerse verse,
    required String content,
  }) async {
    await _database.saveNoteForVerse(
      surahNumber: verse.chapterId,
      ayahNumber: verse.verseNumber,
      content: content,
    );
    emit(state.copyWith(activeVerseNote: content.trim()));
  }

  /// Searches over loaded/cached Arabic verses using [ArabicSearchNormalizer]
  /// (normalizing strictly for matching, returning original unaltered `QuranVerse`s for display).
  Future<void> searchArabicVerses(String rawQuery) async {
    final trimmed = rawQuery.trim();
    if (trimmed.isEmpty) {
      emit(state.copyWith(searchQuery: '', searchMatchedVerses: const []));
      return;
    }

    // Gather all fresh cached verses from Drift for normalized matching
    final allCachedRows = await _database.select(_database.cachedVerses).get();
    final candidateVerses = allCachedRows
        .map(
          (r) => QuranVerse(
            id: r.verseNumber,
            verseKey: r.verseKey,
            chapterId: r.chapterId,
            verseNumber: r.verseNumber,
            pageNumber: r.pageNumber,
            juzNumber: r.juzNumber,
            hizbNumber: r.hizbNumber,
            textUthmani: r.textUthmani,
            textImlaeiSimple: r.textImlaeiSimple,
          ),
        )
        .toList(growable: false);

    final pool =
        candidateVerses.isNotEmpty ? candidateVerses : state.currentPageVerses;
    final matched = ArabicSearchNormalizer.filterVerses(pool, trimmed);

    emit(
      state.copyWith(
        searchQuery: trimmed,
        searchMatchedVerses: matched,
      ),
    );
  }

  Future<Map<String, String>> _loadBookmarksMap() async {
    final rows = await _database.getAllBookmarks();
    return {
      for (final row in rows)
        '${row.surahNumber}:${row.ayahNumber}': row.colorHex,
    };
  }
}
