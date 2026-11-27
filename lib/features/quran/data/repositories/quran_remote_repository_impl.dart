import '../../../../core/network/quran_api_client.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/quran_entities.dart';
import '../../domain/repositories/quran_repository.dart';
import '../models/quran_api_models.dart';

/// Remote implementation of [QuranRepository] backed by Quran Foundation Content API v4.
class QuranRemoteRepositoryImpl implements QuranRepository {
  const QuranRemoteRepositoryImpl({required QuranApiClient apiClient})
      : _apiClient = apiClient;

  final QuranApiClient _apiClient;

  static const String _defaultVerseFields =
      'text_uthmani,chapter_id,hizb_number,text_imlaei_simple,page_number,juz_number';
  static const String _defaultWordFields =
      'text_uthmani,code_v2,v2_page,line_number';

  @override
  Future<Result<List<QuranChapter>>> getChapters({
    String languageCode = 'ar',
  }) async {
    final result = await _apiClient.getJson(
      '/chapters',
      queryParameters: {'language': languageCode},
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => _parseList(
          value,
          key: 'chapters',
          mapper: QuranApiModels.parseChapter,
        ),
    };
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
    final query = _buildVerseQueryParams(
      languageCode: languageCode,
      includeWords: includeWords,
      translationIds: translationIds,
      page: page,
      perPage: perPage,
    );

    final result = await _apiClient.getJson(
      '/verses/by_chapter/$chapterNumber',
      queryParameters: query,
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => _parseList(
          value,
          key: 'verses',
          mapper: QuranApiModels.parseVerse,
        ),
    };
  }

  @override
  Future<Result<List<QuranVerse>>> getVersesByPage(
    int pageNumber, {
    String languageCode = 'ar',
    bool includeWords = true,
    List<int> translationIds = const [],
  }) async {
    final query = _buildVerseQueryParams(
      languageCode: languageCode,
      includeWords: includeWords,
      translationIds: translationIds,
    );

    final result = await _apiClient.getJson(
      '/verses/by_page/$pageNumber',
      queryParameters: query,
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => _parseList(
          value,
          key: 'verses',
          mapper: QuranApiModels.parseVerse,
        ),
    };
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
    final query = _buildVerseQueryParams(
      languageCode: languageCode,
      includeWords: includeWords,
      translationIds: translationIds,
      page: page,
      perPage: perPage,
    );

    final result = await _apiClient.getJson(
      '/verses/by_juz/$juzNumber',
      queryParameters: query,
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => _parseList(
          value,
          key: 'verses',
          mapper: QuranApiModels.parseVerse,
        ),
    };
  }

  @override
  Future<Result<List<TafsirResource>>> getTafsirList({
    String languageCode = 'ar',
  }) async {
    final result = await _apiClient.getJson(
      '/resources/tafsirs',
      queryParameters: {'language': languageCode},
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => _parseList(
          value,
          key: 'tafsirs',
          mapper: QuranApiModels.parseTafsirResource,
        ),
    };
  }

  @override
  Future<Result<VerseTafsir>> getTafsirForVerse({
    required int tafsirId,
    required String verseKey,
  }) async {
    final result = await _apiClient.getJson(
      '/tafsirs/$tafsirId/by_ayah/$verseKey',
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => Success(
          QuranApiModels.parseVerseTafsir(
            value,
            tafsirId: tafsirId,
            verseKey: verseKey,
          ),
        ),
    };
  }

  @override
  Future<Result<List<TranslationResource>>> getTranslationList({
    String languageCode = 'ar',
  }) async {
    final result = await _apiClient.getJson(
      '/resources/translations',
      queryParameters: {'language': languageCode},
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => _parseList(
          value,
          key: 'translations',
          mapper: QuranApiModels.parseTranslationResource,
        ),
    };
  }

  @override
  Future<Result<VerseTranslation>> getTranslationForVerse({
    required int translationId,
    required String verseKey,
  }) async {
    final result = await _apiClient.getJson(
      '/translations/$translationId/by_ayah/$verseKey',
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => Success(
          QuranApiModels.parseVerseTranslation(
            value,
            translationId: translationId,
            verseKey: verseKey,
          ),
        ),
    };
  }

  @override
  Future<Result<List<RecitationResource>>> getRecitationsList({
    String languageCode = 'ar',
  }) async {
    final result = await _apiClient.getJson(
      '/resources/recitations',
      queryParameters: {'language': languageCode},
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => _parseList(
          value,
          key: 'recitations',
          mapper: QuranApiModels.parseRecitationResource,
        ),
    };
  }

  @override
  Future<Result<List<QuranSearchHit>>> search({
    required String query,
    String languageCode = 'ar',
    int page = 1,
    int size = 20,
  }) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return const Success([]);
    }

    final result = await _apiClient.getJson(
      '/search',
      queryParameters: {
        'q': trimmed,
        'language': languageCode,
        'page': '$page',
        'size': '$size',
      },
    );

    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => Success(
          QuranApiModels.parseSearchResults(value),
        ),
    };
  }

  Map<String, String> _buildVerseQueryParams({
    required String languageCode,
    required bool includeWords,
    required List<int> translationIds,
    int? page,
    int? perPage,
  }) {
    final params = <String, String>{
      'language': languageCode,
      'words': includeWords ? 'true' : 'false',
      'fields': _defaultVerseFields,
      'word_fields': _defaultWordFields,
    };
    if (translationIds.isNotEmpty) {
      params['translations'] = translationIds.join(',');
    }
    if (page != null) {
      params['page'] = '$page';
    }
    if (perPage != null) {
      params['per_page'] = '$perPage';
    }
    return params;
  }

  Result<List<T>> _parseList<T>(
    Map<String, dynamic> payload, {
    required String key,
    required T Function(Map<String, dynamic>) mapper,
  }) {
    try {
      final rawList = payload[key];
      if (rawList is! List) {
        return FailureResult(
          ParsingFailure('Expected list at "$key" in Quran API response.'),
        );
      }
      final items = rawList
          .whereType<Map<String, dynamic>>()
          .map(mapper)
          .toList(growable: false);
      return Success(items);
    } catch (e) {
      return FailureResult(
        ParsingFailure('Failed to map "$key" list from Quran API: $e'),
      );
    }
  }
}
