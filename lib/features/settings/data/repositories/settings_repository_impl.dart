import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/notifications/notification_entities.dart';
import '../../../../core/result/result.dart';
import '../../../prayer/domain/entities/prayer_entities.dart';
import '../../../quran/domain/entities/reading_mode_entities.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

/// Drift-backed implementation of [SettingsRepository].
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({required AppDatabase database})
      : _database = database;

  final AppDatabase _database;

  @override
  Future<Result<AppSettings>> getSettings() async {
    try {
      final row = await _database.getOrCreateSettings();
      return Success(_mapToEntity(row));
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to load settings from local database: $e'),
      );
    }
  }

  @override
  Future<Result<AppSettings>> saveSettings(AppSettings settings) async {
    try {
      final updated = await _database.updateSettings(
        SettingsCompanion(
          languageCode: Value(settings.languageCode),
          themeMode: Value(AppSettings.serializeThemeMode(settings.themeMode)),
          textScaleFactor: Value(settings.textScaleFactor),
          prayerCalculationMethod: Value(settings.prayerCalculationMethod.code),
          notificationsEnabled: Value(settings.notificationsEnabled),
          readerFontSize: Value(settings.readerFontSize),
          readerLineSpacing: Value(settings.readerLineSpacing),
          keepScreenAwake: Value(settings.keepScreenAwake),
          defaultReciterId: Value(settings.defaultReciterId),
          asrMadhab: Value(settings.asrMadhab.code),
          highLatitudeRule: Value(settings.highLatitudeRule.code),
          fajrAdjustmentMinutes: Value(settings.prayerAdjustments.fajr),
          sunriseAdjustmentMinutes: Value(settings.prayerAdjustments.sunrise),
          dhuhrAdjustmentMinutes: Value(settings.prayerAdjustments.dhuhr),
          asrAdjustmentMinutes: Value(settings.prayerAdjustments.asr),
          maghribAdjustmentMinutes: Value(settings.prayerAdjustments.maghrib),
          ishaAdjustmentMinutes: Value(settings.prayerAdjustments.isha),
          hijriAdjustmentDays: Value(settings.hijriAdjustmentDays),
          locationLatitude: Value(settings.locationLatitude),
          locationLongitude: Value(settings.locationLongitude),
          locationCityNameAr: Value(settings.locationCityNameAr),
          locationCityNameEn: Value(settings.locationCityNameEn),
          prayerNotificationsConfigJson: Value(
            settings.prayerNotificationsConfig.toJsonString(),
          ),
          wirdReminderEnabled: Value(settings.wirdReminderEnabled),
          wirdReminderHour: Value(settings.wirdReminderHour),
          wirdReminderMinute: Value(settings.wirdReminderMinute),
          fridayReminderEnabled: Value(settings.fridayReminderEnabled),
          fridayReminderHour: Value(settings.fridayReminderHour),
          fridayReminderMinute: Value(settings.fridayReminderMinute),
          tasbihReminderEnabled: Value(settings.tasbihReminderEnabled),
          tasbihReminderHour: Value(settings.tasbihReminderHour),
          tasbihReminderMinute: Value(settings.tasbihReminderMinute),
          tasbihHapticsEnabled: Value(settings.tasbihHapticsEnabled),
          tasbihTargetPreset: Value(settings.tasbihTargetPreset),
          morningAdhkarReminderEnabled:
              Value(settings.morningAdhkarReminderEnabled),
          morningAdhkarReminderHour: Value(settings.morningAdhkarReminderHour),
          morningAdhkarReminderMinute:
              Value(settings.morningAdhkarReminderMinute),
          eveningAdhkarReminderEnabled:
              Value(settings.eveningAdhkarReminderEnabled),
          eveningAdhkarReminderHour: Value(settings.eveningAdhkarReminderHour),
          eveningAdhkarReminderMinute:
              Value(settings.eveningAdhkarReminderMinute),
          autoStartReadingMode: Value(settings.autoStartReadingMode),
          readingModeDndEnabled: Value(settings.readingModeDndEnabled),
          readingModeDndFilter: Value(settings.readingModeDndFilter.code),
          iosFocusTipShown: Value(settings.iosFocusTipShown),
          onboardingCompleted: Value(settings.onboardingCompleted),
          hifzNewVersesPerDayGoal: Value(settings.hifzNewVersesPerDayGoal),
          hifzReviewRangesPerDayCap: Value(settings.hifzReviewRangesPerDayCap),
          hifzCatchUpDays: Value(settings.hifzCatchUpDays),
          hifzCatchUpModeEnabled: Value(settings.hifzCatchUpModeEnabled),
          hifzReminderEnabled: Value(settings.hifzReminderEnabled),
          hifzReminderHour: Value(settings.hifzReminderHour),
          hifzReminderMinute: Value(settings.hifzReminderMinute),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return Success(_mapToEntity(updated));
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to save settings to local database: $e'),
      );
    }
  }

  AppSettings _mapToEntity(SettingRecord row) {
    return AppSettings(
      languageCode: row.languageCode,
      themeMode: AppSettings.parseThemeMode(row.themeMode),
      textScaleFactor: row.textScaleFactor.clamp(0.85, 1.4),
      prayerCalculationMethod:
          PrayerCalculationMethodOption.fromCode(row.prayerCalculationMethod),
      notificationsEnabled: row.notificationsEnabled,
      readerFontSize: row.readerFontSize.clamp(18.0, 42.0),
      readerLineSpacing: row.readerLineSpacing.clamp(1.3, 2.6),
      keepScreenAwake: row.keepScreenAwake,
      defaultReciterId: row.defaultReciterId,
      asrMadhab: AsrMadhabOption.fromCode(row.asrMadhab),
      highLatitudeRule: HighLatitudeRuleOption.fromCode(row.highLatitudeRule),
      prayerAdjustments: PrayerManualAdjustments(
        fajr: row.fajrAdjustmentMinutes,
        sunrise: row.sunriseAdjustmentMinutes,
        dhuhr: row.dhuhrAdjustmentMinutes,
        asr: row.asrAdjustmentMinutes,
        maghrib: row.maghribAdjustmentMinutes,
        isha: row.ishaAdjustmentMinutes,
      ),
      hijriAdjustmentDays: row.hijriAdjustmentDays.clamp(-2, 2),
      locationLatitude: row.locationLatitude,
      locationLongitude: row.locationLongitude,
      locationCityNameAr: row.locationCityNameAr,
      locationCityNameEn: row.locationCityNameEn,
      prayerNotificationsConfig:
          PrayerNotificationsScheduleConfig.fromJsonString(
        row.prayerNotificationsConfigJson,
      ),
      wirdReminderEnabled: row.wirdReminderEnabled,
      wirdReminderHour: row.wirdReminderHour,
      wirdReminderMinute: row.wirdReminderMinute,
      fridayReminderEnabled: row.fridayReminderEnabled,
      fridayReminderHour: row.fridayReminderHour,
      fridayReminderMinute: row.fridayReminderMinute,
      tasbihReminderEnabled: row.tasbihReminderEnabled,
      tasbihReminderHour: row.tasbihReminderHour,
      tasbihReminderMinute: row.tasbihReminderMinute,
      tasbihHapticsEnabled: row.tasbihHapticsEnabled,
      tasbihTargetPreset: row.tasbihTargetPreset,
      morningAdhkarReminderEnabled: row.morningAdhkarReminderEnabled,
      morningAdhkarReminderHour: row.morningAdhkarReminderHour,
      morningAdhkarReminderMinute: row.morningAdhkarReminderMinute,
      eveningAdhkarReminderEnabled: row.eveningAdhkarReminderEnabled,
      eveningAdhkarReminderHour: row.eveningAdhkarReminderHour,
      eveningAdhkarReminderMinute: row.eveningAdhkarReminderMinute,
      autoStartReadingMode: row.autoStartReadingMode,
      readingModeDndEnabled: row.readingModeDndEnabled,
      readingModeDndFilter: ReadingDndFilterOption.fromCode(
        row.readingModeDndFilter,
      ),
      iosFocusTipShown: row.iosFocusTipShown,
      onboardingCompleted: row.onboardingCompleted,
      hifzNewVersesPerDayGoal: row.hifzNewVersesPerDayGoal,
      hifzReviewRangesPerDayCap: row.hifzReviewRangesPerDayCap,
      hifzCatchUpDays: row.hifzCatchUpDays,
      hifzCatchUpModeEnabled: row.hifzCatchUpModeEnabled,
      hifzReminderEnabled: row.hifzReminderEnabled,
      hifzReminderHour: row.hifzReminderHour,
      hifzReminderMinute: row.hifzReminderMinute,
    );
  }
}
