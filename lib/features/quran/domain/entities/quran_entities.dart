import 'package:flutter/foundation.dart';

/// Domain entity representing a Surah (Chapter) from the Quran Foundation API.
@immutable
class QuranChapter {
  const QuranChapter({
    required this.id,
    required this.nameArabic,
    required this.nameSimple,
    required this.nameTranslated,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.versesCount,
    required this.startPage,
    required this.endPage,
  });

  final int id;
  final String nameArabic;
  final String nameSimple;
  final String nameTranslated;
  final String revelationPlace;
  final int revelationOrder;
  final bool bismillahPre;
  final int versesCount;
  final int startPage;
  final int endPage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuranChapter &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameArabic == other.nameArabic &&
          nameSimple == other.nameSimple &&
          nameTranslated == other.nameTranslated &&
          revelationPlace == other.revelationPlace &&
          revelationOrder == other.revelationOrder &&
          bismillahPre == other.bismillahPre &&
          versesCount == other.versesCount &&
          startPage == other.startPage &&
          endPage == other.endPage;

  @override
  int get hashCode => Object.hash(
        id,
        nameArabic,
        nameSimple,
        nameTranslated,
        revelationPlace,
        revelationOrder,
        bismillahPre,
        versesCount,
        startPage,
        endPage,
      );
}

/// Domain entity representing an individual word inside a Quranic verse (word-by-word & Mushaf layout).
@immutable
class QuranWord {
  const QuranWord({
    required this.id,
    required this.position,
    required this.textUthmani,
    required this.charTypeName,
    this.codeV2 = '',
    this.pageNumber = 1,
    this.lineNumber = 1,
    this.translationText = '',
    this.transliterationText = '',
  });

  final int id;
  final int position;
  final String textUthmani;
  final String charTypeName; // 'word' or 'end'
  final String codeV2;
  final int pageNumber;
  final int lineNumber;
  final String translationText;
  final String transliterationText;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuranWord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          position == other.position &&
          textUthmani == other.textUthmani &&
          charTypeName == other.charTypeName &&
          codeV2 == other.codeV2 &&
          pageNumber == other.pageNumber &&
          lineNumber == other.lineNumber &&
          translationText == other.translationText &&
          transliterationText == other.transliterationText;

  @override
  int get hashCode => Object.hash(
        id,
        position,
        textUthmani,
        charTypeName,
        codeV2,
        pageNumber,
        lineNumber,
        translationText,
        transliterationText,
      );
}

/// Domain entity representing a verse (Ayah) from the Quran Foundation API.
///
/// Content Integrity Rule: [textUthmani] is stored and displayed verbatim without any
/// normalization or alteration.
@immutable
class QuranVerse {
  const QuranVerse({
    required this.id,
    required this.verseKey,
    required this.chapterId,
    required this.verseNumber,
    required this.pageNumber,
    required this.juzNumber,
    required this.hizbNumber,
    required this.textUthmani,
    this.textImlaeiSimple = '',
    this.words = const [],
    this.translations = const [],
  });

  final int id;
  final String verseKey; // e.g. '1:1'
  final int chapterId;
  final int verseNumber;
  final int pageNumber;
  final int juzNumber;
  final int hizbNumber;
  final String textUthmani;
  final String textImlaeiSimple;
  final List<QuranWord> words;
  final List<VerseTranslation> translations;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuranVerse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          verseKey == other.verseKey &&
          chapterId == other.chapterId &&
          verseNumber == other.verseNumber &&
          pageNumber == other.pageNumber &&
          juzNumber == other.juzNumber &&
          hizbNumber == other.hizbNumber &&
          textUthmani == other.textUthmani &&
          textImlaeiSimple == other.textImlaeiSimple &&
          listEquals(words, other.words) &&
          listEquals(translations, other.translations);

  @override
  int get hashCode => Object.hash(
        id,
        verseKey,
        chapterId,
        verseNumber,
        pageNumber,
        juzNumber,
        hizbNumber,
        textUthmani,
        textImlaeiSimple,
        Object.hashAll(words),
        Object.hashAll(translations),
      );
}

/// Metadata for an available Tafsir resource in the Quran Foundation catalog.
@immutable
class TafsirResource {
  const TafsirResource({
    required this.id,
    required this.name,
    required this.authorName,
    required this.languageName,
    this.slug = '',
  });

  final int id;
  final String name;
  final String authorName;
  final String languageName;
  final String slug;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TafsirResource &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          authorName == other.authorName &&
          languageName == other.languageName &&
          slug == other.slug;

  @override
  int get hashCode => Object.hash(id, name, authorName, languageName, slug);
}

/// Scholarly Tafsir content for a specific verse.
@immutable
class VerseTafsir {
  const VerseTafsir({
    required this.tafsirId,
    required this.verseKey,
    required this.text,
    this.resourceName = '',
  });

  final int tafsirId;
  final String verseKey;
  final String text;
  final String resourceName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseTafsir &&
          runtimeType == other.runtimeType &&
          tafsirId == other.tafsirId &&
          verseKey == other.verseKey &&
          text == other.text &&
          resourceName == other.resourceName;

  @override
  int get hashCode => Object.hash(tafsirId, verseKey, text, resourceName);
}

/// Metadata for an available Translation resource in the Quran Foundation catalog.
@immutable
class TranslationResource {
  const TranslationResource({
    required this.id,
    required this.name,
    required this.authorName,
    required this.languageName,
    this.slug = '',
  });

  final int id;
  final String name;
  final String authorName;
  final String languageName;
  final String slug;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationResource &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          authorName == other.authorName &&
          languageName == other.languageName &&
          slug == other.slug;

  @override
  int get hashCode => Object.hash(id, name, authorName, languageName, slug);
}

/// Verified translation text for a specific verse.
@immutable
class VerseTranslation {
  const VerseTranslation({
    required this.translationId,
    required this.verseKey,
    required this.text,
    this.resourceName = '',
  });

  final int translationId;
  final String verseKey;
  final String text;
  final String resourceName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseTranslation &&
          runtimeType == other.runtimeType &&
          translationId == other.translationId &&
          verseKey == other.verseKey &&
          text == other.text &&
          resourceName == other.resourceName;

  @override
  int get hashCode => Object.hash(translationId, verseKey, text, resourceName);
}

/// Metadata for an audio Recitation profile in the Quran Foundation catalog.
@immutable
class RecitationResource {
  const RecitationResource({
    required this.id,
    required this.reciterName,
    this.style = '',
    this.translatedName = '',
  });

  final int id;
  final String reciterName;
  final String style; // e.g. 'Murattal' or 'Mujawwad'
  final String translatedName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecitationResource &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          reciterName == other.reciterName &&
          style == other.style &&
          translatedName == other.translatedName;

  @override
  int get hashCode => Object.hash(id, reciterName, style, translatedName);
}

/// Search match result from the Quran Foundation Search API or local verse search.
@immutable
class QuranSearchHit {
  const QuranSearchHit({
    required this.verseKey,
    required this.text,
    this.highlightedText = '',
  });

  final String verseKey;
  final String text;
  final String highlightedText;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuranSearchHit &&
          runtimeType == other.runtimeType &&
          verseKey == other.verseKey &&
          text == other.text &&
          highlightedText == other.highlightedText;

  @override
  int get hashCode => Object.hash(verseKey, text, highlightedText);
}

/// Progress snapshot emitted while downloading a text pack (chapters/translations/tafsirs) for offline use.
@immutable
class TextPackDownloadProgress {
  const TextPackDownloadProgress({
    required this.packId,
    required this.completedSteps,
    required this.totalSteps,
    required this.status,
  });

  final String packId;
  final int completedSteps;
  final int totalSteps;
  final String status; // 'active', 'completed', 'failed'

  double get fraction =>
      totalSteps <= 0 ? 0.0 : (completedSteps / totalSteps).clamp(0.0, 1.0);
}
