import '../../../../core/result/result.dart';
import '../../domain/entities/quran_entities.dart';
import '../../domain/repositories/quran_repository.dart';
import 'quran_local_repository_impl.dart';
import 'quran_remote_repository_impl.dart';

/// Offline-first coordinator implementing [QuranRepository]:
/// 1. Reads from [QuranLocalRepositoryImpl] (Drift SQLite cache with strict 7-day TTL).
/// 2. If not cached or expired (> 7 days), fetches from [QuranRemoteRepositoryImpl]
///    and writes fresh data into the local Drift cache.
class OfflineFirstQuranRepositoryImpl implements QuranRepository {
  const OfflineFirstQuranRepositoryImpl({
    required QuranRemoteRepositoryImpl remoteRepository,
    required QuranLocalRepositoryImpl localRepository,
  })  : _remote = remoteRepository,
        _local = localRepository;

  final QuranRemoteRepositoryImpl _remote;
  final QuranLocalRepositoryImpl _local;

  @override
  Future<Result<List<QuranChapter>>> getChapters({
    String languageCode = 'ar',
  }) async {
    final localResult = await _local.getChapters(languageCode: languageCode);
    if (localResult case Success(:final value) when value.length >= 114) {
      return localResult;
    }

    final remoteResult = await _remote.getChapters(languageCode: languageCode);
    if (remoteResult case Success(:final value)) {
      await _local.cacheChapters(value, languageCode: languageCode);
      return remoteResult;
    }
    if (localResult is Success<List<QuranChapter>>) {
      return localResult;
    }
    return remoteResult;
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
    final localResult = await _local.getVersesByChapter(
      chapterNumber,
      languageCode: languageCode,
      includeWords: includeWords,
      translationIds: translationIds,
      page: page,
      perPage: perPage,
    );
    if (localResult is Success<List<QuranVerse>>) {
      return localResult;
    }

    final remoteResult = await _remote.getVersesByChapter(
      chapterNumber,
      languageCode: languageCode,
      includeWords: includeWords,
      translationIds: translationIds,
      page: page,
      perPage: perPage,
    );
    if (remoteResult case Success(:final value)) {
      await _local.cacheVerses(value);
    }
    return remoteResult;
  }

  @override
  Future<Result<List<QuranVerse>>> getVersesByPage(
    int pageNumber, {
    String languageCode = 'ar',
    bool includeWords = true,
    List<int> translationIds = const [],
  }) async {
    final localResult = await _local.getVersesByPage(
      pageNumber,
      languageCode: languageCode,
      includeWords: includeWords,
      translationIds: translationIds,
    );
    if (localResult is Success<List<QuranVerse>>) {
      return localResult;
    }

    final remoteResult = await _remote.getVersesByPage(
      pageNumber,
      languageCode: languageCode,
      includeWords: includeWords,
      translationIds: translationIds,
    );
    if (remoteResult case Success(:final value)) {
      await _local.cacheVerses(value);
    }
    return remoteResult;
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
    final localResult = await _local.getVersesByJuz(
      juzNumber,
      languageCode: languageCode,
      includeWords: includeWords,
      translationIds: translationIds,
      page: page,
      perPage: perPage,
    );
    if (localResult is Success<List<QuranVerse>>) {
      return localResult;
    }

    final remoteResult = await _remote.getVersesByJuz(
      juzNumber,
      languageCode: languageCode,
      includeWords: includeWords,
      translationIds: translationIds,
      page: page,
      perPage: perPage,
    );
    if (remoteResult case Success(:final value)) {
      await _local.cacheVerses(value);
    }
    return remoteResult;
  }

  @override
  Future<Result<List<TafsirResource>>> getTafsirList({
    String languageCode = 'ar',
  }) async {
    final localResult = await _local.getTafsirList(languageCode: languageCode);
    if (localResult is Success<List<TafsirResource>>) {
      return localResult;
    }

    final remoteResult =
        await _remote.getTafsirList(languageCode: languageCode);
    if (remoteResult case Success(:final value)) {
      await _local.cacheTafsirList(value, languageCode: languageCode);
    }
    return remoteResult;
  }

  @override
  Future<Result<VerseTafsir>> getTafsirForVerse({
    required int tafsirId,
    required String verseKey,
  }) async {
    final localResult = await _local.getTafsirForVerse(
      tafsirId: tafsirId,
      verseKey: verseKey,
    );
    if (localResult is Success<VerseTafsir>) {
      return localResult;
    }

    final remoteResult = await _remote.getTafsirForVerse(
      tafsirId: tafsirId,
      verseKey: verseKey,
    );
    if (remoteResult case Success(:final value)) {
      await _local.cacheVerseTafsir(value);
    }
    return remoteResult;
  }

  @override
  Future<Result<List<TranslationResource>>> getTranslationList({
    String languageCode = 'ar',
  }) async {
    final localResult =
        await _local.getTranslationList(languageCode: languageCode);
    if (localResult is Success<List<TranslationResource>>) {
      return localResult;
    }

    final remoteResult =
        await _remote.getTranslationList(languageCode: languageCode);
    if (remoteResult case Success(:final value)) {
      await _local.cacheTranslationList(value, languageCode: languageCode);
    }
    return remoteResult;
  }

  @override
  Future<Result<VerseTranslation>> getTranslationForVerse({
    required int translationId,
    required String verseKey,
  }) async {
    final localResult = await _local.getTranslationForVerse(
      translationId: translationId,
      verseKey: verseKey,
    );
    if (localResult is Success<VerseTranslation>) {
      return localResult;
    }

    final remoteResult = await _remote.getTranslationForVerse(
      translationId: translationId,
      verseKey: verseKey,
    );
    if (remoteResult case Success(:final value)) {
      await _local.cacheVerseTranslation(value);
    }
    return remoteResult;
  }

  @override
  Future<Result<List<RecitationResource>>> getRecitationsList({
    String languageCode = 'ar',
  }) async {
    final localResult =
        await _local.getRecitationsList(languageCode: languageCode);
    if (localResult is Success<List<RecitationResource>>) {
      return localResult;
    }

    final remoteResult =
        await _remote.getRecitationsList(languageCode: languageCode);
    if (remoteResult case Success(:final value)) {
      await _local.cacheRecitationsList(value, languageCode: languageCode);
    }
    return remoteResult;
  }

  @override
  Future<Result<List<QuranSearchHit>>> search({
    required String query,
    String languageCode = 'ar',
    int page = 1,
    int size = 20,
  }) async {
    final remoteResult = await _remote.search(
      query: query,
      languageCode: languageCode,
      page: page,
      size: size,
    );
    if (remoteResult is Success<List<QuranSearchHit>>) {
      return remoteResult;
    }
    // Fallback to local cached verse search when offline
    final localFallback = await _local.search(
      query: query,
      languageCode: languageCode,
      page: page,
      size: size,
    );
    if (localFallback case Success(:final value) when value.isNotEmpty) {
      return localFallback;
    }
    return remoteResult;
  }
}
