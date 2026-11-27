import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/result/result.dart';
import '../../../calendar/domain/services/hijri_calendar_service.dart';
import '../../../qibla/domain/services/qibla_calculator_service.dart';
import '../../../settings/domain/entities/app_settings.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../data/services/location_service.dart';
import '../../domain/entities/prayer_entities.dart';
import '../../domain/services/prayer_calculator_service.dart';
import 'prayer_state.dart';

/// Cubit managing Phase 5 on-device Prayer Times, Next Prayer countdown,
/// Qibla bearing, Umm al-Qura Hijri dates, and foreground location / manual city selection.
class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit({
    required LocationService locationService,
    DateTime Function()? clock,
  })  : _locationService = locationService,
        _clock = clock ?? DateTime.now,
        super(const PrayerState());

  final LocationService _locationService;
  final DateTime Function() _clock;
  Timer? _countdownTimer;
  AppSettings _lastSettings = const AppSettings();

  /// Computes today, tomorrow, 30-day schedules, Qibla bearing, and Hijri date from [settings].
  void recomputeFromSettings(
    AppSettings settings, {
    bool startCountdownTicker = false,
  }) {
    _lastSettings = settings;
    final now = _clock();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final todaySchedule = PrayerCalculatorService.computeScheduleForDate(
      date: today,
      latitude: settings.locationLatitude,
      longitude: settings.locationLongitude,
      method: settings.prayerCalculationMethod,
      asrMadhab: settings.asrMadhab,
      highLatitudeRule: settings.highLatitudeRule,
      adjustments: settings.prayerAdjustments,
    );

    final tomorrowSchedule = PrayerCalculatorService.computeScheduleForDate(
      date: tomorrow,
      latitude: settings.locationLatitude,
      longitude: settings.locationLongitude,
      method: settings.prayerCalculationMethod,
      asrMadhab: settings.asrMadhab,
      highLatitudeRule: settings.highLatitudeRule,
      adjustments: settings.prayerAdjustments,
    );

    final thirtyDay = PrayerCalculatorService.computeThirtyDaySchedules(
      startDate: today,
      latitude: settings.locationLatitude,
      longitude: settings.locationLongitude,
      method: settings.prayerCalculationMethod,
      asrMadhab: settings.asrMadhab,
      highLatitudeRule: settings.highLatitudeRule,
      adjustments: settings.prayerAdjustments,
    );

    final nextPrayer = PrayerCalculatorService.computeNextPrayer(
      todaySchedule: todaySchedule,
      tomorrowSchedule: tomorrowSchedule,
      now: now,
    );

    final qiblaBearing = QiblaCalculatorService.calculateQiblaBearing(
      latitude: settings.locationLatitude,
      longitude: settings.locationLongitude,
    );

    final hijriToday = HijriCalendarService.fromGregorian(
      today,
      adjustmentDays: settings.hijriAdjustmentDays,
    );

    emit(
      state.copyWith(
        isLoading: false,
        cityNameAr: settings.locationCityNameAr,
        cityNameEn: settings.locationCityNameEn,
        latitude: settings.locationLatitude,
        longitude: settings.locationLongitude,
        qiblaBearingDegrees: qiblaBearing,
        todaySchedule: todaySchedule,
        tomorrowSchedule: tomorrowSchedule,
        thirtyDaySchedules: thirtyDay,
        nextPrayer: nextPrayer,
        hijriToday: hijriToday,
        gregorianTodayFormattedAr: HijriCalendarService.formatGregorianDate(
          today,
          languageCode: 'ar',
        ),
        gregorianTodayFormattedEn: HijriCalendarService.formatGregorianDate(
          today,
          languageCode: 'en',
        ),
      ),
    );

    if (startCountdownTicker) {
      _startTicker();
    }
  }

  /// Requests foreground `when-in-use` GPS location and updates [settingsCubit]
  /// if permission is granted (or if the user moved $\ge 10\text{ km}$).
  Future<void> requestGpsLocation(
    SettingsCubit settingsCubit, {
    bool onlyIfMovedSignificantly = false,
  }) async {
    emit(state.copyWith(isLoading: true));
    final result = await _locationService.acquireWhenInUseLocation();
    switch (result) {
      case Success(:final value):
        final currentSettings = settingsCubit.state.settings;
        if (onlyIfMovedSignificantly &&
            !LocationService.hasMovedSignificantDistance(
              previousLatitude: currentSettings.locationLatitude,
              previousLongitude: currentSettings.locationLongitude,
              newLatitude: value.latitude,
              newLongitude: value.longitude,
            )) {
          emit(state.copyWith(isLoading: false));
          return;
        }
        await settingsCubit.updateLocation(
          latitude: value.latitude,
          longitude: value.longitude,
          cityNameAr: value.nameAr,
          cityNameEn: value.nameEn,
        );
        recomputeFromSettings(settingsCubit.state.settings);
      case FailureResult(:final failure):
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ),
        );
    }
  }

  /// Selects a city from the offline manual city search fallback catalog.
  Future<void> selectManualCity(
    CityLocationPreset city,
    SettingsCubit settingsCubit,
  ) async {
    await settingsCubit.updateLocation(
      latitude: city.latitude,
      longitude: city.longitude,
      cityNameAr: city.nameAr,
      cityNameEn: city.nameEn,
    );
    recomputeFromSettings(settingsCubit.state.settings);
  }

  void _startTicker() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) return;
      final today = state.todaySchedule;
      final tomorrow = state.tomorrowSchedule;
      if (today == null || tomorrow == null) return;

      final now = _clock();
      if (now.day != today.date.day) {
        recomputeFromSettings(_lastSettings);
        return;
      }

      final nextPrayer = PrayerCalculatorService.computeNextPrayer(
        todaySchedule: today,
        tomorrowSchedule: tomorrow,
        now: now,
      );
      emit(state.copyWith(nextPrayer: nextPrayer));
    });
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
