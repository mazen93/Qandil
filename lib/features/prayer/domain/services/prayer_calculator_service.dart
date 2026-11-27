import 'package:adhan/adhan.dart';

import '../../../settings/domain/entities/app_settings.dart';
import '../entities/prayer_entities.dart';

/// Pure Dart on-device prayer times calculator powered by `adhan`.
///
/// Features:
/// - Defaults to **Egyptian General Authority of Survey** (`CalculationMethod.egyptian`)
/// - Supports Asr Madhab (`Shafi` / `Hanafi`)
/// - Supports High-Latitude Rules (`MiddleOfTheNight`, `SeventhOfTheNight`, `TwilightAngle`)
/// - Applies manual per-prayer minute adjustments (`-30..+30` min)
/// - Computes Today, Tomorrow, 30-Day schedules, and Next Prayer live countdown completely offline on device.
abstract final class PrayerCalculatorService {
  /// Computes the [DailyPrayerSchedule] for [date] at ([latitude], [longitude]).
  ///
  /// When [utcOffset] is provided (e.g. `Duration(hours: 2)` for Cairo reference tests),
  /// the returned `DateTime` instances are expressed in that exact UTC offset so tests
  /// are deterministic regardless of the host machine's local timezone.
  static DailyPrayerSchedule computeScheduleForDate({
    required DateTime date,
    required double latitude,
    required double longitude,
    PrayerCalculationMethodOption method =
        PrayerCalculationMethodOption.egyptian,
    AsrMadhabOption asrMadhab = AsrMadhabOption.shafi,
    HighLatitudeRuleOption highLatitudeRule =
        HighLatitudeRuleOption.middleOfTheNight,
    PrayerManualAdjustments adjustments = const PrayerManualAdjustments(),
    Duration? utcOffset,
  }) {
    final coordinates = Coordinates(latitude, longitude);
    final dateComponents = DateComponents(date.year, date.month, date.day);
    final params = _buildCalculationParameters(
      method: method,
      asrMadhab: asrMadhab,
      highLatitudeRule: highLatitudeRule,
      adjustments: adjustments,
    );

    final prayerTimes = PrayerTimes(
      coordinates,
      dateComponents,
      params,
      utcOffset: utcOffset,
    );

    return DailyPrayerSchedule(
      date: DateTime(date.year, date.month, date.day),
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
    );
  }

  /// Computes a 30-day list of prayer schedules starting from [startDate].
  static List<DailyPrayerSchedule> computeThirtyDaySchedules({
    required DateTime startDate,
    required double latitude,
    required double longitude,
    PrayerCalculationMethodOption method =
        PrayerCalculationMethodOption.egyptian,
    AsrMadhabOption asrMadhab = AsrMadhabOption.shafi,
    HighLatitudeRuleOption highLatitudeRule =
        HighLatitudeRuleOption.middleOfTheNight,
    PrayerManualAdjustments adjustments = const PrayerManualAdjustments(),
    Duration? utcOffset,
    int days = 30,
  }) {
    final baseDay = DateTime(startDate.year, startDate.month, startDate.day);
    return List<DailyPrayerSchedule>.generate(days, (index) {
      final day = baseDay.add(Duration(days: index));
      return computeScheduleForDate(
        date: day,
        latitude: latitude,
        longitude: longitude,
        method: method,
        asrMadhab: asrMadhab,
        highLatitudeRule: highLatitudeRule,
        adjustments: adjustments,
        utcOffset: utcOffset,
      );
    }, growable: false);
  }

  /// Determines the next upcoming obligatory prayer (or tomorrow's Fajr after Isha)
  /// and the remaining countdown duration from [now].
  static NextPrayerCountdown computeNextPrayer({
    required DailyPrayerSchedule todaySchedule,
    required DailyPrayerSchedule tomorrowSchedule,
    required DateTime now,
  }) {
    const obligatorySlots = <PrayerSlot>[
      PrayerSlot.fajr,
      PrayerSlot.dhuhr,
      PrayerSlot.asr,
      PrayerSlot.maghrib,
      PrayerSlot.isha,
    ];

    for (final slot in obligatorySlots) {
      final slotTime = todaySchedule.timeForSlot(slot);
      if (slotTime.isAfter(now)) {
        return NextPrayerCountdown(
          slot: slot,
          prayerTime: slotTime,
          remaining: slotTime.difference(now),
          isTomorrowFajr: false,
        );
      }
    }

    // After today's Isha -> next prayer is tomorrow's Fajr
    final tomorrowFajr = tomorrowSchedule.fajr;
    final diff = tomorrowFajr.isAfter(now)
        ? tomorrowFajr.difference(now)
        : Duration.zero;
    return NextPrayerCountdown(
      slot: PrayerSlot.fajr,
      prayerTime: tomorrowFajr,
      remaining: diff,
      isTomorrowFajr: true,
    );
  }

  static CalculationParameters _buildCalculationParameters({
    required PrayerCalculationMethodOption method,
    required AsrMadhabOption asrMadhab,
    required HighLatitudeRuleOption highLatitudeRule,
    required PrayerManualAdjustments adjustments,
  }) {
    final params = switch (method) {
      PrayerCalculationMethodOption.egyptian =>
        CalculationMethod.egyptian.getParameters(),
      PrayerCalculationMethodOption.ummAlQura =>
        CalculationMethod.umm_al_qura.getParameters(),
      PrayerCalculationMethodOption.muslimWorldLeague =>
        CalculationMethod.muslim_world_league.getParameters(),
      PrayerCalculationMethodOption.karachi =>
        CalculationMethod.karachi.getParameters(),
      PrayerCalculationMethodOption.northAmerica =>
        CalculationMethod.north_america.getParameters(),
    };

    params.madhab = switch (asrMadhab) {
      AsrMadhabOption.shafi => Madhab.shafi,
      AsrMadhabOption.hanafi => Madhab.hanafi,
    };

    params.highLatitudeRule = switch (highLatitudeRule) {
      HighLatitudeRuleOption.middleOfTheNight =>
        HighLatitudeRule.middle_of_the_night,
      HighLatitudeRuleOption.seventhOfTheNight =>
        HighLatitudeRule.seventh_of_the_night,
      HighLatitudeRuleOption.twilightAngle => HighLatitudeRule.twilight_angle,
    };

    params.adjustments = PrayerAdjustments(
      fajr: adjustments.fajr,
      sunrise: adjustments.sunrise,
      dhuhr: adjustments.dhuhr,
      asr: adjustments.asr,
      maghrib: adjustments.maghrib,
      isha: adjustments.isha,
    );

    return params;
  }
}
