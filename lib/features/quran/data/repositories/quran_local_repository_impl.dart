import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/quran_entities.dart';
import '../../domain/repositories/quran_repository.dart';
import '../models/quran_api_models.dart';

/// Local Drift cache implementation of [QuranRepository] enforcing the
/// Quran Foundation 7-day cache expiry policy.
class QuranLocalRepositoryImpl implements QuranRepository {
  QuranLocalRepositoryImpl({
    required AppDatabase database,
    DateTime Function()? clock,
    this.maxCacheAge = AppDatabase.quranCacheMaxAge,
  })  : _database = database,
        _clock = clock ?? (() => DateTime.now().toUtc());

  final AppDatabase _database;
  final DateTime Function() _clock;
  final Duration maxCacheAge;

  DateTime get _expiryCutoff => _clock().subtract(maxCacheAge);

  // ---------------------------------------------------------------------------
  // Cache Writers (used by OfflineFirstQuranRepositoryImpl & DownloadManager)
  // ---------------------------------------------------------------------------

  Future<void> cacheChapters(
    List<QuranChapter> chapters, {
    String languageCode = 'ar',
  }) async {
    final now = _clock();
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _database.cachedChapters,
        chapters
            .map(
              (c) => CachedChaptersCompanion.insert(
                chapterId: c.id,
                languageCode: Value(languageCode),
                nameArabic: c.nameArabic,
                nameSimple: c.nameSimple,
                nameTranslated: c.nameTranslated,
                revelationPlace: c.revelationPlace,
                revelationOrder: c.revelationOrder,
                bismillahPre: c.bismillahPre,
                versesCount: c.versesCount,
                startPage: c.startPage,
                endPage: c.endPage,
                cachedAt: now,
              ),
            )
            .toList(),
      );
    });
  }

  Future<void> cacheVerses(List<QuranVerse> verses) async {
    final now = _clock();
    await _database.transaction(() async {
      for (final v in verses) {
        final wordsJson = jsonEncode(
          v.words.map(QuranApiModels.wordToJson).toList(),
        );
        await _database.into(_database.cachedVerses).insertOnConflictUpdate(
              CachedVersesCompanion.insert(
                verseKey: v.verseKey,
                chapterId: v.chapterId,
                verseNumber: v.verseNumber,
                pageNumber: v.pageNumber,
                juzNumber: v.juzNumber,
                hizbNumber: v.hizbNumber,
                textUthmani: v.textUthmani,
                textImlaeiSimple: Value(v.textImlaeiSimple),
                wordsJson: Value(wordsJson),
                cachedAt: now,
              ),
            );

        for (final tr in v.translations) {
          await cacheVerseTranslation(tr);
        }
      }
    });
  }

  Future<void> cacheTafsirList(
    List<TafsirResource> items, {
    String languageCode = 'ar',
  }) async {
    final now = _clock();
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _database.cachedResourceCatalogs,
        items
            .map(
              (item) => CachedResourceCatalogsCompanion.insert(
                resourceType: 'tafsir',
                resourceId: item.id,
                languageCode: Value(languageCode),
                name: item.name,
                authorName: Value(item.authorName),
                languageName: Value(item.languageName),
                slug: Value(item.slug),
                cachedAt: now,
              ),
            )
            .toList(),
      );
    });
  }

  Future<void> cacheTranslationList(
    List<TranslationResource> items, {
    String languageCode = 'ar',
  }) async {
    final now = _clock();
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _database.cachedResourceCatalogs,
        items
            .map(
              (item) => CachedResourceCatalogsCompanion.insert(
                resourceType: 'translation',
                resourceId: item.id,
                languageCode: Value(languageCode),
                name: item.name,
                authorName: Value(item.authorName),
                languageName: Value(item.languageName),
                slug: Value(item.slug),
                cachedAt: now,
              ),
            )
            .toList(),
      );
    });
  }

  Future<void> cacheRecitationsList(
    List<RecitationResource> items, {
    String languageCode = 'ar',
  }) async {
    final now = _clock();
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _database.cachedResourceCatalogs,
        items
            .map(
              (item) => CachedResourceCatalogsCompanion.insert(
                resourceType: 'recitation',
                resourceId: item.id,
                languageCode: Value(languageCode),
                name: item.reciterName,
                authorName: Value(item.translatedName),
                style: Value(item.style),
                cachedAt: now,
              ),
            )
            .toList(),
      );
    });
  }

  Future<void> cacheVerseTafsir(VerseTafsir tafsir) async {
    final now = _clock();
    await _database
        .into(_database.cachedVerseAnnotations)
        .insertOnConflictUpdate(
          CachedVerseAnnotationsCompanion.insert(
            verseKey: tafsir.verseKey,
            resourceType: 'tafsir',
            resourceId: tafsir.tafsirId,
            resourceName: Value(tafsir.resourceName),
            textContent: tafsir.text,
            cachedAt: now,
          ),
        );
  }

  Future<void> cacheVerseTranslation(VerseTranslation translation) async {
    final now = _clock();
    await _database
        .into(_database.cachedVerseAnnotations)
        .insertOnConflictUpdate(
          CachedVerseAnnotationsCompanion.insert(
            verseKey: translation.verseKey,
            resourceType: 'translation',
            resourceId: translation.translationId,
            resourceName: Value(translation.resourceName),
            textContent: translation.text,
            cachedAt: now,
          ),
        );
  }

  // ---------------------------------------------------------------------------
  // QuranRepository Readers (strictly filtering by cachedAt >= _expiryCutoff)
  // ---------------------------------------------------------------------------

  @override
  Future<Result<List<QuranChapter>>> getChapters({
    String languageCode = 'ar',
  }) async {
    try {
      final cutoff = _expiryCutoff;
      final rows = await (_database.select(_database.cachedChapters)
            ..where(
              (t) =>
                  t.languageCode.equals(languageCode) &
                  t.cachedAt.isBiggerOrEqualValue(cutoff),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.chapterId)]))
          .get();

      if (rows.isEmpty) {
        return const FailureResult(
          NotFoundFailure('No fresh cached chapters found in local database.'),
        );
      }

      return Success(
        rows
            .map(
              (r) => QuranChapter(
                id: r.chapterId,
                nameArabic: r.nameArabic,
                nameSimple: r.nameSimple,
                nameTranslated: r.nameTranslated,
                revelationPlace: r.revelationPlace,
                revelationOrder: r.revelationOrder,
                bismillahPre: r.bismillahPre,
                versesCount: r.versesCount,
                startPage: r.startPage,
                endPage: r.endPage,
              ),
            )
            .toList(growable: false),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to read cached chapters: $e'),
      );
    }
  }

  @override
  Future<Result<List<QuranVerse>>> getVersesByChapter(
    int chapterNumber, {
    String languageCode = 'ar',
    bool includeWords = true,
    List<int> translationIds = const [],
    int page = 1,
    int perPage = 50,
  }) async {
    try {
      final cutoff = _expiryCutoff;
      final offset = (page - 1) * perPage;
      final rows = await (_database.select(_database.cachedVerses)
            ..where(
              (t) =>
                  t.chapterId.equals(chapterNumber) &
                  t.cachedAt.isBiggerOrEqualValue(cutoff),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.verseNumber)])
            ..limit(perPage, offset: offset))
          .get();

      if (rows.isEmpty) {
        return const FailureResult(
          NotFoundFailure('No fresh cached verses for chapter.'),
        );
      }

      return Success(
        await _mapCachedVerseRows(
          rows,
          includeWords: includeWords,
          translationIds: translationIds,
        ),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to read cached chapter verses: $e'),
      );
    }
  }

  @override
  Future<Result<List<QuranVerse>>> getVersesByPage(
    int pageNumber, {
    String languageCode = 'ar',
    bool includeWords = true,
    List<int> translationIds = const [],
  }) async {
    try {
      final cutoff = _expiryCutoff;
      final rows = await (_database.select(_database.cachedVerses)
            ..where(
              (t) =>
                  t.pageNumber.equals(pageNumber) &
                  t.cachedAt.isBiggerOrEqualValue(cutoff),
            )
            ..orderBy([
              (t) => OrderingTerm.asc(t.chapterId),
              (t) => OrderingTerm.asc(t.verseNumber),
            ]))
          .get();

      if (rows.isEmpty) {
        return const FailureResult(
          NotFoundFailure('No fresh cached verses for page.'),
        );
      }

      return Success(
        await _mapCachedVerseRows(
          rows,
          includeWords: includeWords,
          translationIds: translationIds,
        ),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to read cached page verses: $e'),
      );
    }
  }

  @override
  Future<Result<List<QuranVerse>>> getVersesByJuz(
    int juzNumber, {
    String languageCode = 'ar',
    bool includeWords = true,
    List<int> translationIds = const [],
    int page = 1,
    int perPage = 50,
  }) async {
    try {
      final cutoff = _expiryCutoff;
      final offset = (page - 1) * perPage;
      final rows = await (_database.select(_database.cachedVerses)
            ..where(
              (t) =>
                  t.juzNumber.equals(juzNumber) &
                  t.cachedAt.isBiggerOrEqualValue(cutoff),
            )
            ..orderBy([
              (t) => OrderingTerm.asc(t.chapterId),
              (t) => OrderingTerm.asc(t.verseNumber),
            ])
            ..limit(perPage, offset: offset))
          .get();

      if (rows.isEmpty) {
        return const FailureResult(
          NotFoundFailure('No fresh cached verses for juz.'),
        );
      }

      return Success(
        await _mapCachedVerseRows(
          rows,
          includeWords: includeWords,
          translationIds: translationIds,
        ),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to read cached juz verses: $e'),
      );
    }
  }

  @override
  Future<Result<List<TafsirResource>>> getTafsirList({
    String languageCode = 'ar',
  }) async {
    try {
      final cutoff = _expiryCutoff;
      final rows = await (_database.select(_database.cachedResourceCatalogs)
            ..where(
              (t) =>
                  t.resourceType.equals('tafsir') &
                  t.languageCode.equals(languageCode) &
                  t.cachedAt.isBiggerOrEqualValue(cutoff),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.resourceId)]))
          .get();

      if (rows.isEmpty) {
        return const FailureResult(
          NotFoundFailure('No fresh cached tafsir catalog.'),
        );
      }

      return Success(
        rows
            .map(
              (r) => TafsirResource(
                id: r.resourceId,
                name: r.name,
                authorName: r.authorName,
                languageName: r.languageName,
                slug: r.slug,
              ),
            )
            .toList(growable: false),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to read cached tafsir catalog: $e'),
      );
    }
  }

  @override
  Future<Result<VerseTafsir>> getTafsirForVerse({
    required int tafsirId,
    required String verseKey,
  }) async {
    try {
      final cutoff = _expiryCutoff;
      final row = await (_database.select(_database.cachedVerseAnnotations)
            ..where(
              (t) =>
                  t.verseKey.equals(verseKey) &
                  t.resourceType.equals('tafsir') &
                  t.resourceId.equals(tafsirId) &
                  t.cachedAt.isBiggerOrEqualValue(cutoff),
            ))
          .getSingleOrNull();

      if (row == null) {
        return const FailureResult(
          NotFoundFailure('No fresh cached tafsir for verse.'),
        );
      }

      return Success(
        VerseTafsir(
          tafsirId: row.resourceId,
          verseKey: row.verseKey,
          text: row.textContent,
          resourceName: row.resourceName,
        ),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to read cached verse tafsir: $e'),
      );
    }
  }

  @override
  Future<Result<List<TranslationResource>>> getTranslationList({
    String languageCode = 'ar',
  }) async {
    try {
      final cutoff = _expiryCutoff;
      final rows = await (_database.select(_database.cachedResourceCatalogs)
            ..where(
              (t) =>
                  t.resourceType.equals('translation') &
                  t.languageCode.equals(languageCode) &
                  t.cachedAt.isBiggerOrEqualValue(cutoff),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.resourceId)]))
          .get();

      if (rows.isEmpty) {
        return const FailureResult(
          NotFoundFailure('No fresh cached translation catalog.'),
        );
      }

      return Success(
        rows
            .map(
              (r) => TranslationResource(
                id: r.resourceId,
                name: r.name,
                authorName: r.authorName,
                languageName: r.languageName,
                slug: r.slug,
              ),
            )
            .toList(growable: false),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to read cached translation catalog: $e'),
      );
    }
  }

  @override
  Future<Result<VerseTranslation>> getTranslationForVerse({
    required int translationId,
    required String verseKey,
  }) async {
    try {
      final cutoff = _expiryCutoff;
      final row = await (_database.select(_database.cachedVerseAnnotations)
            ..where(
              (t) =>
                  t.verseKey.equals(verseKey) &
                  t.resourceType.equals('translation') &
                  t.resourceId.equals(translationId) &
                  t.cachedAt.isBiggerOrEqualValue(cutoff),
            ))
          .getSingleOrNull();

      if (row == null) {
        return const FailureResult(
          NotFoundFailure('No fresh cached translation for verse.'),
        );
      }

      return Success(
        VerseTranslation(
          translationId: row.resourceId,
          verseKey: row.verseKey,
          text: row.textContent,
          resourceName: row.resourceName,
        ),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to read cached verse translation: $e'),
      );
    }
  }

  @override
  Future<Result<List<RecitationResource>>> getRecitationsList({
    String languageCode = 'ar',
  }) async {
    try {
      final cutoff = _expiryCutoff;
      final rows = await (_database.select(_database.cachedResourceCatalogs)
            ..where(
              (t) =>
                  t.resourceType.equals('recitation') &
                  t.languageCode.equals(languageCode) &
                  t.cachedAt.isBiggerOrEqualValue(cutoff),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.resourceId)]))
          .get();

      if (rows.isEmpty) {
        return const FailureResult(
          NotFoundFailure('No fresh cached recitations catalog.'),
        );
      }

      return Success(
        rows
            .map(
              (r) => RecitationResource(
                id: r.resourceId,
                reciterName: r.name,
                translatedName: r.authorName,
                style: r.style,
              ),
            )
            .toList(growable: false),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to read cached recitations catalog: $e'),
      );
    }
  }

  @override
  Future<Result<List<QuranSearchHit>>> search({
    required String query,
    String languageCode = 'ar',
    int page = 1,
    int size = 20,
  }) async {
    try {
      final trimmed = query.trim();
      if (trimmed.isEmpty) {
        return const Success([]);
      }
      final cutoff = _expiryCutoff;
      final offset = (page - 1) * size;
      final rows = await (_database.select(_database.cachedVerses)
            ..where(
              (t) =>
                  t.cachedAt.isBiggerOrEqualValue(cutoff) &
                  (t.textUthmani.like('%$trimmed%') |
                      t.textImlaeiSimple.like('%$trimmed%')),
            )
            ..limit(size, offset: offset))
          .get();

      return Success(
        rows
            .map(
              (r) => QuranSearchHit(
                verseKey: r.verseKey,
                text: r.textUthmani,
              ),
            )
            .toList(growable: false),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to search cached verses: $e'),
      );
    }
  }

  Future<List<QuranVerse>> _mapCachedVerseRows(
    List<CachedVerseRecord> rows, {
    required bool includeWords,
    required List<int> translationIds,
  }) async {
    final cutoff = _expiryCutoff;
    final verses = <QuranVerse>[];

    for (final row in rows) {
      var words = const <QuranWord>[];
      if (includeWords && row.wordsJson.isNotEmpty) {
        final decodedWords = jsonDecode(row.wordsJson);
        if (decodedWords is List) {
          words = decodedWords
              .whereType<Map<String, dynamic>>()
              .map(QuranApiModels.parseWord)
              .toList(growable: false);
        }
      }

      var translations = const <VerseTranslation>[];
      if (translationIds.isNotEmpty) {
        final trRows = await (_database.select(_database.cachedVerseAnnotations)
              ..where(
                (t) =>
                    t.verseKey.equals(row.verseKey) &
                    t.resourceType.equals('translation') &
                    t.resourceId.isIn(translationIds) &
                    t.cachedAt.isBiggerOrEqualValue(cutoff),
              ))
            .get();
        translations = trRows
            .map(
              (tr) => VerseTranslation(
                translationId: tr.resourceId,
                verseKey: tr.verseKey,
                text: tr.textContent,
                resourceName: tr.resourceName,
              ),
            )
            .toList(growable: false);
      }

      verses.add(
        QuranVerse(
          id: row.verseNumber,
          verseKey: row.verseKey,
          chapterId: row.chapterId,
          verseNumber: row.verseNumber,
          pageNumber: row.pageNumber,
          juzNumber: row.juzNumber,
          hizbNumber: row.hizbNumber,
          textUthmani: row.textUthmani,
          textImlaeiSimple: row.textImlaeiSimple,
          words: words,
          translations: translations,
        ),
      );
    }
    return verses;
  }
}
