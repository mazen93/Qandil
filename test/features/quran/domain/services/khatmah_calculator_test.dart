import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/quran/domain/services/khatmah_calculator.dart';

void main() {
  group('KhatmahCalculator', () {
    test('computes standard 30-day Khatmah daily pages and progress fraction',
        () {
      final start = DateTime(2026, 11, 1);
      final summary = KhatmahCalculator.calculate(
        targetDays: 30,
        currentPage: 151,
        startDate: start,
        now: DateTime(2026, 11,
            8), // 7 days elapsed -> expected 7 * 21 = 147 pages completed
      );

      expect(summary.basePagesPerDay, 21); // ceil(604 / 30) = 21
      expect(summary.elapsedDays, 7);
      expect(summary.remainingDays, 23);
      expect(summary.isBehindSchedule, isFalse);
      expect(summary.behindByPages, 0);
      expect(summary.progressFraction, closeTo(151 / 604, 0.001));
    });

    test('computes missed-day catch-up pace when behind schedule', () {
      final start = DateTime(2026, 11, 1);
      // 10 days elapsed on a 30-day plan -> expected 210 pages completed,
      // but user is still at page 41 (only 40 pages completed -> 170 pages behind!)
      final summary = KhatmahCalculator.calculate(
        targetDays: 30,
        currentPage: 41,
        startDate: start,
        now: DateTime(2026, 11, 11),
      );

      expect(summary.elapsedDays, 10);
      expect(summary.remainingDays, 20);
      expect(summary.isBehindSchedule, isTrue);
      expect(summary.behindByPages, 170); // 210 - 40 = 170
      // Remaining pages = 604 - 40 = 564 pages over 20 remaining days -> ceil(564 / 20) = 29 pages/day
      expect(summary.catchUpPagesPerDay, 29);
    });

    test('handles 15-day and 60-day Khatmah targets and completion at page 604',
        () {
      final fifteenDay = KhatmahCalculator.calculate(
        targetDays: 15,
        currentPage: 1,
      );
      expect(fifteenDay.basePagesPerDay, 41); // ceil(604 / 15) = 41

      final completed = KhatmahCalculator.calculate(
        targetDays: 30,
        currentPage: 604,
      );
      expect(completed.isCompleted, isTrue);
      expect(completed.progressFraction, 1.0);
    });
  });
}
