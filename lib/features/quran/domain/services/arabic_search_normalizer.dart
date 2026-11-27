import '../entities/quran_entities.dart';

/// Arabic search normalizer for the Phase 3 Quran Reader.
///
/// Content Integrity Rule (Highest Priority):
/// - Normalization is performed **in memory for search matching ONLY — NEVER for display**.
/// - [filterVerses] always returns the original, unaltered [QuranVerse] instances
///   with verbatim `textUthmani`.
abstract final class ArabicSearchNormalizer {
  // Matches Arabic diacritics (tashkeel/harakat), Quranic pause marks, dagger alef, and tatweel.
  static final RegExp _diacriticsAndMarksRegex = RegExp(
    r'[\u0640\u064B-\u065F\u0670\u06D6-\u06ED\u08F0-\u08FF]',
  );

  /// Normalizes an Arabic string strictly for search comparison.
  /// Never display the return value of this function to the user as Quran text!
  static String normalizeForMatchingOnly(String input) {
    if (input.isEmpty) return '';

    var result = input.replaceAll(_diacriticsAndMarksRegex, '');

    // Unify Alef variants (أ إ آ ٱ -> ا)
    result = result
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ٱ', 'ا');

    // Unify Alef Maksura / Ya and Teh Marbuta / Heh for tolerant search matching
    result = result
        .replaceAll('ى', 'ي')
        .replaceAll('ة', 'ه')
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ي');

    // Collapse multiple whitespace
    result = result.replaceAll(RegExp(r'\s+'), ' ').trim();
    return result;
  }

  /// Checks whether [verse] matches [rawQuery] using normalized comparison,
  /// while preserving [verse] completely unaltered.
  static bool matchesVerse(QuranVerse verse, String rawQuery) {
    final normalizedQuery = normalizeForMatchingOnly(rawQuery);
    if (normalizedQuery.isEmpty) return false;

    final normalizedUthmani = normalizeForMatchingOnly(verse.textUthmani);
    if (normalizedUthmani.contains(normalizedQuery)) {
      return true;
    }

    if (verse.textImlaeiSimple.isNotEmpty) {
      final normalizedImlaei = normalizeForMatchingOnly(verse.textImlaeiSimple);
      if (normalizedImlaei.contains(normalizedQuery)) {
        return true;
      }
    }

    return false;
  }

  /// Filters [verses] matching [rawQuery] and returns the original unaltered [QuranVerse] objects.
  static List<QuranVerse> filterVerses(
    List<QuranVerse> verses,
    String rawQuery,
  ) {
    final normalizedQuery = normalizeForMatchingOnly(rawQuery);
    if (normalizedQuery.isEmpty) return const [];

    return verses
        .where((verse) => matchesVerse(verse, rawQuery))
        .toList(growable: false);
  }
}
