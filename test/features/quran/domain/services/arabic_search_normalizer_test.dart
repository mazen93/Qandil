import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/quran/domain/entities/quran_entities.dart';
import 'package:qandil/features/quran/domain/services/arabic_search_normalizer.dart';

void main() {
  const sampleVerses = [
    QuranVerse(
      id: 1,
      verseKey: '1:1',
      chapterId: 1,
      verseNumber: 1,
      pageNumber: 1,
      juzNumber: 1,
      hizbNumber: 1,
      textUthmani: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
      textImlaeiSimple: 'بسم الله الرحمن الرحيم',
    ),
    QuranVerse(
      id: 2,
      verseKey: '1:2',
      chapterId: 1,
      verseNumber: 2,
      pageNumber: 1,
      juzNumber: 1,
      hizbNumber: 1,
      textUthmani: 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ',
      textImlaeiSimple: 'الحمد لله رب العالمين',
    ),
  ];

  group('ArabicSearchNormalizer', () {
    test(
        'matches unvocalized Arabic query against Uthmani verse and returns unaltered textUthmani for display',
        () {
      final results = ArabicSearchNormalizer.filterVerses(
        sampleVerses,
        'الحمد لله',
      );

      expect(results.length, 1);
      expect(results.first.verseKey, '1:2');
      // Content Integrity check: returned verse textUthmani must be 100% unaltered
      expect(
        results.first.textUthmani,
        'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ',
      );
    });

    test(
        'normalizes Alef variants (أ إ آ ٱ) and strips tatweel and tashkeel for matching',
        () {
      final results = ArabicSearchNormalizer.filterVerses(
        sampleVerses,
        'ألحمد',
      );
      expect(results.length, 1);
      expect(results.first.verseKey, '1:2');
    });
  });
}
