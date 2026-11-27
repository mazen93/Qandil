import 'dart:math' as math;

import '../entities/hifz_entities.dart';

/// Pure Dart SM-2 style spaced-repetition scheduler for Phase 12 Memorization (Hifz):
/// - Configurable initial intervals (`[1, 3, 7, 14, 30, 60]` days by default).
/// - DST- and timezone-safe calendar-ordinal date arithmetic (`YYYY-MM-DD` converted to UTC midnight).
/// - Self-grade transitions (`Perfect`, `Hesitated`, `Forgot`).
/// - Daily review queue with configurable cap, overdue prioritization, and a **Catch-Up Mode**
///   that spreads accumulated overdue reviews across `catchUpSpreadDays`.
/// - Statistics calculation (memorized verses/pages/juz, review streak, weekly accuracy, projected completion date).
class HifzSm2Scheduler {
  const HifzSm2Scheduler({
    this.initialIntervalsDays = defaultInitialIntervalsDays,
    this.minEasinessFactor = 1.3,
    this.maxIntervalDays = 365,
  });

  static const List<int> defaultInitialIntervalsDays = [1, 3, 7, 14, 30, 60];

  final List<int> initialIntervalsDays;
  final double minEasinessFactor;
  final int maxIntervalDays;

  /// Formats a local [DateTime] into `YYYY-MM-DD`.
  static String formatLocalDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Parses `YYYY-MM-DD` into a DST-free UTC midnight [DateTime].
  static DateTime? parseCalendarDateToUtc(String yyyyMmDd) {
    final parts = yyyyMmDd.split('-');
    if (parts.length != 3) return null;
    final y = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final d = int.tryParse(parts[2]);
    if (y == null || m == null || d == null) return null;
    return DateTime.utc(y, m, d);
  }

  /// Computes exact calendar days between [earlierDate] and [laterDate] (`laterDate - earlierDate`),
  /// immune to 23-hour (DST Spring-Forward) or 25-hour (DST Fall-Back) transitions.
  static int calendarDaysBetween(String earlierDate, String laterDate) {
    final a = parseCalendarDateToUtc(earlierDate);
    final b = parseCalendarDateToUtc(laterDate);
    if (a == null || b == null) return 0;
    return b.difference(a).inDays;
  }

  /// Adds [deltaDays] calendar days to `YYYY-MM-DD` using DST-free UTC date math.
  static String addCalendarDays(String yyyyMmDd, int deltaDays) {
    final baseUtc = parseCalendarDateToUtc(yyyyMmDd);
    if (baseUtc == null) return yyyyMmDd;
    final shifted = DateTime.utc(
      baseUtc.year,
      baseUtc.month,
      baseUtc.day + deltaDays,
    );
    return formatLocalDate(shifted);
  }

  /// Computes the next SM-2 state after reviewing [range] on [reviewDate] (`YYYY-MM-DD`) with [grade].
  HifzSm2ScheduleUpdate scheduleNext({
    required HifzMemorizedRange range,
    required HifzSelfGrade grade,
    required String reviewDate,
  }) {
    final currentEf = math.max(minEasinessFactor, range.easinessFactor);
    final currentReps = math.max(0, range.repetitions);
    final currentInterval = math.max(1, range.intervalDays);

    late final double nextEf;
    late final int nextReps;
    late final int nextInterval;

    switch (grade) {
      case HifzSelfGrade.perfect:
        nextReps = currentReps + 1;
        nextEf = math.max(minEasinessFactor, currentEf + 0.1);
        if (currentReps < initialIntervalsDays.length && currentReps < 2) {
          nextInterval = initialIntervalsDays[currentReps];
        } else {
          nextInterval =
              (currentInterval * nextEf).round().clamp(1, maxIntervalDays);
        }
      case HifzSelfGrade.hesitated:
        nextReps = currentReps + 1;
        nextEf = math.max(minEasinessFactor, currentEf - 0.14);
        if (currentReps == 0) {
          nextInterval = 1;
        } else {
          nextInterval = math
              .max(1, (currentInterval * 1.2).round())
              .clamp(1, maxIntervalDays);
        }
      case HifzSelfGrade.forgot:
        nextReps = 0;
        nextEf = math.max(minEasinessFactor, currentEf - 0.2);
        nextInterval = 1;
    }

    final nextDue = addCalendarDays(reviewDate, nextInterval);

    return HifzSm2ScheduleUpdate(
      easinessFactor: double.parse(nextEf.toStringAsFixed(2)),
      intervalDays: nextInterval,
      repetitions: nextReps,
      lastReviewedDate: reviewDate,
      nextDueDate: nextDue,
      grade: grade,
    );
  }

  /// Builds today's daily review queue for [todayDate] (`YYYY-MM-DD`):
  /// - Filters ranges whose `nextDueDate <= todayDate`.
  /// - Sorts overdue items first (largest `overdueDays` first), then lowest `easinessFactor`, then lowest `id`.
  /// - When [catchUpMode] is `true` and there are overdue items (`nextDueDate < todayDate`),
  ///   spreads the total due backlog evenly over [catchUpSpreadDays] (`ceil(totalDue / catchUpSpreadDays)`),
  ///   capped by [dailyCap].
  HifzDailyQueueResult buildDailyQueue({
    required List<HifzMemorizedRange> allRanges,
    required String todayDate,
    int dailyCap = 5,
    bool catchUpMode = false,
    int catchUpSpreadDays = 3,
  }) {
    final safeCap = math.max(1, dailyCap);
    final safeSpreadDays = math.max(1, catchUpSpreadDays);

    final dueItems = <HifzMemorizedRange>[];
    var overdueCount = 0;

    for (final range in allRanges) {
      final diff = calendarDaysBetween(range.nextDueDate, todayDate);
      if (diff >= 0) {
        dueItems.add(range);
        if (diff > 0) {
          overdueCount++;
        }
      }
    }

    // Sort: most overdue first -> lowest EF first -> oldest id first
    dueItems.sort((a, b) {
      final overdueA = calendarDaysBetween(a.nextDueDate, todayDate);
      final overdueB = calendarDaysBetween(b.nextDueDate, todayDate);
      final cmpOverdue = overdueB.compareTo(overdueA);
      if (cmpOverdue != 0) return cmpOverdue;

      final cmpEf = a.easinessFactor.compareTo(b.easinessFactor);
      if (cmpEf != 0) return cmpEf;

      return a.id.compareTo(b.id);
    });

    var effectiveCap = safeCap;
    if (catchUpMode && dueItems.isNotEmpty) {
      final spreadPerDay = (dueItems.length / safeSpreadDays).ceil();
      effectiveCap = math.min(safeCap, math.max(1, spreadPerDay));
    }

    final limitedQueue = dueItems.take(effectiveCap).toList(growable: false);

    return HifzDailyQueueResult(
      dueQueue: limitedQueue,
      totalDueCount: dueItems.length,
      overdueCount: overdueCount,
      effectiveCapToday: effectiveCap,
      isCatchUpActive: catchUpMode && overdueCount > 0,
    );
  }

  /// Computes comprehensive Hifz statistics:
  /// - Total memorized verses, pages, and Juz
  /// - Consecutive review streak (DST-safe)
  /// - Weekly accuracy over the last 7 calendar days (`Perfect = 1.0`, `Hesitated = 0.5`, `Forgot = 0.0`)
  /// - Projected completion date based on [newVersesPerDayGoal]
  static HifzStatsSummary computeStats({
    required List<HifzMemorizedRange> ranges,
    required List<({String localDate, HifzSelfGrade grade})> reviewEvents,
    required String todayDate,
    int newVersesPerDayGoal = 5,
  }) {
    var totalVerses = 0;
    final uniquePages = <int>{};
    final uniqueJuz = <int>{};

    for (final r in ranges) {
      totalVerses += r.versesCount;
      for (var p = r.startPage; p <= r.endPage; p++) {
        uniquePages.add(p);
      }
      uniqueJuz.add(r.juzNumber);
    }

    final clampedVerses =
        totalVerses.clamp(0, HifzStatsSummary.totalQuranVerses);
    final remainingVerses = math.max(
      0,
      HifzStatsSummary.totalQuranVerses - clampedVerses,
    );

    // Consecutive review streak
    final activeReviewDates =
        reviewEvents.map((e) => e.localDate).toSet().toList()..sort();
    final streak = _computeReviewStreak(
      sortedActiveDates: activeReviewDates,
      todayDate: todayDate,
    );

    // 7-day weekly accuracy
    final sevenDaysStart = addCalendarDays(todayDate, -6);
    var weeklyWeightSum = 0.0;
    var weeklyCount = 0;
    for (final ev in reviewEvents) {
      if (ev.localDate.compareTo(sevenDaysStart) >= 0 &&
          ev.localDate.compareTo(todayDate) <= 0) {
        weeklyCount++;
        weeklyWeightSum += switch (ev.grade) {
          HifzSelfGrade.perfect => 1.0,
          HifzSelfGrade.hesitated => 0.5,
          HifzSelfGrade.forgot => 0.0,
        };
      }
    }
    final weeklyAccuracy = weeklyCount == 0
        ? 1.0
        : (weeklyWeightSum / weeklyCount).clamp(0.0, 1.0);

    // Projected completion date
    String? projectedDate;
    if (remainingVerses == 0) {
      projectedDate = todayDate;
    } else if (newVersesPerDayGoal > 0) {
      final daysNeeded = (remainingVerses / newVersesPerDayGoal).ceil();
      projectedDate = addCalendarDays(todayDate, daysNeeded);
    }

    return HifzStatsSummary(
      memorizedVersesCount: clampedVerses,
      memorizedPagesCount: uniquePages.length,
      memorizedJuzCount: uniqueJuz.length,
      reviewStreakDays: streak,
      weeklyAccuracyFraction: weeklyAccuracy,
      projectedCompletionDate: projectedDate,
      remainingVersesToCompleteQuran: remainingVerses,
    );
  }

  /// Builds the adaptive daily Hifz review reminder text based on [dueQueueSize].
  static String buildAdaptiveReviewReminderBody({
    required int dueQueueSize,
    required int overdueCount,
    required String languageCode,
  }) {
    final isAr = languageCode == 'ar';
    if (dueQueueSize <= 0) {
      return isAr
          ? 'أتممت مراجعة محفوظك اليوم — يمكنك تثبيت آيات جديدة في خطة الحفظ.'
          : 'Your Hifz review queue is clear today — great time to memorize new verses.';
    }
    if (overdueCount > 0) {
      return isAr
          ? 'لديك $dueQueueSize مقاطع للمراجعة اليوم (منها $overdueCount فائتة) — افتح قنديل لتثبيت حفظك.'
          : 'You have $dueQueueSize Hifz ranges due today ($overdueCount overdue) — open Qandil to review.';
    }
    return isAr
        ? 'حان موعد مراجعة الحفظ: لديك $dueQueueSize مقاطع مجدولة للمراجعة اليوم.'
        : 'Time for your Hifz review: $dueQueueSize verse range(s) scheduled for today.';
  }

  static int _computeReviewStreak({
    required List<String> sortedActiveDates,
    required String todayDate,
  }) {
    if (sortedActiveDates.isEmpty) return 0;
    final activeSet = sortedActiveDates.toSet();
    final yesterdayDate = addCalendarDays(todayDate, -1);

    String? anchor;
    if (activeSet.contains(todayDate)) {
      anchor = todayDate;
    } else if (activeSet.contains(yesterdayDate)) {
      anchor = yesterdayDate;
    }
    if (anchor == null) return 0;

    var streak = 0;
    var cursor = anchor;
    while (activeSet.contains(cursor)) {
      streak++;
      cursor = addCalendarDays(cursor, -1);
    }
    return streak;
  }
}
