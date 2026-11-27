import 'package:flutter/foundation.dart';

/// Self-grading options for Phase 12 Hifz test and review sessions.
enum HifzSelfGrade {
  perfect('perfect', 5),
  hesitated('hesitated', 3),
  forgot('forgot', 1);

  const HifzSelfGrade(this.code, this.sm2Quality);

  final String code;

  /// Canonical SM-2 quality grade (`5` = Perfect, `3` = Hesitated, `1` = Forgot).
  final int sm2Quality;

  static HifzSelfGrade fromCode(String raw) {
    for (final g in values) {
      if (g.code == raw) return g;
    }
    return HifzSelfGrade.perfect;
  }
}

/// Non-destructive display-layer hide modes in the Quran Reader.
///
/// Content Integrity Rule:
/// "Quran text comes only from the Quran data layer. Hiding is a display layer; never alter stored text."
enum HifzHideMode {
  none('none'),
  hideAll('hide_all'),
  firstWordOnly('first_word_only'),
  randomPercent('random_percent'),
  hideUntilTapped('hide_until_tapped'),
  revealWordByWord('reveal_word_by_word');

  const HifzHideMode(this.code);
  final String code;

  bool get isHidingActive => this != HifzHideMode.none;
}

/// Supported Hifz testing / recitation modes.
enum HifzTestMode {
  /// Mode 1: Show the Surah and verse number, user recites from memory, then reveal and self-grade.
  reciteByVerseNumber('recite_by_number'),

  /// Mode 2: Show verse `k` and ask the user to recite verse `k + 1`, then reveal and self-grade.
  whatIsNextVerse('next_verse'),

  /// Weak-spots session: review verses recorded in the Mistake Log (`Forgot` / `Hesitated`).
  reviewMyMistakes('review_mistakes');

  const HifzTestMode(this.code);
  final String code;

  static HifzTestMode fromCode(String raw) {
    for (final m in values) {
      if (m.code == raw) return m;
    }
    return HifzTestMode.reciteByVerseNumber;
  }
}

/// Represents a memorized verse range tracked by the SM-2 spaced-review scheduler.
@immutable
class HifzMemorizedRange {
  const HifzMemorizedRange({
    required this.id,
    required this.surahNumber,
    required this.startAyah,
    required this.endAyah,
    required this.startPage,
    required this.endPage,
    required this.juzNumber,
    this.easinessFactor = 2.5,
    this.intervalDays = 1,
    this.repetitions = 0,
    this.lastReviewedDate,
    required this.nextDueDate,
    this.lastGrade = HifzSelfGrade.perfect,
  });

  final int id;
  final int surahNumber;
  final int startAyah;
  final int endAyah;
  final int startPage;
  final int endPage;
  final int juzNumber;
  final double easinessFactor;
  final int intervalDays;
  final int repetitions;
  final String? lastReviewedDate; // YYYY-MM-DD
  final String nextDueDate; // YYYY-MM-DD
  final HifzSelfGrade lastGrade;

  int get versesCount => (endAyah - startAyah + 1).clamp(1, 286);
  int get pagesCount => (endPage - startPage + 1).clamp(1, 604);

  String get rangeKey => '$surahNumber:$startAyah-$endAyah';

  HifzMemorizedRange copyWith({
    int? id,
    int? surahNumber,
    int? startAyah,
    int? endAyah,
    int? startPage,
    int? endPage,
    int? juzNumber,
    double? easinessFactor,
    int? intervalDays,
    int? repetitions,
    String? lastReviewedDate,
    String? nextDueDate,
    HifzSelfGrade? lastGrade,
  }) {
    return HifzMemorizedRange(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      juzNumber: juzNumber ?? this.juzNumber,
      easinessFactor: easinessFactor ?? this.easinessFactor,
      intervalDays: intervalDays ?? this.intervalDays,
      repetitions: repetitions ?? this.repetitions,
      lastReviewedDate: lastReviewedDate ?? this.lastReviewedDate,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      lastGrade: lastGrade ?? this.lastGrade,
    );
  }
}

/// Output of scheduling a single review in [HifzSm2Scheduler].
@immutable
class HifzSm2ScheduleUpdate {
  const HifzSm2ScheduleUpdate({
    required this.easinessFactor,
    required this.intervalDays,
    required this.repetitions,
    required this.lastReviewedDate,
    required this.nextDueDate,
    required this.grade,
  });

  final double easinessFactor;
  final int intervalDays;
  final int repetitions;
  final String lastReviewedDate;
  final String nextDueDate;
  final HifzSelfGrade grade;
}

/// Result of building today's daily review queue in [HifzSm2Scheduler].
@immutable
class HifzDailyQueueResult {
  const HifzDailyQueueResult({
    required this.dueQueue,
    required this.totalDueCount,
    required this.overdueCount,
    required this.effectiveCapToday,
    required this.isCatchUpActive,
  });

  final List<HifzMemorizedRange> dueQueue;
  final int totalDueCount;
  final int overdueCount;
  final int effectiveCapToday;
  final bool isCatchUpActive;
}

/// Single recorded mistake in `hifz_mistake_logs`.
@immutable
class HifzMistakeEntry {
  const HifzMistakeEntry({
    required this.id,
    required this.verseKey,
    required this.surahNumber,
    required this.ayahNumber,
    this.wordPosition,
    required this.grade,
    required this.localDate,
  });

  final int id;
  final String verseKey;
  final int surahNumber;
  final int ayahNumber;
  final int? wordPosition;
  final HifzSelfGrade grade;
  final String localDate;
}

/// Aggregated weak-spot summary for a specific verse across mistake logs.
@immutable
class HifzWeakSpotSummary {
  const HifzWeakSpotSummary({
    required this.verseKey,
    required this.surahNumber,
    required this.ayahNumber,
    required this.mistakeCount,
    required this.lastMistakeDate,
    this.frequentWordPositions = const [],
  });

  final String verseKey;
  final int surahNumber;
  final int ayahNumber;
  final int mistakeCount;
  final String lastMistakeDate;
  final List<int> frequentWordPositions;
}

/// Display-only word token produced by [HifzDisplayMasker].
/// Never modifies the underlying [QuranVerse].
@immutable
class HifzDisplayedWord {
  const HifzDisplayedWord({
    required this.wordPosition,
    required this.originalText,
    required this.displayText,
    required this.isHidden,
  });

  final int wordPosition;
  final String originalText;
  final String displayText;
  final bool isHidden;
}

/// Comprehensive Hifz statistics summary:
/// - Memorized totals (`verses`, `pages`, `juz`)
/// - Review streak (consecutive days with at least one review)
/// - Weekly accuracy (`0.0..1.0` over the last 7 days)
/// - Projected completion date based on `newVersesPerDayGoal`
@immutable
class HifzStatsSummary {
  const HifzStatsSummary({
    required this.memorizedVersesCount,
    required this.memorizedPagesCount,
    required this.memorizedJuzCount,
    required this.reviewStreakDays,
    required this.weeklyAccuracyFraction,
    required this.projectedCompletionDate,
    required this.remainingVersesToCompleteQuran,
  });

  static const int totalQuranVerses = 6236;

  final int memorizedVersesCount;
  final int memorizedPagesCount;
  final int memorizedJuzCount;
  final int reviewStreakDays;
  final double weeklyAccuracyFraction;
  final String? projectedCompletionDate; // YYYY-MM-DD
  final int remainingVersesToCompleteQuran;

  int get weeklyAccuracyPercent => (weeklyAccuracyFraction * 100).round();
}

/// Resumable Hifz test/review session snapshot persisted in Drift (`hifz_active_session`)
/// so a session survives the app being killed at any moment.
@immutable
class HifzSessionSnapshot {
  const HifzSessionSnapshot({
    this.isActive = false,
    this.mode = HifzTestMode.reciteByVerseNumber,
    this.rangeId,
    this.surahNumber = 1,
    this.startAyah = 1,
    this.endAyah = 7,
    this.currentIndex = 0,
    this.isRevealed = false,
    this.tappedMistakeWordPosition,
    this.verseKeys = const [],
    this.gradesByVerseKey = const {},
  });

  final bool isActive;
  final HifzTestMode mode;
  final int? rangeId;
  final int surahNumber;
  final int startAyah;
  final int endAyah;
  final int currentIndex;
  final bool isRevealed;
  final int? tappedMistakeWordPosition;
  final List<String> verseKeys;
  final Map<String, HifzSelfGrade> gradesByVerseKey;

  String? get currentVerseKey {
    if (verseKeys.isEmpty) return null;
    final idx = currentIndex.clamp(0, verseKeys.length - 1);
    return verseKeys[idx];
  }

  /// For [HifzTestMode.whatIsNextVerse], returns the prompt verse (`currentIndex`)
  /// while the target verse to recite & grade is `currentIndex + 1`.
  String? get nextTargetVerseKey {
    if (verseKeys.isEmpty) return null;
    if (mode == HifzTestMode.whatIsNextVerse) {
      final nextIdx = (currentIndex + 1).clamp(0, verseKeys.length - 1);
      return verseKeys[nextIdx];
    }
    return currentVerseKey;
  }

  HifzSessionSnapshot copyWith({
    bool? isActive,
    HifzTestMode? mode,
    int? rangeId,
    int? surahNumber,
    int? startAyah,
    int? endAyah,
    int? currentIndex,
    bool? isRevealed,
    int? tappedMistakeWordPosition,
    bool clearTappedWord = false,
    List<String>? verseKeys,
    Map<String, HifzSelfGrade>? gradesByVerseKey,
  }) {
    return HifzSessionSnapshot(
      isActive: isActive ?? this.isActive,
      mode: mode ?? this.mode,
      rangeId: rangeId ?? this.rangeId,
      surahNumber: surahNumber ?? this.surahNumber,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      currentIndex: currentIndex ?? this.currentIndex,
      isRevealed: isRevealed ?? this.isRevealed,
      tappedMistakeWordPosition: clearTappedWord
          ? null
          : (tappedMistakeWordPosition ?? this.tappedMistakeWordPosition),
      verseKeys: verseKeys ?? this.verseKeys,
      gradesByVerseKey: gradesByVerseKey ?? this.gradesByVerseKey,
    );
  }
}

/// Extension point entity for Similar Verses (Mutashabihat).
/// Populated ONLY if the user provides a verified `assets/data/mutashabihat.json` dataset.
@immutable
class MutashabihatPair {
  const MutashabihatPair({
    required this.id,
    required this.firstVerseKey,
    required this.secondVerseKey,
    this.noteAr,
    this.noteEn,
    required this.sourceAttribution,
  });

  final String id;
  final String firstVerseKey;
  final String secondVerseKey;
  final String? noteAr;
  final String? noteEn;
  final String sourceAttribution;

  factory MutashabihatPair.fromJson(Map<String, dynamic> json) {
    return MutashabihatPair(
      id: (json['id'] ?? '').toString(),
      firstVerseKey: (json['first_verse_key'] ?? '').toString(),
      secondVerseKey: (json['second_verse_key'] ?? '').toString(),
      noteAr: json['note_ar']?.toString(),
      noteEn: json['note_en']?.toString(),
      sourceAttribution: (json['source'] ?? '').toString(),
    );
  }
}
