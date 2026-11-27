import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/tasbih/domain/entities/tasbih_entities.dart';
import 'package:qandil/features/tasbih/domain/services/tasbih_stats_calculator.dart';

void main() {
  group('TasbihStatsCalculator — Streaks, Day Boundaries, DST & Aggregation',
      () {
    test('computes multi-day consecutive current streak and best streak', () {
      final nowLocal = DateTime(2026, 5, 10, 14, 30);
      final entries = <TasbihDailyEntry>[
        // Older 5-day streak (best streak = 5)
        const TasbihDailyEntry(
            date: '2026-04-01', dhikrId: 'general', total: 33),
        const TasbihDailyEntry(
            date: '2026-04-02', dhikrId: 'general', total: 33),
        const TasbihDailyEntry(
            date: '2026-04-03', dhikrId: 'general', total: 33),
        const TasbihDailyEntry(
            date: '2026-04-04', dhikrId: 'general', total: 33),
        const TasbihDailyEntry(
            date: '2026-04-05', dhikrId: 'general', total: 33),
        // Active 3-day streak ending today (2026-05-08, 05-09, 05-10)
        const TasbihDailyEntry(
            date: '2026-05-08', dhikrId: 'general', total: 99),
        const TasbihDailyEntry(
            date: '2026-05-09', dhikrId: 'general', total: 100),
        const TasbihDailyEntry(
            date: '2026-05-10', dhikrId: 'general', total: 33),
      ];

      final summary = TasbihStatsCalculator.computeSummary(
        entries: entries,
        nowLocal: nowLocal,
      );

      expect(summary.currentStreakDays, 3);
      expect(summary.bestStreakDays, 5);
      expect(summary.todayTotal, 33);
    });

    test(
        'day boundary: preserves current streak when today is 0 but yesterday had counts, and resets when yesterday is missed',
        () {
      final entries = <TasbihDailyEntry>[
        const TasbihDailyEntry(
            date: '2026-05-07', dhikrId: 'general', total: 33),
        const TasbihDailyEntry(
            date: '2026-05-08', dhikrId: 'general', total: 33),
        const TasbihDailyEntry(
            date: '2026-05-09', dhikrId: 'general', total: 33),
      ];

      // Morning of 2026-05-10 before user has tapped today -> streak is still alive (3 days)
      final summaryBeforeTodayTap = TasbihStatsCalculator.computeSummary(
        entries: entries,
        nowLocal: DateTime(2026, 5, 10, 8, 0),
      );
      expect(summaryBeforeTodayTap.todayTotal, 0);
      expect(summaryBeforeTodayTap.currentStreakDays, 3);
      expect(summaryBeforeTodayTap.bestStreakDays, 3);

      // Next day 2026-05-11 (yesterday 2026-05-10 was missed) -> current streak resets to 0, best remains 3
      final summaryAfterMissedDay = TasbihStatsCalculator.computeSummary(
        entries: entries,
        nowLocal: DateTime(2026, 5, 11, 9, 0),
      );
      expect(summaryAfterMissedDay.currentStreakDays, 0);
      expect(summaryAfterMissedDay.bestStreakDays, 3);
    });

    test(
        'handles DST Spring-Forward (23-hour day) and Fall-Back (25-hour day) transitions without breaking streaks',
        () {
      // Egypt / US / EU DST Spring-Forward boundary: 2026-03-28 -> 2026-03-29 -> 2026-03-30
      expect(
        TasbihStatsCalculator.calendarDaysBetween('2026-03-28', '2026-03-29'),
        1,
      );
      expect(
        TasbihStatsCalculator.calendarDaysBetween('2026-03-29', '2026-03-30'),
        1,
      );

      // DST Fall-Back boundary: 2026-10-29 -> 2026-10-30 -> 2026-10-31
      expect(
        TasbihStatsCalculator.calendarDaysBetween('2026-10-29', '2026-10-30'),
        1,
      );
      expect(
        TasbihStatsCalculator.calendarDaysBetween('2026-10-30', '2026-10-31'),
        1,
      );

      final dstEntries = <TasbihDailyEntry>[
        const TasbihDailyEntry(
            date: '2026-03-27', dhikrId: 'general', total: 33),
        const TasbihDailyEntry(
            date: '2026-03-28', dhikrId: 'general', total: 33),
        const TasbihDailyEntry(
            date: '2026-03-29', dhikrId: 'general', total: 33),
        const TasbihDailyEntry(
            date: '2026-03-30', dhikrId: 'general', total: 33),
      ];

      final summary = TasbihStatsCalculator.computeSummary(
        entries: dstEntries,
        nowLocal: DateTime(2026, 3, 30, 23, 59),
      );
      expect(summary.currentStreakDays, 4);
      expect(summary.bestStreakDays, 4);
    });

    test(
        'aggregates today, 7 days, 30 days, all time totals and per-dhikr breakdown accurately',
        () {
      final nowLocal = DateTime(2026, 6, 15, 18, 0);
      final entries = <TasbihDailyEntry>[
        // Today (2026-06-15): 33 + 67 = 100
        const TasbihDailyEntry(
            date: '2026-06-15', dhikrId: 'dhikr_a', total: 33),
        const TasbihDailyEntry(
            date: '2026-06-15', dhikrId: 'dhikr_b', total: 67),
        // Within 7 days (2026-06-10): 50
        const TasbihDailyEntry(
            date: '2026-06-10', dhikrId: 'dhikr_a', total: 50),
        // Within 30 days but outside 7 days (2026-05-25): 200
        const TasbihDailyEntry(
            date: '2026-05-25', dhikrId: 'dhikr_b', total: 200),
        // Older than 30 days (2026-01-10): 500
        const TasbihDailyEntry(
            date: '2026-01-10', dhikrId: 'dhikr_a', total: 500),
      ];

      final sevenDaysSummary = TasbihStatsCalculator.computeSummary(
        entries: entries,
        nowLocal: nowLocal,
        period: TasbihStatsPeriod.sevenDays,
      );

      expect(sevenDaysSummary.todayTotal, 100);
      expect(sevenDaysSummary.sevenDaysTotal, 150);
      expect(sevenDaysSummary.thirtyDaysTotal, 350);
      expect(sevenDaysSummary.allTimeTotal, 850);
      expect(sevenDaysSummary.periodTotal, 150);
      expect(sevenDaysSummary.perDhikrBreakdown['dhikr_a'], 83);
      expect(sevenDaysSummary.perDhikrBreakdown['dhikr_b'], 67);
      expect(sevenDaysSummary.dailyChartPoints.length, 7);

      final allTimeSummary = TasbihStatsCalculator.computeSummary(
        entries: entries,
        nowLocal: nowLocal,
        period: TasbihStatsPeriod.allTime,
      );
      expect(allTimeSummary.periodTotal, 850);
      expect(allTimeSummary.perDhikrBreakdown['dhikr_a'], 583);
      expect(allTimeSummary.perDhikrBreakdown['dhikr_b'], 267);
    });

    test('builds adaptive reminder message when goal is unreached vs reached',
        () {
      final unreachedAr = TasbihStatsCalculator.buildAdaptiveReminderBody(
        todayTotal: 10,
        dailyGoal: 33,
        currentStreakDays: 4,
        languageCode: 'ar',
      );
      expect(unreachedAr, contains('10'));
      expect(unreachedAr, contains('23'));

      final reachedEn = TasbihStatsCalculator.buildAdaptiveReminderBody(
        todayTotal: 99,
        dailyGoal: 33,
        currentStreakDays: 7,
        languageCode: 'en',
      );
      expect(reachedEn, contains('99'));
      expect(reachedEn, contains('7'));
    });
  });
}
