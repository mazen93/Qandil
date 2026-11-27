import 'dart:math' as math;

import '../../../quran/domain/entities/quran_entities.dart';
import '../entities/hifz_entities.dart';

/// Pure display-layer word masker for Phase 12 Memorization (Hifz) Hide Modes.
///
/// Content Integrity Rule (Highest Priority):
/// "Quran text comes only from the Quran data layer. Hiding is a display layer; never alter stored text."
///
/// This class transforms a [QuranVerse] into a list of [HifzDisplayedWord] tokens
/// for rendering in the UI without mutating [verse.textUthmani] or [verse.words].
abstract final class HifzDisplayMasker {
  static const String hiddenWordPlaceholder = '••••';

  /// Extracts the authentic Uthmani words of [verse] without altering any characters.
  static List<String> extractWords(QuranVerse verse) {
    if (verse.words.isNotEmpty) {
      final fromWords = verse.words
          .where(
              (w) => w.charTypeName != 'end' && w.textUthmani.trim().isNotEmpty)
          .map((w) => w.textUthmani)
          .toList(growable: false);
      if (fromWords.isNotEmpty) {
        return fromWords;
      }
    }
    return verse.textUthmani
        .split(RegExp(r'\s+'))
        .where((token) => token.isNotEmpty)
        .toList(growable: false);
  }

  /// Builds display tokens for [verse] under [mode]:
  /// - [HifzHideMode.none]: All words visible.
  /// - [HifzHideMode.hideAll]: Every word is masked as `••••`.
  /// - [HifzHideMode.firstWordOnly]: Word 1 (`index == 0`) is visible; words `2..N` are masked.
  /// - [HifzHideMode.randomPercent]: Deterministically hides [randomHidePercent] (`1..100`) of words
  ///   using a deterministic seed (`verse.verseKey.hashCode ^ randomSeed`).
  /// - [HifzHideMode.hideUntilTapped]: Masked when [isVerseTapped] is `false`, visible when `true`.
  /// - [HifzHideMode.revealWordByWord]: Words `0 .. revealedWordCount - 1` are visible; remaining words are masked.
  static List<HifzDisplayedWord> buildDisplayWords({
    required QuranVerse verse,
    required HifzHideMode mode,
    int randomHidePercent = 50,
    int randomSeed = 42,
    bool isVerseTapped = false,
    int revealedWordCount = 0,
  }) {
    final words = extractWords(verse);
    if (words.isEmpty) return const [];

    final total = words.length;
    final hiddenIndices = <int>{};

    switch (mode) {
      case HifzHideMode.none:
        break;
      case HifzHideMode.hideAll:
        for (var i = 0; i < total; i++) {
          hiddenIndices.add(i);
        }
      case HifzHideMode.firstWordOnly:
        for (var i = 1; i < total; i++) {
          hiddenIndices.add(i);
        }
      case HifzHideMode.randomPercent:
        final clampedPercent = randomHidePercent.clamp(0, 100);
        final targetHideCount =
            ((total * clampedPercent) / 100.0).round().clamp(
                  clampedPercent > 0 ? 1 : 0,
                  total,
                );
        final indices = List<int>.generate(total, (i) => i);
        final rng = math.Random(verse.verseKey.hashCode ^ randomSeed);
        indices.shuffle(rng);
        hiddenIndices.addAll(indices.take(targetHideCount));
      case HifzHideMode.hideUntilTapped:
        if (!isVerseTapped) {
          for (var i = 0; i < total; i++) {
            hiddenIndices.add(i);
          }
        }
      case HifzHideMode.revealWordByWord:
        final safeRevealed = revealedWordCount.clamp(0, total);
        for (var i = safeRevealed; i < total; i++) {
          hiddenIndices.add(i);
        }
    }

    return List<HifzDisplayedWord>.generate(total, (i) {
      final original = words[i];
      final hide = hiddenIndices.contains(i);
      return HifzDisplayedWord(
        wordPosition: i + 1,
        originalText: original,
        displayText: hide ? hiddenWordPlaceholder : original,
        isHidden: hide,
      );
    }, growable: false);
  }

  /// Formats the display tokens into a single display string for Mushaf or Verse List rendering.
  static String formatMaskedVerseText({
    required QuranVerse verse,
    required HifzHideMode mode,
    int randomHidePercent = 50,
    int randomSeed = 42,
    bool isVerseTapped = false,
    int revealedWordCount = 0,
  }) {
    if (mode == HifzHideMode.none) {
      return verse.textUthmani;
    }
    final tokens = buildDisplayWords(
      verse: verse,
      mode: mode,
      randomHidePercent: randomHidePercent,
      randomSeed: randomSeed,
      isVerseTapped: isVerseTapped,
      revealedWordCount: revealedWordCount,
    );
    return tokens.map((t) => t.displayText).join(' ');
  }
}
