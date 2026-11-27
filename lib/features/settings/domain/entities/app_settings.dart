import 'package:flutter/material.dart';

import '../../../../core/notifications/notification_entities.dart';
import '../../../prayer/domain/entities/prayer_entities.dart';
import '../../../quran/domain/entities/reading_mode_entities.dart';

/// Supported prayer calculation methods in Qandil.
enum PrayerCalculationMethodOption {
  egyptian('egyptian'),
  ummAlQura('umm_al_qura'),
  muslimWorldLeague('mwl'),
  karachi('karachi'),
  northAmerica('isna');

  const PrayerCalculationMethodOption(this.code);
  final String code;

  static PrayerCalculationMethodOption fromCode(String raw) {
    for (final method in values) {
      if (method.code == raw) {
        return method;
      }
    }
    return PrayerCalculationMethodOption.egyptian;
  }
}

/// Domain entity representing user preferences persisted in Drift.
class AppSettings {
  const AppSettings({
    this.languageCode = 'ar',
    this.themeMode = ThemeMode.system,
    this.textScaleFactor = 1.0,
    this.prayerCalculationMethod = PrayerCalculationMethodOption.egyptian,
    this.notificationsEnabled = true,
    this.readerFontSize = 26.0,
    this.readerLineSpacing = 1.9,
    this.keepScreenAwake = true,
    this.defaultReciterId = 6,
    this.asrMadhab = AsrMadhabOption.shafi,
    this.highLatitudeRule = HighLatitudeRuleOption.middleOfTheNight,
    this.prayerAdjustments = const PrayerManualAdjustments(),
    this.hijriAdjustmentDays = 0,
    this.locationLatitude = 30.0444,
    this.locationLongitude = 31.2357,
    this.locationCityNameAr = 'القاهرة، مصر',
    this.locationCityNameEn = 'Cairo, Egypt',
    this.prayerNotificationsConfig = const PrayerNotificationsScheduleConfig(),
    this.wirdReminderEnabled = true,
    this.wirdReminderHour = 20,
    this.wirdReminderMinute = 0,
    this.fridayReminderEnabled = true,
    this.fridayReminderHour = 10,
    this.fridayReminderMinute = 0,
    this.tasbihReminderEnabled = false,
    this.tasbihReminderHour = 21,
    this.tasbihReminderMinute = 0,
    this.tasbihHapticsEnabled = true,
    this.tasbihTargetPreset = 33,
    this.morningAdhkarReminderEnabled = true,
    this.morningAdhkarReminderHour = 7,
    this.morningAdhkarReminderMinute = 0,
    this.eveningAdhkarReminderEnabled = true,
    this.eveningAdhkarReminderHour = 17,
    this.eveningAdhkarReminderMinute = 0,
    this.autoStartReadingMode = false,
    this.readingModeDndEnabled = false,
    this.readingModeDndFilter = ReadingDndFilterOption.priority,
    this.iosFocusTipShown = false,
    this.onboardingCompleted = false,
    this.hifzNewVersesPerDayGoal = 5,
    this.hifzReviewRangesPerDayCap = 5,
    this.hifzCatchUpDays = 3,
    this.hifzCatchUpModeEnabled = false,
    this.hifzReminderEnabled = false,
    this.hifzReminderHour = 6,
    this.hifzReminderMinute = 30,
  });

  final String languageCode;
  final ThemeMode themeMode;
  final double textScaleFactor;
  final PrayerCalculationMethodOption prayerCalculationMethod;
  final bool notificationsEnabled;
  final double readerFontSize;
  final double readerLineSpacing;
  final bool keepScreenAwake;
  final int defaultReciterId;
  final AsrMadhabOption asrMadhab;
  final HighLatitudeRuleOption highLatitudeRule;
  final PrayerManualAdjustments prayerAdjustments;
  final int hijriAdjustmentDays;
  final double locationLatitude;
  final double locationLongitude;
  final String locationCityNameAr;
  final String locationCityNameEn;
  final PrayerNotificationsScheduleConfig prayerNotificationsConfig;
  final bool wirdReminderEnabled;
  final int wirdReminderHour;
  final int wirdReminderMinute;
  final bool fridayReminderEnabled;
  final int fridayReminderHour;
  final int fridayReminderMinute;
  final bool tasbihReminderEnabled;
  final int tasbihReminderHour;
  final int tasbihReminderMinute;
  final bool tasbihHapticsEnabled;
  final int tasbihTargetPreset;
  final bool morningAdhkarReminderEnabled;
  final int morningAdhkarReminderHour;
  final int morningAdhkarReminderMinute;
  final bool eveningAdhkarReminderEnabled;
  final int eveningAdhkarReminderHour;
  final int eveningAdhkarReminderMinute;
  final bool autoStartReadingMode;
  final bool readingModeDndEnabled;
  final ReadingDndFilterOption readingModeDndFilter;
  final bool iosFocusTipShown;
  final bool onboardingCompleted;
  final int hifzNewVersesPerDayGoal;
  final int hifzReviewRangesPerDayCap;
  final int hifzCatchUpDays;
  final bool hifzCatchUpModeEnabled;
  final bool hifzReminderEnabled;
  final int hifzReminderHour;
  final int hifzReminderMinute;

  Locale get locale => Locale(languageCode);

  String get currentCityDisplayName =>
      languageCode == 'ar' ? locationCityNameAr : locationCityNameEn;

  AppSettings copyWith({
    String? languageCode,
    ThemeMode? themeMode,
    double? textScaleFactor,
    PrayerCalculationMethodOption? prayerCalculationMethod,
    bool? notificationsEnabled,
    double? readerFontSize,
    double? readerLineSpacing,
    bool? keepScreenAwake,
    int? defaultReciterId,
    AsrMadhabOption? asrMadhab,
    HighLatitudeRuleOption? highLatitudeRule,
    PrayerManualAdjustments? prayerAdjustments,
    int? hijriAdjustmentDays,
    double? locationLatitude,
    double? locationLongitude,
    String? locationCityNameAr,
    String? locationCityNameEn,
    PrayerNotificationsScheduleConfig? prayerNotificationsConfig,
    bool? wirdReminderEnabled,
    int? wirdReminderHour,
    int? wirdReminderMinute,
    bool? fridayReminderEnabled,
    int? fridayReminderHour,
    int? fridayReminderMinute,
    bool? tasbihReminderEnabled,
    int? tasbihReminderHour,
    int? tasbihReminderMinute,
    bool? tasbihHapticsEnabled,
    int? tasbihTargetPreset,
    bool? morningAdhkarReminderEnabled,
    int? morningAdhkarReminderHour,
    int? morningAdhkarReminderMinute,
    bool? eveningAdhkarReminderEnabled,
    int? eveningAdhkarReminderHour,
    int? eveningAdhkarReminderMinute,
    bool? autoStartReadingMode,
    bool? readingModeDndEnabled,
    ReadingDndFilterOption? readingModeDndFilter,
    bool? iosFocusTipShown,
    bool? onboardingCompleted,
    int? hifzNewVersesPerDayGoal,
    int? hifzReviewRangesPerDayCap,
    int? hifzCatchUpDays,
    bool? hifzCatchUpModeEnabled,
    bool? hifzReminderEnabled,
    int? hifzReminderHour,
    int? hifzReminderMinute,
  }) {
    return AppSettings(
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      prayerCalculationMethod:
          prayerCalculationMethod ?? this.prayerCalculationMethod,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      readerFontSize: readerFontSize ?? this.readerFontSize,
      readerLineSpacing: readerLineSpacing ?? this.readerLineSpacing,
      keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
      defaultReciterId: defaultReciterId ?? this.defaultReciterId,
      asrMadhab: asrMadhab ?? this.asrMadhab,
      highLatitudeRule: highLatitudeRule ?? this.highLatitudeRule,
      prayerAdjustments: prayerAdjustments ?? this.prayerAdjustments,
      hijriAdjustmentDays:
          (hijriAdjustmentDays ?? this.hijriAdjustmentDays).clamp(-2, 2),
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      locationCityNameAr: locationCityNameAr ?? this.locationCityNameAr,
      locationCityNameEn: locationCityNameEn ?? this.locationCityNameEn,
      prayerNotificationsConfig:
          prayerNotificationsConfig ?? this.prayerNotificationsConfig,
      wirdReminderEnabled: wirdReminderEnabled ?? this.wirdReminderEnabled,
      wirdReminderHour: (wirdReminderHour ?? this.wirdReminderHour).clamp(
        0,
        23,
      ),
      wirdReminderMinute: (wirdReminderMinute ?? this.wirdReminderMinute).clamp(
        0,
        59,
      ),
      fridayReminderEnabled:
          fridayReminderEnabled ?? this.fridayReminderEnabled,
      fridayReminderHour: (fridayReminderHour ?? this.fridayReminderHour).clamp(
        0,
        23,
      ),
      fridayReminderMinute:
          (fridayReminderMinute ?? this.fridayReminderMinute).clamp(0, 59),
      tasbihReminderEnabled:
          tasbihReminderEnabled ?? this.tasbihReminderEnabled,
      tasbihReminderHour: (tasbihReminderHour ?? this.tasbihReminderHour).clamp(
        0,
        23,
      ),
      tasbihReminderMinute:
          (tasbihReminderMinute ?? this.tasbihReminderMinute).clamp(0, 59),
      tasbihHapticsEnabled: tasbihHapticsEnabled ?? this.tasbihHapticsEnabled,
      tasbihTargetPreset:
          (tasbihTargetPreset ?? this.tasbihTargetPreset).clamp(1, 100000),
      morningAdhkarReminderEnabled:
          morningAdhkarReminderEnabled ?? this.morningAdhkarReminderEnabled,
      morningAdhkarReminderHour:
          (morningAdhkarReminderHour ?? this.morningAdhkarReminderHour)
              .clamp(0, 23),
      morningAdhkarReminderMinute:
          (morningAdhkarReminderMinute ?? this.morningAdhkarReminderMinute)
              .clamp(0, 59),
      eveningAdhkarReminderEnabled:
          eveningAdhkarReminderEnabled ?? this.eveningAdhkarReminderEnabled,
      eveningAdhkarReminderHour:
          (eveningAdhkarReminderHour ?? this.eveningAdhkarReminderHour)
              .clamp(0, 23),
      eveningAdhkarReminderMinute:
          (eveningAdhkarReminderMinute ?? this.eveningAdhkarReminderMinute)
              .clamp(0, 59),
      autoStartReadingMode: autoStartReadingMode ?? this.autoStartReadingMode,
      readingModeDndEnabled:
          readingModeDndEnabled ?? this.readingModeDndEnabled,
      readingModeDndFilter: readingModeDndFilter ?? this.readingModeDndFilter,
      iosFocusTipShown: iosFocusTipShown ?? this.iosFocusTipShown,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      hifzNewVersesPerDayGoal:
          (hifzNewVersesPerDayGoal ?? this.hifzNewVersesPerDayGoal)
              .clamp(1, 286),
      hifzReviewRangesPerDayCap:
          (hifzReviewRangesPerDayCap ?? this.hifzReviewRangesPerDayCap)
              .clamp(1, 50),
      hifzCatchUpDays: (hifzCatchUpDays ?? this.hifzCatchUpDays).clamp(1, 30),
      hifzCatchUpModeEnabled:
          hifzCatchUpModeEnabled ?? this.hifzCatchUpModeEnabled,
      hifzReminderEnabled: hifzReminderEnabled ?? this.hifzReminderEnabled,
      hifzReminderHour:
          (hifzReminderHour ?? this.hifzReminderHour).clamp(0, 23),
      hifzReminderMinute:
          (hifzReminderMinute ?? this.hifzReminderMinute).clamp(0, 59),
    );
  }

  static ThemeMode parseThemeMode(String raw) {
    return switch (raw) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  static String serializeThemeMode(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode &&
          themeMode == other.themeMode &&
          textScaleFactor == other.textScaleFactor &&
          prayerCalculationMethod == other.prayerCalculationMethod &&
          notificationsEnabled == other.notificationsEnabled &&
          readerFontSize == other.readerFontSize &&
          readerLineSpacing == other.readerLineSpacing &&
          keepScreenAwake == other.keepScreenAwake &&
          defaultReciterId == other.defaultReciterId &&
          asrMadhab == other.asrMadhab &&
          highLatitudeRule == other.highLatitudeRule &&
          prayerAdjustments == other.prayerAdjustments &&
          hijriAdjustmentDays == other.hijriAdjustmentDays &&
          locationLatitude == other.locationLatitude &&
          locationLongitude == other.locationLongitude &&
          locationCityNameAr == other.locationCityNameAr &&
          locationCityNameEn == other.locationCityNameEn &&
          prayerNotificationsConfig == other.prayerNotificationsConfig &&
          wirdReminderEnabled == other.wirdReminderEnabled &&
          wirdReminderHour == other.wirdReminderHour &&
          wirdReminderMinute == other.wirdReminderMinute &&
          fridayReminderEnabled == other.fridayReminderEnabled &&
          fridayReminderHour == other.fridayReminderHour &&
          fridayReminderMinute == other.fridayReminderMinute &&
          tasbihReminderEnabled == other.tasbihReminderEnabled &&
          tasbihReminderHour == other.tasbihReminderHour &&
          tasbihReminderMinute == other.tasbihReminderMinute &&
          tasbihHapticsEnabled == other.tasbihHapticsEnabled &&
          tasbihTargetPreset == other.tasbihTargetPreset &&
          morningAdhkarReminderEnabled == other.morningAdhkarReminderEnabled &&
          morningAdhkarReminderHour == other.morningAdhkarReminderHour &&
          morningAdhkarReminderMinute == other.morningAdhkarReminderMinute &&
          eveningAdhkarReminderEnabled == other.eveningAdhkarReminderEnabled &&
          eveningAdhkarReminderHour == other.eveningAdhkarReminderHour &&
          eveningAdhkarReminderMinute == other.eveningAdhkarReminderMinute &&
          autoStartReadingMode == other.autoStartReadingMode &&
          readingModeDndEnabled == other.readingModeDndEnabled &&
          readingModeDndFilter == other.readingModeDndFilter &&
          iosFocusTipShown == other.iosFocusTipShown &&
          onboardingCompleted == other.onboardingCompleted &&
          hifzNewVersesPerDayGoal == other.hifzNewVersesPerDayGoal &&
          hifzReviewRangesPerDayCap == other.hifzReviewRangesPerDayCap &&
          hifzCatchUpDays == other.hifzCatchUpDays &&
          hifzCatchUpModeEnabled == other.hifzCatchUpModeEnabled &&
          hifzReminderEnabled == other.hifzReminderEnabled &&
          hifzReminderHour == other.hifzReminderHour &&
          hifzReminderMinute == other.hifzReminderMinute;

  @override
  int get hashCode => Object.hashAll([
        languageCode,
        themeMode,
        textScaleFactor,
        prayerCalculationMethod,
        notificationsEnabled,
        readerFontSize,
        readerLineSpacing,
        keepScreenAwake,
        defaultReciterId,
        asrMadhab,
        highLatitudeRule,
        prayerAdjustments,
        hijriAdjustmentDays,
        locationLatitude,
        locationLongitude,
        locationCityNameAr,
        locationCityNameEn,
        prayerNotificationsConfig,
        wirdReminderEnabled,
        wirdReminderHour,
        wirdReminderMinute,
        fridayReminderEnabled,
        fridayReminderHour,
        fridayReminderMinute,
        tasbihReminderEnabled,
        tasbihReminderHour,
        tasbihReminderMinute,
        tasbihHapticsEnabled,
        tasbihTargetPreset,
        morningAdhkarReminderEnabled,
        morningAdhkarReminderHour,
        morningAdhkarReminderMinute,
        eveningAdhkarReminderEnabled,
        eveningAdhkarReminderHour,
        eveningAdhkarReminderMinute,
        autoStartReadingMode,
        readingModeDndEnabled,
        readingModeDndFilter,
        iosFocusTipShown,
        onboardingCompleted,
        hifzNewVersesPerDayGoal,
        hifzReviewRangesPerDayCap,
        hifzCatchUpDays,
        hifzCatchUpModeEnabled,
        hifzReminderEnabled,
        hifzReminderHour,
        hifzReminderMinute,
      ]);
}
