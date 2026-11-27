import '../../../quran/domain/entities/quran_entities.dart';

/// Sorts reciters from the Quran Foundation API so that **Egyptian reciters appear first**,
/// while preserving their style (`Murattal`, `Mujawwad`, `Muallim`) and original relative order.
abstract final class ReciterSorter {
  static const List<String> _egyptianReciterKeywords = [
    // English patterns
    'husary',
    'hussary',
    'minshawi',
    'minshawy',
    'abdulbaset',
    'abdul basit',
    'abdulsamad',
    'tablaway',
    'tablawi',
    'mustafa ismail',
    'banna',
    'jibril',
    'jebril',
    // Arabic patterns
    'الحصري',
    'المنشاوي',
    'عبد الباسط',
    'عبدالباسط',
    'الطبلاوي',
    'مصطفى إسماعيل',
    'البنا',
    'جبريل',
  ];

  /// Returns true if [reciter] matches a known Egyptian Qari in English or Arabic.
  static bool isEgyptianReciter(RecitationResource reciter) {
    final combined =
        '${reciter.reciterName} ${reciter.translatedName}'.toLowerCase();
    for (final keyword in _egyptianReciterKeywords) {
      if (combined.contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  /// Stable sort placing Egyptian reciters first, preserving the relative order within each group.
  static List<RecitationResource> sortEgyptianFirst(
    List<RecitationResource> reciters,
  ) {
    final egyptian = <RecitationResource>[];
    final others = <RecitationResource>[];

    for (final r in reciters) {
      if (isEgyptianReciter(r)) {
        egyptian.add(r);
      } else {
        others.add(r);
      }
    }

    return <RecitationResource>[...egyptian, ...others];
  }

  /// Formats the display label of a reciter including their recitation style (`Murattal` / `Mujawwad`) when provided.
  static String formatDisplayName(
    RecitationResource reciter, {
    required String languageCode,
  }) {
    final baseName =
        (languageCode == 'ar' && reciter.translatedName.trim().isNotEmpty)
            ? reciter.translatedName.trim()
            : reciter.reciterName.trim();

    final rawStyle = reciter.style.trim();
    if (rawStyle.isEmpty) {
      return baseName;
    }

    final localizedStyle = _localizeStyle(rawStyle, languageCode);
    return '$baseName ($localizedStyle)';
  }

  static String _localizeStyle(String style, String languageCode) {
    if (languageCode != 'ar') return style;
    return switch (style.toLowerCase()) {
      'murattal' => 'مرتل',
      'mujawwad' => 'مجود',
      'muallim' => 'المعلم',
      _ => style,
    };
  }
}
