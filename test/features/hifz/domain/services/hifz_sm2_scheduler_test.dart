import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/hifz/domain/entities/hifz_entities.dart';
import 'package:qandil/features/hifz/domain/services/hifz_sm2_scheduler.dart';

void main() {
  const scheduler = HifzSm2Scheduler();

  group('Phase 12: HifzSm2Scheduler Unit Tests', () {
    test('SM-2 interval progression on Perfect, Hesitated, and Forgot grades',
        () {
      const initialRange = HifzMemorizedRange(
        id: 1,
        surahNumber: 1,
        startAyah: 1,
        endAyah: 7,
        startPage: 1,
        endPage: 1,
        juzNumber: 1,
        easinessFactor: 2.5,
        intervalDays: 1,
        repetitions: 0,
        nextDueDate: '2026-11-27',
      );

      // 1. First Perfect review -> repetitions: 1, interval: 1 day, EF: 2.6
      final r1 = scheduler.scheduleNext(
        range: initialRange,
        grade: HifzSelfGrade.perfect,
        reviewDate: '2026-11-27',
      );
      expect(r1.repetitions, 1);
      expect(r1.intervalDays, 1);
      expect(r1.easinessFactor, 2.6);
      expect(r1.nextDueDate, '2026-11-28');

      // 2. Second Perfect review -> repetitions: 2, interval: 3 days, EF: 2.7
      final r2 = scheduler.scheduleNext(
        range: initialRange.copyWith(
          repetitions: r1.repetitions,
          intervalDays: r1.intervalDays,
          easinessFactor: r1.easinessFactor,
          nextDueDate: r1.nextDueDate,
        ),
        grade: HifzSelfGrade.perfect,
        reviewDate: '2026-11-28',
      );
      expect(r2.repetitions, 2);
      expect(r2.intervalDays, 3);
      expect(r2.easinessFactor, 2.7);
      expect(r2.nextDueDate, '2026-12-01');

      // 3. Third Perfect review -> interval = round(3 * 2.8) = 8 days
      final r3 = scheduler.scheduleNext(
        range: initialRange.copyWith(
          repetitions: r2.repetitions,
          intervalDays: r2.intervalDays,
          easinessFactor: r2.easinessFactor,
          nextDueDate: r2.nextDueDate,
        ),
        grade: HifzSelfGrade.perfect,
        reviewDate: '2026-12-01',
      );
      expect(r3.repetitions, 3);
      expect(r3.intervalDays, 8);
      expect(r3.nextDueDate, '2026-12-09');

      // 4. Hesitated review -> conservative 1.2x interval (round(8 * 1.2) = 10) and EF reduced by 0.14
      final rHesitated = scheduler.scheduleNext(
        range: initialRange.copyWith(
          repetitions: r3.repetitions,
          intervalDays: r3.intervalDays,
          easinessFactor: r3.easinessFactor,
        ),
        grade: HifzSelfGrade.hesitated,
        reviewDate: '2026-12-09',
      );
      expect(rHesitated.intervalDays, 10);
      expect(rHesitated.easinessFactor, lessThan(r3.easinessFactor));

      // 5. Forgot review -> resets repetitions to 0 and intervalDays to 1 (due tomorrow), EF >= 1.3
      final rForgot = scheduler.scheduleNext(
        range: initialRange.copyWith(
          repetitions: 5,
          intervalDays: 21,
          easinessFactor: 1.35,
        ),
        grade: HifzSelfGrade.forgot,
        reviewDate: '2026-12-09',
      );
      expect(rForgot.repetitions, 0);
      expect(rForgot.intervalDays, 1);
      expect(rForgot.easinessFactor, 1.3); // Clamped to minEasinessFactor
      expect(rForgot.nextDueDate, '2026-12-10');
    });

    test(
        'overdue handling, daily cap, and Catch-Up Mode spreading missed reviews across days',
        () {
      const ranges = <HifzMemorizedRange>[
        HifzMemorizedRange(
          id: 1,
          surahNumber: 1,
          startAyah: 1,
          endAyah: 7,
          startPage: 1,
          endPage: 1,
          juzNumber: 1,
          easinessFactor: 2.5,
          nextDueDate: '2026-11-27', // Due today (overdue 0)
        ),
        HifzMemorizedRange(
          id: 2,
          surahNumber: 2,
          startAyah: 1,
          endAyah: 5,
          startPage: 2,
          endPage: 2,
          juzNumber: 1,
          easinessFactor: 2.1,
          nextDueDate: '2026-11-20', // Overdue by 7 days (most overdue!)
        ),
        HifzMemorizedRange(
          id: 3,
          surahNumber: 2,
          startAyah: 6,
          endAyah: 10,
          startPage: 3,
          endPage: 3,
          juzNumber: 1,
          easinessFactor: 2.3,
          nextDueDate: '2026-11-24', // Overdue by 3 days
        ),
        HifzMemorizedRange(
          id: 4,
          surahNumber: 2,
          startAyah: 11,
          endAyah: 16,
          startPage: 3,
          endPage: 3,
          juzNumber: 1,
          easinessFactor: 2.4,
          nextDueDate: '2026-11-25', // Overdue by 2 days
        ),
        HifzMemorizedRange(
          id: 5,
          surahNumber: 2,
          startAyah: 17,
          endAyah: 20,
          startPage: 4,
          endPage: 4,
          juzNumber: 1,
          easinessFactor: 2.5,
          nextDueDate: '2026-11-26', // Overdue by 1 day
        ),
        HifzMemorizedRange(
          id: 6,
          surahNumber: 2,
          startAyah: 21,
          endAyah: 25,
          startPage: 4,
          endPage: 4,
          juzNumber: 1,
          easinessFactor: 2.5,
          nextDueDate: '2026-11-30', // Future (not due yet)
        ),
      ];

      // Standard mode with dailyCap = 4: sorts most overdue first (id 2, 3, 4, 5)
      final normalQueue = scheduler.buildDailyQueue(
        allRanges: ranges,
        todayDate: '2026-11-27',
        dailyCap: 4,
        catchUpMode: false,
      );
      expect(normalQueue.totalDueCount, 5);
      expect(normalQueue.overdueCount, 4);
      expect(normalQueue.dueQueue.map((r) => r.id).toList(), [2, 3, 4, 5]);

      // Catch-Up Mode spreading 5 due items over 3 days -> ceil(5 / 3) = 2 items today!
      final catchUpQueue = scheduler.buildDailyQueue(
        allRanges: ranges,
        todayDate: '2026-11-27',
        dailyCap: 5,
        catchUpMode: true,
        catchUpSpreadDays: 3,
      );
      expect(catchUpQueue.isCatchUpActive, isTrue);
      expect(catchUpQueue.effectiveCapToday, 2);
      expect(catchUpQueue.dueQueue.map((r) => r.id).toList(), [2, 3]);
    });

    test(
        'handles day boundaries, DST Spring-Forward / Fall-Back transitions, stats & projected completion date',
        () {
      // DST Spring-Forward (2026-03-28 -> 2026-03-29) and Fall-Back (2026-10-30 -> 2026-10-31)
      expect(
        HifzSm2Scheduler.calendarDaysBetween('2026-03-28', '2026-03-29'),
        1,
      );
      expect(
        HifzSm2Scheduler.calendarDaysBetween('2026-10-30', '2026-10-31'),
        1,
      );

      final stats = HifzSm2Scheduler.computeStats(
        ranges: const [
          HifzMemorizedRange(
            id: 1,
            surahNumber: 1,
            startAyah: 1,
            endAyah: 7,
            startPage: 1,
            endPage: 1,
            juzNumber: 1,
            nextDueDate: '2026-11-28',
          ),
        ],
        reviewEvents: const [
          (localDate: '2026-11-25', grade: HifzSelfGrade.perfect),
          (localDate: '2026-11-26', grade: HifzSelfGrade.hesitated),
          (localDate: '2026-11-27', grade: HifzSelfGrade.perfect),
        ],
        todayDate: '2026-11-27',
        newVersesPerDayGoal: 10,
      );

      expect(stats.memorizedVersesCount, 7);
      expect(stats.memorizedPagesCount, 1);
      expect(stats.memorizedJuzCount, 1);
      expect(stats.reviewStreakDays, 3);
      // Weekly accuracy: (1.0 + 0.5 + 1.0) / 3 = 0.833 -> 83%
      expect(stats.weeklyAccuracyPercent, 83);
      expect(stats.projectedCompletionDate, isNotNull);
    });
  });
}
