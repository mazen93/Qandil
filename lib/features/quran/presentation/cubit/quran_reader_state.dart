import 'package:flutter/foundation.dart';

import '../../domain/entities/quran_entities.dart';
import '../../domain/services/khatmah_calculator.dart';

/// Viewing mode in the Phase 3 Quran Reader.
enum QuranReaderViewMode {
  mushafPage,
  verseList,
}

/// Immutable state for [QuranReaderCubit].
@immutable
class QuranReaderState {
  const QuranReaderState({
    this.viewMode = QuranReaderViewMode.mushafPage,
    this.isLoading = false,
    this.chapters = const [],
    this.currentPageVerses = const [],
    this.currentSurahNumber = 1,
    this.currentAyahNumber = 1,
    this.currentPageNumber = 1,
    this.currentJuzNumber = 1,
    this.khatmahTargetDays = 30,
    this.khatmahStartDate,
    this.tafsirCatalog = const [],
    this.translationCatalog = const [],
    this.selectedTafsirId = 16,
    this.selectedTranslationId = 131,
    this.activeVerseTafsir,
    this.activeVerseTranslation,
    this.bookmarksByVerseKey = const {},
    this.activeVerseNote = '',
    this.searchQuery = '',
    this.searchMatchedVerses = const [],
    this.errorMessage,
  });

  final QuranReaderViewMode viewMode;
  final bool isLoading;
  final List<QuranChapter> chapters;
  final List<QuranVerse> currentPageVerses;
  final int currentSurahNumber;
  final int currentAyahNumber;
  final int currentPageNumber;
  final int currentJuzNumber;
  final int khatmahTargetDays;
  final DateTime? khatmahStartDate;
  final List<TafsirResource> tafsirCatalog;
  final List<TranslationResource> translationCatalog;
  final int selectedTafsirId;
  final int selectedTranslationId;
  final VerseTafsir? activeVerseTafsir;
  final VerseTranslation? activeVerseTranslation;

  /// Maps `verseKey` (e.g. `1:1`) -> hex color string (e.g. `#F2A93B`).
  final Map<String, String> bookmarksByVerseKey;
  final String activeVerseNote;
  final String searchQuery;
  final List<QuranVerse> searchMatchedVerses;
  final String? errorMessage;

  QuranChapter? get currentChapter {
    for (final c in chapters) {
      if (c.id == currentSurahNumber) return c;
    }
    return chapters.isNotEmpty ? chapters.first : null;
  }

  KhatmahScheduleSummary get khatmahSummary {
    return KhatmahCalculator.calculate(
      targetDays: khatmahTargetDays,
      currentPage: currentPageNumber,
      startDate: khatmahStartDate,
    );
  }

  QuranReaderState copyWith({
    QuranReaderViewMode? viewMode,
    bool? isLoading,
    List<QuranChapter>? chapters,
    List<QuranVerse>? currentPageVerses,
    int? currentSurahNumber,
    int? currentAyahNumber,
    int? currentPageNumber,
    int? currentJuzNumber,
    int? khatmahTargetDays,
    DateTime? khatmahStartDate,
    List<TafsirResource>? tafsirCatalog,
    List<TranslationResource>? translationCatalog,
    int? selectedTafsirId,
    int? selectedTranslationId,
    VerseTafsir? activeVerseTafsir,
    VerseTranslation? activeVerseTranslation,
    Map<String, String>? bookmarksByVerseKey,
    String? activeVerseNote,
    String? searchQuery,
    List<QuranVerse>? searchMatchedVerses,
    String? errorMessage,
  }) {
    return QuranReaderState(
      viewMode: viewMode ?? this.viewMode,
      isLoading: isLoading ?? this.isLoading,
      chapters: chapters ?? this.chapters,
      currentPageVerses: currentPageVerses ?? this.currentPageVerses,
      currentSurahNumber: currentSurahNumber ?? this.currentSurahNumber,
      currentAyahNumber: currentAyahNumber ?? this.currentAyahNumber,
      currentPageNumber: currentPageNumber ?? this.currentPageNumber,
      currentJuzNumber: currentJuzNumber ?? this.currentJuzNumber,
      khatmahTargetDays: khatmahTargetDays ?? this.khatmahTargetDays,
      khatmahStartDate: khatmahStartDate ?? this.khatmahStartDate,
      tafsirCatalog: tafsirCatalog ?? this.tafsirCatalog,
      translationCatalog: translationCatalog ?? this.translationCatalog,
      selectedTafsirId: selectedTafsirId ?? this.selectedTafsirId,
      selectedTranslationId:
          selectedTranslationId ?? this.selectedTranslationId,
      activeVerseTafsir: activeVerseTafsir ?? this.activeVerseTafsir,
      activeVerseTranslation:
          activeVerseTranslation ?? this.activeVerseTranslation,
      bookmarksByVerseKey: bookmarksByVerseKey ?? this.bookmarksByVerseKey,
      activeVerseNote: activeVerseNote ?? this.activeVerseNote,
      searchQuery: searchQuery ?? this.searchQuery,
      searchMatchedVerses: searchMatchedVerses ?? this.searchMatchedVerses,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuranReaderState &&
          runtimeType == other.runtimeType &&
          viewMode == other.viewMode &&
          isLoading == other.isLoading &&
          listEquals(chapters, other.chapters) &&
          listEquals(currentPageVerses, other.currentPageVerses) &&
          currentSurahNumber == other.currentSurahNumber &&
          currentAyahNumber == other.currentAyahNumber &&
          currentPageNumber == other.currentPageNumber &&
          currentJuzNumber == other.currentJuzNumber &&
          khatmahTargetDays == other.khatmahTargetDays &&
          khatmahStartDate == other.khatmahStartDate &&
          listEquals(tafsirCatalog, other.tafsirCatalog) &&
          listEquals(translationCatalog, other.translationCatalog) &&
          selectedTafsirId == other.selectedTafsirId &&
          selectedTranslationId == other.selectedTranslationId &&
          activeVerseTafsir == other.activeVerseTafsir &&
          activeVerseTranslation == other.activeVerseTranslation &&
          mapEquals(bookmarksByVerseKey, other.bookmarksByVerseKey) &&
          activeVerseNote == other.activeVerseNote &&
          searchQuery == other.searchQuery &&
          listEquals(searchMatchedVerses, other.searchMatchedVerses) &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hashAll([
        viewMode,
        isLoading,
        Object.hashAll(chapters),
        Object.hashAll(currentPageVerses),
        currentSurahNumber,
        currentAyahNumber,
        currentPageNumber,
        currentJuzNumber,
        khatmahTargetDays,
        khatmahStartDate,
        Object.hashAll(tafsirCatalog),
        Object.hashAll(translationCatalog),
        selectedTafsirId,
        selectedTranslationId,
        activeVerseTafsir,
        activeVerseTranslation,
        Object.hashAll(bookmarksByVerseKey.entries),
        activeVerseNote,
        searchQuery,
        Object.hashAll(searchMatchedVerses),
        errorMessage,
      ]);
}
