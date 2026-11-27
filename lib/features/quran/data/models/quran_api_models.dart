import '../../domain/entities/quran_entities.dart';

/// Pure JSON mappers for Quran Foundation Content API v4 payloads.
///
/// Content Integrity Rule: Never normalize, alter, or strip diacritics from
/// Quranic text (`text_uthmani`, `code_v2`, tafsir text, or translation text).
abstract final class QuranApiModels {
  static QuranChapter parseChapter(Map<String, dynamic> json) {
    final translatedName = json['translated_name'];
    final translatedStr = translatedName is Map<String, dynamic>
        ? (translatedName['name'] as String? ?? '')
        : '';

    final pages = json['pages'];
    var startPage = 1;
    var endPage = 1;
    if (pages is List && pages.isNotEmpty) {
      startPage = (pages.first as num?)?.toInt() ?? 1;
      endPage = (pages.last as num?)?.toInt() ?? startPage;
    }

    return QuranChapter(
      id: (json['id'] as num).toInt(),
      nameArabic: json['name_arabic'] as String? ?? '',
      nameSimple: json['name_simple'] as String? ?? '',
      nameTranslated: translatedStr,
      revelationPlace: json['revelation_place'] as String? ?? '',
      revelationOrder: (json['revelation_order'] as num?)?.toInt() ?? 0,
      bismillahPre: json['bismillah_pre'] as bool? ?? true,
      versesCount: (json['verses_count'] as num?)?.toInt() ?? 0,
      startPage: startPage,
      endPage: endPage,
    );
  }

  static QuranWord parseWord(Map<String, dynamic> json) {
    final translation = json['translation'];
    final transliteration = json['transliteration'];

    return QuranWord(
      id: (json['id'] as num?)?.toInt() ?? 0,
      position: (json['position'] as num?)?.toInt() ?? 0,
      textUthmani:
          json['text_uthmani'] as String? ?? json['text'] as String? ?? '',
      charTypeName: json['char_type_name'] as String? ?? 'word',
      codeV2: json['code_v2'] as String? ?? '',
      pageNumber: (json['v2_page'] as num?)?.toInt() ??
          (json['page_number'] as num?)?.toInt() ??
          1,
      lineNumber: (json['line_number'] as num?)?.toInt() ?? 1,
      translationText: translation is Map<String, dynamic>
          ? (translation['text'] as String? ?? '')
          : '',
      transliterationText: transliteration is Map<String, dynamic>
          ? (transliteration['text'] as String? ?? '')
          : '',
    );
  }

  static Map<String, dynamic> wordToJson(QuranWord word) {
    return {
      'id': word.id,
      'position': word.position,
      'text_uthmani': word.textUthmani,
      'char_type_name': word.charTypeName,
      'code_v2': word.codeV2,
      'v2_page': word.pageNumber,
      'line_number': word.lineNumber,
      'translation': {'text': word.translationText},
      'transliteration': {'text': word.transliterationText},
    };
  }

  static QuranVerse parseVerse(Map<String, dynamic> json) {
    final verseKey = json['verse_key'] as String? ?? '';
    final keyParts = verseKey.split(':');
    final parsedChapterId =
        keyParts.isNotEmpty ? (int.tryParse(keyParts.first) ?? 1) : 1;
    final parsedVerseNum =
        keyParts.length > 1 ? (int.tryParse(keyParts[1]) ?? 1) : 1;

    final chapterId = (json['chapter_id'] as num?)?.toInt() ?? parsedChapterId;
    final verseNumber =
        (json['verse_number'] as num?)?.toInt() ?? parsedVerseNum;

    final rawWords = json['words'];
    final words = rawWords is List
        ? rawWords
            .whereType<Map<String, dynamic>>()
            .map(parseWord)
            .toList(growable: false)
        : const <QuranWord>[];

    final rawTranslations = json['translations'];
    final translations = rawTranslations is List
        ? rawTranslations
            .whereType<Map<String, dynamic>>()
            .map((t) => parseEmbeddedTranslation(t, verseKey))
            .toList(growable: false)
        : const <VerseTranslation>[];

    return QuranVerse(
      id: (json['id'] as num?)?.toInt() ?? 0,
      verseKey: verseKey,
      chapterId: chapterId,
      verseNumber: verseNumber,
      pageNumber: (json['page_number'] as num?)?.toInt() ??
          (json['v2_page'] as num?)?.toInt() ??
          1,
      juzNumber: (json['juz_number'] as num?)?.toInt() ?? 1,
      hizbNumber: (json['hizb_number'] as num?)?.toInt() ?? 1,
      textUthmani: json['text_uthmani'] as String? ?? '',
      textImlaeiSimple: json['text_imlaei_simple'] as String? ?? '',
      words: words,
      translations: translations,
    );
  }

  static VerseTranslation parseEmbeddedTranslation(
    Map<String, dynamic> json,
    String fallbackVerseKey,
  ) {
    return VerseTranslation(
      translationId: (json['resource_id'] as num?)?.toInt() ??
          (json['id'] as num?)?.toInt() ??
          0,
      verseKey: json['verse_key'] as String? ?? fallbackVerseKey,
      text: json['text'] as String? ?? '',
      resourceName: json['resource_name'] as String? ?? '',
    );
  }

  static TafsirResource parseTafsirResource(Map<String, dynamic> json) {
    return TafsirResource(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      authorName: json['author_name'] as String? ?? '',
      languageName: json['language_name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }

  static VerseTafsir parseVerseTafsir(
    Map<String, dynamic> json, {
    required int tafsirId,
    required String verseKey,
  }) {
    final tafsirObj = json['tafsir'] is Map<String, dynamic>
        ? json['tafsir'] as Map<String, dynamic>
        : json;

    return VerseTafsir(
      tafsirId: (tafsirObj['resource_id'] as num?)?.toInt() ?? tafsirId,
      verseKey: tafsirObj['verse_key'] as String? ?? verseKey,
      text: tafsirObj['text'] as String? ?? '',
      resourceName: tafsirObj['resource_name'] as String? ?? '',
    );
  }

  static TranslationResource parseTranslationResource(
    Map<String, dynamic> json,
  ) {
    return TranslationResource(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      authorName: json['author_name'] as String? ?? '',
      languageName: json['language_name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }

  static VerseTranslation parseVerseTranslation(
    Map<String, dynamic> json, {
    required int translationId,
    required String verseKey,
  }) {
    Map<String, dynamic> transObj = json;
    if (json['translation'] is Map<String, dynamic>) {
      transObj = json['translation'] as Map<String, dynamic>;
    } else if (json['translations'] is List &&
        (json['translations'] as List).isNotEmpty) {
      final first = (json['translations'] as List).first;
      if (first is Map<String, dynamic>) {
        transObj = first;
      }
    }

    return VerseTranslation(
      translationId:
          (transObj['resource_id'] as num?)?.toInt() ?? translationId,
      verseKey: transObj['verse_key'] as String? ?? verseKey,
      text: transObj['text'] as String? ?? '',
      resourceName: transObj['resource_name'] as String? ?? '',
    );
  }

  static RecitationResource parseRecitationResource(
    Map<String, dynamic> json,
  ) {
    final translated = json['translated_name'];
    final translatedStr = translated is Map<String, dynamic>
        ? (translated['name'] as String? ?? '')
        : '';

    return RecitationResource(
      id: (json['id'] as num).toInt(),
      reciterName: json['reciter_name'] as String? ?? '',
      style: json['style'] as String? ?? '',
      translatedName: translatedStr,
    );
  }

  static List<QuranSearchHit> parseSearchResults(Map<String, dynamic> json) {
    final searchObj = json['search'] is Map<String, dynamic>
        ? json['search'] as Map<String, dynamic>
        : json;
    final rawResults = searchObj['results'];
    if (rawResults is! List) {
      return const [];
    }

    return rawResults
        .whereType<Map<String, dynamic>>()
        .map(
          (item) => QuranSearchHit(
            verseKey: item['verse_key'] as String? ?? '',
            text: item['text'] as String? ?? '',
            highlightedText: item['highlighted'] as String? ?? '',
          ),
        )
        .toList(growable: false);
  }
}
