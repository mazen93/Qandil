import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/hifz/domain/entities/hifz_entities.dart';
import 'package:qandil/features/hifz/domain/services/hifz_display_masker.dart';
import 'package:qandil/features/quran/domain/entities/quran_entities.dart';

void main() {
  group('Phase 12: HifzDisplayMasker Non-Destructive Hide Modes Tests', () {
    const sampleVerse = QuranVerse(
      id: 1,
      verseKey: '1:1',
      chapterId: 1,
      verseNumber: 1,
      pageNumber: 1,
      juzNumber: 1,
      hizbNumber: 1,
      textUthmani: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
      textImlaeiSimple: 'بسم الله الرحمن الرحيم',
    );

    test(
        'all 5 hide modes mask display tokens accurately and NEVER alter stored QuranVerse textUthmani',
        () {
      const originalUthmani = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ';

      // 1. Hide All
      final hideAllTokens = HifzDisplayMasker.buildDisplayWords(
        verse: sampleVerse,
        mode: HifzHideMode.hideAll,
      );
      expect(hideAllTokens.length, 4);
      expect(hideAllTokens.every((t) => t.isHidden), isTrue);
      expect(
        hideAllTokens.every(
          (t) => t.displayText == HifzDisplayMasker.hiddenWordPlaceholder,
        ),
        isTrue,
      );

      // 2. Show only first word of each verse
      final firstWordTokens = HifzDisplayMasker.buildDisplayWords(
        verse: sampleVerse,
        mode: HifzHideMode.firstWordOnly,
      );
      expect(firstWordTokens[0].isHidden, isFalse);
      expect(firstWordTokens[0].displayText, 'بِسْمِ');
      expect(firstWordTokens[1].isHidden, isTrue);
      expect(firstWordTokens[2].isHidden, isTrue);
      expect(firstWordTokens[3].isHidden, isTrue);

      // 3. Hide random N% of words (50% of 4 words = 2 hidden words)
      final random50Tokens = HifzDisplayMasker.buildDisplayWords(
        verse: sampleVerse,
        mode: HifzHideMode.randomPercent,
        randomHidePercent: 50,
      );
      expect(random50Tokens.where((t) => t.isHidden).length, 2);
      expect(random50Tokens.where((t) => !t.isHidden).length, 2);

      // 4. Hide until tapped
      final untappedTokens = HifzDisplayMasker.buildDisplayWords(
        verse: sampleVerse,
        mode: HifzHideMode.hideUntilTapped,
        isVerseTapped: false,
      );
      expect(untappedTokens.every((t) => t.isHidden), isTrue);

      final tappedTokens = HifzDisplayMasker.buildDisplayWords(
        verse: sampleVerse,
        mode: HifzHideMode.hideUntilTapped,
        isVerseTapped: true,
      );
      expect(tappedTokens.every((t) => !t.isHidden), isTrue);

      // 5. Reveal word by word (2 words revealed out of 4)
      final wordByWordTokens = HifzDisplayMasker.buildDisplayWords(
        verse: sampleVerse,
        mode: HifzHideMode.revealWordByWord,
        revealedWordCount: 2,
      );
      expect(wordByWordTokens[0].isHidden, isFalse);
      expect(wordByWordTokens[1].isHidden, isFalse);
      expect(wordByWordTokens[2].isHidden, isTrue);
      expect(wordByWordTokens[3].isHidden, isTrue);

      // CRITICAL CONTENT INTEGRITY CHECK: underlying sampleVerse.textUthmani is 100% unchanged!
      expect(sampleVerse.textUthmani, originalUthmani);
    });
  });
}
