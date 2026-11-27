import 'package:flutter/foundation.dart';

/// Supported Asr juristic school options (Shafi/Standard vs Hanafi).
enum AsrMadhabOption {
  shafi('shafi'),
  hanafi('hanafi');

  const AsrMadhabOption(this.code);
  final String code;

  static AsrMadhabOption fromCode(String raw) {
    return raw == 'hanafi' ? AsrMadhabOption.hanafi : AsrMadhabOption.shafi;
  }
}

/// Supported high-latitude rules for Fajr and Isha in extreme latitudes.
enum HighLatitudeRuleOption {
  middleOfTheNight('middle_of_the_night'),
  seventhOfTheNight('seventh_of_the_night'),
  twilightAngle('twilight_angle');

  const HighLatitudeRuleOption(this.code);
  final String code;

  static HighLatitudeRuleOption fromCode(String raw) {
    for (final r in values) {
      if (r.code == raw) return r;
    }
    return HighLatitudeRuleOption.middleOfTheNight;
  }
}

/// Ordered prayer & sunrise slots in the daily schedule.
enum PrayerSlot {
  fajr,
  sunrise,
  dhuhr,
  asr,
  maghrib,
  isha,
}

/// Per-prayer manual minute adjustments (`-30` to `+30` minutes).
@immutable
class PrayerManualAdjustments {
  const PrayerManualAdjustments({
    this.fajr = 0,
    this.sunrise = 0,
    this.dhuhr = 0,
    this.asr = 0,
    this.maghrib = 0,
    this.isha = 0,
  });

  final int fajr;
  final int sunrise;
  final int dhuhr;
  final int asr;
  final int maghrib;
  final int isha;

  PrayerManualAdjustments copyWith({
    int? fajr,
    int? sunrise,
    int? dhuhr,
    int? asr,
    int? maghrib,
    int? isha,
  }) {
    return PrayerManualAdjustments(
      fajr: (fajr ?? this.fajr).clamp(-30, 30),
      sunrise: (sunrise ?? this.sunrise).clamp(-30, 30),
      dhuhr: (dhuhr ?? this.dhuhr).clamp(-30, 30),
      asr: (asr ?? this.asr).clamp(-30, 30),
      maghrib: (maghrib ?? this.maghrib).clamp(-30, 30),
      isha: (isha ?? this.isha).clamp(-30, 30),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerManualAdjustments &&
          runtimeType == other.runtimeType &&
          fajr == other.fajr &&
          sunrise == other.sunrise &&
          dhuhr == other.dhuhr &&
          asr == other.asr &&
          maghrib == other.maghrib &&
          isha == other.isha;

  @override
  int get hashCode => Object.hash(fajr, sunrise, dhuhr, asr, maghrib, isha);
}

/// Complete on-device computed prayer schedule for a single calendar date.
@immutable
class DailyPrayerSchedule {
  const DailyPrayerSchedule({
    required this.date,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  final DateTime date;
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;

  DateTime timeForSlot(PrayerSlot slot) {
    return switch (slot) {
      PrayerSlot.fajr => fajr,
      PrayerSlot.sunrise => sunrise,
      PrayerSlot.dhuhr => dhuhr,
      PrayerSlot.asr => asr,
      PrayerSlot.maghrib => maghrib,
      PrayerSlot.isha => isha,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyPrayerSchedule &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          fajr == other.fajr &&
          sunrise == other.sunrise &&
          dhuhr == other.dhuhr &&
          asr == other.asr &&
          maghrib == other.maghrib &&
          isha == other.isha;

  @override
  int get hashCode =>
      Object.hash(date, fajr, sunrise, dhuhr, asr, maghrib, isha);
}

/// Snapshot of the upcoming prayer and its countdown duration.
@immutable
class NextPrayerCountdown {
  const NextPrayerCountdown({
    required this.slot,
    required this.prayerTime,
    required this.remaining,
    required this.isTomorrowFajr,
  });

  final PrayerSlot slot;
  final DateTime prayerTime;
  final Duration remaining;
  final bool isTomorrowFajr;
}

/// Verified offline city coordinate entry for manual city search fallback and nearest-city matching.
@immutable
class CityLocationPreset {
  const CityLocationPreset({
    required this.nameAr,
    required this.nameEn,
    required this.latitude,
    required this.longitude,
  });

  final String nameAr;
  final String nameEn;
  final double latitude;
  final double longitude;

  String displayName(String languageCode) =>
      languageCode == 'ar' ? nameAr : nameEn;
}
