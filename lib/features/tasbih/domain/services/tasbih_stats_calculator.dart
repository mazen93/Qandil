import 'dart:math' as math;

import '../entities/tasbih_entities.dart';

/// Input record representing a row from `tasbih_daily` (`date`, `dhikrId`, `total`).
class TasbihDailyEntry {
  const TasbihDailyEntry({
    required this.date,
    required this.dhikrId,
    required this.total,
  });

  final String
      date; // YYYY-MM-DD in user's local timezone at the moment of the tap
  final String dhikrId;
  final int total;
}

/// Pure, deterministic Dart calculator for Phase 7 Tasbih statistics and streaks.
///
/// Day-Boundary, Timezone, and DST Safety:
/// - All daily records are keyed by their local calendar date (`YYYY-MM-DD`).
/// - Calendar day arithmetic converts `YYYY-MM-DD` to a UTC midnight proleptic
///   Gregorian ordinal (`DateTime.utc(y, m, d)`), so consecutive calendar days
///   always differ by exactly `1` day (`86400` UTC seconds), completely immune to
///   23-hour (DST Spring-Forward) or 25-hour (DST Fall-Back) local clock shifts.
abstract final class TasbihStatsCalculator {
  /// Formats a local [DateTime] into the canonical `YYYY-MM-DD` local date key.
  static String formatLocalDate(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Parses a `YYYY-MM-DD` string into a DST-free UTC calendar date (`DateTime.utc(y, m, d)`).
  static DateTime? parseCalendarDateToUtc(String yyyyMmDd) {
    final parts = yyyyMmDd.split('-');
    if (parts.length != 3) return null;
    final y = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final d = int.tryParse(parts[2]);
    if (y == null || m == null || d == null) return null;
    return DateTime.utc(y, m, d);
  }

  /// Computes the exact number of calendar days between two `YYYY-MM-DD` date strings
  /// (`laterDate - earlierDate`), completely unaffected by local DST transitions.
  static int calendarDaysBetween(String earlierDate, String laterDate) {
    final a = parseCalendarDateToUtc(earlierDate);
    final b = parseCalendarDateToUtc(laterDate);
    if (a == null || b == null) return 0;
    return b.difference(a).inDays;
  }

  /// Adds [deltaDays] calendar days to a `YYYY-MM-DD` string using DST-free UTC calendar math.
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

  /// Computes Current Streak, Best Streak, Period Totals (`today`, `7 days`, `30 days`, `all time`),
  /// Chart series, and Per-Dhikr Breakdown from raw `tasbih_daily` entries.
  static TasbihStatsSummary computeSummary({
    required List<TasbihDailyEntry> entries,
    required DateTime nowLocal,
    TasbihStatsPeriod period = TasbihStatsPeriod.sevenDays,
  }) {
    final todayKey = formatLocalDate(nowLocal);

    // 1. Aggregate total per date across all dhikrs
    final totalsByDate = <String, int>{};
    for (final entry in entries) {
      if (entry.total <= 0) continue;
      totalsByDate[entry.date] = (totalsByDate[entry.date] ?? 0) + entry.total;
    }

    // 2. Compute Current Streak & Best Streak across active dates (total > 0)
    final activeDates = totalsByDate.keys.toList()..sort();
    final streaks = _computeStreaks(
      sortedActiveDates: activeDates,
      todayKey: todayKey,
    );

    // 3. Compute Totals for Today, 7 Days, 30 Days, All Time
    final sevenDaysStartKey = addCalendarDays(todayKey, -6);
    final thirtyDaysStartKey = addCalendarDays(todayKey, -29);

    var todayTotal = 0;
    var sevenDaysTotal = 0;
    var thirtyDaysTotal = 0;
    var allTimeTotal = 0;

    final perDhikrBreakdown = <String, int>{};

    for (final entry in entries) {
      if (entry.total <= 0) continue;
      allTimeTotal += entry.total;

      final isToday = entry.date == todayKey;
      final isWithin7Days = entry.date.compareTo(sevenDaysStartKey) >= 0 &&
          entry.date.compareTo(todayKey) <= 0;
      final isWithin30Days = entry.date.compareTo(thirtyDaysStartKey) >= 0 &&
          entry.date.compareTo(todayKey) <= 0;

      if (isToday) {
        todayTotal += entry.total;
      }
      if (isWithin7Days) {
        sevenDaysTotal += entry.total;
      }
      if (isWithin30Days) {
        thirtyDaysTotal += entry.total;
      }

      final includeInPeriod = switch (period) {
        TasbihStatsPeriod.today => isToday,
        TasbihStatsPeriod.sevenDays => isWithin7Days,
        TasbihStatsPeriod.thirtyDays => isWithin30Days,
        TasbihStatsPeriod.allTime => true,
      };

      if (includeInPeriod) {
        perDhikrBreakdown[entry.dhikrId] =
            (perDhikrBreakdown[entry.dhikrId] ?? 0) + entry.total;
      }
    }

    final periodTotal = switch (period) {
      TasbihStatsPeriod.today => todayTotal,
      TasbihStatsPeriod.sevenDays => sevenDaysTotal,
      TasbihStatsPeriod.thirtyDays => thirtyDaysTotal,
      TasbihStatsPeriod.allTime => allTimeTotal,
    };

    // 4. Build daily chart series for the active period
    final chartDaysCount = switch (period) {
      TasbihStatsPeriod.today => 1,
      TasbihStatsPeriod.sevenDays => 7,
      TasbihStatsPeriod.thirtyDays => 30,
      TasbihStatsPeriod.allTime => 14,
    };

    final chartStartKey = addCalendarDays(todayKey, -(chartDaysCount - 1));
    final dailyChartPoints = List<TasbihDailyPoint>.generate(chartDaysCount, (
      i,
    ) {
      final dateKey = addCalendarDays(chartStartKey, i);
      return TasbihDailyPoint(
        localDate: dateKey,
        totalCount: totalsByDate[dateKey] ?? 0,
      );
    }, growable: false);

    return TasbihStatsSummary(
      period: period,
      todayTotal: todayTotal,
      sevenDaysTotal: sevenDaysTotal,
      thirtyDaysTotal: thirtyDaysTotal,
      allTimeTotal: allTimeTotal,
      periodTotal: periodTotal,
      currentStreakDays: streaks.currentStreak,
      bestStreakDays: streaks.bestStreak,
      dailyChartPoints: dailyChartPoints,
      perDhikrBreakdown: perDhikrBreakdown,
    );
  }

  /// Builds the adaptive Phase 7 Tasbih reminder text using local data only:
  /// adapts when today's goal is not yet reached vs. when today's goal has been achieved.
  static String buildAdaptiveReminderBody({
    required int todayTotal,
    required int dailyGoal,
    required int currentStreakDays,
    required String languageCode,
  }) {
    final safeGoal = dailyGoal <= 0 ? 33 : dailyGoal;
    final remaining = math.max(0, safeGoal - todayTotal);
    final isAr = languageCode == 'ar';

    if (remaining > 0) {
      if (isAr) {
        return 'سبّحت اليوم $todayTotal من أصل $safeGoal — متبقي $remaining تسبيحة لإتمام هدفك اليومي والحفاظ على تتابعك.';
      }
      return 'You have completed $todayTotal of $safeGoal today — $remaining more to reach today\'s tasbih goal.';
    }

    if (isAr) {
      return 'أتممت هدفك اليومي ($todayTotal تسبيحة) • أيام المواظبة المتتالية: $currentStreakDays.';
    }
    return 'Today\'s tasbih goal reached ($todayTotal)! Current streak: $currentStreakDays days.';
  }

  static ({int currentStreak, int bestStreak}) _computeStreaks({
    required List<String> sortedActiveDates,
    required String todayKey,
  }) {
    if (sortedActiveDates.isEmpty) {
      return (currentStreak: 0, bestStreak: 0);
    }

    var bestStreak = 1;
    var runningStreak = 1;

    for (var i = 1; i < sortedActiveDates.length; i++) {
      final prevDate = sortedActiveDates[i - 1];
      final currDate = sortedActiveDates[i];
      final diffDays = calendarDaysBetween(prevDate, currDate);

      if (diffDays == 1) {
        runningStreak++;
        if (runningStreak > bestStreak) {
          bestStreak = runningStreak;
        }
      } else if (diffDays > 1) {
        runningStreak = 1;
      }
    }

    // Current streak: must end on either `todayKey` or `yesterdayKey`
    final yesterdayKey = addCalendarDays(todayKey, -1);
    final activeSet = sortedActiveDates.toSet();

    String? anchorDate;
    if (activeSet.contains(todayKey)) {
      anchorDate = todayKey;
    } else if (activeSet.contains(yesterdayKey)) {
      anchorDate = yesterdayKey;
    }

    if (anchorDate == null) {
      return (currentStreak: 0, bestStreak: bestStreak);
    }

    var currentStreak = 0;
    var cursor = anchorDate;
    while (activeSet.contains(cursor)) {
      currentStreak++;
      cursor = addCalendarDays(cursor, -1);
    }

    return (
      currentStreak: currentStreak,
      bestStreak: math.max(bestStreak, currentStreak),
    );
  }
}
