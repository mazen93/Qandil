import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/notifications/local_notification_service.dart';
import '../../../../core/notifications/notification_entities.dart';
import '../../../../core/result/result.dart';
import '../../../prayer/domain/entities/prayer_entities.dart';
import '../../../quran/domain/entities/reading_mode_entities.dart';
import '../../../quran/domain/services/reading_mode_service.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_state.dart';

/// Cubit managing user preferences and triggering rolling 7-day notification
/// rescheduling on app open, settings change, or location change.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required SettingsRepository repository,
    LocalNotificationService? notificationService,
    ReadingModeService? readingModeService,
  })  : _repository = repository,
        _notificationService = notificationService,
        _readingModeService = readingModeService,
        super(const SettingsState());

  final SettingsRepository _repository;
  final LocalNotificationService? _notificationService;
  final ReadingModeService? _readingModeService;

  Future<void> loadSettings() async {
    // Phase 9 Crash-Safe DND Restoration: restore any saved interruption filter from a crashed/killed session first.
    await _readingModeService?.restoreCrashedDndSessionIfNeeded();

    final result = await _repository.getSettings();
    switch (result) {
      case Success(:final value):
        emit(SettingsState(settings: value, isLoaded: true));
        await _notificationService?.rescheduleRollingWindow(value);
      case FailureResult(:final failure):
        emit(
          state.copyWith(
            isLoaded: true,
            errorMessage: failure.message,
          ),
        );
    }
  }

  /// Explicitly triggers a rolling 7-day notification reschedule (e.g. on app resume or timezone change).
  Future<void> rescheduleNotifications() async {
    await _notificationService?.rescheduleRollingWindow(state.settings);
  }

  Future<void> updateLanguage(String languageCode) async {
    if (languageCode != 'ar' && languageCode != 'en') return;
    await _persist(
      state.settings.copyWith(languageCode: languageCode),
      reschedule: true,
    );
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _persist(state.settings.copyWith(themeMode: themeMode));
  }

  Future<void> updateTextScaleFactor(double scaleFactor) async {
    final clamped = scaleFactor.clamp(0.85, 1.4);
    await _persist(state.settings.copyWith(textScaleFactor: clamped));
  }

  Future<void> updatePrayerCalculationMethod(
    PrayerCalculationMethodOption method,
  ) async {
    await _persist(
      state.settings.copyWith(prayerCalculationMethod: method),
      reschedule: true,
    );
  }

  Future<void> updateAsrMadhab(AsrMadhabOption madhab) async {
    await _persist(
      state.settings.copyWith(asrMadhab: madhab),
      reschedule: true,
    );
  }

  Future<void> updateHighLatitudeRule(HighLatitudeRuleOption rule) async {
    await _persist(
      state.settings.copyWith(highLatitudeRule: rule),
      reschedule: true,
    );
  }

  Future<void> updatePrayerAdjustments(
    PrayerManualAdjustments adjustments,
  ) async {
    await _persist(
      state.settings.copyWith(prayerAdjustments: adjustments),
      reschedule: true,
    );
  }

  Future<void> updateHijriAdjustmentDays(int days) async {
    await _persist(
      state.settings.copyWith(hijriAdjustmentDays: days.clamp(-2, 2)),
    );
  }

  Future<void> updateLocation({
    required double latitude,
    required double longitude,
    required String cityNameAr,
    required String cityNameEn,
  }) async {
    await _persist(
      state.settings.copyWith(
        locationLatitude: latitude,
        locationLongitude: longitude,
        locationCityNameAr: cityNameAr,
        locationCityNameEn: cityNameEn,
      ),
      reschedule: true,
    );
  }

  Future<void> updateNotificationsEnabled(bool enabled) async {
    await _persist(
      state.settings.copyWith(notificationsEnabled: enabled),
      reschedule: true,
    );
  }

  Future<void> updatePerPrayerNotificationConfig(
    PrayerSlot slot,
    PerPrayerNotificationConfig config,
  ) async {
    final updatedMap =
        state.settings.prayerNotificationsConfig.updateSlot(slot, config);
    await _persist(
      state.settings.copyWith(prayerNotificationsConfig: updatedMap),
      reschedule: true,
    );
  }

  Future<void> updateWirdReminder({
    bool? enabled,
    int? hour,
    int? minute,
  }) async {
    await _persist(
      state.settings.copyWith(
        wirdReminderEnabled: enabled,
        wirdReminderHour: hour,
        wirdReminderMinute: minute,
      ),
      reschedule: true,
    );
  }

  Future<void> updateFridayReminder({
    bool? enabled,
    int? hour,
    int? minute,
  }) async {
    await _persist(
      state.settings.copyWith(
        fridayReminderEnabled: enabled,
        fridayReminderHour: hour,
        fridayReminderMinute: minute,
      ),
      reschedule: true,
    );
  }

  Future<void> updateTasbihReminder({
    bool? enabled,
    int? hour,
    int? minute,
  }) async {
    await _persist(
      state.settings.copyWith(
        tasbihReminderEnabled: enabled,
        tasbihReminderHour: hour,
        tasbihReminderMinute: minute,
      ),
      reschedule: true,
    );
  }

  Future<void> updateMorningAdhkarReminder({
    bool? enabled,
    int? hour,
    int? minute,
  }) async {
    await _persist(
      state.settings.copyWith(
        morningAdhkarReminderEnabled: enabled,
        morningAdhkarReminderHour: hour,
        morningAdhkarReminderMinute: minute,
      ),
      reschedule: true,
    );
  }

  Future<void> updateEveningAdhkarReminder({
    bool? enabled,
    int? hour,
    int? minute,
  }) async {
    await _persist(
      state.settings.copyWith(
        eveningAdhkarReminderEnabled: enabled,
        eveningAdhkarReminderHour: hour,
        eveningAdhkarReminderMinute: minute,
      ),
      reschedule: true,
    );
  }

  Future<void> updateReaderFontSize(double fontSize) async {
    final clamped = fontSize.clamp(18.0, 42.0);
    await _persist(state.settings.copyWith(readerFontSize: clamped));
  }

  Future<void> updateReaderLineSpacing(double lineSpacing) async {
    final clamped = lineSpacing.clamp(1.3, 2.6);
    await _persist(state.settings.copyWith(readerLineSpacing: clamped));
  }

  Future<void> updateKeepScreenAwake(bool keepAwake) async {
    await _persist(state.settings.copyWith(keepScreenAwake: keepAwake));
  }

  Future<void> updateDefaultReciterId(int reciterId) async {
    await _persist(state.settings.copyWith(defaultReciterId: reciterId));
  }

  Future<void> updateAutoStartReadingMode(bool autoStart) async {
    await _persist(state.settings.copyWith(autoStartReadingMode: autoStart));
  }

  Future<void> updateReadingModeDndEnabled(bool enabled) async {
    await _persist(state.settings.copyWith(readingModeDndEnabled: enabled));
  }

  Future<void> updateReadingModeDndFilter(ReadingDndFilterOption filter) async {
    await _persist(state.settings.copyWith(readingModeDndFilter: filter));
  }

  Future<void> markIosFocusTipShown() async {
    await _persist(state.settings.copyWith(iosFocusTipShown: true));
  }

  Future<void> completeOnboarding() async {
    await _persist(state.settings.copyWith(onboardingCompleted: true));
  }

  Future<void> updateHifzGoals({
    int? newVersesPerDayGoal,
    int? reviewRangesPerDayCap,
    int? catchUpDays,
    bool? catchUpModeEnabled,
  }) async {
    await _persist(
      state.settings.copyWith(
        hifzNewVersesPerDayGoal: newVersesPerDayGoal,
        hifzReviewRangesPerDayCap: reviewRangesPerDayCap,
        hifzCatchUpDays: catchUpDays,
        hifzCatchUpModeEnabled: catchUpModeEnabled,
      ),
    );
  }

  Future<void> updateHifzReminder({
    bool? enabled,
    int? hour,
    int? minute,
  }) async {
    await _persist(
      state.settings.copyWith(
        hifzReminderEnabled: enabled,
        hifzReminderHour: hour,
        hifzReminderMinute: minute,
      ),
      reschedule: true,
    );
  }

  Future<void> _persist(
    AppSettings updated, {
    bool reschedule = false,
  }) async {
    emit(state.copyWith(settings: updated));
    final result = await _repository.saveSettings(updated);
    switch (result) {
      case Success(:final value):
        emit(SettingsState(settings: value, isLoaded: true));
        if (reschedule) {
          await _notificationService?.rescheduleRollingWindow(value);
        }
      case FailureResult(:final failure):
        emit(state.copyWith(errorMessage: failure.message));
    }
  }
}
