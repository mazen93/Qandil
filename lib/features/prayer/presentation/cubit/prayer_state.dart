import 'package:flutter/foundation.dart';

import '../../../calendar/domain/services/hijri_calendar_service.dart';
import '../../domain/entities/prayer_entities.dart';

/// Immutable state for [PrayerCubit].
@immutable
class PrayerState {
  const PrayerState({
    this.isLoading = false,
    this.cityNameAr = 'القاهرة، مصر',
    this.cityNameEn = 'Cairo, Egypt',
    this.latitude = 30.0444,
    this.longitude = 31.2357,
    this.qiblaBearingDegrees = 136.14,
    this.todaySchedule,
    this.tomorrowSchedule,
    this.thirtyDaySchedules = const [],
    this.nextPrayer,
    this.hijriToday,
    this.gregorianTodayFormattedAr = '',
    this.gregorianTodayFormattedEn = '',
    this.errorMessage,
  });

  final bool isLoading;
  final String cityNameAr;
  final String cityNameEn;
  final double latitude;
  final double longitude;
  final double qiblaBearingDegrees;
  final DailyPrayerSchedule? todaySchedule;
  final DailyPrayerSchedule? tomorrowSchedule;
  final List<DailyPrayerSchedule> thirtyDaySchedules;
  final NextPrayerCountdown? nextPrayer;
  final HijriDateInfo? hijriToday;
  final String gregorianTodayFormattedAr;
  final String gregorianTodayFormattedEn;
  final String? errorMessage;

  String cityName(String languageCode) =>
      languageCode == 'ar' ? cityNameAr : cityNameEn;

  String gregorianTodayFormatted(String languageCode) => languageCode == 'ar'
      ? gregorianTodayFormattedAr
      : gregorianTodayFormattedEn;

  PrayerState copyWith({
    bool? isLoading,
    String? cityNameAr,
    String? cityNameEn,
    double? latitude,
    double? longitude,
    double? qiblaBearingDegrees,
    DailyPrayerSchedule? todaySchedule,
    DailyPrayerSchedule? tomorrowSchedule,
    List<DailyPrayerSchedule>? thirtyDaySchedules,
    NextPrayerCountdown? nextPrayer,
    HijriDateInfo? hijriToday,
    String? gregorianTodayFormattedAr,
    String? gregorianTodayFormattedEn,
    String? errorMessage,
  }) {
    return PrayerState(
      isLoading: isLoading ?? this.isLoading,
      cityNameAr: cityNameAr ?? this.cityNameAr,
      cityNameEn: cityNameEn ?? this.cityNameEn,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      qiblaBearingDegrees: qiblaBearingDegrees ?? this.qiblaBearingDegrees,
      todaySchedule: todaySchedule ?? this.todaySchedule,
      tomorrowSchedule: tomorrowSchedule ?? this.tomorrowSchedule,
      thirtyDaySchedules: thirtyDaySchedules ?? this.thirtyDaySchedules,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      hijriToday: hijriToday ?? this.hijriToday,
      gregorianTodayFormattedAr:
          gregorianTodayFormattedAr ?? this.gregorianTodayFormattedAr,
      gregorianTodayFormattedEn:
          gregorianTodayFormattedEn ?? this.gregorianTodayFormattedEn,
      errorMessage: errorMessage,
    );
  }
}
