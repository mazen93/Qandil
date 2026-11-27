import '../../../../core/result/result.dart';
import '../entities/quran_entities.dart';

/// Contract for Quran data access (remote Quran Foundation API v4 and local Drift cache).
abstract interface class QuranRepository {
  /// Fetches all chapters (Surahs).
  Future<Result<List<QuranChapter>>> getChapters({
    String languageCode = 'ar',
  });

  /// Fetches verses for a specific [chapterNumber] (Surah 1..114), including word-by-word when [includeWords] is true.
  Future<Result<List<QuranVerse>>> getVersesByChapter(
    int chapterNumber, {
    String languageCode = 'ar',
    bool includeWords = true,
    List<int> translationIds = const [],
    int page = 1,
    int perPage = 50,
  });

  /// Fetches verses for a specific Mushaf [pageNumber] (1..604).
  Future<Result<List<QuranVerse>>> getVersesByPage(
    int pageNumber, {
    String languageCode = 'ar',
    bool includeWords = true,
    List<int> translationIds = const [],
  });

  /// Fetches verses for a specific [juzNumber] (1..30).
  Future<Result<List<QuranVerse>>> getVersesByJuz(
    int juzNumber, {
    String languageCode = 'ar',
    bool includeWords = true,
    List<int> translationIds = const [],
    int page = 1,
    int perPage = 50,
  });

  /// Fetches available Tafsir catalogs.
  Future<Result<List<TafsirResource>>> getTafsirList({
    String languageCode = 'ar',
  });

  /// Fetches Tafsir commentary for a specific [verseKey] (e.g., `1:1`) and [tafsirId].
  Future<Result<VerseTafsir>> getTafsirForVerse({
    required int tafsirId,
    required String verseKey,
  });

  /// Fetches available Translation catalogs.
  Future<Result<List<TranslationResource>>> getTranslationList({
    String languageCode = 'ar',
  });

  /// Fetches Translation for a specific [verseKey] (e.g., `1:1`) and [translationId].
  Future<Result<VerseTranslation>> getTranslationForVerse({
    required int translationId,
    required String verseKey,
  });

  /// Fetches available audio Recitations catalog.
  Future<Result<List<RecitationResource>>> getRecitationsList({
    String languageCode = 'ar',
  });

  /// Searches Quran verses and translations for [query].
  Future<Result<List<QuranSearchHit>>> search({
    required String query,
    String languageCode = 'ar',
    int page = 1,
    int size = 20,
  });
}
