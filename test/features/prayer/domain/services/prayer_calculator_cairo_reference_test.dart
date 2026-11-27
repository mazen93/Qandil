import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/prayer/data/services/location_service.dart';
import 'package:qandil/features/prayer/domain/entities/prayer_entities.dart';
import 'package:qandil/features/prayer/domain/services/prayer_calculator_service.dart';
import 'package:qandil/features/settings/domain/entities/app_settings.dart';

void main() {
  const cairoLat = 30.0444;
  const cairoLng = 31.2357;
  const cairoUtcOffset = Duration(hours: 2);

  /// Formats a computed prayer DateTime as 'HH:mm' for reference table verification.
  String hhMm(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  /// Checks that [actual] is within [toleranceMinutes] of [expectedHhMm] (`HH:mm`).
  void expectWithinMinutes(
    DateTime actual,
    String expectedHhMm, {
    int toleranceMinutes = 2,
  }) {
    final parts = expectedHhMm.split(':');
    final expectedTotalMinutes = int.parse(parts[0]) * 60 + int.parse(parts[1]);
    final actualTotalMinutes = actual.hour * 60 + actual.minute;
    final diff = (actualTotalMinutes - expectedTotalMinutes).abs();
    expect(
      diff,
      lessThanOrEqualTo(toleranceMinutes),
      reason:
          'Expected ${hhMm(actual)} to be within $toleranceMinutes min of reference $expectedHhMm',
    );
  }

  group(
      'Phase 5: Cairo 5-Date Trusted Reference Table & Prayer Calculator Tests',
      () {
    test(
        'compares computed prayer times for Cairo (Egyptian General Authority of Survey, UTC+2) against reference table on 5 dates across the year',
        () {
      // Trusted Egyptian General Authority of Survey reference table for Cairo (30.0444 N, 31.2357 E, UTC+2):
      // Angles: Fajr 19.5°, Isha 17.5°, Shafi Asr
      final referenceTable = <({
        DateTime date,
        String fajr,
        String sunrise,
        String dhuhr,
        String asr,
        String maghrib,
        String isha,
      })>[
        (
          date: DateTime(2026, 1, 15),
          fajr: '05:20',
          sunrise: '06:52',
          dhuhr: '12:04',
          asr: '15:00',
          maghrib: '17:17',
          isha: '18:39',
        ),
        (
          date: DateTime(2026, 3, 21), // Vernal Equinox
          fajr: '04:32',
          sunrise: '05:59',
          dhuhr: '12:02',
          asr: '15:30',
          maghrib: '18:07',
          isha: '19:24',
        ),
        (
          date: DateTime(2026, 6, 21), // Summer Solstice
          fajr: '03:08',
          sunrise: '04:54',
          dhuhr: '11:57',
          asr: '15:32',
          maghrib: '18:59',
          isha: '20:33',
        ),
        (
          date: DateTime(2026, 9, 23), // Autumnal Equinox
          fajr: '04:17',
          sunrise: '05:44',
          dhuhr: '11:48',
          asr: '15:14',
          maghrib: '17:51',
          isha: '19:08',
        ),
        (
          date: DateTime(2026, 12, 21), // Winter Solstice
          fajr: '05:14',
          sunrise: '06:47',
          dhuhr: '11:53',
          asr: '14:43',
          maghrib: '16:59',
          isha: '18:22',
        ),
      ];

      for (final ref in referenceTable) {
        final schedule = PrayerCalculatorService.computeScheduleForDate(
          date: ref.date,
          latitude: cairoLat,
          longitude: cairoLng,
          method: PrayerCalculationMethodOption.egyptian,
          asrMadhab: AsrMadhabOption.shafi,
          utcOffset: cairoUtcOffset,
        );

        expectWithinMinutes(schedule.fajr, ref.fajr);
        expectWithinMinutes(schedule.sunrise, ref.sunrise);
        expectWithinMinutes(schedule.dhuhr, ref.dhuhr);
        expectWithinMinutes(schedule.asr, ref.asr);
        expectWithinMinutes(schedule.maghrib, ref.maghrib);
        expectWithinMinutes(schedule.isha, ref.isha);
      }
    });

    test('applies Hanafi Asr school and manual minute adjustments per prayer',
        () {
      final date = DateTime(2026, 3, 21);
      final shafiSchedule = PrayerCalculatorService.computeScheduleForDate(
        date: date,
        latitude: cairoLat,
        longitude: cairoLng,
        asrMadhab: AsrMadhabOption.shafi,
        utcOffset: cairoUtcOffset,
      );
      final hanafiSchedule = PrayerCalculatorService.computeScheduleForDate(
        date: date,
        latitude: cairoLat,
        longitude: cairoLng,
        asrMadhab: AsrMadhabOption.hanafi,
        utcOffset: cairoUtcOffset,
      );

      // Hanafi Asr is always later than Shafi Asr
      expect(hanafiSchedule.asr.isAfter(shafiSchedule.asr), isTrue);

      // Manual minute adjustment (+5 min on Fajr, -3 min on Maghrib)
      final adjustedSchedule = PrayerCalculatorService.computeScheduleForDate(
        date: date,
        latitude: cairoLat,
        longitude: cairoLng,
        adjustments: const PrayerManualAdjustments(fajr: 5, maghrib: -3),
        utcOffset: cairoUtcOffset,
      );

      expect(
        adjustedSchedule.fajr.difference(shafiSchedule.fajr).inMinutes,
        5,
      );
      expect(
        adjustedSchedule.maghrib.difference(shafiSchedule.maghrib).inMinutes,
        -3,
      );
    });

    test(
        'computes 30-day schedule list and rolls Next Prayer to tomorrow Fajr after Isha',
        () {
      final start = DateTime(2026, 11, 27);
      final thirtyDays = PrayerCalculatorService.computeThirtyDaySchedules(
        startDate: start,
        latitude: cairoLat,
        longitude: cairoLng,
        utcOffset: cairoUtcOffset,
      );

      expect(thirtyDays.length, 30);

      final today = thirtyDays[0];
      final tomorrow = thirtyDays[1];

      // 1 hour after today's Isha -> Next prayer must be tomorrow's Fajr
      final afterIsha = today.isha.add(const Duration(hours: 1));
      final next = PrayerCalculatorService.computeNextPrayer(
        todaySchedule: today,
        tomorrowSchedule: tomorrow,
        now: afterIsha,
      );

      expect(next.slot, PrayerSlot.fajr);
      expect(next.isTomorrowFajr, isTrue);
      expect(next.prayerTime, tomorrow.fajr);
    });

    test(
        'LocationService detects significant movement (>= 10 km) and searches cities offline',
        () {
      // Cairo to Giza (~4.3 km) -> NOT significant movement (< 10 km)
      expect(
        LocationService.hasMovedSignificantDistance(
          previousLatitude: 30.0444,
          previousLongitude: 31.2357,
          newLatitude: 30.0131,
          newLongitude: 31.2089,
        ),
        isFalse,
      );

      // Cairo to Alexandria (~179 km) -> Significant movement (>= 10 km)
      expect(
        LocationService.hasMovedSignificantDistance(
          previousLatitude: 30.0444,
          previousLongitude: 31.2357,
          newLatitude: 31.2001,
          newLongitude: 29.9187,
        ),
        isTrue,
      );

      final searchAr = LocationService.searchCities('الإسكندرية');
      expect(searchAr.isNotEmpty, isTrue);
      expect(searchAr.first.nameEn, 'Alexandria, Egypt');
    });
  });
}
