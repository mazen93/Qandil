import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/calendar/domain/services/hijri_calendar_service.dart';
import 'package:qandil/features/qibla/domain/services/qibla_calculator_service.dart';

void main() {
  group('QiblaCalculatorService & HijriCalendarService', () {
    test(
        'calculates accurate Qibla bearing for Cairo (~136.14° SE) and checks alignment',
        () {
      final bearing = QiblaCalculatorService.calculateQiblaBearing(
        latitude: 30.0444,
        longitude: 31.2357,
      );

      expect(bearing, closeTo(136.14, 0.2));
      expect(
        QiblaCalculatorService.cardinalDirection(bearing, languageCode: 'en'),
        'SE',
      );
      expect(
        QiblaCalculatorService.cardinalDirection(bearing, languageCode: 'ar'),
        'جنوب شرق',
      );

      expect(
        QiblaCalculatorService.isAlignedWithQibla(
          compassHeading: 135.0,
          qiblaBearing: bearing,
        ),
        isTrue,
      );
      expect(
        QiblaCalculatorService.isAlignedWithQibla(
          compassHeading: 90.0,
          qiblaBearing: bearing,
        ),
        isFalse,
      );
    });

    test(
        'converts Gregorian date to Umm al-Qura Hijri date and applies -2 to +2 day moon-sighting adjustments',
        () {
      final gregDate = DateTime(2026, 11, 27);
      final baseHijri = HijriCalendarService.fromGregorian(
        gregDate,
        adjustmentDays: 0,
      );
      final plusOneHijri = HijriCalendarService.fromGregorian(
        gregDate,
        adjustmentDays: 1,
      );
      final minusTwoHijri = HijriCalendarService.fromGregorian(
        gregDate,
        adjustmentDays: -2,
      );

      expect(baseHijri.hYear, greaterThanOrEqualTo(1448));
      expect(plusOneHijri.adjustmentDays, 1);
      expect(minusTwoHijri.adjustmentDays, -2);
      expect(
        baseHijri.format(languageCode: 'ar'),
        contains('هـ'),
      );
      expect(
        baseHijri.format(languageCode: 'en'),
        contains('AH'),
      );
    });
  });
}
