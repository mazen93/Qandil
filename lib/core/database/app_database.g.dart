// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ar'));
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
      'theme_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('system'));
  static const VerificationMeta _textScaleFactorMeta =
      const VerificationMeta('textScaleFactor');
  @override
  late final GeneratedColumn<double> textScaleFactor = GeneratedColumn<double>(
      'text_scale_factor', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _prayerCalculationMethodMeta =
      const VerificationMeta('prayerCalculationMethod');
  @override
  late final GeneratedColumn<String> prayerCalculationMethod =
      GeneratedColumn<String>('prayer_calculation_method', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('egyptian'));
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
      'notifications_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notifications_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _readerFontSizeMeta =
      const VerificationMeta('readerFontSize');
  @override
  late final GeneratedColumn<double> readerFontSize = GeneratedColumn<double>(
      'reader_font_size', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(26.0));
  static const VerificationMeta _readerLineSpacingMeta =
      const VerificationMeta('readerLineSpacing');
  @override
  late final GeneratedColumn<double> readerLineSpacing =
      GeneratedColumn<double>('reader_line_spacing', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(1.9));
  static const VerificationMeta _keepScreenAwakeMeta =
      const VerificationMeta('keepScreenAwake');
  @override
  late final GeneratedColumn<bool> keepScreenAwake = GeneratedColumn<bool>(
      'keep_screen_awake', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("keep_screen_awake" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _defaultReciterIdMeta =
      const VerificationMeta('defaultReciterId');
  @override
  late final GeneratedColumn<int> defaultReciterId = GeneratedColumn<int>(
      'default_reciter_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(6));
  static const VerificationMeta _asrMadhabMeta =
      const VerificationMeta('asrMadhab');
  @override
  late final GeneratedColumn<String> asrMadhab = GeneratedColumn<String>(
      'asr_madhab', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('shafi'));
  static const VerificationMeta _highLatitudeRuleMeta =
      const VerificationMeta('highLatitudeRule');
  @override
  late final GeneratedColumn<String> highLatitudeRule = GeneratedColumn<String>(
      'high_latitude_rule', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('middle_of_the_night'));
  static const VerificationMeta _fajrAdjustmentMinutesMeta =
      const VerificationMeta('fajrAdjustmentMinutes');
  @override
  late final GeneratedColumn<int> fajrAdjustmentMinutes = GeneratedColumn<int>(
      'fajr_adjustment_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sunriseAdjustmentMinutesMeta =
      const VerificationMeta('sunriseAdjustmentMinutes');
  @override
  late final GeneratedColumn<int> sunriseAdjustmentMinutes =
      GeneratedColumn<int>('sunrise_adjustment_minutes', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _dhuhrAdjustmentMinutesMeta =
      const VerificationMeta('dhuhrAdjustmentMinutes');
  @override
  late final GeneratedColumn<int> dhuhrAdjustmentMinutes = GeneratedColumn<int>(
      'dhuhr_adjustment_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _asrAdjustmentMinutesMeta =
      const VerificationMeta('asrAdjustmentMinutes');
  @override
  late final GeneratedColumn<int> asrAdjustmentMinutes = GeneratedColumn<int>(
      'asr_adjustment_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _maghribAdjustmentMinutesMeta =
      const VerificationMeta('maghribAdjustmentMinutes');
  @override
  late final GeneratedColumn<int> maghribAdjustmentMinutes =
      GeneratedColumn<int>('maghrib_adjustment_minutes', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _ishaAdjustmentMinutesMeta =
      const VerificationMeta('ishaAdjustmentMinutes');
  @override
  late final GeneratedColumn<int> ishaAdjustmentMinutes = GeneratedColumn<int>(
      'isha_adjustment_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _hijriAdjustmentDaysMeta =
      const VerificationMeta('hijriAdjustmentDays');
  @override
  late final GeneratedColumn<int> hijriAdjustmentDays = GeneratedColumn<int>(
      'hijri_adjustment_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _locationLatitudeMeta =
      const VerificationMeta('locationLatitude');
  @override
  late final GeneratedColumn<double> locationLatitude = GeneratedColumn<double>(
      'location_latitude', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(30.0444));
  static const VerificationMeta _locationLongitudeMeta =
      const VerificationMeta('locationLongitude');
  @override
  late final GeneratedColumn<double> locationLongitude =
      GeneratedColumn<double>('location_longitude', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(31.2357));
  static const VerificationMeta _locationCityNameArMeta =
      const VerificationMeta('locationCityNameAr');
  @override
  late final GeneratedColumn<String> locationCityNameAr =
      GeneratedColumn<String>('location_city_name_ar', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('القاهرة، مصر'));
  static const VerificationMeta _locationCityNameEnMeta =
      const VerificationMeta('locationCityNameEn');
  @override
  late final GeneratedColumn<String> locationCityNameEn =
      GeneratedColumn<String>('location_city_name_en', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('Cairo, Egypt'));
  static const VerificationMeta _prayerNotificationsConfigJsonMeta =
      const VerificationMeta('prayerNotificationsConfigJson');
  @override
  late final GeneratedColumn<String> prayerNotificationsConfigJson =
      GeneratedColumn<String>(
          'prayer_notifications_config_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('{}'));
  static const VerificationMeta _wirdReminderEnabledMeta =
      const VerificationMeta('wirdReminderEnabled');
  @override
  late final GeneratedColumn<bool> wirdReminderEnabled = GeneratedColumn<bool>(
      'wird_reminder_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("wird_reminder_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _wirdReminderHourMeta =
      const VerificationMeta('wirdReminderHour');
  @override
  late final GeneratedColumn<int> wirdReminderHour = GeneratedColumn<int>(
      'wird_reminder_hour', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(20));
  static const VerificationMeta _wirdReminderMinuteMeta =
      const VerificationMeta('wirdReminderMinute');
  @override
  late final GeneratedColumn<int> wirdReminderMinute = GeneratedColumn<int>(
      'wird_reminder_minute', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fridayReminderEnabledMeta =
      const VerificationMeta('fridayReminderEnabled');
  @override
  late final GeneratedColumn<bool> fridayReminderEnabled =
      GeneratedColumn<bool>('friday_reminder_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("friday_reminder_enabled" IN (0, 1))'),
          defaultValue: const Constant(true));
  static const VerificationMeta _fridayReminderHourMeta =
      const VerificationMeta('fridayReminderHour');
  @override
  late final GeneratedColumn<int> fridayReminderHour = GeneratedColumn<int>(
      'friday_reminder_hour', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(10));
  static const VerificationMeta _fridayReminderMinuteMeta =
      const VerificationMeta('fridayReminderMinute');
  @override
  late final GeneratedColumn<int> fridayReminderMinute = GeneratedColumn<int>(
      'friday_reminder_minute', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _tasbihReminderEnabledMeta =
      const VerificationMeta('tasbihReminderEnabled');
  @override
  late final GeneratedColumn<bool> tasbihReminderEnabled =
      GeneratedColumn<bool>('tasbih_reminder_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("tasbih_reminder_enabled" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _tasbihReminderHourMeta =
      const VerificationMeta('tasbihReminderHour');
  @override
  late final GeneratedColumn<int> tasbihReminderHour = GeneratedColumn<int>(
      'tasbih_reminder_hour', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(21));
  static const VerificationMeta _tasbihReminderMinuteMeta =
      const VerificationMeta('tasbihReminderMinute');
  @override
  late final GeneratedColumn<int> tasbihReminderMinute = GeneratedColumn<int>(
      'tasbih_reminder_minute', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _tasbihHapticsEnabledMeta =
      const VerificationMeta('tasbihHapticsEnabled');
  @override
  late final GeneratedColumn<bool> tasbihHapticsEnabled = GeneratedColumn<bool>(
      'tasbih_haptics_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("tasbih_haptics_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _tasbihTargetPresetMeta =
      const VerificationMeta('tasbihTargetPreset');
  @override
  late final GeneratedColumn<int> tasbihTargetPreset = GeneratedColumn<int>(
      'tasbih_target_preset', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(33));
  static const VerificationMeta _tasbihCustomLabelsJsonMeta =
      const VerificationMeta('tasbihCustomLabelsJson');
  @override
  late final GeneratedColumn<String> tasbihCustomLabelsJson =
      GeneratedColumn<String>('tasbih_custom_labels_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _morningAdhkarReminderEnabledMeta =
      const VerificationMeta('morningAdhkarReminderEnabled');
  @override
  late final GeneratedColumn<bool> morningAdhkarReminderEnabled =
      GeneratedColumn<bool>(
          'morning_adhkar_reminder_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("morning_adhkar_reminder_enabled" IN (0, 1))'),
          defaultValue: const Constant(true));
  static const VerificationMeta _morningAdhkarReminderHourMeta =
      const VerificationMeta('morningAdhkarReminderHour');
  @override
  late final GeneratedColumn<int> morningAdhkarReminderHour =
      GeneratedColumn<int>('morning_adhkar_reminder_hour', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(7));
  static const VerificationMeta _morningAdhkarReminderMinuteMeta =
      const VerificationMeta('morningAdhkarReminderMinute');
  @override
  late final GeneratedColumn<int> morningAdhkarReminderMinute =
      GeneratedColumn<int>('morning_adhkar_reminder_minute', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _eveningAdhkarReminderEnabledMeta =
      const VerificationMeta('eveningAdhkarReminderEnabled');
  @override
  late final GeneratedColumn<bool> eveningAdhkarReminderEnabled =
      GeneratedColumn<bool>(
          'evening_adhkar_reminder_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("evening_adhkar_reminder_enabled" IN (0, 1))'),
          defaultValue: const Constant(true));
  static const VerificationMeta _eveningAdhkarReminderHourMeta =
      const VerificationMeta('eveningAdhkarReminderHour');
  @override
  late final GeneratedColumn<int> eveningAdhkarReminderHour =
      GeneratedColumn<int>('evening_adhkar_reminder_hour', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(17));
  static const VerificationMeta _eveningAdhkarReminderMinuteMeta =
      const VerificationMeta('eveningAdhkarReminderMinute');
  @override
  late final GeneratedColumn<int> eveningAdhkarReminderMinute =
      GeneratedColumn<int>('evening_adhkar_reminder_minute', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _autoStartReadingModeMeta =
      const VerificationMeta('autoStartReadingMode');
  @override
  late final GeneratedColumn<bool> autoStartReadingMode = GeneratedColumn<bool>(
      'auto_start_reading_mode', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("auto_start_reading_mode" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _readingModeDndEnabledMeta =
      const VerificationMeta('readingModeDndEnabled');
  @override
  late final GeneratedColumn<bool> readingModeDndEnabled =
      GeneratedColumn<bool>('reading_mode_dnd_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("reading_mode_dnd_enabled" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _readingModeDndFilterMeta =
      const VerificationMeta('readingModeDndFilter');
  @override
  late final GeneratedColumn<String> readingModeDndFilter =
      GeneratedColumn<String>('reading_mode_dnd_filter', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('priority'));
  static const VerificationMeta _savedPreviousDndFilterMeta =
      const VerificationMeta('savedPreviousDndFilter');
  @override
  late final GeneratedColumn<int> savedPreviousDndFilter = GeneratedColumn<int>(
      'saved_previous_dnd_filter', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _iosFocusTipShownMeta =
      const VerificationMeta('iosFocusTipShown');
  @override
  late final GeneratedColumn<bool> iosFocusTipShown = GeneratedColumn<bool>(
      'ios_focus_tip_shown', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("ios_focus_tip_shown" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
      'onboarding_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("onboarding_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hifzNewVersesPerDayGoalMeta =
      const VerificationMeta('hifzNewVersesPerDayGoal');
  @override
  late final GeneratedColumn<int> hifzNewVersesPerDayGoal =
      GeneratedColumn<int>('hifz_new_verses_per_day_goal', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(5));
  static const VerificationMeta _hifzReviewRangesPerDayCapMeta =
      const VerificationMeta('hifzReviewRangesPerDayCap');
  @override
  late final GeneratedColumn<int> hifzReviewRangesPerDayCap =
      GeneratedColumn<int>('hifz_review_ranges_per_day_cap', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(5));
  static const VerificationMeta _hifzCatchUpDaysMeta =
      const VerificationMeta('hifzCatchUpDays');
  @override
  late final GeneratedColumn<int> hifzCatchUpDays = GeneratedColumn<int>(
      'hifz_catch_up_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _hifzCatchUpModeEnabledMeta =
      const VerificationMeta('hifzCatchUpModeEnabled');
  @override
  late final GeneratedColumn<bool> hifzCatchUpModeEnabled =
      GeneratedColumn<bool>('hifz_catch_up_mode_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("hifz_catch_up_mode_enabled" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _hifzReminderEnabledMeta =
      const VerificationMeta('hifzReminderEnabled');
  @override
  late final GeneratedColumn<bool> hifzReminderEnabled = GeneratedColumn<bool>(
      'hifz_reminder_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("hifz_reminder_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hifzReminderHourMeta =
      const VerificationMeta('hifzReminderHour');
  @override
  late final GeneratedColumn<int> hifzReminderHour = GeneratedColumn<int>(
      'hifz_reminder_hour', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(6));
  static const VerificationMeta _hifzReminderMinuteMeta =
      const VerificationMeta('hifzReminderMinute');
  @override
  late final GeneratedColumn<int> hifzReminderMinute = GeneratedColumn<int>(
      'hifz_reminder_minute', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(30));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
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
        fajrAdjustmentMinutes,
        sunriseAdjustmentMinutes,
        dhuhrAdjustmentMinutes,
        asrAdjustmentMinutes,
        maghribAdjustmentMinutes,
        ishaAdjustmentMinutes,
        hijriAdjustmentDays,
        locationLatitude,
        locationLongitude,
        locationCityNameAr,
        locationCityNameEn,
        prayerNotificationsConfigJson,
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
        tasbihCustomLabelsJson,
        morningAdhkarReminderEnabled,
        morningAdhkarReminderHour,
        morningAdhkarReminderMinute,
        eveningAdhkarReminderEnabled,
        eveningAdhkarReminderHour,
        eveningAdhkarReminderMinute,
        autoStartReadingMode,
        readingModeDndEnabled,
        readingModeDndFilter,
        savedPreviousDndFilter,
        iosFocusTipShown,
        onboardingCompleted,
        hifzNewVersesPerDayGoal,
        hifzReviewRangesPerDayCap,
        hifzCatchUpDays,
        hifzCatchUpModeEnabled,
        hifzReminderEnabled,
        hifzReminderHour,
        hifzReminderMinute,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<SettingRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(_themeModeMeta,
          themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta));
    }
    if (data.containsKey('text_scale_factor')) {
      context.handle(
          _textScaleFactorMeta,
          textScaleFactor.isAcceptableOrUnknown(
              data['text_scale_factor']!, _textScaleFactorMeta));
    }
    if (data.containsKey('prayer_calculation_method')) {
      context.handle(
          _prayerCalculationMethodMeta,
          prayerCalculationMethod.isAcceptableOrUnknown(
              data['prayer_calculation_method']!,
              _prayerCalculationMethodMeta));
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
          _notificationsEnabledMeta,
          notificationsEnabled.isAcceptableOrUnknown(
              data['notifications_enabled']!, _notificationsEnabledMeta));
    }
    if (data.containsKey('reader_font_size')) {
      context.handle(
          _readerFontSizeMeta,
          readerFontSize.isAcceptableOrUnknown(
              data['reader_font_size']!, _readerFontSizeMeta));
    }
    if (data.containsKey('reader_line_spacing')) {
      context.handle(
          _readerLineSpacingMeta,
          readerLineSpacing.isAcceptableOrUnknown(
              data['reader_line_spacing']!, _readerLineSpacingMeta));
    }
    if (data.containsKey('keep_screen_awake')) {
      context.handle(
          _keepScreenAwakeMeta,
          keepScreenAwake.isAcceptableOrUnknown(
              data['keep_screen_awake']!, _keepScreenAwakeMeta));
    }
    if (data.containsKey('default_reciter_id')) {
      context.handle(
          _defaultReciterIdMeta,
          defaultReciterId.isAcceptableOrUnknown(
              data['default_reciter_id']!, _defaultReciterIdMeta));
    }
    if (data.containsKey('asr_madhab')) {
      context.handle(_asrMadhabMeta,
          asrMadhab.isAcceptableOrUnknown(data['asr_madhab']!, _asrMadhabMeta));
    }
    if (data.containsKey('high_latitude_rule')) {
      context.handle(
          _highLatitudeRuleMeta,
          highLatitudeRule.isAcceptableOrUnknown(
              data['high_latitude_rule']!, _highLatitudeRuleMeta));
    }
    if (data.containsKey('fajr_adjustment_minutes')) {
      context.handle(
          _fajrAdjustmentMinutesMeta,
          fajrAdjustmentMinutes.isAcceptableOrUnknown(
              data['fajr_adjustment_minutes']!, _fajrAdjustmentMinutesMeta));
    }
    if (data.containsKey('sunrise_adjustment_minutes')) {
      context.handle(
          _sunriseAdjustmentMinutesMeta,
          sunriseAdjustmentMinutes.isAcceptableOrUnknown(
              data['sunrise_adjustment_minutes']!,
              _sunriseAdjustmentMinutesMeta));
    }
    if (data.containsKey('dhuhr_adjustment_minutes')) {
      context.handle(
          _dhuhrAdjustmentMinutesMeta,
          dhuhrAdjustmentMinutes.isAcceptableOrUnknown(
              data['dhuhr_adjustment_minutes']!, _dhuhrAdjustmentMinutesMeta));
    }
    if (data.containsKey('asr_adjustment_minutes')) {
      context.handle(
          _asrAdjustmentMinutesMeta,
          asrAdjustmentMinutes.isAcceptableOrUnknown(
              data['asr_adjustment_minutes']!, _asrAdjustmentMinutesMeta));
    }
    if (data.containsKey('maghrib_adjustment_minutes')) {
      context.handle(
          _maghribAdjustmentMinutesMeta,
          maghribAdjustmentMinutes.isAcceptableOrUnknown(
              data['maghrib_adjustment_minutes']!,
              _maghribAdjustmentMinutesMeta));
    }
    if (data.containsKey('isha_adjustment_minutes')) {
      context.handle(
          _ishaAdjustmentMinutesMeta,
          ishaAdjustmentMinutes.isAcceptableOrUnknown(
              data['isha_adjustment_minutes']!, _ishaAdjustmentMinutesMeta));
    }
    if (data.containsKey('hijri_adjustment_days')) {
      context.handle(
          _hijriAdjustmentDaysMeta,
          hijriAdjustmentDays.isAcceptableOrUnknown(
              data['hijri_adjustment_days']!, _hijriAdjustmentDaysMeta));
    }
    if (data.containsKey('location_latitude')) {
      context.handle(
          _locationLatitudeMeta,
          locationLatitude.isAcceptableOrUnknown(
              data['location_latitude']!, _locationLatitudeMeta));
    }
    if (data.containsKey('location_longitude')) {
      context.handle(
          _locationLongitudeMeta,
          locationLongitude.isAcceptableOrUnknown(
              data['location_longitude']!, _locationLongitudeMeta));
    }
    if (data.containsKey('location_city_name_ar')) {
      context.handle(
          _locationCityNameArMeta,
          locationCityNameAr.isAcceptableOrUnknown(
              data['location_city_name_ar']!, _locationCityNameArMeta));
    }
    if (data.containsKey('location_city_name_en')) {
      context.handle(
          _locationCityNameEnMeta,
          locationCityNameEn.isAcceptableOrUnknown(
              data['location_city_name_en']!, _locationCityNameEnMeta));
    }
    if (data.containsKey('prayer_notifications_config_json')) {
      context.handle(
          _prayerNotificationsConfigJsonMeta,
          prayerNotificationsConfigJson.isAcceptableOrUnknown(
              data['prayer_notifications_config_json']!,
              _prayerNotificationsConfigJsonMeta));
    }
    if (data.containsKey('wird_reminder_enabled')) {
      context.handle(
          _wirdReminderEnabledMeta,
          wirdReminderEnabled.isAcceptableOrUnknown(
              data['wird_reminder_enabled']!, _wirdReminderEnabledMeta));
    }
    if (data.containsKey('wird_reminder_hour')) {
      context.handle(
          _wirdReminderHourMeta,
          wirdReminderHour.isAcceptableOrUnknown(
              data['wird_reminder_hour']!, _wirdReminderHourMeta));
    }
    if (data.containsKey('wird_reminder_minute')) {
      context.handle(
          _wirdReminderMinuteMeta,
          wirdReminderMinute.isAcceptableOrUnknown(
              data['wird_reminder_minute']!, _wirdReminderMinuteMeta));
    }
    if (data.containsKey('friday_reminder_enabled')) {
      context.handle(
          _fridayReminderEnabledMeta,
          fridayReminderEnabled.isAcceptableOrUnknown(
              data['friday_reminder_enabled']!, _fridayReminderEnabledMeta));
    }
    if (data.containsKey('friday_reminder_hour')) {
      context.handle(
          _fridayReminderHourMeta,
          fridayReminderHour.isAcceptableOrUnknown(
              data['friday_reminder_hour']!, _fridayReminderHourMeta));
    }
    if (data.containsKey('friday_reminder_minute')) {
      context.handle(
          _fridayReminderMinuteMeta,
          fridayReminderMinute.isAcceptableOrUnknown(
              data['friday_reminder_minute']!, _fridayReminderMinuteMeta));
    }
    if (data.containsKey('tasbih_reminder_enabled')) {
      context.handle(
          _tasbihReminderEnabledMeta,
          tasbihReminderEnabled.isAcceptableOrUnknown(
              data['tasbih_reminder_enabled']!, _tasbihReminderEnabledMeta));
    }
    if (data.containsKey('tasbih_reminder_hour')) {
      context.handle(
          _tasbihReminderHourMeta,
          tasbihReminderHour.isAcceptableOrUnknown(
              data['tasbih_reminder_hour']!, _tasbihReminderHourMeta));
    }
    if (data.containsKey('tasbih_reminder_minute')) {
      context.handle(
          _tasbihReminderMinuteMeta,
          tasbihReminderMinute.isAcceptableOrUnknown(
              data['tasbih_reminder_minute']!, _tasbihReminderMinuteMeta));
    }
    if (data.containsKey('tasbih_haptics_enabled')) {
      context.handle(
          _tasbihHapticsEnabledMeta,
          tasbihHapticsEnabled.isAcceptableOrUnknown(
              data['tasbih_haptics_enabled']!, _tasbihHapticsEnabledMeta));
    }
    if (data.containsKey('tasbih_target_preset')) {
      context.handle(
          _tasbihTargetPresetMeta,
          tasbihTargetPreset.isAcceptableOrUnknown(
              data['tasbih_target_preset']!, _tasbihTargetPresetMeta));
    }
    if (data.containsKey('tasbih_custom_labels_json')) {
      context.handle(
          _tasbihCustomLabelsJsonMeta,
          tasbihCustomLabelsJson.isAcceptableOrUnknown(
              data['tasbih_custom_labels_json']!, _tasbihCustomLabelsJsonMeta));
    }
    if (data.containsKey('morning_adhkar_reminder_enabled')) {
      context.handle(
          _morningAdhkarReminderEnabledMeta,
          morningAdhkarReminderEnabled.isAcceptableOrUnknown(
              data['morning_adhkar_reminder_enabled']!,
              _morningAdhkarReminderEnabledMeta));
    }
    if (data.containsKey('morning_adhkar_reminder_hour')) {
      context.handle(
          _morningAdhkarReminderHourMeta,
          morningAdhkarReminderHour.isAcceptableOrUnknown(
              data['morning_adhkar_reminder_hour']!,
              _morningAdhkarReminderHourMeta));
    }
    if (data.containsKey('morning_adhkar_reminder_minute')) {
      context.handle(
          _morningAdhkarReminderMinuteMeta,
          morningAdhkarReminderMinute.isAcceptableOrUnknown(
              data['morning_adhkar_reminder_minute']!,
              _morningAdhkarReminderMinuteMeta));
    }
    if (data.containsKey('evening_adhkar_reminder_enabled')) {
      context.handle(
          _eveningAdhkarReminderEnabledMeta,
          eveningAdhkarReminderEnabled.isAcceptableOrUnknown(
              data['evening_adhkar_reminder_enabled']!,
              _eveningAdhkarReminderEnabledMeta));
    }
    if (data.containsKey('evening_adhkar_reminder_hour')) {
      context.handle(
          _eveningAdhkarReminderHourMeta,
          eveningAdhkarReminderHour.isAcceptableOrUnknown(
              data['evening_adhkar_reminder_hour']!,
              _eveningAdhkarReminderHourMeta));
    }
    if (data.containsKey('evening_adhkar_reminder_minute')) {
      context.handle(
          _eveningAdhkarReminderMinuteMeta,
          eveningAdhkarReminderMinute.isAcceptableOrUnknown(
              data['evening_adhkar_reminder_minute']!,
              _eveningAdhkarReminderMinuteMeta));
    }
    if (data.containsKey('auto_start_reading_mode')) {
      context.handle(
          _autoStartReadingModeMeta,
          autoStartReadingMode.isAcceptableOrUnknown(
              data['auto_start_reading_mode']!, _autoStartReadingModeMeta));
    }
    if (data.containsKey('reading_mode_dnd_enabled')) {
      context.handle(
          _readingModeDndEnabledMeta,
          readingModeDndEnabled.isAcceptableOrUnknown(
              data['reading_mode_dnd_enabled']!, _readingModeDndEnabledMeta));
    }
    if (data.containsKey('reading_mode_dnd_filter')) {
      context.handle(
          _readingModeDndFilterMeta,
          readingModeDndFilter.isAcceptableOrUnknown(
              data['reading_mode_dnd_filter']!, _readingModeDndFilterMeta));
    }
    if (data.containsKey('saved_previous_dnd_filter')) {
      context.handle(
          _savedPreviousDndFilterMeta,
          savedPreviousDndFilter.isAcceptableOrUnknown(
              data['saved_previous_dnd_filter']!, _savedPreviousDndFilterMeta));
    }
    if (data.containsKey('ios_focus_tip_shown')) {
      context.handle(
          _iosFocusTipShownMeta,
          iosFocusTipShown.isAcceptableOrUnknown(
              data['ios_focus_tip_shown']!, _iosFocusTipShownMeta));
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
          _onboardingCompletedMeta,
          onboardingCompleted.isAcceptableOrUnknown(
              data['onboarding_completed']!, _onboardingCompletedMeta));
    }
    if (data.containsKey('hifz_new_verses_per_day_goal')) {
      context.handle(
          _hifzNewVersesPerDayGoalMeta,
          hifzNewVersesPerDayGoal.isAcceptableOrUnknown(
              data['hifz_new_verses_per_day_goal']!,
              _hifzNewVersesPerDayGoalMeta));
    }
    if (data.containsKey('hifz_review_ranges_per_day_cap')) {
      context.handle(
          _hifzReviewRangesPerDayCapMeta,
          hifzReviewRangesPerDayCap.isAcceptableOrUnknown(
              data['hifz_review_ranges_per_day_cap']!,
              _hifzReviewRangesPerDayCapMeta));
    }
    if (data.containsKey('hifz_catch_up_days')) {
      context.handle(
          _hifzCatchUpDaysMeta,
          hifzCatchUpDays.isAcceptableOrUnknown(
              data['hifz_catch_up_days']!, _hifzCatchUpDaysMeta));
    }
    if (data.containsKey('hifz_catch_up_mode_enabled')) {
      context.handle(
          _hifzCatchUpModeEnabledMeta,
          hifzCatchUpModeEnabled.isAcceptableOrUnknown(
              data['hifz_catch_up_mode_enabled']!,
              _hifzCatchUpModeEnabledMeta));
    }
    if (data.containsKey('hifz_reminder_enabled')) {
      context.handle(
          _hifzReminderEnabledMeta,
          hifzReminderEnabled.isAcceptableOrUnknown(
              data['hifz_reminder_enabled']!, _hifzReminderEnabledMeta));
    }
    if (data.containsKey('hifz_reminder_hour')) {
      context.handle(
          _hifzReminderHourMeta,
          hifzReminderHour.isAcceptableOrUnknown(
              data['hifz_reminder_hour']!, _hifzReminderHourMeta));
    }
    if (data.containsKey('hifz_reminder_minute')) {
      context.handle(
          _hifzReminderMinuteMeta,
          hifzReminderMinute.isAcceptableOrUnknown(
              data['hifz_reminder_minute']!, _hifzReminderMinuteMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      themeMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_mode'])!,
      textScaleFactor: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}text_scale_factor'])!,
      prayerCalculationMethod: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}prayer_calculation_method'])!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notifications_enabled'])!,
      readerFontSize: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}reader_font_size'])!,
      readerLineSpacing: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}reader_line_spacing'])!,
      keepScreenAwake: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}keep_screen_awake'])!,
      defaultReciterId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}default_reciter_id'])!,
      asrMadhab: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asr_madhab'])!,
      highLatitudeRule: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}high_latitude_rule'])!,
      fajrAdjustmentMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}fajr_adjustment_minutes'])!,
      sunriseAdjustmentMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sunrise_adjustment_minutes'])!,
      dhuhrAdjustmentMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}dhuhr_adjustment_minutes'])!,
      asrAdjustmentMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}asr_adjustment_minutes'])!,
      maghribAdjustmentMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}maghrib_adjustment_minutes'])!,
      ishaAdjustmentMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}isha_adjustment_minutes'])!,
      hijriAdjustmentDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}hijri_adjustment_days'])!,
      locationLatitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}location_latitude'])!,
      locationLongitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}location_longitude'])!,
      locationCityNameAr: attachedDatabase.typeMapping.read(DriftSqlType.string,
          data['${effectivePrefix}location_city_name_ar'])!,
      locationCityNameEn: attachedDatabase.typeMapping.read(DriftSqlType.string,
          data['${effectivePrefix}location_city_name_en'])!,
      prayerNotificationsConfigJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}prayer_notifications_config_json'])!,
      wirdReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}wird_reminder_enabled'])!,
      wirdReminderHour: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}wird_reminder_hour'])!,
      wirdReminderMinute: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}wird_reminder_minute'])!,
      fridayReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}friday_reminder_enabled'])!,
      fridayReminderHour: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}friday_reminder_hour'])!,
      fridayReminderMinute: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}friday_reminder_minute'])!,
      tasbihReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}tasbih_reminder_enabled'])!,
      tasbihReminderHour: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}tasbih_reminder_hour'])!,
      tasbihReminderMinute: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}tasbih_reminder_minute'])!,
      tasbihHapticsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}tasbih_haptics_enabled'])!,
      tasbihTargetPreset: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}tasbih_target_preset'])!,
      tasbihCustomLabelsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tasbih_custom_labels_json'])!,
      morningAdhkarReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}morning_adhkar_reminder_enabled'])!,
      morningAdhkarReminderHour: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}morning_adhkar_reminder_hour'])!,
      morningAdhkarReminderMinute: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}morning_adhkar_reminder_minute'])!,
      eveningAdhkarReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}evening_adhkar_reminder_enabled'])!,
      eveningAdhkarReminderHour: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}evening_adhkar_reminder_hour'])!,
      eveningAdhkarReminderMinute: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}evening_adhkar_reminder_minute'])!,
      autoStartReadingMode: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}auto_start_reading_mode'])!,
      readingModeDndEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}reading_mode_dnd_enabled'])!,
      readingModeDndFilter: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reading_mode_dnd_filter'])!,
      savedPreviousDndFilter: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}saved_previous_dnd_filter']),
      iosFocusTipShown: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}ios_focus_tip_shown'])!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}onboarding_completed'])!,
      hifzNewVersesPerDayGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}hifz_new_verses_per_day_goal'])!,
      hifzReviewRangesPerDayCap: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}hifz_review_ranges_per_day_cap'])!,
      hifzCatchUpDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}hifz_catch_up_days'])!,
      hifzCatchUpModeEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}hifz_catch_up_mode_enabled'])!,
      hifzReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}hifz_reminder_enabled'])!,
      hifzReminderHour: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}hifz_reminder_hour'])!,
      hifzReminderMinute: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}hifz_reminder_minute'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingRecord extends DataClass implements Insertable<SettingRecord> {
  final int id;
  final String languageCode;
  final String themeMode;
  final double textScaleFactor;
  final String prayerCalculationMethod;
  final bool notificationsEnabled;
  final double readerFontSize;
  final double readerLineSpacing;
  final bool keepScreenAwake;
  final int defaultReciterId;
  final String asrMadhab;
  final String highLatitudeRule;
  final int fajrAdjustmentMinutes;
  final int sunriseAdjustmentMinutes;
  final int dhuhrAdjustmentMinutes;
  final int asrAdjustmentMinutes;
  final int maghribAdjustmentMinutes;
  final int ishaAdjustmentMinutes;
  final int hijriAdjustmentDays;
  final double locationLatitude;
  final double locationLongitude;
  final String locationCityNameAr;
  final String locationCityNameEn;
  final String prayerNotificationsConfigJson;
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
  final String tasbihCustomLabelsJson;
  final bool morningAdhkarReminderEnabled;
  final int morningAdhkarReminderHour;
  final int morningAdhkarReminderMinute;
  final bool eveningAdhkarReminderEnabled;
  final int eveningAdhkarReminderHour;
  final int eveningAdhkarReminderMinute;
  final bool autoStartReadingMode;
  final bool readingModeDndEnabled;
  final String readingModeDndFilter;
  final int? savedPreviousDndFilter;
  final bool iosFocusTipShown;
  final bool onboardingCompleted;
  final int hifzNewVersesPerDayGoal;
  final int hifzReviewRangesPerDayCap;
  final int hifzCatchUpDays;
  final bool hifzCatchUpModeEnabled;
  final bool hifzReminderEnabled;
  final int hifzReminderHour;
  final int hifzReminderMinute;
  final DateTime updatedAt;
  const SettingRecord(
      {required this.id,
      required this.languageCode,
      required this.themeMode,
      required this.textScaleFactor,
      required this.prayerCalculationMethod,
      required this.notificationsEnabled,
      required this.readerFontSize,
      required this.readerLineSpacing,
      required this.keepScreenAwake,
      required this.defaultReciterId,
      required this.asrMadhab,
      required this.highLatitudeRule,
      required this.fajrAdjustmentMinutes,
      required this.sunriseAdjustmentMinutes,
      required this.dhuhrAdjustmentMinutes,
      required this.asrAdjustmentMinutes,
      required this.maghribAdjustmentMinutes,
      required this.ishaAdjustmentMinutes,
      required this.hijriAdjustmentDays,
      required this.locationLatitude,
      required this.locationLongitude,
      required this.locationCityNameAr,
      required this.locationCityNameEn,
      required this.prayerNotificationsConfigJson,
      required this.wirdReminderEnabled,
      required this.wirdReminderHour,
      required this.wirdReminderMinute,
      required this.fridayReminderEnabled,
      required this.fridayReminderHour,
      required this.fridayReminderMinute,
      required this.tasbihReminderEnabled,
      required this.tasbihReminderHour,
      required this.tasbihReminderMinute,
      required this.tasbihHapticsEnabled,
      required this.tasbihTargetPreset,
      required this.tasbihCustomLabelsJson,
      required this.morningAdhkarReminderEnabled,
      required this.morningAdhkarReminderHour,
      required this.morningAdhkarReminderMinute,
      required this.eveningAdhkarReminderEnabled,
      required this.eveningAdhkarReminderHour,
      required this.eveningAdhkarReminderMinute,
      required this.autoStartReadingMode,
      required this.readingModeDndEnabled,
      required this.readingModeDndFilter,
      this.savedPreviousDndFilter,
      required this.iosFocusTipShown,
      required this.onboardingCompleted,
      required this.hifzNewVersesPerDayGoal,
      required this.hifzReviewRangesPerDayCap,
      required this.hifzCatchUpDays,
      required this.hifzCatchUpModeEnabled,
      required this.hifzReminderEnabled,
      required this.hifzReminderHour,
      required this.hifzReminderMinute,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language_code'] = Variable<String>(languageCode);
    map['theme_mode'] = Variable<String>(themeMode);
    map['text_scale_factor'] = Variable<double>(textScaleFactor);
    map['prayer_calculation_method'] =
        Variable<String>(prayerCalculationMethod);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['reader_font_size'] = Variable<double>(readerFontSize);
    map['reader_line_spacing'] = Variable<double>(readerLineSpacing);
    map['keep_screen_awake'] = Variable<bool>(keepScreenAwake);
    map['default_reciter_id'] = Variable<int>(defaultReciterId);
    map['asr_madhab'] = Variable<String>(asrMadhab);
    map['high_latitude_rule'] = Variable<String>(highLatitudeRule);
    map['fajr_adjustment_minutes'] = Variable<int>(fajrAdjustmentMinutes);
    map['sunrise_adjustment_minutes'] = Variable<int>(sunriseAdjustmentMinutes);
    map['dhuhr_adjustment_minutes'] = Variable<int>(dhuhrAdjustmentMinutes);
    map['asr_adjustment_minutes'] = Variable<int>(asrAdjustmentMinutes);
    map['maghrib_adjustment_minutes'] = Variable<int>(maghribAdjustmentMinutes);
    map['isha_adjustment_minutes'] = Variable<int>(ishaAdjustmentMinutes);
    map['hijri_adjustment_days'] = Variable<int>(hijriAdjustmentDays);
    map['location_latitude'] = Variable<double>(locationLatitude);
    map['location_longitude'] = Variable<double>(locationLongitude);
    map['location_city_name_ar'] = Variable<String>(locationCityNameAr);
    map['location_city_name_en'] = Variable<String>(locationCityNameEn);
    map['prayer_notifications_config_json'] =
        Variable<String>(prayerNotificationsConfigJson);
    map['wird_reminder_enabled'] = Variable<bool>(wirdReminderEnabled);
    map['wird_reminder_hour'] = Variable<int>(wirdReminderHour);
    map['wird_reminder_minute'] = Variable<int>(wirdReminderMinute);
    map['friday_reminder_enabled'] = Variable<bool>(fridayReminderEnabled);
    map['friday_reminder_hour'] = Variable<int>(fridayReminderHour);
    map['friday_reminder_minute'] = Variable<int>(fridayReminderMinute);
    map['tasbih_reminder_enabled'] = Variable<bool>(tasbihReminderEnabled);
    map['tasbih_reminder_hour'] = Variable<int>(tasbihReminderHour);
    map['tasbih_reminder_minute'] = Variable<int>(tasbihReminderMinute);
    map['tasbih_haptics_enabled'] = Variable<bool>(tasbihHapticsEnabled);
    map['tasbih_target_preset'] = Variable<int>(tasbihTargetPreset);
    map['tasbih_custom_labels_json'] = Variable<String>(tasbihCustomLabelsJson);
    map['morning_adhkar_reminder_enabled'] =
        Variable<bool>(morningAdhkarReminderEnabled);
    map['morning_adhkar_reminder_hour'] =
        Variable<int>(morningAdhkarReminderHour);
    map['morning_adhkar_reminder_minute'] =
        Variable<int>(morningAdhkarReminderMinute);
    map['evening_adhkar_reminder_enabled'] =
        Variable<bool>(eveningAdhkarReminderEnabled);
    map['evening_adhkar_reminder_hour'] =
        Variable<int>(eveningAdhkarReminderHour);
    map['evening_adhkar_reminder_minute'] =
        Variable<int>(eveningAdhkarReminderMinute);
    map['auto_start_reading_mode'] = Variable<bool>(autoStartReadingMode);
    map['reading_mode_dnd_enabled'] = Variable<bool>(readingModeDndEnabled);
    map['reading_mode_dnd_filter'] = Variable<String>(readingModeDndFilter);
    if (!nullToAbsent || savedPreviousDndFilter != null) {
      map['saved_previous_dnd_filter'] = Variable<int>(savedPreviousDndFilter);
    }
    map['ios_focus_tip_shown'] = Variable<bool>(iosFocusTipShown);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['hifz_new_verses_per_day_goal'] =
        Variable<int>(hifzNewVersesPerDayGoal);
    map['hifz_review_ranges_per_day_cap'] =
        Variable<int>(hifzReviewRangesPerDayCap);
    map['hifz_catch_up_days'] = Variable<int>(hifzCatchUpDays);
    map['hifz_catch_up_mode_enabled'] = Variable<bool>(hifzCatchUpModeEnabled);
    map['hifz_reminder_enabled'] = Variable<bool>(hifzReminderEnabled);
    map['hifz_reminder_hour'] = Variable<int>(hifzReminderHour);
    map['hifz_reminder_minute'] = Variable<int>(hifzReminderMinute);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      languageCode: Value(languageCode),
      themeMode: Value(themeMode),
      textScaleFactor: Value(textScaleFactor),
      prayerCalculationMethod: Value(prayerCalculationMethod),
      notificationsEnabled: Value(notificationsEnabled),
      readerFontSize: Value(readerFontSize),
      readerLineSpacing: Value(readerLineSpacing),
      keepScreenAwake: Value(keepScreenAwake),
      defaultReciterId: Value(defaultReciterId),
      asrMadhab: Value(asrMadhab),
      highLatitudeRule: Value(highLatitudeRule),
      fajrAdjustmentMinutes: Value(fajrAdjustmentMinutes),
      sunriseAdjustmentMinutes: Value(sunriseAdjustmentMinutes),
      dhuhrAdjustmentMinutes: Value(dhuhrAdjustmentMinutes),
      asrAdjustmentMinutes: Value(asrAdjustmentMinutes),
      maghribAdjustmentMinutes: Value(maghribAdjustmentMinutes),
      ishaAdjustmentMinutes: Value(ishaAdjustmentMinutes),
      hijriAdjustmentDays: Value(hijriAdjustmentDays),
      locationLatitude: Value(locationLatitude),
      locationLongitude: Value(locationLongitude),
      locationCityNameAr: Value(locationCityNameAr),
      locationCityNameEn: Value(locationCityNameEn),
      prayerNotificationsConfigJson: Value(prayerNotificationsConfigJson),
      wirdReminderEnabled: Value(wirdReminderEnabled),
      wirdReminderHour: Value(wirdReminderHour),
      wirdReminderMinute: Value(wirdReminderMinute),
      fridayReminderEnabled: Value(fridayReminderEnabled),
      fridayReminderHour: Value(fridayReminderHour),
      fridayReminderMinute: Value(fridayReminderMinute),
      tasbihReminderEnabled: Value(tasbihReminderEnabled),
      tasbihReminderHour: Value(tasbihReminderHour),
      tasbihReminderMinute: Value(tasbihReminderMinute),
      tasbihHapticsEnabled: Value(tasbihHapticsEnabled),
      tasbihTargetPreset: Value(tasbihTargetPreset),
      tasbihCustomLabelsJson: Value(tasbihCustomLabelsJson),
      morningAdhkarReminderEnabled: Value(morningAdhkarReminderEnabled),
      morningAdhkarReminderHour: Value(morningAdhkarReminderHour),
      morningAdhkarReminderMinute: Value(morningAdhkarReminderMinute),
      eveningAdhkarReminderEnabled: Value(eveningAdhkarReminderEnabled),
      eveningAdhkarReminderHour: Value(eveningAdhkarReminderHour),
      eveningAdhkarReminderMinute: Value(eveningAdhkarReminderMinute),
      autoStartReadingMode: Value(autoStartReadingMode),
      readingModeDndEnabled: Value(readingModeDndEnabled),
      readingModeDndFilter: Value(readingModeDndFilter),
      savedPreviousDndFilter: savedPreviousDndFilter == null && nullToAbsent
          ? const Value.absent()
          : Value(savedPreviousDndFilter),
      iosFocusTipShown: Value(iosFocusTipShown),
      onboardingCompleted: Value(onboardingCompleted),
      hifzNewVersesPerDayGoal: Value(hifzNewVersesPerDayGoal),
      hifzReviewRangesPerDayCap: Value(hifzReviewRangesPerDayCap),
      hifzCatchUpDays: Value(hifzCatchUpDays),
      hifzCatchUpModeEnabled: Value(hifzCatchUpModeEnabled),
      hifzReminderEnabled: Value(hifzReminderEnabled),
      hifzReminderHour: Value(hifzReminderHour),
      hifzReminderMinute: Value(hifzReminderMinute),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingRecord(
      id: serializer.fromJson<int>(json['id']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      textScaleFactor: serializer.fromJson<double>(json['textScaleFactor']),
      prayerCalculationMethod:
          serializer.fromJson<String>(json['prayerCalculationMethod']),
      notificationsEnabled:
          serializer.fromJson<bool>(json['notificationsEnabled']),
      readerFontSize: serializer.fromJson<double>(json['readerFontSize']),
      readerLineSpacing: serializer.fromJson<double>(json['readerLineSpacing']),
      keepScreenAwake: serializer.fromJson<bool>(json['keepScreenAwake']),
      defaultReciterId: serializer.fromJson<int>(json['defaultReciterId']),
      asrMadhab: serializer.fromJson<String>(json['asrMadhab']),
      highLatitudeRule: serializer.fromJson<String>(json['highLatitudeRule']),
      fajrAdjustmentMinutes:
          serializer.fromJson<int>(json['fajrAdjustmentMinutes']),
      sunriseAdjustmentMinutes:
          serializer.fromJson<int>(json['sunriseAdjustmentMinutes']),
      dhuhrAdjustmentMinutes:
          serializer.fromJson<int>(json['dhuhrAdjustmentMinutes']),
      asrAdjustmentMinutes:
          serializer.fromJson<int>(json['asrAdjustmentMinutes']),
      maghribAdjustmentMinutes:
          serializer.fromJson<int>(json['maghribAdjustmentMinutes']),
      ishaAdjustmentMinutes:
          serializer.fromJson<int>(json['ishaAdjustmentMinutes']),
      hijriAdjustmentDays:
          serializer.fromJson<int>(json['hijriAdjustmentDays']),
      locationLatitude: serializer.fromJson<double>(json['locationLatitude']),
      locationLongitude: serializer.fromJson<double>(json['locationLongitude']),
      locationCityNameAr:
          serializer.fromJson<String>(json['locationCityNameAr']),
      locationCityNameEn:
          serializer.fromJson<String>(json['locationCityNameEn']),
      prayerNotificationsConfigJson:
          serializer.fromJson<String>(json['prayerNotificationsConfigJson']),
      wirdReminderEnabled:
          serializer.fromJson<bool>(json['wirdReminderEnabled']),
      wirdReminderHour: serializer.fromJson<int>(json['wirdReminderHour']),
      wirdReminderMinute: serializer.fromJson<int>(json['wirdReminderMinute']),
      fridayReminderEnabled:
          serializer.fromJson<bool>(json['fridayReminderEnabled']),
      fridayReminderHour: serializer.fromJson<int>(json['fridayReminderHour']),
      fridayReminderMinute:
          serializer.fromJson<int>(json['fridayReminderMinute']),
      tasbihReminderEnabled:
          serializer.fromJson<bool>(json['tasbihReminderEnabled']),
      tasbihReminderHour: serializer.fromJson<int>(json['tasbihReminderHour']),
      tasbihReminderMinute:
          serializer.fromJson<int>(json['tasbihReminderMinute']),
      tasbihHapticsEnabled:
          serializer.fromJson<bool>(json['tasbihHapticsEnabled']),
      tasbihTargetPreset: serializer.fromJson<int>(json['tasbihTargetPreset']),
      tasbihCustomLabelsJson:
          serializer.fromJson<String>(json['tasbihCustomLabelsJson']),
      morningAdhkarReminderEnabled:
          serializer.fromJson<bool>(json['morningAdhkarReminderEnabled']),
      morningAdhkarReminderHour:
          serializer.fromJson<int>(json['morningAdhkarReminderHour']),
      morningAdhkarReminderMinute:
          serializer.fromJson<int>(json['morningAdhkarReminderMinute']),
      eveningAdhkarReminderEnabled:
          serializer.fromJson<bool>(json['eveningAdhkarReminderEnabled']),
      eveningAdhkarReminderHour:
          serializer.fromJson<int>(json['eveningAdhkarReminderHour']),
      eveningAdhkarReminderMinute:
          serializer.fromJson<int>(json['eveningAdhkarReminderMinute']),
      autoStartReadingMode:
          serializer.fromJson<bool>(json['autoStartReadingMode']),
      readingModeDndEnabled:
          serializer.fromJson<bool>(json['readingModeDndEnabled']),
      readingModeDndFilter:
          serializer.fromJson<String>(json['readingModeDndFilter']),
      savedPreviousDndFilter:
          serializer.fromJson<int?>(json['savedPreviousDndFilter']),
      iosFocusTipShown: serializer.fromJson<bool>(json['iosFocusTipShown']),
      onboardingCompleted:
          serializer.fromJson<bool>(json['onboardingCompleted']),
      hifzNewVersesPerDayGoal:
          serializer.fromJson<int>(json['hifzNewVersesPerDayGoal']),
      hifzReviewRangesPerDayCap:
          serializer.fromJson<int>(json['hifzReviewRangesPerDayCap']),
      hifzCatchUpDays: serializer.fromJson<int>(json['hifzCatchUpDays']),
      hifzCatchUpModeEnabled:
          serializer.fromJson<bool>(json['hifzCatchUpModeEnabled']),
      hifzReminderEnabled:
          serializer.fromJson<bool>(json['hifzReminderEnabled']),
      hifzReminderHour: serializer.fromJson<int>(json['hifzReminderHour']),
      hifzReminderMinute: serializer.fromJson<int>(json['hifzReminderMinute']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'languageCode': serializer.toJson<String>(languageCode),
      'themeMode': serializer.toJson<String>(themeMode),
      'textScaleFactor': serializer.toJson<double>(textScaleFactor),
      'prayerCalculationMethod':
          serializer.toJson<String>(prayerCalculationMethod),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'readerFontSize': serializer.toJson<double>(readerFontSize),
      'readerLineSpacing': serializer.toJson<double>(readerLineSpacing),
      'keepScreenAwake': serializer.toJson<bool>(keepScreenAwake),
      'defaultReciterId': serializer.toJson<int>(defaultReciterId),
      'asrMadhab': serializer.toJson<String>(asrMadhab),
      'highLatitudeRule': serializer.toJson<String>(highLatitudeRule),
      'fajrAdjustmentMinutes': serializer.toJson<int>(fajrAdjustmentMinutes),
      'sunriseAdjustmentMinutes':
          serializer.toJson<int>(sunriseAdjustmentMinutes),
      'dhuhrAdjustmentMinutes': serializer.toJson<int>(dhuhrAdjustmentMinutes),
      'asrAdjustmentMinutes': serializer.toJson<int>(asrAdjustmentMinutes),
      'maghribAdjustmentMinutes':
          serializer.toJson<int>(maghribAdjustmentMinutes),
      'ishaAdjustmentMinutes': serializer.toJson<int>(ishaAdjustmentMinutes),
      'hijriAdjustmentDays': serializer.toJson<int>(hijriAdjustmentDays),
      'locationLatitude': serializer.toJson<double>(locationLatitude),
      'locationLongitude': serializer.toJson<double>(locationLongitude),
      'locationCityNameAr': serializer.toJson<String>(locationCityNameAr),
      'locationCityNameEn': serializer.toJson<String>(locationCityNameEn),
      'prayerNotificationsConfigJson':
          serializer.toJson<String>(prayerNotificationsConfigJson),
      'wirdReminderEnabled': serializer.toJson<bool>(wirdReminderEnabled),
      'wirdReminderHour': serializer.toJson<int>(wirdReminderHour),
      'wirdReminderMinute': serializer.toJson<int>(wirdReminderMinute),
      'fridayReminderEnabled': serializer.toJson<bool>(fridayReminderEnabled),
      'fridayReminderHour': serializer.toJson<int>(fridayReminderHour),
      'fridayReminderMinute': serializer.toJson<int>(fridayReminderMinute),
      'tasbihReminderEnabled': serializer.toJson<bool>(tasbihReminderEnabled),
      'tasbihReminderHour': serializer.toJson<int>(tasbihReminderHour),
      'tasbihReminderMinute': serializer.toJson<int>(tasbihReminderMinute),
      'tasbihHapticsEnabled': serializer.toJson<bool>(tasbihHapticsEnabled),
      'tasbihTargetPreset': serializer.toJson<int>(tasbihTargetPreset),
      'tasbihCustomLabelsJson':
          serializer.toJson<String>(tasbihCustomLabelsJson),
      'morningAdhkarReminderEnabled':
          serializer.toJson<bool>(morningAdhkarReminderEnabled),
      'morningAdhkarReminderHour':
          serializer.toJson<int>(morningAdhkarReminderHour),
      'morningAdhkarReminderMinute':
          serializer.toJson<int>(morningAdhkarReminderMinute),
      'eveningAdhkarReminderEnabled':
          serializer.toJson<bool>(eveningAdhkarReminderEnabled),
      'eveningAdhkarReminderHour':
          serializer.toJson<int>(eveningAdhkarReminderHour),
      'eveningAdhkarReminderMinute':
          serializer.toJson<int>(eveningAdhkarReminderMinute),
      'autoStartReadingMode': serializer.toJson<bool>(autoStartReadingMode),
      'readingModeDndEnabled': serializer.toJson<bool>(readingModeDndEnabled),
      'readingModeDndFilter': serializer.toJson<String>(readingModeDndFilter),
      'savedPreviousDndFilter': serializer.toJson<int?>(savedPreviousDndFilter),
      'iosFocusTipShown': serializer.toJson<bool>(iosFocusTipShown),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'hifzNewVersesPerDayGoal':
          serializer.toJson<int>(hifzNewVersesPerDayGoal),
      'hifzReviewRangesPerDayCap':
          serializer.toJson<int>(hifzReviewRangesPerDayCap),
      'hifzCatchUpDays': serializer.toJson<int>(hifzCatchUpDays),
      'hifzCatchUpModeEnabled': serializer.toJson<bool>(hifzCatchUpModeEnabled),
      'hifzReminderEnabled': serializer.toJson<bool>(hifzReminderEnabled),
      'hifzReminderHour': serializer.toJson<int>(hifzReminderHour),
      'hifzReminderMinute': serializer.toJson<int>(hifzReminderMinute),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SettingRecord copyWith(
          {int? id,
          String? languageCode,
          String? themeMode,
          double? textScaleFactor,
          String? prayerCalculationMethod,
          bool? notificationsEnabled,
          double? readerFontSize,
          double? readerLineSpacing,
          bool? keepScreenAwake,
          int? defaultReciterId,
          String? asrMadhab,
          String? highLatitudeRule,
          int? fajrAdjustmentMinutes,
          int? sunriseAdjustmentMinutes,
          int? dhuhrAdjustmentMinutes,
          int? asrAdjustmentMinutes,
          int? maghribAdjustmentMinutes,
          int? ishaAdjustmentMinutes,
          int? hijriAdjustmentDays,
          double? locationLatitude,
          double? locationLongitude,
          String? locationCityNameAr,
          String? locationCityNameEn,
          String? prayerNotificationsConfigJson,
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
          String? tasbihCustomLabelsJson,
          bool? morningAdhkarReminderEnabled,
          int? morningAdhkarReminderHour,
          int? morningAdhkarReminderMinute,
          bool? eveningAdhkarReminderEnabled,
          int? eveningAdhkarReminderHour,
          int? eveningAdhkarReminderMinute,
          bool? autoStartReadingMode,
          bool? readingModeDndEnabled,
          String? readingModeDndFilter,
          Value<int?> savedPreviousDndFilter = const Value.absent(),
          bool? iosFocusTipShown,
          bool? onboardingCompleted,
          int? hifzNewVersesPerDayGoal,
          int? hifzReviewRangesPerDayCap,
          int? hifzCatchUpDays,
          bool? hifzCatchUpModeEnabled,
          bool? hifzReminderEnabled,
          int? hifzReminderHour,
          int? hifzReminderMinute,
          DateTime? updatedAt}) =>
      SettingRecord(
        id: id ?? this.id,
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
        fajrAdjustmentMinutes:
            fajrAdjustmentMinutes ?? this.fajrAdjustmentMinutes,
        sunriseAdjustmentMinutes:
            sunriseAdjustmentMinutes ?? this.sunriseAdjustmentMinutes,
        dhuhrAdjustmentMinutes:
            dhuhrAdjustmentMinutes ?? this.dhuhrAdjustmentMinutes,
        asrAdjustmentMinutes: asrAdjustmentMinutes ?? this.asrAdjustmentMinutes,
        maghribAdjustmentMinutes:
            maghribAdjustmentMinutes ?? this.maghribAdjustmentMinutes,
        ishaAdjustmentMinutes:
            ishaAdjustmentMinutes ?? this.ishaAdjustmentMinutes,
        hijriAdjustmentDays: hijriAdjustmentDays ?? this.hijriAdjustmentDays,
        locationLatitude: locationLatitude ?? this.locationLatitude,
        locationLongitude: locationLongitude ?? this.locationLongitude,
        locationCityNameAr: locationCityNameAr ?? this.locationCityNameAr,
        locationCityNameEn: locationCityNameEn ?? this.locationCityNameEn,
        prayerNotificationsConfigJson:
            prayerNotificationsConfigJson ?? this.prayerNotificationsConfigJson,
        wirdReminderEnabled: wirdReminderEnabled ?? this.wirdReminderEnabled,
        wirdReminderHour: wirdReminderHour ?? this.wirdReminderHour,
        wirdReminderMinute: wirdReminderMinute ?? this.wirdReminderMinute,
        fridayReminderEnabled:
            fridayReminderEnabled ?? this.fridayReminderEnabled,
        fridayReminderHour: fridayReminderHour ?? this.fridayReminderHour,
        fridayReminderMinute: fridayReminderMinute ?? this.fridayReminderMinute,
        tasbihReminderEnabled:
            tasbihReminderEnabled ?? this.tasbihReminderEnabled,
        tasbihReminderHour: tasbihReminderHour ?? this.tasbihReminderHour,
        tasbihReminderMinute: tasbihReminderMinute ?? this.tasbihReminderMinute,
        tasbihHapticsEnabled: tasbihHapticsEnabled ?? this.tasbihHapticsEnabled,
        tasbihTargetPreset: tasbihTargetPreset ?? this.tasbihTargetPreset,
        tasbihCustomLabelsJson:
            tasbihCustomLabelsJson ?? this.tasbihCustomLabelsJson,
        morningAdhkarReminderEnabled:
            morningAdhkarReminderEnabled ?? this.morningAdhkarReminderEnabled,
        morningAdhkarReminderHour:
            morningAdhkarReminderHour ?? this.morningAdhkarReminderHour,
        morningAdhkarReminderMinute:
            morningAdhkarReminderMinute ?? this.morningAdhkarReminderMinute,
        eveningAdhkarReminderEnabled:
            eveningAdhkarReminderEnabled ?? this.eveningAdhkarReminderEnabled,
        eveningAdhkarReminderHour:
            eveningAdhkarReminderHour ?? this.eveningAdhkarReminderHour,
        eveningAdhkarReminderMinute:
            eveningAdhkarReminderMinute ?? this.eveningAdhkarReminderMinute,
        autoStartReadingMode: autoStartReadingMode ?? this.autoStartReadingMode,
        readingModeDndEnabled:
            readingModeDndEnabled ?? this.readingModeDndEnabled,
        readingModeDndFilter: readingModeDndFilter ?? this.readingModeDndFilter,
        savedPreviousDndFilter: savedPreviousDndFilter.present
            ? savedPreviousDndFilter.value
            : this.savedPreviousDndFilter,
        iosFocusTipShown: iosFocusTipShown ?? this.iosFocusTipShown,
        onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
        hifzNewVersesPerDayGoal:
            hifzNewVersesPerDayGoal ?? this.hifzNewVersesPerDayGoal,
        hifzReviewRangesPerDayCap:
            hifzReviewRangesPerDayCap ?? this.hifzReviewRangesPerDayCap,
        hifzCatchUpDays: hifzCatchUpDays ?? this.hifzCatchUpDays,
        hifzCatchUpModeEnabled:
            hifzCatchUpModeEnabled ?? this.hifzCatchUpModeEnabled,
        hifzReminderEnabled: hifzReminderEnabled ?? this.hifzReminderEnabled,
        hifzReminderHour: hifzReminderHour ?? this.hifzReminderHour,
        hifzReminderMinute: hifzReminderMinute ?? this.hifzReminderMinute,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SettingRecord copyWithCompanion(SettingsCompanion data) {
    return SettingRecord(
      id: data.id.present ? data.id.value : this.id,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      textScaleFactor: data.textScaleFactor.present
          ? data.textScaleFactor.value
          : this.textScaleFactor,
      prayerCalculationMethod: data.prayerCalculationMethod.present
          ? data.prayerCalculationMethod.value
          : this.prayerCalculationMethod,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      readerFontSize: data.readerFontSize.present
          ? data.readerFontSize.value
          : this.readerFontSize,
      readerLineSpacing: data.readerLineSpacing.present
          ? data.readerLineSpacing.value
          : this.readerLineSpacing,
      keepScreenAwake: data.keepScreenAwake.present
          ? data.keepScreenAwake.value
          : this.keepScreenAwake,
      defaultReciterId: data.defaultReciterId.present
          ? data.defaultReciterId.value
          : this.defaultReciterId,
      asrMadhab: data.asrMadhab.present ? data.asrMadhab.value : this.asrMadhab,
      highLatitudeRule: data.highLatitudeRule.present
          ? data.highLatitudeRule.value
          : this.highLatitudeRule,
      fajrAdjustmentMinutes: data.fajrAdjustmentMinutes.present
          ? data.fajrAdjustmentMinutes.value
          : this.fajrAdjustmentMinutes,
      sunriseAdjustmentMinutes: data.sunriseAdjustmentMinutes.present
          ? data.sunriseAdjustmentMinutes.value
          : this.sunriseAdjustmentMinutes,
      dhuhrAdjustmentMinutes: data.dhuhrAdjustmentMinutes.present
          ? data.dhuhrAdjustmentMinutes.value
          : this.dhuhrAdjustmentMinutes,
      asrAdjustmentMinutes: data.asrAdjustmentMinutes.present
          ? data.asrAdjustmentMinutes.value
          : this.asrAdjustmentMinutes,
      maghribAdjustmentMinutes: data.maghribAdjustmentMinutes.present
          ? data.maghribAdjustmentMinutes.value
          : this.maghribAdjustmentMinutes,
      ishaAdjustmentMinutes: data.ishaAdjustmentMinutes.present
          ? data.ishaAdjustmentMinutes.value
          : this.ishaAdjustmentMinutes,
      hijriAdjustmentDays: data.hijriAdjustmentDays.present
          ? data.hijriAdjustmentDays.value
          : this.hijriAdjustmentDays,
      locationLatitude: data.locationLatitude.present
          ? data.locationLatitude.value
          : this.locationLatitude,
      locationLongitude: data.locationLongitude.present
          ? data.locationLongitude.value
          : this.locationLongitude,
      locationCityNameAr: data.locationCityNameAr.present
          ? data.locationCityNameAr.value
          : this.locationCityNameAr,
      locationCityNameEn: data.locationCityNameEn.present
          ? data.locationCityNameEn.value
          : this.locationCityNameEn,
      prayerNotificationsConfigJson: data.prayerNotificationsConfigJson.present
          ? data.prayerNotificationsConfigJson.value
          : this.prayerNotificationsConfigJson,
      wirdReminderEnabled: data.wirdReminderEnabled.present
          ? data.wirdReminderEnabled.value
          : this.wirdReminderEnabled,
      wirdReminderHour: data.wirdReminderHour.present
          ? data.wirdReminderHour.value
          : this.wirdReminderHour,
      wirdReminderMinute: data.wirdReminderMinute.present
          ? data.wirdReminderMinute.value
          : this.wirdReminderMinute,
      fridayReminderEnabled: data.fridayReminderEnabled.present
          ? data.fridayReminderEnabled.value
          : this.fridayReminderEnabled,
      fridayReminderHour: data.fridayReminderHour.present
          ? data.fridayReminderHour.value
          : this.fridayReminderHour,
      fridayReminderMinute: data.fridayReminderMinute.present
          ? data.fridayReminderMinute.value
          : this.fridayReminderMinute,
      tasbihReminderEnabled: data.tasbihReminderEnabled.present
          ? data.tasbihReminderEnabled.value
          : this.tasbihReminderEnabled,
      tasbihReminderHour: data.tasbihReminderHour.present
          ? data.tasbihReminderHour.value
          : this.tasbihReminderHour,
      tasbihReminderMinute: data.tasbihReminderMinute.present
          ? data.tasbihReminderMinute.value
          : this.tasbihReminderMinute,
      tasbihHapticsEnabled: data.tasbihHapticsEnabled.present
          ? data.tasbihHapticsEnabled.value
          : this.tasbihHapticsEnabled,
      tasbihTargetPreset: data.tasbihTargetPreset.present
          ? data.tasbihTargetPreset.value
          : this.tasbihTargetPreset,
      tasbihCustomLabelsJson: data.tasbihCustomLabelsJson.present
          ? data.tasbihCustomLabelsJson.value
          : this.tasbihCustomLabelsJson,
      morningAdhkarReminderEnabled: data.morningAdhkarReminderEnabled.present
          ? data.morningAdhkarReminderEnabled.value
          : this.morningAdhkarReminderEnabled,
      morningAdhkarReminderHour: data.morningAdhkarReminderHour.present
          ? data.morningAdhkarReminderHour.value
          : this.morningAdhkarReminderHour,
      morningAdhkarReminderMinute: data.morningAdhkarReminderMinute.present
          ? data.morningAdhkarReminderMinute.value
          : this.morningAdhkarReminderMinute,
      eveningAdhkarReminderEnabled: data.eveningAdhkarReminderEnabled.present
          ? data.eveningAdhkarReminderEnabled.value
          : this.eveningAdhkarReminderEnabled,
      eveningAdhkarReminderHour: data.eveningAdhkarReminderHour.present
          ? data.eveningAdhkarReminderHour.value
          : this.eveningAdhkarReminderHour,
      eveningAdhkarReminderMinute: data.eveningAdhkarReminderMinute.present
          ? data.eveningAdhkarReminderMinute.value
          : this.eveningAdhkarReminderMinute,
      autoStartReadingMode: data.autoStartReadingMode.present
          ? data.autoStartReadingMode.value
          : this.autoStartReadingMode,
      readingModeDndEnabled: data.readingModeDndEnabled.present
          ? data.readingModeDndEnabled.value
          : this.readingModeDndEnabled,
      readingModeDndFilter: data.readingModeDndFilter.present
          ? data.readingModeDndFilter.value
          : this.readingModeDndFilter,
      savedPreviousDndFilter: data.savedPreviousDndFilter.present
          ? data.savedPreviousDndFilter.value
          : this.savedPreviousDndFilter,
      iosFocusTipShown: data.iosFocusTipShown.present
          ? data.iosFocusTipShown.value
          : this.iosFocusTipShown,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      hifzNewVersesPerDayGoal: data.hifzNewVersesPerDayGoal.present
          ? data.hifzNewVersesPerDayGoal.value
          : this.hifzNewVersesPerDayGoal,
      hifzReviewRangesPerDayCap: data.hifzReviewRangesPerDayCap.present
          ? data.hifzReviewRangesPerDayCap.value
          : this.hifzReviewRangesPerDayCap,
      hifzCatchUpDays: data.hifzCatchUpDays.present
          ? data.hifzCatchUpDays.value
          : this.hifzCatchUpDays,
      hifzCatchUpModeEnabled: data.hifzCatchUpModeEnabled.present
          ? data.hifzCatchUpModeEnabled.value
          : this.hifzCatchUpModeEnabled,
      hifzReminderEnabled: data.hifzReminderEnabled.present
          ? data.hifzReminderEnabled.value
          : this.hifzReminderEnabled,
      hifzReminderHour: data.hifzReminderHour.present
          ? data.hifzReminderHour.value
          : this.hifzReminderHour,
      hifzReminderMinute: data.hifzReminderMinute.present
          ? data.hifzReminderMinute.value
          : this.hifzReminderMinute,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingRecord(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('textScaleFactor: $textScaleFactor, ')
          ..write('prayerCalculationMethod: $prayerCalculationMethod, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('readerFontSize: $readerFontSize, ')
          ..write('readerLineSpacing: $readerLineSpacing, ')
          ..write('keepScreenAwake: $keepScreenAwake, ')
          ..write('defaultReciterId: $defaultReciterId, ')
          ..write('asrMadhab: $asrMadhab, ')
          ..write('highLatitudeRule: $highLatitudeRule, ')
          ..write('fajrAdjustmentMinutes: $fajrAdjustmentMinutes, ')
          ..write('sunriseAdjustmentMinutes: $sunriseAdjustmentMinutes, ')
          ..write('dhuhrAdjustmentMinutes: $dhuhrAdjustmentMinutes, ')
          ..write('asrAdjustmentMinutes: $asrAdjustmentMinutes, ')
          ..write('maghribAdjustmentMinutes: $maghribAdjustmentMinutes, ')
          ..write('ishaAdjustmentMinutes: $ishaAdjustmentMinutes, ')
          ..write('hijriAdjustmentDays: $hijriAdjustmentDays, ')
          ..write('locationLatitude: $locationLatitude, ')
          ..write('locationLongitude: $locationLongitude, ')
          ..write('locationCityNameAr: $locationCityNameAr, ')
          ..write('locationCityNameEn: $locationCityNameEn, ')
          ..write(
              'prayerNotificationsConfigJson: $prayerNotificationsConfigJson, ')
          ..write('wirdReminderEnabled: $wirdReminderEnabled, ')
          ..write('wirdReminderHour: $wirdReminderHour, ')
          ..write('wirdReminderMinute: $wirdReminderMinute, ')
          ..write('fridayReminderEnabled: $fridayReminderEnabled, ')
          ..write('fridayReminderHour: $fridayReminderHour, ')
          ..write('fridayReminderMinute: $fridayReminderMinute, ')
          ..write('tasbihReminderEnabled: $tasbihReminderEnabled, ')
          ..write('tasbihReminderHour: $tasbihReminderHour, ')
          ..write('tasbihReminderMinute: $tasbihReminderMinute, ')
          ..write('tasbihHapticsEnabled: $tasbihHapticsEnabled, ')
          ..write('tasbihTargetPreset: $tasbihTargetPreset, ')
          ..write('tasbihCustomLabelsJson: $tasbihCustomLabelsJson, ')
          ..write(
              'morningAdhkarReminderEnabled: $morningAdhkarReminderEnabled, ')
          ..write('morningAdhkarReminderHour: $morningAdhkarReminderHour, ')
          ..write('morningAdhkarReminderMinute: $morningAdhkarReminderMinute, ')
          ..write(
              'eveningAdhkarReminderEnabled: $eveningAdhkarReminderEnabled, ')
          ..write('eveningAdhkarReminderHour: $eveningAdhkarReminderHour, ')
          ..write('eveningAdhkarReminderMinute: $eveningAdhkarReminderMinute, ')
          ..write('autoStartReadingMode: $autoStartReadingMode, ')
          ..write('readingModeDndEnabled: $readingModeDndEnabled, ')
          ..write('readingModeDndFilter: $readingModeDndFilter, ')
          ..write('savedPreviousDndFilter: $savedPreviousDndFilter, ')
          ..write('iosFocusTipShown: $iosFocusTipShown, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('hifzNewVersesPerDayGoal: $hifzNewVersesPerDayGoal, ')
          ..write('hifzReviewRangesPerDayCap: $hifzReviewRangesPerDayCap, ')
          ..write('hifzCatchUpDays: $hifzCatchUpDays, ')
          ..write('hifzCatchUpModeEnabled: $hifzCatchUpModeEnabled, ')
          ..write('hifzReminderEnabled: $hifzReminderEnabled, ')
          ..write('hifzReminderHour: $hifzReminderHour, ')
          ..write('hifzReminderMinute: $hifzReminderMinute, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
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
        fajrAdjustmentMinutes,
        sunriseAdjustmentMinutes,
        dhuhrAdjustmentMinutes,
        asrAdjustmentMinutes,
        maghribAdjustmentMinutes,
        ishaAdjustmentMinutes,
        hijriAdjustmentDays,
        locationLatitude,
        locationLongitude,
        locationCityNameAr,
        locationCityNameEn,
        prayerNotificationsConfigJson,
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
        tasbihCustomLabelsJson,
        morningAdhkarReminderEnabled,
        morningAdhkarReminderHour,
        morningAdhkarReminderMinute,
        eveningAdhkarReminderEnabled,
        eveningAdhkarReminderHour,
        eveningAdhkarReminderMinute,
        autoStartReadingMode,
        readingModeDndEnabled,
        readingModeDndFilter,
        savedPreviousDndFilter,
        iosFocusTipShown,
        onboardingCompleted,
        hifzNewVersesPerDayGoal,
        hifzReviewRangesPerDayCap,
        hifzCatchUpDays,
        hifzCatchUpModeEnabled,
        hifzReminderEnabled,
        hifzReminderHour,
        hifzReminderMinute,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingRecord &&
          other.id == this.id &&
          other.languageCode == this.languageCode &&
          other.themeMode == this.themeMode &&
          other.textScaleFactor == this.textScaleFactor &&
          other.prayerCalculationMethod == this.prayerCalculationMethod &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.readerFontSize == this.readerFontSize &&
          other.readerLineSpacing == this.readerLineSpacing &&
          other.keepScreenAwake == this.keepScreenAwake &&
          other.defaultReciterId == this.defaultReciterId &&
          other.asrMadhab == this.asrMadhab &&
          other.highLatitudeRule == this.highLatitudeRule &&
          other.fajrAdjustmentMinutes == this.fajrAdjustmentMinutes &&
          other.sunriseAdjustmentMinutes == this.sunriseAdjustmentMinutes &&
          other.dhuhrAdjustmentMinutes == this.dhuhrAdjustmentMinutes &&
          other.asrAdjustmentMinutes == this.asrAdjustmentMinutes &&
          other.maghribAdjustmentMinutes == this.maghribAdjustmentMinutes &&
          other.ishaAdjustmentMinutes == this.ishaAdjustmentMinutes &&
          other.hijriAdjustmentDays == this.hijriAdjustmentDays &&
          other.locationLatitude == this.locationLatitude &&
          other.locationLongitude == this.locationLongitude &&
          other.locationCityNameAr == this.locationCityNameAr &&
          other.locationCityNameEn == this.locationCityNameEn &&
          other.prayerNotificationsConfigJson ==
              this.prayerNotificationsConfigJson &&
          other.wirdReminderEnabled == this.wirdReminderEnabled &&
          other.wirdReminderHour == this.wirdReminderHour &&
          other.wirdReminderMinute == this.wirdReminderMinute &&
          other.fridayReminderEnabled == this.fridayReminderEnabled &&
          other.fridayReminderHour == this.fridayReminderHour &&
          other.fridayReminderMinute == this.fridayReminderMinute &&
          other.tasbihReminderEnabled == this.tasbihReminderEnabled &&
          other.tasbihReminderHour == this.tasbihReminderHour &&
          other.tasbihReminderMinute == this.tasbihReminderMinute &&
          other.tasbihHapticsEnabled == this.tasbihHapticsEnabled &&
          other.tasbihTargetPreset == this.tasbihTargetPreset &&
          other.tasbihCustomLabelsJson == this.tasbihCustomLabelsJson &&
          other.morningAdhkarReminderEnabled ==
              this.morningAdhkarReminderEnabled &&
          other.morningAdhkarReminderHour == this.morningAdhkarReminderHour &&
          other.morningAdhkarReminderMinute ==
              this.morningAdhkarReminderMinute &&
          other.eveningAdhkarReminderEnabled ==
              this.eveningAdhkarReminderEnabled &&
          other.eveningAdhkarReminderHour == this.eveningAdhkarReminderHour &&
          other.eveningAdhkarReminderMinute ==
              this.eveningAdhkarReminderMinute &&
          other.autoStartReadingMode == this.autoStartReadingMode &&
          other.readingModeDndEnabled == this.readingModeDndEnabled &&
          other.readingModeDndFilter == this.readingModeDndFilter &&
          other.savedPreviousDndFilter == this.savedPreviousDndFilter &&
          other.iosFocusTipShown == this.iosFocusTipShown &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.hifzNewVersesPerDayGoal == this.hifzNewVersesPerDayGoal &&
          other.hifzReviewRangesPerDayCap == this.hifzReviewRangesPerDayCap &&
          other.hifzCatchUpDays == this.hifzCatchUpDays &&
          other.hifzCatchUpModeEnabled == this.hifzCatchUpModeEnabled &&
          other.hifzReminderEnabled == this.hifzReminderEnabled &&
          other.hifzReminderHour == this.hifzReminderHour &&
          other.hifzReminderMinute == this.hifzReminderMinute &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<SettingRecord> {
  final Value<int> id;
  final Value<String> languageCode;
  final Value<String> themeMode;
  final Value<double> textScaleFactor;
  final Value<String> prayerCalculationMethod;
  final Value<bool> notificationsEnabled;
  final Value<double> readerFontSize;
  final Value<double> readerLineSpacing;
  final Value<bool> keepScreenAwake;
  final Value<int> defaultReciterId;
  final Value<String> asrMadhab;
  final Value<String> highLatitudeRule;
  final Value<int> fajrAdjustmentMinutes;
  final Value<int> sunriseAdjustmentMinutes;
  final Value<int> dhuhrAdjustmentMinutes;
  final Value<int> asrAdjustmentMinutes;
  final Value<int> maghribAdjustmentMinutes;
  final Value<int> ishaAdjustmentMinutes;
  final Value<int> hijriAdjustmentDays;
  final Value<double> locationLatitude;
  final Value<double> locationLongitude;
  final Value<String> locationCityNameAr;
  final Value<String> locationCityNameEn;
  final Value<String> prayerNotificationsConfigJson;
  final Value<bool> wirdReminderEnabled;
  final Value<int> wirdReminderHour;
  final Value<int> wirdReminderMinute;
  final Value<bool> fridayReminderEnabled;
  final Value<int> fridayReminderHour;
  final Value<int> fridayReminderMinute;
  final Value<bool> tasbihReminderEnabled;
  final Value<int> tasbihReminderHour;
  final Value<int> tasbihReminderMinute;
  final Value<bool> tasbihHapticsEnabled;
  final Value<int> tasbihTargetPreset;
  final Value<String> tasbihCustomLabelsJson;
  final Value<bool> morningAdhkarReminderEnabled;
  final Value<int> morningAdhkarReminderHour;
  final Value<int> morningAdhkarReminderMinute;
  final Value<bool> eveningAdhkarReminderEnabled;
  final Value<int> eveningAdhkarReminderHour;
  final Value<int> eveningAdhkarReminderMinute;
  final Value<bool> autoStartReadingMode;
  final Value<bool> readingModeDndEnabled;
  final Value<String> readingModeDndFilter;
  final Value<int?> savedPreviousDndFilter;
  final Value<bool> iosFocusTipShown;
  final Value<bool> onboardingCompleted;
  final Value<int> hifzNewVersesPerDayGoal;
  final Value<int> hifzReviewRangesPerDayCap;
  final Value<int> hifzCatchUpDays;
  final Value<bool> hifzCatchUpModeEnabled;
  final Value<bool> hifzReminderEnabled;
  final Value<int> hifzReminderHour;
  final Value<int> hifzReminderMinute;
  final Value<DateTime> updatedAt;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.textScaleFactor = const Value.absent(),
    this.prayerCalculationMethod = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.readerFontSize = const Value.absent(),
    this.readerLineSpacing = const Value.absent(),
    this.keepScreenAwake = const Value.absent(),
    this.defaultReciterId = const Value.absent(),
    this.asrMadhab = const Value.absent(),
    this.highLatitudeRule = const Value.absent(),
    this.fajrAdjustmentMinutes = const Value.absent(),
    this.sunriseAdjustmentMinutes = const Value.absent(),
    this.dhuhrAdjustmentMinutes = const Value.absent(),
    this.asrAdjustmentMinutes = const Value.absent(),
    this.maghribAdjustmentMinutes = const Value.absent(),
    this.ishaAdjustmentMinutes = const Value.absent(),
    this.hijriAdjustmentDays = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
    this.locationCityNameAr = const Value.absent(),
    this.locationCityNameEn = const Value.absent(),
    this.prayerNotificationsConfigJson = const Value.absent(),
    this.wirdReminderEnabled = const Value.absent(),
    this.wirdReminderHour = const Value.absent(),
    this.wirdReminderMinute = const Value.absent(),
    this.fridayReminderEnabled = const Value.absent(),
    this.fridayReminderHour = const Value.absent(),
    this.fridayReminderMinute = const Value.absent(),
    this.tasbihReminderEnabled = const Value.absent(),
    this.tasbihReminderHour = const Value.absent(),
    this.tasbihReminderMinute = const Value.absent(),
    this.tasbihHapticsEnabled = const Value.absent(),
    this.tasbihTargetPreset = const Value.absent(),
    this.tasbihCustomLabelsJson = const Value.absent(),
    this.morningAdhkarReminderEnabled = const Value.absent(),
    this.morningAdhkarReminderHour = const Value.absent(),
    this.morningAdhkarReminderMinute = const Value.absent(),
    this.eveningAdhkarReminderEnabled = const Value.absent(),
    this.eveningAdhkarReminderHour = const Value.absent(),
    this.eveningAdhkarReminderMinute = const Value.absent(),
    this.autoStartReadingMode = const Value.absent(),
    this.readingModeDndEnabled = const Value.absent(),
    this.readingModeDndFilter = const Value.absent(),
    this.savedPreviousDndFilter = const Value.absent(),
    this.iosFocusTipShown = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.hifzNewVersesPerDayGoal = const Value.absent(),
    this.hifzReviewRangesPerDayCap = const Value.absent(),
    this.hifzCatchUpDays = const Value.absent(),
    this.hifzCatchUpModeEnabled = const Value.absent(),
    this.hifzReminderEnabled = const Value.absent(),
    this.hifzReminderHour = const Value.absent(),
    this.hifzReminderMinute = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.textScaleFactor = const Value.absent(),
    this.prayerCalculationMethod = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.readerFontSize = const Value.absent(),
    this.readerLineSpacing = const Value.absent(),
    this.keepScreenAwake = const Value.absent(),
    this.defaultReciterId = const Value.absent(),
    this.asrMadhab = const Value.absent(),
    this.highLatitudeRule = const Value.absent(),
    this.fajrAdjustmentMinutes = const Value.absent(),
    this.sunriseAdjustmentMinutes = const Value.absent(),
    this.dhuhrAdjustmentMinutes = const Value.absent(),
    this.asrAdjustmentMinutes = const Value.absent(),
    this.maghribAdjustmentMinutes = const Value.absent(),
    this.ishaAdjustmentMinutes = const Value.absent(),
    this.hijriAdjustmentDays = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
    this.locationCityNameAr = const Value.absent(),
    this.locationCityNameEn = const Value.absent(),
    this.prayerNotificationsConfigJson = const Value.absent(),
    this.wirdReminderEnabled = const Value.absent(),
    this.wirdReminderHour = const Value.absent(),
    this.wirdReminderMinute = const Value.absent(),
    this.fridayReminderEnabled = const Value.absent(),
    this.fridayReminderHour = const Value.absent(),
    this.fridayReminderMinute = const Value.absent(),
    this.tasbihReminderEnabled = const Value.absent(),
    this.tasbihReminderHour = const Value.absent(),
    this.tasbihReminderMinute = const Value.absent(),
    this.tasbihHapticsEnabled = const Value.absent(),
    this.tasbihTargetPreset = const Value.absent(),
    this.tasbihCustomLabelsJson = const Value.absent(),
    this.morningAdhkarReminderEnabled = const Value.absent(),
    this.morningAdhkarReminderHour = const Value.absent(),
    this.morningAdhkarReminderMinute = const Value.absent(),
    this.eveningAdhkarReminderEnabled = const Value.absent(),
    this.eveningAdhkarReminderHour = const Value.absent(),
    this.eveningAdhkarReminderMinute = const Value.absent(),
    this.autoStartReadingMode = const Value.absent(),
    this.readingModeDndEnabled = const Value.absent(),
    this.readingModeDndFilter = const Value.absent(),
    this.savedPreviousDndFilter = const Value.absent(),
    this.iosFocusTipShown = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.hifzNewVersesPerDayGoal = const Value.absent(),
    this.hifzReviewRangesPerDayCap = const Value.absent(),
    this.hifzCatchUpDays = const Value.absent(),
    this.hifzCatchUpModeEnabled = const Value.absent(),
    this.hifzReminderEnabled = const Value.absent(),
    this.hifzReminderHour = const Value.absent(),
    this.hifzReminderMinute = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<SettingRecord> custom({
    Expression<int>? id,
    Expression<String>? languageCode,
    Expression<String>? themeMode,
    Expression<double>? textScaleFactor,
    Expression<String>? prayerCalculationMethod,
    Expression<bool>? notificationsEnabled,
    Expression<double>? readerFontSize,
    Expression<double>? readerLineSpacing,
    Expression<bool>? keepScreenAwake,
    Expression<int>? defaultReciterId,
    Expression<String>? asrMadhab,
    Expression<String>? highLatitudeRule,
    Expression<int>? fajrAdjustmentMinutes,
    Expression<int>? sunriseAdjustmentMinutes,
    Expression<int>? dhuhrAdjustmentMinutes,
    Expression<int>? asrAdjustmentMinutes,
    Expression<int>? maghribAdjustmentMinutes,
    Expression<int>? ishaAdjustmentMinutes,
    Expression<int>? hijriAdjustmentDays,
    Expression<double>? locationLatitude,
    Expression<double>? locationLongitude,
    Expression<String>? locationCityNameAr,
    Expression<String>? locationCityNameEn,
    Expression<String>? prayerNotificationsConfigJson,
    Expression<bool>? wirdReminderEnabled,
    Expression<int>? wirdReminderHour,
    Expression<int>? wirdReminderMinute,
    Expression<bool>? fridayReminderEnabled,
    Expression<int>? fridayReminderHour,
    Expression<int>? fridayReminderMinute,
    Expression<bool>? tasbihReminderEnabled,
    Expression<int>? tasbihReminderHour,
    Expression<int>? tasbihReminderMinute,
    Expression<bool>? tasbihHapticsEnabled,
    Expression<int>? tasbihTargetPreset,
    Expression<String>? tasbihCustomLabelsJson,
    Expression<bool>? morningAdhkarReminderEnabled,
    Expression<int>? morningAdhkarReminderHour,
    Expression<int>? morningAdhkarReminderMinute,
    Expression<bool>? eveningAdhkarReminderEnabled,
    Expression<int>? eveningAdhkarReminderHour,
    Expression<int>? eveningAdhkarReminderMinute,
    Expression<bool>? autoStartReadingMode,
    Expression<bool>? readingModeDndEnabled,
    Expression<String>? readingModeDndFilter,
    Expression<int>? savedPreviousDndFilter,
    Expression<bool>? iosFocusTipShown,
    Expression<bool>? onboardingCompleted,
    Expression<int>? hifzNewVersesPerDayGoal,
    Expression<int>? hifzReviewRangesPerDayCap,
    Expression<int>? hifzCatchUpDays,
    Expression<bool>? hifzCatchUpModeEnabled,
    Expression<bool>? hifzReminderEnabled,
    Expression<int>? hifzReminderHour,
    Expression<int>? hifzReminderMinute,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (languageCode != null) 'language_code': languageCode,
      if (themeMode != null) 'theme_mode': themeMode,
      if (textScaleFactor != null) 'text_scale_factor': textScaleFactor,
      if (prayerCalculationMethod != null)
        'prayer_calculation_method': prayerCalculationMethod,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (readerFontSize != null) 'reader_font_size': readerFontSize,
      if (readerLineSpacing != null) 'reader_line_spacing': readerLineSpacing,
      if (keepScreenAwake != null) 'keep_screen_awake': keepScreenAwake,
      if (defaultReciterId != null) 'default_reciter_id': defaultReciterId,
      if (asrMadhab != null) 'asr_madhab': asrMadhab,
      if (highLatitudeRule != null) 'high_latitude_rule': highLatitudeRule,
      if (fajrAdjustmentMinutes != null)
        'fajr_adjustment_minutes': fajrAdjustmentMinutes,
      if (sunriseAdjustmentMinutes != null)
        'sunrise_adjustment_minutes': sunriseAdjustmentMinutes,
      if (dhuhrAdjustmentMinutes != null)
        'dhuhr_adjustment_minutes': dhuhrAdjustmentMinutes,
      if (asrAdjustmentMinutes != null)
        'asr_adjustment_minutes': asrAdjustmentMinutes,
      if (maghribAdjustmentMinutes != null)
        'maghrib_adjustment_minutes': maghribAdjustmentMinutes,
      if (ishaAdjustmentMinutes != null)
        'isha_adjustment_minutes': ishaAdjustmentMinutes,
      if (hijriAdjustmentDays != null)
        'hijri_adjustment_days': hijriAdjustmentDays,
      if (locationLatitude != null) 'location_latitude': locationLatitude,
      if (locationLongitude != null) 'location_longitude': locationLongitude,
      if (locationCityNameAr != null)
        'location_city_name_ar': locationCityNameAr,
      if (locationCityNameEn != null)
        'location_city_name_en': locationCityNameEn,
      if (prayerNotificationsConfigJson != null)
        'prayer_notifications_config_json': prayerNotificationsConfigJson,
      if (wirdReminderEnabled != null)
        'wird_reminder_enabled': wirdReminderEnabled,
      if (wirdReminderHour != null) 'wird_reminder_hour': wirdReminderHour,
      if (wirdReminderMinute != null)
        'wird_reminder_minute': wirdReminderMinute,
      if (fridayReminderEnabled != null)
        'friday_reminder_enabled': fridayReminderEnabled,
      if (fridayReminderHour != null)
        'friday_reminder_hour': fridayReminderHour,
      if (fridayReminderMinute != null)
        'friday_reminder_minute': fridayReminderMinute,
      if (tasbihReminderEnabled != null)
        'tasbih_reminder_enabled': tasbihReminderEnabled,
      if (tasbihReminderHour != null)
        'tasbih_reminder_hour': tasbihReminderHour,
      if (tasbihReminderMinute != null)
        'tasbih_reminder_minute': tasbihReminderMinute,
      if (tasbihHapticsEnabled != null)
        'tasbih_haptics_enabled': tasbihHapticsEnabled,
      if (tasbihTargetPreset != null)
        'tasbih_target_preset': tasbihTargetPreset,
      if (tasbihCustomLabelsJson != null)
        'tasbih_custom_labels_json': tasbihCustomLabelsJson,
      if (morningAdhkarReminderEnabled != null)
        'morning_adhkar_reminder_enabled': morningAdhkarReminderEnabled,
      if (morningAdhkarReminderHour != null)
        'morning_adhkar_reminder_hour': morningAdhkarReminderHour,
      if (morningAdhkarReminderMinute != null)
        'morning_adhkar_reminder_minute': morningAdhkarReminderMinute,
      if (eveningAdhkarReminderEnabled != null)
        'evening_adhkar_reminder_enabled': eveningAdhkarReminderEnabled,
      if (eveningAdhkarReminderHour != null)
        'evening_adhkar_reminder_hour': eveningAdhkarReminderHour,
      if (eveningAdhkarReminderMinute != null)
        'evening_adhkar_reminder_minute': eveningAdhkarReminderMinute,
      if (autoStartReadingMode != null)
        'auto_start_reading_mode': autoStartReadingMode,
      if (readingModeDndEnabled != null)
        'reading_mode_dnd_enabled': readingModeDndEnabled,
      if (readingModeDndFilter != null)
        'reading_mode_dnd_filter': readingModeDndFilter,
      if (savedPreviousDndFilter != null)
        'saved_previous_dnd_filter': savedPreviousDndFilter,
      if (iosFocusTipShown != null) 'ios_focus_tip_shown': iosFocusTipShown,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (hifzNewVersesPerDayGoal != null)
        'hifz_new_verses_per_day_goal': hifzNewVersesPerDayGoal,
      if (hifzReviewRangesPerDayCap != null)
        'hifz_review_ranges_per_day_cap': hifzReviewRangesPerDayCap,
      if (hifzCatchUpDays != null) 'hifz_catch_up_days': hifzCatchUpDays,
      if (hifzCatchUpModeEnabled != null)
        'hifz_catch_up_mode_enabled': hifzCatchUpModeEnabled,
      if (hifzReminderEnabled != null)
        'hifz_reminder_enabled': hifzReminderEnabled,
      if (hifzReminderHour != null) 'hifz_reminder_hour': hifzReminderHour,
      if (hifzReminderMinute != null)
        'hifz_reminder_minute': hifzReminderMinute,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SettingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? languageCode,
      Value<String>? themeMode,
      Value<double>? textScaleFactor,
      Value<String>? prayerCalculationMethod,
      Value<bool>? notificationsEnabled,
      Value<double>? readerFontSize,
      Value<double>? readerLineSpacing,
      Value<bool>? keepScreenAwake,
      Value<int>? defaultReciterId,
      Value<String>? asrMadhab,
      Value<String>? highLatitudeRule,
      Value<int>? fajrAdjustmentMinutes,
      Value<int>? sunriseAdjustmentMinutes,
      Value<int>? dhuhrAdjustmentMinutes,
      Value<int>? asrAdjustmentMinutes,
      Value<int>? maghribAdjustmentMinutes,
      Value<int>? ishaAdjustmentMinutes,
      Value<int>? hijriAdjustmentDays,
      Value<double>? locationLatitude,
      Value<double>? locationLongitude,
      Value<String>? locationCityNameAr,
      Value<String>? locationCityNameEn,
      Value<String>? prayerNotificationsConfigJson,
      Value<bool>? wirdReminderEnabled,
      Value<int>? wirdReminderHour,
      Value<int>? wirdReminderMinute,
      Value<bool>? fridayReminderEnabled,
      Value<int>? fridayReminderHour,
      Value<int>? fridayReminderMinute,
      Value<bool>? tasbihReminderEnabled,
      Value<int>? tasbihReminderHour,
      Value<int>? tasbihReminderMinute,
      Value<bool>? tasbihHapticsEnabled,
      Value<int>? tasbihTargetPreset,
      Value<String>? tasbihCustomLabelsJson,
      Value<bool>? morningAdhkarReminderEnabled,
      Value<int>? morningAdhkarReminderHour,
      Value<int>? morningAdhkarReminderMinute,
      Value<bool>? eveningAdhkarReminderEnabled,
      Value<int>? eveningAdhkarReminderHour,
      Value<int>? eveningAdhkarReminderMinute,
      Value<bool>? autoStartReadingMode,
      Value<bool>? readingModeDndEnabled,
      Value<String>? readingModeDndFilter,
      Value<int?>? savedPreviousDndFilter,
      Value<bool>? iosFocusTipShown,
      Value<bool>? onboardingCompleted,
      Value<int>? hifzNewVersesPerDayGoal,
      Value<int>? hifzReviewRangesPerDayCap,
      Value<int>? hifzCatchUpDays,
      Value<bool>? hifzCatchUpModeEnabled,
      Value<bool>? hifzReminderEnabled,
      Value<int>? hifzReminderHour,
      Value<int>? hifzReminderMinute,
      Value<DateTime>? updatedAt}) {
    return SettingsCompanion(
      id: id ?? this.id,
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
      fajrAdjustmentMinutes:
          fajrAdjustmentMinutes ?? this.fajrAdjustmentMinutes,
      sunriseAdjustmentMinutes:
          sunriseAdjustmentMinutes ?? this.sunriseAdjustmentMinutes,
      dhuhrAdjustmentMinutes:
          dhuhrAdjustmentMinutes ?? this.dhuhrAdjustmentMinutes,
      asrAdjustmentMinutes: asrAdjustmentMinutes ?? this.asrAdjustmentMinutes,
      maghribAdjustmentMinutes:
          maghribAdjustmentMinutes ?? this.maghribAdjustmentMinutes,
      ishaAdjustmentMinutes:
          ishaAdjustmentMinutes ?? this.ishaAdjustmentMinutes,
      hijriAdjustmentDays: hijriAdjustmentDays ?? this.hijriAdjustmentDays,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      locationCityNameAr: locationCityNameAr ?? this.locationCityNameAr,
      locationCityNameEn: locationCityNameEn ?? this.locationCityNameEn,
      prayerNotificationsConfigJson:
          prayerNotificationsConfigJson ?? this.prayerNotificationsConfigJson,
      wirdReminderEnabled: wirdReminderEnabled ?? this.wirdReminderEnabled,
      wirdReminderHour: wirdReminderHour ?? this.wirdReminderHour,
      wirdReminderMinute: wirdReminderMinute ?? this.wirdReminderMinute,
      fridayReminderEnabled:
          fridayReminderEnabled ?? this.fridayReminderEnabled,
      fridayReminderHour: fridayReminderHour ?? this.fridayReminderHour,
      fridayReminderMinute: fridayReminderMinute ?? this.fridayReminderMinute,
      tasbihReminderEnabled:
          tasbihReminderEnabled ?? this.tasbihReminderEnabled,
      tasbihReminderHour: tasbihReminderHour ?? this.tasbihReminderHour,
      tasbihReminderMinute: tasbihReminderMinute ?? this.tasbihReminderMinute,
      tasbihHapticsEnabled: tasbihHapticsEnabled ?? this.tasbihHapticsEnabled,
      tasbihTargetPreset: tasbihTargetPreset ?? this.tasbihTargetPreset,
      tasbihCustomLabelsJson:
          tasbihCustomLabelsJson ?? this.tasbihCustomLabelsJson,
      morningAdhkarReminderEnabled:
          morningAdhkarReminderEnabled ?? this.morningAdhkarReminderEnabled,
      morningAdhkarReminderHour:
          morningAdhkarReminderHour ?? this.morningAdhkarReminderHour,
      morningAdhkarReminderMinute:
          morningAdhkarReminderMinute ?? this.morningAdhkarReminderMinute,
      eveningAdhkarReminderEnabled:
          eveningAdhkarReminderEnabled ?? this.eveningAdhkarReminderEnabled,
      eveningAdhkarReminderHour:
          eveningAdhkarReminderHour ?? this.eveningAdhkarReminderHour,
      eveningAdhkarReminderMinute:
          eveningAdhkarReminderMinute ?? this.eveningAdhkarReminderMinute,
      autoStartReadingMode: autoStartReadingMode ?? this.autoStartReadingMode,
      readingModeDndEnabled:
          readingModeDndEnabled ?? this.readingModeDndEnabled,
      readingModeDndFilter: readingModeDndFilter ?? this.readingModeDndFilter,
      savedPreviousDndFilter:
          savedPreviousDndFilter ?? this.savedPreviousDndFilter,
      iosFocusTipShown: iosFocusTipShown ?? this.iosFocusTipShown,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      hifzNewVersesPerDayGoal:
          hifzNewVersesPerDayGoal ?? this.hifzNewVersesPerDayGoal,
      hifzReviewRangesPerDayCap:
          hifzReviewRangesPerDayCap ?? this.hifzReviewRangesPerDayCap,
      hifzCatchUpDays: hifzCatchUpDays ?? this.hifzCatchUpDays,
      hifzCatchUpModeEnabled:
          hifzCatchUpModeEnabled ?? this.hifzCatchUpModeEnabled,
      hifzReminderEnabled: hifzReminderEnabled ?? this.hifzReminderEnabled,
      hifzReminderHour: hifzReminderHour ?? this.hifzReminderHour,
      hifzReminderMinute: hifzReminderMinute ?? this.hifzReminderMinute,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (textScaleFactor.present) {
      map['text_scale_factor'] = Variable<double>(textScaleFactor.value);
    }
    if (prayerCalculationMethod.present) {
      map['prayer_calculation_method'] =
          Variable<String>(prayerCalculationMethod.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (readerFontSize.present) {
      map['reader_font_size'] = Variable<double>(readerFontSize.value);
    }
    if (readerLineSpacing.present) {
      map['reader_line_spacing'] = Variable<double>(readerLineSpacing.value);
    }
    if (keepScreenAwake.present) {
      map['keep_screen_awake'] = Variable<bool>(keepScreenAwake.value);
    }
    if (defaultReciterId.present) {
      map['default_reciter_id'] = Variable<int>(defaultReciterId.value);
    }
    if (asrMadhab.present) {
      map['asr_madhab'] = Variable<String>(asrMadhab.value);
    }
    if (highLatitudeRule.present) {
      map['high_latitude_rule'] = Variable<String>(highLatitudeRule.value);
    }
    if (fajrAdjustmentMinutes.present) {
      map['fajr_adjustment_minutes'] =
          Variable<int>(fajrAdjustmentMinutes.value);
    }
    if (sunriseAdjustmentMinutes.present) {
      map['sunrise_adjustment_minutes'] =
          Variable<int>(sunriseAdjustmentMinutes.value);
    }
    if (dhuhrAdjustmentMinutes.present) {
      map['dhuhr_adjustment_minutes'] =
          Variable<int>(dhuhrAdjustmentMinutes.value);
    }
    if (asrAdjustmentMinutes.present) {
      map['asr_adjustment_minutes'] = Variable<int>(asrAdjustmentMinutes.value);
    }
    if (maghribAdjustmentMinutes.present) {
      map['maghrib_adjustment_minutes'] =
          Variable<int>(maghribAdjustmentMinutes.value);
    }
    if (ishaAdjustmentMinutes.present) {
      map['isha_adjustment_minutes'] =
          Variable<int>(ishaAdjustmentMinutes.value);
    }
    if (hijriAdjustmentDays.present) {
      map['hijri_adjustment_days'] = Variable<int>(hijriAdjustmentDays.value);
    }
    if (locationLatitude.present) {
      map['location_latitude'] = Variable<double>(locationLatitude.value);
    }
    if (locationLongitude.present) {
      map['location_longitude'] = Variable<double>(locationLongitude.value);
    }
    if (locationCityNameAr.present) {
      map['location_city_name_ar'] = Variable<String>(locationCityNameAr.value);
    }
    if (locationCityNameEn.present) {
      map['location_city_name_en'] = Variable<String>(locationCityNameEn.value);
    }
    if (prayerNotificationsConfigJson.present) {
      map['prayer_notifications_config_json'] =
          Variable<String>(prayerNotificationsConfigJson.value);
    }
    if (wirdReminderEnabled.present) {
      map['wird_reminder_enabled'] = Variable<bool>(wirdReminderEnabled.value);
    }
    if (wirdReminderHour.present) {
      map['wird_reminder_hour'] = Variable<int>(wirdReminderHour.value);
    }
    if (wirdReminderMinute.present) {
      map['wird_reminder_minute'] = Variable<int>(wirdReminderMinute.value);
    }
    if (fridayReminderEnabled.present) {
      map['friday_reminder_enabled'] =
          Variable<bool>(fridayReminderEnabled.value);
    }
    if (fridayReminderHour.present) {
      map['friday_reminder_hour'] = Variable<int>(fridayReminderHour.value);
    }
    if (fridayReminderMinute.present) {
      map['friday_reminder_minute'] = Variable<int>(fridayReminderMinute.value);
    }
    if (tasbihReminderEnabled.present) {
      map['tasbih_reminder_enabled'] =
          Variable<bool>(tasbihReminderEnabled.value);
    }
    if (tasbihReminderHour.present) {
      map['tasbih_reminder_hour'] = Variable<int>(tasbihReminderHour.value);
    }
    if (tasbihReminderMinute.present) {
      map['tasbih_reminder_minute'] = Variable<int>(tasbihReminderMinute.value);
    }
    if (tasbihHapticsEnabled.present) {
      map['tasbih_haptics_enabled'] =
          Variable<bool>(tasbihHapticsEnabled.value);
    }
    if (tasbihTargetPreset.present) {
      map['tasbih_target_preset'] = Variable<int>(tasbihTargetPreset.value);
    }
    if (tasbihCustomLabelsJson.present) {
      map['tasbih_custom_labels_json'] =
          Variable<String>(tasbihCustomLabelsJson.value);
    }
    if (morningAdhkarReminderEnabled.present) {
      map['morning_adhkar_reminder_enabled'] =
          Variable<bool>(morningAdhkarReminderEnabled.value);
    }
    if (morningAdhkarReminderHour.present) {
      map['morning_adhkar_reminder_hour'] =
          Variable<int>(morningAdhkarReminderHour.value);
    }
    if (morningAdhkarReminderMinute.present) {
      map['morning_adhkar_reminder_minute'] =
          Variable<int>(morningAdhkarReminderMinute.value);
    }
    if (eveningAdhkarReminderEnabled.present) {
      map['evening_adhkar_reminder_enabled'] =
          Variable<bool>(eveningAdhkarReminderEnabled.value);
    }
    if (eveningAdhkarReminderHour.present) {
      map['evening_adhkar_reminder_hour'] =
          Variable<int>(eveningAdhkarReminderHour.value);
    }
    if (eveningAdhkarReminderMinute.present) {
      map['evening_adhkar_reminder_minute'] =
          Variable<int>(eveningAdhkarReminderMinute.value);
    }
    if (autoStartReadingMode.present) {
      map['auto_start_reading_mode'] =
          Variable<bool>(autoStartReadingMode.value);
    }
    if (readingModeDndEnabled.present) {
      map['reading_mode_dnd_enabled'] =
          Variable<bool>(readingModeDndEnabled.value);
    }
    if (readingModeDndFilter.present) {
      map['reading_mode_dnd_filter'] =
          Variable<String>(readingModeDndFilter.value);
    }
    if (savedPreviousDndFilter.present) {
      map['saved_previous_dnd_filter'] =
          Variable<int>(savedPreviousDndFilter.value);
    }
    if (iosFocusTipShown.present) {
      map['ios_focus_tip_shown'] = Variable<bool>(iosFocusTipShown.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (hifzNewVersesPerDayGoal.present) {
      map['hifz_new_verses_per_day_goal'] =
          Variable<int>(hifzNewVersesPerDayGoal.value);
    }
    if (hifzReviewRangesPerDayCap.present) {
      map['hifz_review_ranges_per_day_cap'] =
          Variable<int>(hifzReviewRangesPerDayCap.value);
    }
    if (hifzCatchUpDays.present) {
      map['hifz_catch_up_days'] = Variable<int>(hifzCatchUpDays.value);
    }
    if (hifzCatchUpModeEnabled.present) {
      map['hifz_catch_up_mode_enabled'] =
          Variable<bool>(hifzCatchUpModeEnabled.value);
    }
    if (hifzReminderEnabled.present) {
      map['hifz_reminder_enabled'] = Variable<bool>(hifzReminderEnabled.value);
    }
    if (hifzReminderHour.present) {
      map['hifz_reminder_hour'] = Variable<int>(hifzReminderHour.value);
    }
    if (hifzReminderMinute.present) {
      map['hifz_reminder_minute'] = Variable<int>(hifzReminderMinute.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('textScaleFactor: $textScaleFactor, ')
          ..write('prayerCalculationMethod: $prayerCalculationMethod, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('readerFontSize: $readerFontSize, ')
          ..write('readerLineSpacing: $readerLineSpacing, ')
          ..write('keepScreenAwake: $keepScreenAwake, ')
          ..write('defaultReciterId: $defaultReciterId, ')
          ..write('asrMadhab: $asrMadhab, ')
          ..write('highLatitudeRule: $highLatitudeRule, ')
          ..write('fajrAdjustmentMinutes: $fajrAdjustmentMinutes, ')
          ..write('sunriseAdjustmentMinutes: $sunriseAdjustmentMinutes, ')
          ..write('dhuhrAdjustmentMinutes: $dhuhrAdjustmentMinutes, ')
          ..write('asrAdjustmentMinutes: $asrAdjustmentMinutes, ')
          ..write('maghribAdjustmentMinutes: $maghribAdjustmentMinutes, ')
          ..write('ishaAdjustmentMinutes: $ishaAdjustmentMinutes, ')
          ..write('hijriAdjustmentDays: $hijriAdjustmentDays, ')
          ..write('locationLatitude: $locationLatitude, ')
          ..write('locationLongitude: $locationLongitude, ')
          ..write('locationCityNameAr: $locationCityNameAr, ')
          ..write('locationCityNameEn: $locationCityNameEn, ')
          ..write(
              'prayerNotificationsConfigJson: $prayerNotificationsConfigJson, ')
          ..write('wirdReminderEnabled: $wirdReminderEnabled, ')
          ..write('wirdReminderHour: $wirdReminderHour, ')
          ..write('wirdReminderMinute: $wirdReminderMinute, ')
          ..write('fridayReminderEnabled: $fridayReminderEnabled, ')
          ..write('fridayReminderHour: $fridayReminderHour, ')
          ..write('fridayReminderMinute: $fridayReminderMinute, ')
          ..write('tasbihReminderEnabled: $tasbihReminderEnabled, ')
          ..write('tasbihReminderHour: $tasbihReminderHour, ')
          ..write('tasbihReminderMinute: $tasbihReminderMinute, ')
          ..write('tasbihHapticsEnabled: $tasbihHapticsEnabled, ')
          ..write('tasbihTargetPreset: $tasbihTargetPreset, ')
          ..write('tasbihCustomLabelsJson: $tasbihCustomLabelsJson, ')
          ..write(
              'morningAdhkarReminderEnabled: $morningAdhkarReminderEnabled, ')
          ..write('morningAdhkarReminderHour: $morningAdhkarReminderHour, ')
          ..write('morningAdhkarReminderMinute: $morningAdhkarReminderMinute, ')
          ..write(
              'eveningAdhkarReminderEnabled: $eveningAdhkarReminderEnabled, ')
          ..write('eveningAdhkarReminderHour: $eveningAdhkarReminderHour, ')
          ..write('eveningAdhkarReminderMinute: $eveningAdhkarReminderMinute, ')
          ..write('autoStartReadingMode: $autoStartReadingMode, ')
          ..write('readingModeDndEnabled: $readingModeDndEnabled, ')
          ..write('readingModeDndFilter: $readingModeDndFilter, ')
          ..write('savedPreviousDndFilter: $savedPreviousDndFilter, ')
          ..write('iosFocusTipShown: $iosFocusTipShown, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('hifzNewVersesPerDayGoal: $hifzNewVersesPerDayGoal, ')
          ..write('hifzReviewRangesPerDayCap: $hifzReviewRangesPerDayCap, ')
          ..write('hifzCatchUpDays: $hifzCatchUpDays, ')
          ..write('hifzCatchUpModeEnabled: $hifzCatchUpModeEnabled, ')
          ..write('hifzReminderEnabled: $hifzReminderEnabled, ')
          ..write('hifzReminderHour: $hifzReminderHour, ')
          ..write('hifzReminderMinute: $hifzReminderMinute, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, BookmarkRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ayahNumberMeta =
      const VerificationMeta('ayahNumber');
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
      'ayah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pageNumberMeta =
      const VerificationMeta('pageNumber');
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
      'page_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#F2A93B'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, surahNumber, ayahNumber, pageNumber, colorHex, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<BookmarkRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
          _ayahNumberMeta,
          ayahNumber.isAcceptableOrUnknown(
              data['ayah_number']!, _ayahNumberMeta));
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
          _pageNumberMeta,
          pageNumber.isAcceptableOrUnknown(
              data['page_number']!, _pageNumberMeta));
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BookmarkRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookmarkRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number'])!,
      ayahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_number'])!,
      pageNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_number'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class BookmarkRecord extends DataClass implements Insertable<BookmarkRecord> {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final int pageNumber;
  final String colorHex;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BookmarkRecord(
      {required this.id,
      required this.surahNumber,
      required this.ayahNumber,
      required this.pageNumber,
      required this.colorHex,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['page_number'] = Variable<int>(pageNumber);
    map['color_hex'] = Variable<String>(colorHex);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      pageNumber: Value(pageNumber),
      colorHex: Value(colorHex),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BookmarkRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookmarkRecord(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'colorHex': serializer.toJson<String>(colorHex),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BookmarkRecord copyWith(
          {int? id,
          int? surahNumber,
          int? ayahNumber,
          int? pageNumber,
          String? colorHex,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      BookmarkRecord(
        id: id ?? this.id,
        surahNumber: surahNumber ?? this.surahNumber,
        ayahNumber: ayahNumber ?? this.ayahNumber,
        pageNumber: pageNumber ?? this.pageNumber,
        colorHex: colorHex ?? this.colorHex,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  BookmarkRecord copyWithCompanion(BookmarksCompanion data) {
    return BookmarkRecord(
      id: data.id.present ? data.id.value : this.id,
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      pageNumber:
          data.pageNumber.present ? data.pageNumber.value : this.pageNumber,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkRecord(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('colorHex: $colorHex, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, surahNumber, ayahNumber, pageNumber, colorHex, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookmarkRecord &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.pageNumber == this.pageNumber &&
          other.colorHex == this.colorHex &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BookmarksCompanion extends UpdateCompanion<BookmarkRecord> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<int> pageNumber;
  final Value<String> colorHex;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    required int pageNumber,
    this.colorHex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : surahNumber = Value(surahNumber),
        ayahNumber = Value(ayahNumber),
        pageNumber = Value(pageNumber);
  static Insertable<BookmarkRecord> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<int>? pageNumber,
    Expression<String>? colorHex,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (pageNumber != null) 'page_number': pageNumber,
      if (colorHex != null) 'color_hex': colorHex,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BookmarksCompanion copyWith(
      {Value<int>? id,
      Value<int>? surahNumber,
      Value<int>? ayahNumber,
      Value<int>? pageNumber,
      Value<String>? colorHex,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return BookmarksCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      pageNumber: pageNumber ?? this.pageNumber,
      colorHex: colorHex ?? this.colorHex,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('colorHex: $colorHex, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ReadingProgressTable extends ReadingProgress
    with TableInfo<$ReadingProgressTable, ReadingProgressRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _ayahNumberMeta =
      const VerificationMeta('ayahNumber');
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
      'ayah_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _pageNumberMeta =
      const VerificationMeta('pageNumber');
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
      'page_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _juzNumberMeta =
      const VerificationMeta('juzNumber');
  @override
  late final GeneratedColumn<int> juzNumber = GeneratedColumn<int>(
      'juz_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _khatmahTargetDaysMeta =
      const VerificationMeta('khatmahTargetDays');
  @override
  late final GeneratedColumn<int> khatmahTargetDays = GeneratedColumn<int>(
      'khatmah_target_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(30));
  static const VerificationMeta _khatmahStartDateMeta =
      const VerificationMeta('khatmahStartDate');
  @override
  late final GeneratedColumn<DateTime> khatmahStartDate =
      GeneratedColumn<DateTime>('khatmah_start_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        surahNumber,
        ayahNumber,
        pageNumber,
        juzNumber,
        khatmahTargetDays,
        khatmahStartDate,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progress';
  @override
  VerificationContext validateIntegrity(
      Insertable<ReadingProgressRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
          _ayahNumberMeta,
          ayahNumber.isAcceptableOrUnknown(
              data['ayah_number']!, _ayahNumberMeta));
    }
    if (data.containsKey('page_number')) {
      context.handle(
          _pageNumberMeta,
          pageNumber.isAcceptableOrUnknown(
              data['page_number']!, _pageNumberMeta));
    }
    if (data.containsKey('juz_number')) {
      context.handle(_juzNumberMeta,
          juzNumber.isAcceptableOrUnknown(data['juz_number']!, _juzNumberMeta));
    }
    if (data.containsKey('khatmah_target_days')) {
      context.handle(
          _khatmahTargetDaysMeta,
          khatmahTargetDays.isAcceptableOrUnknown(
              data['khatmah_target_days']!, _khatmahTargetDaysMeta));
    }
    if (data.containsKey('khatmah_start_date')) {
      context.handle(
          _khatmahStartDateMeta,
          khatmahStartDate.isAcceptableOrUnknown(
              data['khatmah_start_date']!, _khatmahStartDateMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingProgressRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingProgressRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number'])!,
      ayahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_number'])!,
      pageNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_number'])!,
      juzNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}juz_number'])!,
      khatmahTargetDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}khatmah_target_days'])!,
      khatmahStartDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}khatmah_start_date']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ReadingProgressTable createAlias(String alias) {
    return $ReadingProgressTable(attachedDatabase, alias);
  }
}

class ReadingProgressRecord extends DataClass
    implements Insertable<ReadingProgressRecord> {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final int pageNumber;
  final int juzNumber;
  final int khatmahTargetDays;
  final DateTime? khatmahStartDate;
  final DateTime updatedAt;
  const ReadingProgressRecord(
      {required this.id,
      required this.surahNumber,
      required this.ayahNumber,
      required this.pageNumber,
      required this.juzNumber,
      required this.khatmahTargetDays,
      this.khatmahStartDate,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['page_number'] = Variable<int>(pageNumber);
    map['juz_number'] = Variable<int>(juzNumber);
    map['khatmah_target_days'] = Variable<int>(khatmahTargetDays);
    if (!nullToAbsent || khatmahStartDate != null) {
      map['khatmah_start_date'] = Variable<DateTime>(khatmahStartDate);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReadingProgressCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      pageNumber: Value(pageNumber),
      juzNumber: Value(juzNumber),
      khatmahTargetDays: Value(khatmahTargetDays),
      khatmahStartDate: khatmahStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(khatmahStartDate),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReadingProgressRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingProgressRecord(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      juzNumber: serializer.fromJson<int>(json['juzNumber']),
      khatmahTargetDays: serializer.fromJson<int>(json['khatmahTargetDays']),
      khatmahStartDate:
          serializer.fromJson<DateTime?>(json['khatmahStartDate']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'juzNumber': serializer.toJson<int>(juzNumber),
      'khatmahTargetDays': serializer.toJson<int>(khatmahTargetDays),
      'khatmahStartDate': serializer.toJson<DateTime?>(khatmahStartDate),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReadingProgressRecord copyWith(
          {int? id,
          int? surahNumber,
          int? ayahNumber,
          int? pageNumber,
          int? juzNumber,
          int? khatmahTargetDays,
          Value<DateTime?> khatmahStartDate = const Value.absent(),
          DateTime? updatedAt}) =>
      ReadingProgressRecord(
        id: id ?? this.id,
        surahNumber: surahNumber ?? this.surahNumber,
        ayahNumber: ayahNumber ?? this.ayahNumber,
        pageNumber: pageNumber ?? this.pageNumber,
        juzNumber: juzNumber ?? this.juzNumber,
        khatmahTargetDays: khatmahTargetDays ?? this.khatmahTargetDays,
        khatmahStartDate: khatmahStartDate.present
            ? khatmahStartDate.value
            : this.khatmahStartDate,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ReadingProgressRecord copyWithCompanion(ReadingProgressCompanion data) {
    return ReadingProgressRecord(
      id: data.id.present ? data.id.value : this.id,
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      pageNumber:
          data.pageNumber.present ? data.pageNumber.value : this.pageNumber,
      juzNumber: data.juzNumber.present ? data.juzNumber.value : this.juzNumber,
      khatmahTargetDays: data.khatmahTargetDays.present
          ? data.khatmahTargetDays.value
          : this.khatmahTargetDays,
      khatmahStartDate: data.khatmahStartDate.present
          ? data.khatmahStartDate.value
          : this.khatmahStartDate,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressRecord(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('khatmahTargetDays: $khatmahTargetDays, ')
          ..write('khatmahStartDate: $khatmahStartDate, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surahNumber, ayahNumber, pageNumber,
      juzNumber, khatmahTargetDays, khatmahStartDate, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingProgressRecord &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.pageNumber == this.pageNumber &&
          other.juzNumber == this.juzNumber &&
          other.khatmahTargetDays == this.khatmahTargetDays &&
          other.khatmahStartDate == this.khatmahStartDate &&
          other.updatedAt == this.updatedAt);
}

class ReadingProgressCompanion extends UpdateCompanion<ReadingProgressRecord> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<int> pageNumber;
  final Value<int> juzNumber;
  final Value<int> khatmahTargetDays;
  final Value<DateTime?> khatmahStartDate;
  final Value<DateTime> updatedAt;
  const ReadingProgressCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.juzNumber = const Value.absent(),
    this.khatmahTargetDays = const Value.absent(),
    this.khatmahStartDate = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ReadingProgressCompanion.insert({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.juzNumber = const Value.absent(),
    this.khatmahTargetDays = const Value.absent(),
    this.khatmahStartDate = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<ReadingProgressRecord> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<int>? pageNumber,
    Expression<int>? juzNumber,
    Expression<int>? khatmahTargetDays,
    Expression<DateTime>? khatmahStartDate,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (pageNumber != null) 'page_number': pageNumber,
      if (juzNumber != null) 'juz_number': juzNumber,
      if (khatmahTargetDays != null) 'khatmah_target_days': khatmahTargetDays,
      if (khatmahStartDate != null) 'khatmah_start_date': khatmahStartDate,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ReadingProgressCompanion copyWith(
      {Value<int>? id,
      Value<int>? surahNumber,
      Value<int>? ayahNumber,
      Value<int>? pageNumber,
      Value<int>? juzNumber,
      Value<int>? khatmahTargetDays,
      Value<DateTime?>? khatmahStartDate,
      Value<DateTime>? updatedAt}) {
    return ReadingProgressCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      pageNumber: pageNumber ?? this.pageNumber,
      juzNumber: juzNumber ?? this.juzNumber,
      khatmahTargetDays: khatmahTargetDays ?? this.khatmahTargetDays,
      khatmahStartDate: khatmahStartDate ?? this.khatmahStartDate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (juzNumber.present) {
      map['juz_number'] = Variable<int>(juzNumber.value);
    }
    if (khatmahTargetDays.present) {
      map['khatmah_target_days'] = Variable<int>(khatmahTargetDays.value);
    }
    if (khatmahStartDate.present) {
      map['khatmah_start_date'] = Variable<DateTime>(khatmahStartDate.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('khatmahTargetDays: $khatmahTargetDays, ')
          ..write('khatmahStartDate: $khatmahStartDate, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, NoteRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ayahNumberMeta =
      const VerificationMeta('ayahNumber');
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
      'ayah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, surahNumber, ayahNumber, content, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<NoteRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
          _ayahNumberMeta,
          ayahNumber.isAcceptableOrUnknown(
              data['ayah_number']!, _ayahNumberMeta));
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number'])!,
      ayahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_number'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class NoteRecord extends DataClass implements Insertable<NoteRecord> {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  const NoteRecord(
      {required this.id,
      required this.surahNumber,
      required this.ayahNumber,
      required this.content,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NoteRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteRecord(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NoteRecord copyWith(
          {int? id,
          int? surahNumber,
          int? ayahNumber,
          String? content,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      NoteRecord(
        id: id ?? this.id,
        surahNumber: surahNumber ?? this.surahNumber,
        ayahNumber: ayahNumber ?? this.ayahNumber,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  NoteRecord copyWithCompanion(NotesCompanion data) {
    return NoteRecord(
      id: data.id.present ? data.id.value : this.id,
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteRecord(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surahNumber, ayahNumber, content, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteRecord &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotesCompanion extends UpdateCompanion<NoteRecord> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    required String content,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : surahNumber = Value(surahNumber),
        ayahNumber = Value(ayahNumber),
        content = Value(content);
  static Insertable<NoteRecord> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotesCompanion copyWith(
      {Value<int>? id,
      Value<int>? surahNumber,
      Value<int>? ayahNumber,
      Value<String>? content,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return NotesCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TasbihEventsTable extends TasbihEvents
    with TableInfo<$TasbihEventsTable, TasbihEventRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasbihEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dhikrIdMeta =
      const VerificationMeta('dhikrId');
  @override
  late final GeneratedColumn<String> dhikrId = GeneratedColumn<String>(
      'dhikr_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, dhikrId, count, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasbih_events';
  @override
  VerificationContext validateIntegrity(Insertable<TasbihEventRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dhikr_id')) {
      context.handle(_dhikrIdMeta,
          dhikrId.isAcceptableOrUnknown(data['dhikr_id']!, _dhikrIdMeta));
    } else if (isInserting) {
      context.missing(_dhikrIdMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TasbihEventRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TasbihEventRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dhikrId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dhikr_id'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $TasbihEventsTable createAlias(String alias) {
    return $TasbihEventsTable(attachedDatabase, alias);
  }
}

class TasbihEventRecord extends DataClass
    implements Insertable<TasbihEventRecord> {
  final int id;
  final String dhikrId;
  final int count;
  final DateTime timestamp;
  const TasbihEventRecord(
      {required this.id,
      required this.dhikrId,
      required this.count,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dhikr_id'] = Variable<String>(dhikrId);
    map['count'] = Variable<int>(count);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  TasbihEventsCompanion toCompanion(bool nullToAbsent) {
    return TasbihEventsCompanion(
      id: Value(id),
      dhikrId: Value(dhikrId),
      count: Value(count),
      timestamp: Value(timestamp),
    );
  }

  factory TasbihEventRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TasbihEventRecord(
      id: serializer.fromJson<int>(json['id']),
      dhikrId: serializer.fromJson<String>(json['dhikrId']),
      count: serializer.fromJson<int>(json['count']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dhikrId': serializer.toJson<String>(dhikrId),
      'count': serializer.toJson<int>(count),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  TasbihEventRecord copyWith(
          {int? id, String? dhikrId, int? count, DateTime? timestamp}) =>
      TasbihEventRecord(
        id: id ?? this.id,
        dhikrId: dhikrId ?? this.dhikrId,
        count: count ?? this.count,
        timestamp: timestamp ?? this.timestamp,
      );
  TasbihEventRecord copyWithCompanion(TasbihEventsCompanion data) {
    return TasbihEventRecord(
      id: data.id.present ? data.id.value : this.id,
      dhikrId: data.dhikrId.present ? data.dhikrId.value : this.dhikrId,
      count: data.count.present ? data.count.value : this.count,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TasbihEventRecord(')
          ..write('id: $id, ')
          ..write('dhikrId: $dhikrId, ')
          ..write('count: $count, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dhikrId, count, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TasbihEventRecord &&
          other.id == this.id &&
          other.dhikrId == this.dhikrId &&
          other.count == this.count &&
          other.timestamp == this.timestamp);
}

class TasbihEventsCompanion extends UpdateCompanion<TasbihEventRecord> {
  final Value<int> id;
  final Value<String> dhikrId;
  final Value<int> count;
  final Value<DateTime> timestamp;
  const TasbihEventsCompanion({
    this.id = const Value.absent(),
    this.dhikrId = const Value.absent(),
    this.count = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  TasbihEventsCompanion.insert({
    this.id = const Value.absent(),
    required String dhikrId,
    required int count,
    this.timestamp = const Value.absent(),
  })  : dhikrId = Value(dhikrId),
        count = Value(count);
  static Insertable<TasbihEventRecord> custom({
    Expression<int>? id,
    Expression<String>? dhikrId,
    Expression<int>? count,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dhikrId != null) 'dhikr_id': dhikrId,
      if (count != null) 'count': count,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  TasbihEventsCompanion copyWith(
      {Value<int>? id,
      Value<String>? dhikrId,
      Value<int>? count,
      Value<DateTime>? timestamp}) {
    return TasbihEventsCompanion(
      id: id ?? this.id,
      dhikrId: dhikrId ?? this.dhikrId,
      count: count ?? this.count,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dhikrId.present) {
      map['dhikr_id'] = Variable<String>(dhikrId.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasbihEventsCompanion(')
          ..write('id: $id, ')
          ..write('dhikrId: $dhikrId, ')
          ..write('count: $count, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $TasbihDailyTable extends TasbihDaily
    with TableInfo<$TasbihDailyTable, TasbihDailyRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasbihDailyTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dhikrIdMeta =
      const VerificationMeta('dhikrId');
  @override
  late final GeneratedColumn<String> dhikrId = GeneratedColumn<String>(
      'dhikr_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
      'total', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [date, dhikrId, total];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasbih_daily';
  @override
  VerificationContext validateIntegrity(Insertable<TasbihDailyRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('dhikr_id')) {
      context.handle(_dhikrIdMeta,
          dhikrId.isAcceptableOrUnknown(data['dhikr_id']!, _dhikrIdMeta));
    } else if (isInserting) {
      context.missing(_dhikrIdMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date, dhikrId};
  @override
  TasbihDailyRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TasbihDailyRecord(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      dhikrId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dhikr_id'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total'])!,
    );
  }

  @override
  $TasbihDailyTable createAlias(String alias) {
    return $TasbihDailyTable(attachedDatabase, alias);
  }
}

class TasbihDailyRecord extends DataClass
    implements Insertable<TasbihDailyRecord> {
  /// Local calendar date formatted as YYYY-MM-DD.
  final String date;
  final String dhikrId;
  final int total;
  const TasbihDailyRecord(
      {required this.date, required this.dhikrId, required this.total});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['dhikr_id'] = Variable<String>(dhikrId);
    map['total'] = Variable<int>(total);
    return map;
  }

  TasbihDailyCompanion toCompanion(bool nullToAbsent) {
    return TasbihDailyCompanion(
      date: Value(date),
      dhikrId: Value(dhikrId),
      total: Value(total),
    );
  }

  factory TasbihDailyRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TasbihDailyRecord(
      date: serializer.fromJson<String>(json['date']),
      dhikrId: serializer.fromJson<String>(json['dhikrId']),
      total: serializer.fromJson<int>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'dhikrId': serializer.toJson<String>(dhikrId),
      'total': serializer.toJson<int>(total),
    };
  }

  TasbihDailyRecord copyWith({String? date, String? dhikrId, int? total}) =>
      TasbihDailyRecord(
        date: date ?? this.date,
        dhikrId: dhikrId ?? this.dhikrId,
        total: total ?? this.total,
      );
  TasbihDailyRecord copyWithCompanion(TasbihDailyCompanion data) {
    return TasbihDailyRecord(
      date: data.date.present ? data.date.value : this.date,
      dhikrId: data.dhikrId.present ? data.dhikrId.value : this.dhikrId,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TasbihDailyRecord(')
          ..write('date: $date, ')
          ..write('dhikrId: $dhikrId, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, dhikrId, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TasbihDailyRecord &&
          other.date == this.date &&
          other.dhikrId == this.dhikrId &&
          other.total == this.total);
}

class TasbihDailyCompanion extends UpdateCompanion<TasbihDailyRecord> {
  final Value<String> date;
  final Value<String> dhikrId;
  final Value<int> total;
  final Value<int> rowid;
  const TasbihDailyCompanion({
    this.date = const Value.absent(),
    this.dhikrId = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasbihDailyCompanion.insert({
    required String date,
    required String dhikrId,
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        dhikrId = Value(dhikrId);
  static Insertable<TasbihDailyRecord> custom({
    Expression<String>? date,
    Expression<String>? dhikrId,
    Expression<int>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (dhikrId != null) 'dhikr_id': dhikrId,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasbihDailyCompanion copyWith(
      {Value<String>? date,
      Value<String>? dhikrId,
      Value<int>? total,
      Value<int>? rowid}) {
    return TasbihDailyCompanion(
      date: date ?? this.date,
      dhikrId: dhikrId ?? this.dhikrId,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (dhikrId.present) {
      map['dhikr_id'] = Variable<String>(dhikrId.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasbihDailyCompanion(')
          ..write('date: $date, ')
          ..write('dhikrId: $dhikrId, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DownloadsTable extends Downloads
    with TableInfo<$DownloadsTable, DownloadRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemTypeMeta =
      const VerificationMeta('itemType');
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
      'item_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reciterIdMeta =
      const VerificationMeta('reciterId');
  @override
  late final GeneratedColumn<int> reciterId = GeneratedColumn<int>(
      'reciter_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _packIdMeta = const VerificationMeta('packId');
  @override
  late final GeneratedColumn<String> packId = GeneratedColumn<String>(
      'pack_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalBytesMeta =
      const VerificationMeta('totalBytes');
  @override
  late final GeneratedColumn<int> totalBytes = GeneratedColumn<int>(
      'total_bytes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        itemType,
        reciterId,
        surahNumber,
        packId,
        localPath,
        status,
        progress,
        totalBytes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'downloads';
  @override
  VerificationContext validateIntegrity(Insertable<DownloadRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_type')) {
      context.handle(_itemTypeMeta,
          itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta));
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('reciter_id')) {
      context.handle(_reciterIdMeta,
          reciterId.isAcceptableOrUnknown(data['reciter_id']!, _reciterIdMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    }
    if (data.containsKey('pack_id')) {
      context.handle(_packIdMeta,
          packId.isAcceptableOrUnknown(data['pack_id']!, _packIdMeta));
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    }
    if (data.containsKey('total_bytes')) {
      context.handle(
          _totalBytesMeta,
          totalBytes.isAcceptableOrUnknown(
              data['total_bytes']!, _totalBytesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DownloadRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      itemType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_type'])!,
      reciterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reciter_id']),
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number']),
      packId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pack_id']),
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress'])!,
      totalBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_bytes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DownloadsTable createAlias(String alias) {
    return $DownloadsTable(attachedDatabase, alias);
  }
}

class DownloadRecord extends DataClass implements Insertable<DownloadRecord> {
  final int id;
  final String itemType;
  final int? reciterId;
  final int? surahNumber;
  final String? packId;
  final String localPath;
  final String status;
  final double progress;
  final int totalBytes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DownloadRecord(
      {required this.id,
      required this.itemType,
      this.reciterId,
      this.surahNumber,
      this.packId,
      required this.localPath,
      required this.status,
      required this.progress,
      required this.totalBytes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_type'] = Variable<String>(itemType);
    if (!nullToAbsent || reciterId != null) {
      map['reciter_id'] = Variable<int>(reciterId);
    }
    if (!nullToAbsent || surahNumber != null) {
      map['surah_number'] = Variable<int>(surahNumber);
    }
    if (!nullToAbsent || packId != null) {
      map['pack_id'] = Variable<String>(packId);
    }
    map['local_path'] = Variable<String>(localPath);
    map['status'] = Variable<String>(status);
    map['progress'] = Variable<double>(progress);
    map['total_bytes'] = Variable<int>(totalBytes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DownloadsCompanion toCompanion(bool nullToAbsent) {
    return DownloadsCompanion(
      id: Value(id),
      itemType: Value(itemType),
      reciterId: reciterId == null && nullToAbsent
          ? const Value.absent()
          : Value(reciterId),
      surahNumber: surahNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(surahNumber),
      packId:
          packId == null && nullToAbsent ? const Value.absent() : Value(packId),
      localPath: Value(localPath),
      status: Value(status),
      progress: Value(progress),
      totalBytes: Value(totalBytes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DownloadRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadRecord(
      id: serializer.fromJson<int>(json['id']),
      itemType: serializer.fromJson<String>(json['itemType']),
      reciterId: serializer.fromJson<int?>(json['reciterId']),
      surahNumber: serializer.fromJson<int?>(json['surahNumber']),
      packId: serializer.fromJson<String?>(json['packId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      status: serializer.fromJson<String>(json['status']),
      progress: serializer.fromJson<double>(json['progress']),
      totalBytes: serializer.fromJson<int>(json['totalBytes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemType': serializer.toJson<String>(itemType),
      'reciterId': serializer.toJson<int?>(reciterId),
      'surahNumber': serializer.toJson<int?>(surahNumber),
      'packId': serializer.toJson<String?>(packId),
      'localPath': serializer.toJson<String>(localPath),
      'status': serializer.toJson<String>(status),
      'progress': serializer.toJson<double>(progress),
      'totalBytes': serializer.toJson<int>(totalBytes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DownloadRecord copyWith(
          {int? id,
          String? itemType,
          Value<int?> reciterId = const Value.absent(),
          Value<int?> surahNumber = const Value.absent(),
          Value<String?> packId = const Value.absent(),
          String? localPath,
          String? status,
          double? progress,
          int? totalBytes,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DownloadRecord(
        id: id ?? this.id,
        itemType: itemType ?? this.itemType,
        reciterId: reciterId.present ? reciterId.value : this.reciterId,
        surahNumber: surahNumber.present ? surahNumber.value : this.surahNumber,
        packId: packId.present ? packId.value : this.packId,
        localPath: localPath ?? this.localPath,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        totalBytes: totalBytes ?? this.totalBytes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DownloadRecord copyWithCompanion(DownloadsCompanion data) {
    return DownloadRecord(
      id: data.id.present ? data.id.value : this.id,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      reciterId: data.reciterId.present ? data.reciterId.value : this.reciterId,
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      packId: data.packId.present ? data.packId.value : this.packId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      status: data.status.present ? data.status.value : this.status,
      progress: data.progress.present ? data.progress.value : this.progress,
      totalBytes:
          data.totalBytes.present ? data.totalBytes.value : this.totalBytes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadRecord(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('reciterId: $reciterId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('packId: $packId, ')
          ..write('localPath: $localPath, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemType, reciterId, surahNumber, packId,
      localPath, status, progress, totalBytes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadRecord &&
          other.id == this.id &&
          other.itemType == this.itemType &&
          other.reciterId == this.reciterId &&
          other.surahNumber == this.surahNumber &&
          other.packId == this.packId &&
          other.localPath == this.localPath &&
          other.status == this.status &&
          other.progress == this.progress &&
          other.totalBytes == this.totalBytes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DownloadsCompanion extends UpdateCompanion<DownloadRecord> {
  final Value<int> id;
  final Value<String> itemType;
  final Value<int?> reciterId;
  final Value<int?> surahNumber;
  final Value<String?> packId;
  final Value<String> localPath;
  final Value<String> status;
  final Value<double> progress;
  final Value<int> totalBytes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DownloadsCompanion({
    this.id = const Value.absent(),
    this.itemType = const Value.absent(),
    this.reciterId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.packId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DownloadsCompanion.insert({
    this.id = const Value.absent(),
    required String itemType,
    this.reciterId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.packId = const Value.absent(),
    required String localPath,
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : itemType = Value(itemType),
        localPath = Value(localPath);
  static Insertable<DownloadRecord> custom({
    Expression<int>? id,
    Expression<String>? itemType,
    Expression<int>? reciterId,
    Expression<int>? surahNumber,
    Expression<String>? packId,
    Expression<String>? localPath,
    Expression<String>? status,
    Expression<double>? progress,
    Expression<int>? totalBytes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemType != null) 'item_type': itemType,
      if (reciterId != null) 'reciter_id': reciterId,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (packId != null) 'pack_id': packId,
      if (localPath != null) 'local_path': localPath,
      if (status != null) 'status': status,
      if (progress != null) 'progress': progress,
      if (totalBytes != null) 'total_bytes': totalBytes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DownloadsCompanion copyWith(
      {Value<int>? id,
      Value<String>? itemType,
      Value<int?>? reciterId,
      Value<int?>? surahNumber,
      Value<String?>? packId,
      Value<String>? localPath,
      Value<String>? status,
      Value<double>? progress,
      Value<int>? totalBytes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return DownloadsCompanion(
      id: id ?? this.id,
      itemType: itemType ?? this.itemType,
      reciterId: reciterId ?? this.reciterId,
      surahNumber: surahNumber ?? this.surahNumber,
      packId: packId ?? this.packId,
      localPath: localPath ?? this.localPath,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      totalBytes: totalBytes ?? this.totalBytes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (reciterId.present) {
      map['reciter_id'] = Variable<int>(reciterId.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (packId.present) {
      map['pack_id'] = Variable<String>(packId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (totalBytes.present) {
      map['total_bytes'] = Variable<int>(totalBytes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadsCompanion(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('reciterId: $reciterId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('packId: $packId, ')
          ..write('localPath: $localPath, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CachedChaptersTable extends CachedChapters
    with TableInfo<$CachedChaptersTable, CachedChapterRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _chapterIdMeta =
      const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
      'chapter_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ar'));
  static const VerificationMeta _nameArabicMeta =
      const VerificationMeta('nameArabic');
  @override
  late final GeneratedColumn<String> nameArabic = GeneratedColumn<String>(
      'name_arabic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameSimpleMeta =
      const VerificationMeta('nameSimple');
  @override
  late final GeneratedColumn<String> nameSimple = GeneratedColumn<String>(
      'name_simple', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameTranslatedMeta =
      const VerificationMeta('nameTranslated');
  @override
  late final GeneratedColumn<String> nameTranslated = GeneratedColumn<String>(
      'name_translated', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _revelationPlaceMeta =
      const VerificationMeta('revelationPlace');
  @override
  late final GeneratedColumn<String> revelationPlace = GeneratedColumn<String>(
      'revelation_place', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _revelationOrderMeta =
      const VerificationMeta('revelationOrder');
  @override
  late final GeneratedColumn<int> revelationOrder = GeneratedColumn<int>(
      'revelation_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bismillahPreMeta =
      const VerificationMeta('bismillahPre');
  @override
  late final GeneratedColumn<bool> bismillahPre = GeneratedColumn<bool>(
      'bismillah_pre', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("bismillah_pre" IN (0, 1))'));
  static const VerificationMeta _versesCountMeta =
      const VerificationMeta('versesCount');
  @override
  late final GeneratedColumn<int> versesCount = GeneratedColumn<int>(
      'verses_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startPageMeta =
      const VerificationMeta('startPage');
  @override
  late final GeneratedColumn<int> startPage = GeneratedColumn<int>(
      'start_page', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endPageMeta =
      const VerificationMeta('endPage');
  @override
  late final GeneratedColumn<int> endPage = GeneratedColumn<int>(
      'end_page', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        chapterId,
        languageCode,
        nameArabic,
        nameSimple,
        nameTranslated,
        revelationPlace,
        revelationOrder,
        bismillahPre,
        versesCount,
        startPage,
        endPage,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_chapters';
  @override
  VerificationContext validateIntegrity(
      Insertable<CachedChapterRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta,
          chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    if (data.containsKey('name_arabic')) {
      context.handle(
          _nameArabicMeta,
          nameArabic.isAcceptableOrUnknown(
              data['name_arabic']!, _nameArabicMeta));
    } else if (isInserting) {
      context.missing(_nameArabicMeta);
    }
    if (data.containsKey('name_simple')) {
      context.handle(
          _nameSimpleMeta,
          nameSimple.isAcceptableOrUnknown(
              data['name_simple']!, _nameSimpleMeta));
    } else if (isInserting) {
      context.missing(_nameSimpleMeta);
    }
    if (data.containsKey('name_translated')) {
      context.handle(
          _nameTranslatedMeta,
          nameTranslated.isAcceptableOrUnknown(
              data['name_translated']!, _nameTranslatedMeta));
    } else if (isInserting) {
      context.missing(_nameTranslatedMeta);
    }
    if (data.containsKey('revelation_place')) {
      context.handle(
          _revelationPlaceMeta,
          revelationPlace.isAcceptableOrUnknown(
              data['revelation_place']!, _revelationPlaceMeta));
    } else if (isInserting) {
      context.missing(_revelationPlaceMeta);
    }
    if (data.containsKey('revelation_order')) {
      context.handle(
          _revelationOrderMeta,
          revelationOrder.isAcceptableOrUnknown(
              data['revelation_order']!, _revelationOrderMeta));
    } else if (isInserting) {
      context.missing(_revelationOrderMeta);
    }
    if (data.containsKey('bismillah_pre')) {
      context.handle(
          _bismillahPreMeta,
          bismillahPre.isAcceptableOrUnknown(
              data['bismillah_pre']!, _bismillahPreMeta));
    } else if (isInserting) {
      context.missing(_bismillahPreMeta);
    }
    if (data.containsKey('verses_count')) {
      context.handle(
          _versesCountMeta,
          versesCount.isAcceptableOrUnknown(
              data['verses_count']!, _versesCountMeta));
    } else if (isInserting) {
      context.missing(_versesCountMeta);
    }
    if (data.containsKey('start_page')) {
      context.handle(_startPageMeta,
          startPage.isAcceptableOrUnknown(data['start_page']!, _startPageMeta));
    } else if (isInserting) {
      context.missing(_startPageMeta);
    }
    if (data.containsKey('end_page')) {
      context.handle(_endPageMeta,
          endPage.isAcceptableOrUnknown(data['end_page']!, _endPageMeta));
    } else if (isInserting) {
      context.missing(_endPageMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {chapterId, languageCode};
  @override
  CachedChapterRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedChapterRecord(
      chapterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter_id'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      nameArabic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_arabic'])!,
      nameSimple: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_simple'])!,
      nameTranslated: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}name_translated'])!,
      revelationPlace: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}revelation_place'])!,
      revelationOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}revelation_order'])!,
      bismillahPre: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}bismillah_pre'])!,
      versesCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}verses_count'])!,
      startPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_page'])!,
      endPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_page'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CachedChaptersTable createAlias(String alias) {
    return $CachedChaptersTable(attachedDatabase, alias);
  }
}

class CachedChapterRecord extends DataClass
    implements Insertable<CachedChapterRecord> {
  final int chapterId;
  final String languageCode;
  final String nameArabic;
  final String nameSimple;
  final String nameTranslated;
  final String revelationPlace;
  final int revelationOrder;
  final bool bismillahPre;
  final int versesCount;
  final int startPage;
  final int endPage;
  final DateTime cachedAt;
  const CachedChapterRecord(
      {required this.chapterId,
      required this.languageCode,
      required this.nameArabic,
      required this.nameSimple,
      required this.nameTranslated,
      required this.revelationPlace,
      required this.revelationOrder,
      required this.bismillahPre,
      required this.versesCount,
      required this.startPage,
      required this.endPage,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chapter_id'] = Variable<int>(chapterId);
    map['language_code'] = Variable<String>(languageCode);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['name_simple'] = Variable<String>(nameSimple);
    map['name_translated'] = Variable<String>(nameTranslated);
    map['revelation_place'] = Variable<String>(revelationPlace);
    map['revelation_order'] = Variable<int>(revelationOrder);
    map['bismillah_pre'] = Variable<bool>(bismillahPre);
    map['verses_count'] = Variable<int>(versesCount);
    map['start_page'] = Variable<int>(startPage);
    map['end_page'] = Variable<int>(endPage);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedChaptersCompanion toCompanion(bool nullToAbsent) {
    return CachedChaptersCompanion(
      chapterId: Value(chapterId),
      languageCode: Value(languageCode),
      nameArabic: Value(nameArabic),
      nameSimple: Value(nameSimple),
      nameTranslated: Value(nameTranslated),
      revelationPlace: Value(revelationPlace),
      revelationOrder: Value(revelationOrder),
      bismillahPre: Value(bismillahPre),
      versesCount: Value(versesCount),
      startPage: Value(startPage),
      endPage: Value(endPage),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedChapterRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedChapterRecord(
      chapterId: serializer.fromJson<int>(json['chapterId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      nameSimple: serializer.fromJson<String>(json['nameSimple']),
      nameTranslated: serializer.fromJson<String>(json['nameTranslated']),
      revelationPlace: serializer.fromJson<String>(json['revelationPlace']),
      revelationOrder: serializer.fromJson<int>(json['revelationOrder']),
      bismillahPre: serializer.fromJson<bool>(json['bismillahPre']),
      versesCount: serializer.fromJson<int>(json['versesCount']),
      startPage: serializer.fromJson<int>(json['startPage']),
      endPage: serializer.fromJson<int>(json['endPage']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'chapterId': serializer.toJson<int>(chapterId),
      'languageCode': serializer.toJson<String>(languageCode),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'nameSimple': serializer.toJson<String>(nameSimple),
      'nameTranslated': serializer.toJson<String>(nameTranslated),
      'revelationPlace': serializer.toJson<String>(revelationPlace),
      'revelationOrder': serializer.toJson<int>(revelationOrder),
      'bismillahPre': serializer.toJson<bool>(bismillahPre),
      'versesCount': serializer.toJson<int>(versesCount),
      'startPage': serializer.toJson<int>(startPage),
      'endPage': serializer.toJson<int>(endPage),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedChapterRecord copyWith(
          {int? chapterId,
          String? languageCode,
          String? nameArabic,
          String? nameSimple,
          String? nameTranslated,
          String? revelationPlace,
          int? revelationOrder,
          bool? bismillahPre,
          int? versesCount,
          int? startPage,
          int? endPage,
          DateTime? cachedAt}) =>
      CachedChapterRecord(
        chapterId: chapterId ?? this.chapterId,
        languageCode: languageCode ?? this.languageCode,
        nameArabic: nameArabic ?? this.nameArabic,
        nameSimple: nameSimple ?? this.nameSimple,
        nameTranslated: nameTranslated ?? this.nameTranslated,
        revelationPlace: revelationPlace ?? this.revelationPlace,
        revelationOrder: revelationOrder ?? this.revelationOrder,
        bismillahPre: bismillahPre ?? this.bismillahPre,
        versesCount: versesCount ?? this.versesCount,
        startPage: startPage ?? this.startPage,
        endPage: endPage ?? this.endPage,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedChapterRecord copyWithCompanion(CachedChaptersCompanion data) {
    return CachedChapterRecord(
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      nameArabic:
          data.nameArabic.present ? data.nameArabic.value : this.nameArabic,
      nameSimple:
          data.nameSimple.present ? data.nameSimple.value : this.nameSimple,
      nameTranslated: data.nameTranslated.present
          ? data.nameTranslated.value
          : this.nameTranslated,
      revelationPlace: data.revelationPlace.present
          ? data.revelationPlace.value
          : this.revelationPlace,
      revelationOrder: data.revelationOrder.present
          ? data.revelationOrder.value
          : this.revelationOrder,
      bismillahPre: data.bismillahPre.present
          ? data.bismillahPre.value
          : this.bismillahPre,
      versesCount:
          data.versesCount.present ? data.versesCount.value : this.versesCount,
      startPage: data.startPage.present ? data.startPage.value : this.startPage,
      endPage: data.endPage.present ? data.endPage.value : this.endPage,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedChapterRecord(')
          ..write('chapterId: $chapterId, ')
          ..write('languageCode: $languageCode, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameSimple: $nameSimple, ')
          ..write('nameTranslated: $nameTranslated, ')
          ..write('revelationPlace: $revelationPlace, ')
          ..write('revelationOrder: $revelationOrder, ')
          ..write('bismillahPre: $bismillahPre, ')
          ..write('versesCount: $versesCount, ')
          ..write('startPage: $startPage, ')
          ..write('endPage: $endPage, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      chapterId,
      languageCode,
      nameArabic,
      nameSimple,
      nameTranslated,
      revelationPlace,
      revelationOrder,
      bismillahPre,
      versesCount,
      startPage,
      endPage,
      cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedChapterRecord &&
          other.chapterId == this.chapterId &&
          other.languageCode == this.languageCode &&
          other.nameArabic == this.nameArabic &&
          other.nameSimple == this.nameSimple &&
          other.nameTranslated == this.nameTranslated &&
          other.revelationPlace == this.revelationPlace &&
          other.revelationOrder == this.revelationOrder &&
          other.bismillahPre == this.bismillahPre &&
          other.versesCount == this.versesCount &&
          other.startPage == this.startPage &&
          other.endPage == this.endPage &&
          other.cachedAt == this.cachedAt);
}

class CachedChaptersCompanion extends UpdateCompanion<CachedChapterRecord> {
  final Value<int> chapterId;
  final Value<String> languageCode;
  final Value<String> nameArabic;
  final Value<String> nameSimple;
  final Value<String> nameTranslated;
  final Value<String> revelationPlace;
  final Value<int> revelationOrder;
  final Value<bool> bismillahPre;
  final Value<int> versesCount;
  final Value<int> startPage;
  final Value<int> endPage;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedChaptersCompanion({
    this.chapterId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.nameSimple = const Value.absent(),
    this.nameTranslated = const Value.absent(),
    this.revelationPlace = const Value.absent(),
    this.revelationOrder = const Value.absent(),
    this.bismillahPre = const Value.absent(),
    this.versesCount = const Value.absent(),
    this.startPage = const Value.absent(),
    this.endPage = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedChaptersCompanion.insert({
    required int chapterId,
    this.languageCode = const Value.absent(),
    required String nameArabic,
    required String nameSimple,
    required String nameTranslated,
    required String revelationPlace,
    required int revelationOrder,
    required bool bismillahPre,
    required int versesCount,
    required int startPage,
    required int endPage,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : chapterId = Value(chapterId),
        nameArabic = Value(nameArabic),
        nameSimple = Value(nameSimple),
        nameTranslated = Value(nameTranslated),
        revelationPlace = Value(revelationPlace),
        revelationOrder = Value(revelationOrder),
        bismillahPre = Value(bismillahPre),
        versesCount = Value(versesCount),
        startPage = Value(startPage),
        endPage = Value(endPage),
        cachedAt = Value(cachedAt);
  static Insertable<CachedChapterRecord> custom({
    Expression<int>? chapterId,
    Expression<String>? languageCode,
    Expression<String>? nameArabic,
    Expression<String>? nameSimple,
    Expression<String>? nameTranslated,
    Expression<String>? revelationPlace,
    Expression<int>? revelationOrder,
    Expression<bool>? bismillahPre,
    Expression<int>? versesCount,
    Expression<int>? startPage,
    Expression<int>? endPage,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (chapterId != null) 'chapter_id': chapterId,
      if (languageCode != null) 'language_code': languageCode,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (nameSimple != null) 'name_simple': nameSimple,
      if (nameTranslated != null) 'name_translated': nameTranslated,
      if (revelationPlace != null) 'revelation_place': revelationPlace,
      if (revelationOrder != null) 'revelation_order': revelationOrder,
      if (bismillahPre != null) 'bismillah_pre': bismillahPre,
      if (versesCount != null) 'verses_count': versesCount,
      if (startPage != null) 'start_page': startPage,
      if (endPage != null) 'end_page': endPage,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedChaptersCompanion copyWith(
      {Value<int>? chapterId,
      Value<String>? languageCode,
      Value<String>? nameArabic,
      Value<String>? nameSimple,
      Value<String>? nameTranslated,
      Value<String>? revelationPlace,
      Value<int>? revelationOrder,
      Value<bool>? bismillahPre,
      Value<int>? versesCount,
      Value<int>? startPage,
      Value<int>? endPage,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return CachedChaptersCompanion(
      chapterId: chapterId ?? this.chapterId,
      languageCode: languageCode ?? this.languageCode,
      nameArabic: nameArabic ?? this.nameArabic,
      nameSimple: nameSimple ?? this.nameSimple,
      nameTranslated: nameTranslated ?? this.nameTranslated,
      revelationPlace: revelationPlace ?? this.revelationPlace,
      revelationOrder: revelationOrder ?? this.revelationOrder,
      bismillahPre: bismillahPre ?? this.bismillahPre,
      versesCount: versesCount ?? this.versesCount,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (chapterId.present) {
      map['chapter_id'] = Variable<int>(chapterId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (nameArabic.present) {
      map['name_arabic'] = Variable<String>(nameArabic.value);
    }
    if (nameSimple.present) {
      map['name_simple'] = Variable<String>(nameSimple.value);
    }
    if (nameTranslated.present) {
      map['name_translated'] = Variable<String>(nameTranslated.value);
    }
    if (revelationPlace.present) {
      map['revelation_place'] = Variable<String>(revelationPlace.value);
    }
    if (revelationOrder.present) {
      map['revelation_order'] = Variable<int>(revelationOrder.value);
    }
    if (bismillahPre.present) {
      map['bismillah_pre'] = Variable<bool>(bismillahPre.value);
    }
    if (versesCount.present) {
      map['verses_count'] = Variable<int>(versesCount.value);
    }
    if (startPage.present) {
      map['start_page'] = Variable<int>(startPage.value);
    }
    if (endPage.present) {
      map['end_page'] = Variable<int>(endPage.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedChaptersCompanion(')
          ..write('chapterId: $chapterId, ')
          ..write('languageCode: $languageCode, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameSimple: $nameSimple, ')
          ..write('nameTranslated: $nameTranslated, ')
          ..write('revelationPlace: $revelationPlace, ')
          ..write('revelationOrder: $revelationOrder, ')
          ..write('bismillahPre: $bismillahPre, ')
          ..write('versesCount: $versesCount, ')
          ..write('startPage: $startPage, ')
          ..write('endPage: $endPage, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedVersesTable extends CachedVerses
    with TableInfo<$CachedVersesTable, CachedVerseRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedVersesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _verseKeyMeta =
      const VerificationMeta('verseKey');
  @override
  late final GeneratedColumn<String> verseKey = GeneratedColumn<String>(
      'verse_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chapterIdMeta =
      const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
      'chapter_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _verseNumberMeta =
      const VerificationMeta('verseNumber');
  @override
  late final GeneratedColumn<int> verseNumber = GeneratedColumn<int>(
      'verse_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pageNumberMeta =
      const VerificationMeta('pageNumber');
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
      'page_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _juzNumberMeta =
      const VerificationMeta('juzNumber');
  @override
  late final GeneratedColumn<int> juzNumber = GeneratedColumn<int>(
      'juz_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hizbNumberMeta =
      const VerificationMeta('hizbNumber');
  @override
  late final GeneratedColumn<int> hizbNumber = GeneratedColumn<int>(
      'hizb_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textUthmaniMeta =
      const VerificationMeta('textUthmani');
  @override
  late final GeneratedColumn<String> textUthmani = GeneratedColumn<String>(
      'text_uthmani', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textImlaeiSimpleMeta =
      const VerificationMeta('textImlaeiSimple');
  @override
  late final GeneratedColumn<String> textImlaeiSimple = GeneratedColumn<String>(
      'text_imlaei_simple', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _wordsJsonMeta =
      const VerificationMeta('wordsJson');
  @override
  late final GeneratedColumn<String> wordsJson = GeneratedColumn<String>(
      'words_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        verseKey,
        chapterId,
        verseNumber,
        pageNumber,
        juzNumber,
        hizbNumber,
        textUthmani,
        textImlaeiSimple,
        wordsJson,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_verses';
  @override
  VerificationContext validateIntegrity(Insertable<CachedVerseRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('verse_key')) {
      context.handle(_verseKeyMeta,
          verseKey.isAcceptableOrUnknown(data['verse_key']!, _verseKeyMeta));
    } else if (isInserting) {
      context.missing(_verseKeyMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta,
          chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('verse_number')) {
      context.handle(
          _verseNumberMeta,
          verseNumber.isAcceptableOrUnknown(
              data['verse_number']!, _verseNumberMeta));
    } else if (isInserting) {
      context.missing(_verseNumberMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
          _pageNumberMeta,
          pageNumber.isAcceptableOrUnknown(
              data['page_number']!, _pageNumberMeta));
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    if (data.containsKey('juz_number')) {
      context.handle(_juzNumberMeta,
          juzNumber.isAcceptableOrUnknown(data['juz_number']!, _juzNumberMeta));
    } else if (isInserting) {
      context.missing(_juzNumberMeta);
    }
    if (data.containsKey('hizb_number')) {
      context.handle(
          _hizbNumberMeta,
          hizbNumber.isAcceptableOrUnknown(
              data['hizb_number']!, _hizbNumberMeta));
    } else if (isInserting) {
      context.missing(_hizbNumberMeta);
    }
    if (data.containsKey('text_uthmani')) {
      context.handle(
          _textUthmaniMeta,
          textUthmani.isAcceptableOrUnknown(
              data['text_uthmani']!, _textUthmaniMeta));
    } else if (isInserting) {
      context.missing(_textUthmaniMeta);
    }
    if (data.containsKey('text_imlaei_simple')) {
      context.handle(
          _textImlaeiSimpleMeta,
          textImlaeiSimple.isAcceptableOrUnknown(
              data['text_imlaei_simple']!, _textImlaeiSimpleMeta));
    }
    if (data.containsKey('words_json')) {
      context.handle(_wordsJsonMeta,
          wordsJson.isAcceptableOrUnknown(data['words_json']!, _wordsJsonMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {verseKey};
  @override
  CachedVerseRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedVerseRecord(
      verseKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}verse_key'])!,
      chapterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter_id'])!,
      verseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}verse_number'])!,
      pageNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_number'])!,
      juzNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}juz_number'])!,
      hizbNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hizb_number'])!,
      textUthmani: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_uthmani'])!,
      textImlaeiSimple: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_imlaei_simple'])!,
      wordsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}words_json'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CachedVersesTable createAlias(String alias) {
    return $CachedVersesTable(attachedDatabase, alias);
  }
}

class CachedVerseRecord extends DataClass
    implements Insertable<CachedVerseRecord> {
  final String verseKey;
  final int chapterId;
  final int verseNumber;
  final int pageNumber;
  final int juzNumber;
  final int hizbNumber;
  final String textUthmani;
  final String textImlaeiSimple;
  final String wordsJson;
  final DateTime cachedAt;
  const CachedVerseRecord(
      {required this.verseKey,
      required this.chapterId,
      required this.verseNumber,
      required this.pageNumber,
      required this.juzNumber,
      required this.hizbNumber,
      required this.textUthmani,
      required this.textImlaeiSimple,
      required this.wordsJson,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['verse_key'] = Variable<String>(verseKey);
    map['chapter_id'] = Variable<int>(chapterId);
    map['verse_number'] = Variable<int>(verseNumber);
    map['page_number'] = Variable<int>(pageNumber);
    map['juz_number'] = Variable<int>(juzNumber);
    map['hizb_number'] = Variable<int>(hizbNumber);
    map['text_uthmani'] = Variable<String>(textUthmani);
    map['text_imlaei_simple'] = Variable<String>(textImlaeiSimple);
    map['words_json'] = Variable<String>(wordsJson);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedVersesCompanion toCompanion(bool nullToAbsent) {
    return CachedVersesCompanion(
      verseKey: Value(verseKey),
      chapterId: Value(chapterId),
      verseNumber: Value(verseNumber),
      pageNumber: Value(pageNumber),
      juzNumber: Value(juzNumber),
      hizbNumber: Value(hizbNumber),
      textUthmani: Value(textUthmani),
      textImlaeiSimple: Value(textImlaeiSimple),
      wordsJson: Value(wordsJson),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedVerseRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedVerseRecord(
      verseKey: serializer.fromJson<String>(json['verseKey']),
      chapterId: serializer.fromJson<int>(json['chapterId']),
      verseNumber: serializer.fromJson<int>(json['verseNumber']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      juzNumber: serializer.fromJson<int>(json['juzNumber']),
      hizbNumber: serializer.fromJson<int>(json['hizbNumber']),
      textUthmani: serializer.fromJson<String>(json['textUthmani']),
      textImlaeiSimple: serializer.fromJson<String>(json['textImlaeiSimple']),
      wordsJson: serializer.fromJson<String>(json['wordsJson']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'verseKey': serializer.toJson<String>(verseKey),
      'chapterId': serializer.toJson<int>(chapterId),
      'verseNumber': serializer.toJson<int>(verseNumber),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'juzNumber': serializer.toJson<int>(juzNumber),
      'hizbNumber': serializer.toJson<int>(hizbNumber),
      'textUthmani': serializer.toJson<String>(textUthmani),
      'textImlaeiSimple': serializer.toJson<String>(textImlaeiSimple),
      'wordsJson': serializer.toJson<String>(wordsJson),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedVerseRecord copyWith(
          {String? verseKey,
          int? chapterId,
          int? verseNumber,
          int? pageNumber,
          int? juzNumber,
          int? hizbNumber,
          String? textUthmani,
          String? textImlaeiSimple,
          String? wordsJson,
          DateTime? cachedAt}) =>
      CachedVerseRecord(
        verseKey: verseKey ?? this.verseKey,
        chapterId: chapterId ?? this.chapterId,
        verseNumber: verseNumber ?? this.verseNumber,
        pageNumber: pageNumber ?? this.pageNumber,
        juzNumber: juzNumber ?? this.juzNumber,
        hizbNumber: hizbNumber ?? this.hizbNumber,
        textUthmani: textUthmani ?? this.textUthmani,
        textImlaeiSimple: textImlaeiSimple ?? this.textImlaeiSimple,
        wordsJson: wordsJson ?? this.wordsJson,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedVerseRecord copyWithCompanion(CachedVersesCompanion data) {
    return CachedVerseRecord(
      verseKey: data.verseKey.present ? data.verseKey.value : this.verseKey,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      verseNumber:
          data.verseNumber.present ? data.verseNumber.value : this.verseNumber,
      pageNumber:
          data.pageNumber.present ? data.pageNumber.value : this.pageNumber,
      juzNumber: data.juzNumber.present ? data.juzNumber.value : this.juzNumber,
      hizbNumber:
          data.hizbNumber.present ? data.hizbNumber.value : this.hizbNumber,
      textUthmani:
          data.textUthmani.present ? data.textUthmani.value : this.textUthmani,
      textImlaeiSimple: data.textImlaeiSimple.present
          ? data.textImlaeiSimple.value
          : this.textImlaeiSimple,
      wordsJson: data.wordsJson.present ? data.wordsJson.value : this.wordsJson,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedVerseRecord(')
          ..write('verseKey: $verseKey, ')
          ..write('chapterId: $chapterId, ')
          ..write('verseNumber: $verseNumber, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('hizbNumber: $hizbNumber, ')
          ..write('textUthmani: $textUthmani, ')
          ..write('textImlaeiSimple: $textImlaeiSimple, ')
          ..write('wordsJson: $wordsJson, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      verseKey,
      chapterId,
      verseNumber,
      pageNumber,
      juzNumber,
      hizbNumber,
      textUthmani,
      textImlaeiSimple,
      wordsJson,
      cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedVerseRecord &&
          other.verseKey == this.verseKey &&
          other.chapterId == this.chapterId &&
          other.verseNumber == this.verseNumber &&
          other.pageNumber == this.pageNumber &&
          other.juzNumber == this.juzNumber &&
          other.hizbNumber == this.hizbNumber &&
          other.textUthmani == this.textUthmani &&
          other.textImlaeiSimple == this.textImlaeiSimple &&
          other.wordsJson == this.wordsJson &&
          other.cachedAt == this.cachedAt);
}

class CachedVersesCompanion extends UpdateCompanion<CachedVerseRecord> {
  final Value<String> verseKey;
  final Value<int> chapterId;
  final Value<int> verseNumber;
  final Value<int> pageNumber;
  final Value<int> juzNumber;
  final Value<int> hizbNumber;
  final Value<String> textUthmani;
  final Value<String> textImlaeiSimple;
  final Value<String> wordsJson;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedVersesCompanion({
    this.verseKey = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.verseNumber = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.juzNumber = const Value.absent(),
    this.hizbNumber = const Value.absent(),
    this.textUthmani = const Value.absent(),
    this.textImlaeiSimple = const Value.absent(),
    this.wordsJson = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedVersesCompanion.insert({
    required String verseKey,
    required int chapterId,
    required int verseNumber,
    required int pageNumber,
    required int juzNumber,
    required int hizbNumber,
    required String textUthmani,
    this.textImlaeiSimple = const Value.absent(),
    this.wordsJson = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : verseKey = Value(verseKey),
        chapterId = Value(chapterId),
        verseNumber = Value(verseNumber),
        pageNumber = Value(pageNumber),
        juzNumber = Value(juzNumber),
        hizbNumber = Value(hizbNumber),
        textUthmani = Value(textUthmani),
        cachedAt = Value(cachedAt);
  static Insertable<CachedVerseRecord> custom({
    Expression<String>? verseKey,
    Expression<int>? chapterId,
    Expression<int>? verseNumber,
    Expression<int>? pageNumber,
    Expression<int>? juzNumber,
    Expression<int>? hizbNumber,
    Expression<String>? textUthmani,
    Expression<String>? textImlaeiSimple,
    Expression<String>? wordsJson,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (verseKey != null) 'verse_key': verseKey,
      if (chapterId != null) 'chapter_id': chapterId,
      if (verseNumber != null) 'verse_number': verseNumber,
      if (pageNumber != null) 'page_number': pageNumber,
      if (juzNumber != null) 'juz_number': juzNumber,
      if (hizbNumber != null) 'hizb_number': hizbNumber,
      if (textUthmani != null) 'text_uthmani': textUthmani,
      if (textImlaeiSimple != null) 'text_imlaei_simple': textImlaeiSimple,
      if (wordsJson != null) 'words_json': wordsJson,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedVersesCompanion copyWith(
      {Value<String>? verseKey,
      Value<int>? chapterId,
      Value<int>? verseNumber,
      Value<int>? pageNumber,
      Value<int>? juzNumber,
      Value<int>? hizbNumber,
      Value<String>? textUthmani,
      Value<String>? textImlaeiSimple,
      Value<String>? wordsJson,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return CachedVersesCompanion(
      verseKey: verseKey ?? this.verseKey,
      chapterId: chapterId ?? this.chapterId,
      verseNumber: verseNumber ?? this.verseNumber,
      pageNumber: pageNumber ?? this.pageNumber,
      juzNumber: juzNumber ?? this.juzNumber,
      hizbNumber: hizbNumber ?? this.hizbNumber,
      textUthmani: textUthmani ?? this.textUthmani,
      textImlaeiSimple: textImlaeiSimple ?? this.textImlaeiSimple,
      wordsJson: wordsJson ?? this.wordsJson,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (verseKey.present) {
      map['verse_key'] = Variable<String>(verseKey.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<int>(chapterId.value);
    }
    if (verseNumber.present) {
      map['verse_number'] = Variable<int>(verseNumber.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (juzNumber.present) {
      map['juz_number'] = Variable<int>(juzNumber.value);
    }
    if (hizbNumber.present) {
      map['hizb_number'] = Variable<int>(hizbNumber.value);
    }
    if (textUthmani.present) {
      map['text_uthmani'] = Variable<String>(textUthmani.value);
    }
    if (textImlaeiSimple.present) {
      map['text_imlaei_simple'] = Variable<String>(textImlaeiSimple.value);
    }
    if (wordsJson.present) {
      map['words_json'] = Variable<String>(wordsJson.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedVersesCompanion(')
          ..write('verseKey: $verseKey, ')
          ..write('chapterId: $chapterId, ')
          ..write('verseNumber: $verseNumber, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('hizbNumber: $hizbNumber, ')
          ..write('textUthmani: $textUthmani, ')
          ..write('textImlaeiSimple: $textImlaeiSimple, ')
          ..write('wordsJson: $wordsJson, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedResourceCatalogsTable extends CachedResourceCatalogs
    with TableInfo<$CachedResourceCatalogsTable, CachedResourceCatalogRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedResourceCatalogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _resourceTypeMeta =
      const VerificationMeta('resourceType');
  @override
  late final GeneratedColumn<String> resourceType = GeneratedColumn<String>(
      'resource_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resourceIdMeta =
      const VerificationMeta('resourceId');
  @override
  late final GeneratedColumn<int> resourceId = GeneratedColumn<int>(
      'resource_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ar'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorNameMeta =
      const VerificationMeta('authorName');
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
      'author_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _languageNameMeta =
      const VerificationMeta('languageName');
  @override
  late final GeneratedColumn<String> languageName = GeneratedColumn<String>(
      'language_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _styleMeta = const VerificationMeta('style');
  @override
  late final GeneratedColumn<String> style = GeneratedColumn<String>(
      'style', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        resourceType,
        resourceId,
        languageCode,
        name,
        authorName,
        languageName,
        slug,
        style,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_resource_catalogs';
  @override
  VerificationContext validateIntegrity(
      Insertable<CachedResourceCatalogRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('resource_type')) {
      context.handle(
          _resourceTypeMeta,
          resourceType.isAcceptableOrUnknown(
              data['resource_type']!, _resourceTypeMeta));
    } else if (isInserting) {
      context.missing(_resourceTypeMeta);
    }
    if (data.containsKey('resource_id')) {
      context.handle(
          _resourceIdMeta,
          resourceId.isAcceptableOrUnknown(
              data['resource_id']!, _resourceIdMeta));
    } else if (isInserting) {
      context.missing(_resourceIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name']!, _authorNameMeta));
    }
    if (data.containsKey('language_name')) {
      context.handle(
          _languageNameMeta,
          languageName.isAcceptableOrUnknown(
              data['language_name']!, _languageNameMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    }
    if (data.containsKey('style')) {
      context.handle(
          _styleMeta, style.isAcceptableOrUnknown(data['style']!, _styleMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {resourceType, resourceId, languageCode};
  @override
  CachedResourceCatalogRecord map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedResourceCatalogRecord(
      resourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_type'])!,
      resourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}resource_id'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      authorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_name'])!,
      languageName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_name'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      style: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}style'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CachedResourceCatalogsTable createAlias(String alias) {
    return $CachedResourceCatalogsTable(attachedDatabase, alias);
  }
}

class CachedResourceCatalogRecord extends DataClass
    implements Insertable<CachedResourceCatalogRecord> {
  final String resourceType;
  final int resourceId;
  final String languageCode;
  final String name;
  final String authorName;
  final String languageName;
  final String slug;
  final String style;
  final DateTime cachedAt;
  const CachedResourceCatalogRecord(
      {required this.resourceType,
      required this.resourceId,
      required this.languageCode,
      required this.name,
      required this.authorName,
      required this.languageName,
      required this.slug,
      required this.style,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['resource_type'] = Variable<String>(resourceType);
    map['resource_id'] = Variable<int>(resourceId);
    map['language_code'] = Variable<String>(languageCode);
    map['name'] = Variable<String>(name);
    map['author_name'] = Variable<String>(authorName);
    map['language_name'] = Variable<String>(languageName);
    map['slug'] = Variable<String>(slug);
    map['style'] = Variable<String>(style);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedResourceCatalogsCompanion toCompanion(bool nullToAbsent) {
    return CachedResourceCatalogsCompanion(
      resourceType: Value(resourceType),
      resourceId: Value(resourceId),
      languageCode: Value(languageCode),
      name: Value(name),
      authorName: Value(authorName),
      languageName: Value(languageName),
      slug: Value(slug),
      style: Value(style),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedResourceCatalogRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedResourceCatalogRecord(
      resourceType: serializer.fromJson<String>(json['resourceType']),
      resourceId: serializer.fromJson<int>(json['resourceId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String>(json['name']),
      authorName: serializer.fromJson<String>(json['authorName']),
      languageName: serializer.fromJson<String>(json['languageName']),
      slug: serializer.fromJson<String>(json['slug']),
      style: serializer.fromJson<String>(json['style']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'resourceType': serializer.toJson<String>(resourceType),
      'resourceId': serializer.toJson<int>(resourceId),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String>(name),
      'authorName': serializer.toJson<String>(authorName),
      'languageName': serializer.toJson<String>(languageName),
      'slug': serializer.toJson<String>(slug),
      'style': serializer.toJson<String>(style),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedResourceCatalogRecord copyWith(
          {String? resourceType,
          int? resourceId,
          String? languageCode,
          String? name,
          String? authorName,
          String? languageName,
          String? slug,
          String? style,
          DateTime? cachedAt}) =>
      CachedResourceCatalogRecord(
        resourceType: resourceType ?? this.resourceType,
        resourceId: resourceId ?? this.resourceId,
        languageCode: languageCode ?? this.languageCode,
        name: name ?? this.name,
        authorName: authorName ?? this.authorName,
        languageName: languageName ?? this.languageName,
        slug: slug ?? this.slug,
        style: style ?? this.style,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedResourceCatalogRecord copyWithCompanion(
      CachedResourceCatalogsCompanion data) {
    return CachedResourceCatalogRecord(
      resourceType: data.resourceType.present
          ? data.resourceType.value
          : this.resourceType,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      name: data.name.present ? data.name.value : this.name,
      authorName:
          data.authorName.present ? data.authorName.value : this.authorName,
      languageName: data.languageName.present
          ? data.languageName.value
          : this.languageName,
      slug: data.slug.present ? data.slug.value : this.slug,
      style: data.style.present ? data.style.value : this.style,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedResourceCatalogRecord(')
          ..write('resourceType: $resourceType, ')
          ..write('resourceId: $resourceId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('authorName: $authorName, ')
          ..write('languageName: $languageName, ')
          ..write('slug: $slug, ')
          ..write('style: $style, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(resourceType, resourceId, languageCode, name,
      authorName, languageName, slug, style, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedResourceCatalogRecord &&
          other.resourceType == this.resourceType &&
          other.resourceId == this.resourceId &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.authorName == this.authorName &&
          other.languageName == this.languageName &&
          other.slug == this.slug &&
          other.style == this.style &&
          other.cachedAt == this.cachedAt);
}

class CachedResourceCatalogsCompanion
    extends UpdateCompanion<CachedResourceCatalogRecord> {
  final Value<String> resourceType;
  final Value<int> resourceId;
  final Value<String> languageCode;
  final Value<String> name;
  final Value<String> authorName;
  final Value<String> languageName;
  final Value<String> slug;
  final Value<String> style;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedResourceCatalogsCompanion({
    this.resourceType = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.authorName = const Value.absent(),
    this.languageName = const Value.absent(),
    this.slug = const Value.absent(),
    this.style = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedResourceCatalogsCompanion.insert({
    required String resourceType,
    required int resourceId,
    this.languageCode = const Value.absent(),
    required String name,
    this.authorName = const Value.absent(),
    this.languageName = const Value.absent(),
    this.slug = const Value.absent(),
    this.style = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : resourceType = Value(resourceType),
        resourceId = Value(resourceId),
        name = Value(name),
        cachedAt = Value(cachedAt);
  static Insertable<CachedResourceCatalogRecord> custom({
    Expression<String>? resourceType,
    Expression<int>? resourceId,
    Expression<String>? languageCode,
    Expression<String>? name,
    Expression<String>? authorName,
    Expression<String>? languageName,
    Expression<String>? slug,
    Expression<String>? style,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (resourceType != null) 'resource_type': resourceType,
      if (resourceId != null) 'resource_id': resourceId,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (authorName != null) 'author_name': authorName,
      if (languageName != null) 'language_name': languageName,
      if (slug != null) 'slug': slug,
      if (style != null) 'style': style,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedResourceCatalogsCompanion copyWith(
      {Value<String>? resourceType,
      Value<int>? resourceId,
      Value<String>? languageCode,
      Value<String>? name,
      Value<String>? authorName,
      Value<String>? languageName,
      Value<String>? slug,
      Value<String>? style,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return CachedResourceCatalogsCompanion(
      resourceType: resourceType ?? this.resourceType,
      resourceId: resourceId ?? this.resourceId,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      authorName: authorName ?? this.authorName,
      languageName: languageName ?? this.languageName,
      slug: slug ?? this.slug,
      style: style ?? this.style,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (resourceType.present) {
      map['resource_type'] = Variable<String>(resourceType.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<int>(resourceId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (languageName.present) {
      map['language_name'] = Variable<String>(languageName.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (style.present) {
      map['style'] = Variable<String>(style.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedResourceCatalogsCompanion(')
          ..write('resourceType: $resourceType, ')
          ..write('resourceId: $resourceId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('authorName: $authorName, ')
          ..write('languageName: $languageName, ')
          ..write('slug: $slug, ')
          ..write('style: $style, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedVerseAnnotationsTable extends CachedVerseAnnotations
    with TableInfo<$CachedVerseAnnotationsTable, CachedVerseAnnotationRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedVerseAnnotationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _verseKeyMeta =
      const VerificationMeta('verseKey');
  @override
  late final GeneratedColumn<String> verseKey = GeneratedColumn<String>(
      'verse_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resourceTypeMeta =
      const VerificationMeta('resourceType');
  @override
  late final GeneratedColumn<String> resourceType = GeneratedColumn<String>(
      'resource_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resourceIdMeta =
      const VerificationMeta('resourceId');
  @override
  late final GeneratedColumn<int> resourceId = GeneratedColumn<int>(
      'resource_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _resourceNameMeta =
      const VerificationMeta('resourceName');
  @override
  late final GeneratedColumn<String> resourceName = GeneratedColumn<String>(
      'resource_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _textContentMeta =
      const VerificationMeta('textContent');
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
      'text_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [verseKey, resourceType, resourceId, resourceName, textContent, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_verse_annotations';
  @override
  VerificationContext validateIntegrity(
      Insertable<CachedVerseAnnotationRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('verse_key')) {
      context.handle(_verseKeyMeta,
          verseKey.isAcceptableOrUnknown(data['verse_key']!, _verseKeyMeta));
    } else if (isInserting) {
      context.missing(_verseKeyMeta);
    }
    if (data.containsKey('resource_type')) {
      context.handle(
          _resourceTypeMeta,
          resourceType.isAcceptableOrUnknown(
              data['resource_type']!, _resourceTypeMeta));
    } else if (isInserting) {
      context.missing(_resourceTypeMeta);
    }
    if (data.containsKey('resource_id')) {
      context.handle(
          _resourceIdMeta,
          resourceId.isAcceptableOrUnknown(
              data['resource_id']!, _resourceIdMeta));
    } else if (isInserting) {
      context.missing(_resourceIdMeta);
    }
    if (data.containsKey('resource_name')) {
      context.handle(
          _resourceNameMeta,
          resourceName.isAcceptableOrUnknown(
              data['resource_name']!, _resourceNameMeta));
    }
    if (data.containsKey('text_content')) {
      context.handle(
          _textContentMeta,
          textContent.isAcceptableOrUnknown(
              data['text_content']!, _textContentMeta));
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {verseKey, resourceType, resourceId};
  @override
  CachedVerseAnnotationRecord map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedVerseAnnotationRecord(
      verseKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}verse_key'])!,
      resourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_type'])!,
      resourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}resource_id'])!,
      resourceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_name'])!,
      textContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_content'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CachedVerseAnnotationsTable createAlias(String alias) {
    return $CachedVerseAnnotationsTable(attachedDatabase, alias);
  }
}

class CachedVerseAnnotationRecord extends DataClass
    implements Insertable<CachedVerseAnnotationRecord> {
  final String verseKey;
  final String resourceType;
  final int resourceId;
  final String resourceName;
  final String textContent;
  final DateTime cachedAt;
  const CachedVerseAnnotationRecord(
      {required this.verseKey,
      required this.resourceType,
      required this.resourceId,
      required this.resourceName,
      required this.textContent,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['verse_key'] = Variable<String>(verseKey);
    map['resource_type'] = Variable<String>(resourceType);
    map['resource_id'] = Variable<int>(resourceId);
    map['resource_name'] = Variable<String>(resourceName);
    map['text_content'] = Variable<String>(textContent);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedVerseAnnotationsCompanion toCompanion(bool nullToAbsent) {
    return CachedVerseAnnotationsCompanion(
      verseKey: Value(verseKey),
      resourceType: Value(resourceType),
      resourceId: Value(resourceId),
      resourceName: Value(resourceName),
      textContent: Value(textContent),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedVerseAnnotationRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedVerseAnnotationRecord(
      verseKey: serializer.fromJson<String>(json['verseKey']),
      resourceType: serializer.fromJson<String>(json['resourceType']),
      resourceId: serializer.fromJson<int>(json['resourceId']),
      resourceName: serializer.fromJson<String>(json['resourceName']),
      textContent: serializer.fromJson<String>(json['textContent']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'verseKey': serializer.toJson<String>(verseKey),
      'resourceType': serializer.toJson<String>(resourceType),
      'resourceId': serializer.toJson<int>(resourceId),
      'resourceName': serializer.toJson<String>(resourceName),
      'textContent': serializer.toJson<String>(textContent),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedVerseAnnotationRecord copyWith(
          {String? verseKey,
          String? resourceType,
          int? resourceId,
          String? resourceName,
          String? textContent,
          DateTime? cachedAt}) =>
      CachedVerseAnnotationRecord(
        verseKey: verseKey ?? this.verseKey,
        resourceType: resourceType ?? this.resourceType,
        resourceId: resourceId ?? this.resourceId,
        resourceName: resourceName ?? this.resourceName,
        textContent: textContent ?? this.textContent,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedVerseAnnotationRecord copyWithCompanion(
      CachedVerseAnnotationsCompanion data) {
    return CachedVerseAnnotationRecord(
      verseKey: data.verseKey.present ? data.verseKey.value : this.verseKey,
      resourceType: data.resourceType.present
          ? data.resourceType.value
          : this.resourceType,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
      resourceName: data.resourceName.present
          ? data.resourceName.value
          : this.resourceName,
      textContent:
          data.textContent.present ? data.textContent.value : this.textContent,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedVerseAnnotationRecord(')
          ..write('verseKey: $verseKey, ')
          ..write('resourceType: $resourceType, ')
          ..write('resourceId: $resourceId, ')
          ..write('resourceName: $resourceName, ')
          ..write('textContent: $textContent, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      verseKey, resourceType, resourceId, resourceName, textContent, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedVerseAnnotationRecord &&
          other.verseKey == this.verseKey &&
          other.resourceType == this.resourceType &&
          other.resourceId == this.resourceId &&
          other.resourceName == this.resourceName &&
          other.textContent == this.textContent &&
          other.cachedAt == this.cachedAt);
}

class CachedVerseAnnotationsCompanion
    extends UpdateCompanion<CachedVerseAnnotationRecord> {
  final Value<String> verseKey;
  final Value<String> resourceType;
  final Value<int> resourceId;
  final Value<String> resourceName;
  final Value<String> textContent;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedVerseAnnotationsCompanion({
    this.verseKey = const Value.absent(),
    this.resourceType = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.resourceName = const Value.absent(),
    this.textContent = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedVerseAnnotationsCompanion.insert({
    required String verseKey,
    required String resourceType,
    required int resourceId,
    this.resourceName = const Value.absent(),
    required String textContent,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : verseKey = Value(verseKey),
        resourceType = Value(resourceType),
        resourceId = Value(resourceId),
        textContent = Value(textContent),
        cachedAt = Value(cachedAt);
  static Insertable<CachedVerseAnnotationRecord> custom({
    Expression<String>? verseKey,
    Expression<String>? resourceType,
    Expression<int>? resourceId,
    Expression<String>? resourceName,
    Expression<String>? textContent,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (verseKey != null) 'verse_key': verseKey,
      if (resourceType != null) 'resource_type': resourceType,
      if (resourceId != null) 'resource_id': resourceId,
      if (resourceName != null) 'resource_name': resourceName,
      if (textContent != null) 'text_content': textContent,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedVerseAnnotationsCompanion copyWith(
      {Value<String>? verseKey,
      Value<String>? resourceType,
      Value<int>? resourceId,
      Value<String>? resourceName,
      Value<String>? textContent,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return CachedVerseAnnotationsCompanion(
      verseKey: verseKey ?? this.verseKey,
      resourceType: resourceType ?? this.resourceType,
      resourceId: resourceId ?? this.resourceId,
      resourceName: resourceName ?? this.resourceName,
      textContent: textContent ?? this.textContent,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (verseKey.present) {
      map['verse_key'] = Variable<String>(verseKey.value);
    }
    if (resourceType.present) {
      map['resource_type'] = Variable<String>(resourceType.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<int>(resourceId.value);
    }
    if (resourceName.present) {
      map['resource_name'] = Variable<String>(resourceName.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedVerseAnnotationsCompanion(')
          ..write('verseKey: $verseKey, ')
          ..write('resourceType: $resourceType, ')
          ..write('resourceId: $resourceId, ')
          ..write('resourceName: $resourceName, ')
          ..write('textContent: $textContent, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AdhkarDailyProgressTable extends AdhkarDailyProgress
    with TableInfo<$AdhkarDailyProgressTable, AdhkarDailyProgressRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdhkarDailyProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentCountMeta =
      const VerificationMeta('currentCount');
  @override
  late final GeneratedColumn<int> currentCount = GeneratedColumn<int>(
      'current_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _targetCountMeta =
      const VerificationMeta('targetCount');
  @override
  late final GeneratedColumn<int> targetCount = GeneratedColumn<int>(
      'target_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        date,
        itemId,
        category,
        currentCount,
        targetCount,
        isCompleted,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'adhkar_daily_progress';
  @override
  VerificationContext validateIntegrity(
      Insertable<AdhkarDailyProgressRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('current_count')) {
      context.handle(
          _currentCountMeta,
          currentCount.isAcceptableOrUnknown(
              data['current_count']!, _currentCountMeta));
    }
    if (data.containsKey('target_count')) {
      context.handle(
          _targetCountMeta,
          targetCount.isAcceptableOrUnknown(
              data['target_count']!, _targetCountMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date, itemId};
  @override
  AdhkarDailyProgressRecord map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdhkarDailyProgressRecord(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      currentCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_count'])!,
      targetCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_count'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AdhkarDailyProgressTable createAlias(String alias) {
    return $AdhkarDailyProgressTable(attachedDatabase, alias);
  }
}

class AdhkarDailyProgressRecord extends DataClass
    implements Insertable<AdhkarDailyProgressRecord> {
  final String date;
  final String itemId;
  final String category;
  final int currentCount;
  final int targetCount;
  final bool isCompleted;
  final DateTime updatedAt;
  const AdhkarDailyProgressRecord(
      {required this.date,
      required this.itemId,
      required this.category,
      required this.currentCount,
      required this.targetCount,
      required this.isCompleted,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['item_id'] = Variable<String>(itemId);
    map['category'] = Variable<String>(category);
    map['current_count'] = Variable<int>(currentCount);
    map['target_count'] = Variable<int>(targetCount);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AdhkarDailyProgressCompanion toCompanion(bool nullToAbsent) {
    return AdhkarDailyProgressCompanion(
      date: Value(date),
      itemId: Value(itemId),
      category: Value(category),
      currentCount: Value(currentCount),
      targetCount: Value(targetCount),
      isCompleted: Value(isCompleted),
      updatedAt: Value(updatedAt),
    );
  }

  factory AdhkarDailyProgressRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdhkarDailyProgressRecord(
      date: serializer.fromJson<String>(json['date']),
      itemId: serializer.fromJson<String>(json['itemId']),
      category: serializer.fromJson<String>(json['category']),
      currentCount: serializer.fromJson<int>(json['currentCount']),
      targetCount: serializer.fromJson<int>(json['targetCount']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'itemId': serializer.toJson<String>(itemId),
      'category': serializer.toJson<String>(category),
      'currentCount': serializer.toJson<int>(currentCount),
      'targetCount': serializer.toJson<int>(targetCount),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AdhkarDailyProgressRecord copyWith(
          {String? date,
          String? itemId,
          String? category,
          int? currentCount,
          int? targetCount,
          bool? isCompleted,
          DateTime? updatedAt}) =>
      AdhkarDailyProgressRecord(
        date: date ?? this.date,
        itemId: itemId ?? this.itemId,
        category: category ?? this.category,
        currentCount: currentCount ?? this.currentCount,
        targetCount: targetCount ?? this.targetCount,
        isCompleted: isCompleted ?? this.isCompleted,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AdhkarDailyProgressRecord copyWithCompanion(
      AdhkarDailyProgressCompanion data) {
    return AdhkarDailyProgressRecord(
      date: data.date.present ? data.date.value : this.date,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      category: data.category.present ? data.category.value : this.category,
      currentCount: data.currentCount.present
          ? data.currentCount.value
          : this.currentCount,
      targetCount:
          data.targetCount.present ? data.targetCount.value : this.targetCount,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdhkarDailyProgressRecord(')
          ..write('date: $date, ')
          ..write('itemId: $itemId, ')
          ..write('category: $category, ')
          ..write('currentCount: $currentCount, ')
          ..write('targetCount: $targetCount, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, itemId, category, currentCount,
      targetCount, isCompleted, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdhkarDailyProgressRecord &&
          other.date == this.date &&
          other.itemId == this.itemId &&
          other.category == this.category &&
          other.currentCount == this.currentCount &&
          other.targetCount == this.targetCount &&
          other.isCompleted == this.isCompleted &&
          other.updatedAt == this.updatedAt);
}

class AdhkarDailyProgressCompanion
    extends UpdateCompanion<AdhkarDailyProgressRecord> {
  final Value<String> date;
  final Value<String> itemId;
  final Value<String> category;
  final Value<int> currentCount;
  final Value<int> targetCount;
  final Value<bool> isCompleted;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AdhkarDailyProgressCompanion({
    this.date = const Value.absent(),
    this.itemId = const Value.absent(),
    this.category = const Value.absent(),
    this.currentCount = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AdhkarDailyProgressCompanion.insert({
    required String date,
    required String itemId,
    required String category,
    this.currentCount = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        itemId = Value(itemId),
        category = Value(category);
  static Insertable<AdhkarDailyProgressRecord> custom({
    Expression<String>? date,
    Expression<String>? itemId,
    Expression<String>? category,
    Expression<int>? currentCount,
    Expression<int>? targetCount,
    Expression<bool>? isCompleted,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (itemId != null) 'item_id': itemId,
      if (category != null) 'category': category,
      if (currentCount != null) 'current_count': currentCount,
      if (targetCount != null) 'target_count': targetCount,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AdhkarDailyProgressCompanion copyWith(
      {Value<String>? date,
      Value<String>? itemId,
      Value<String>? category,
      Value<int>? currentCount,
      Value<int>? targetCount,
      Value<bool>? isCompleted,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AdhkarDailyProgressCompanion(
      date: date ?? this.date,
      itemId: itemId ?? this.itemId,
      category: category ?? this.category,
      currentCount: currentCount ?? this.currentCount,
      targetCount: targetCount ?? this.targetCount,
      isCompleted: isCompleted ?? this.isCompleted,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (currentCount.present) {
      map['current_count'] = Variable<int>(currentCount.value);
    }
    if (targetCount.present) {
      map['target_count'] = Variable<int>(targetCount.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdhkarDailyProgressCompanion(')
          ..write('date: $date, ')
          ..write('itemId: $itemId, ')
          ..write('category: $category, ')
          ..write('currentCount: $currentCount, ')
          ..write('targetCount: $targetCount, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HifzMemorizedRangesTable extends HifzMemorizedRanges
    with TableInfo<$HifzMemorizedRangesTable, HifzMemorizedRangeRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HifzMemorizedRangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startAyahMeta =
      const VerificationMeta('startAyah');
  @override
  late final GeneratedColumn<int> startAyah = GeneratedColumn<int>(
      'start_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endAyahMeta =
      const VerificationMeta('endAyah');
  @override
  late final GeneratedColumn<int> endAyah = GeneratedColumn<int>(
      'end_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startPageMeta =
      const VerificationMeta('startPage');
  @override
  late final GeneratedColumn<int> startPage = GeneratedColumn<int>(
      'start_page', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _endPageMeta =
      const VerificationMeta('endPage');
  @override
  late final GeneratedColumn<int> endPage = GeneratedColumn<int>(
      'end_page', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _juzNumberMeta =
      const VerificationMeta('juzNumber');
  @override
  late final GeneratedColumn<int> juzNumber = GeneratedColumn<int>(
      'juz_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _easinessFactorMeta =
      const VerificationMeta('easinessFactor');
  @override
  late final GeneratedColumn<double> easinessFactor = GeneratedColumn<double>(
      'easiness_factor', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(2.5));
  static const VerificationMeta _intervalDaysMeta =
      const VerificationMeta('intervalDays');
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
      'interval_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _repetitionsMeta =
      const VerificationMeta('repetitions');
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
      'repetitions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastReviewedDateMeta =
      const VerificationMeta('lastReviewedDate');
  @override
  late final GeneratedColumn<String> lastReviewedDate = GeneratedColumn<String>(
      'last_reviewed_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nextDueDateMeta =
      const VerificationMeta('nextDueDate');
  @override
  late final GeneratedColumn<String> nextDueDate = GeneratedColumn<String>(
      'next_due_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastGradeMeta =
      const VerificationMeta('lastGrade');
  @override
  late final GeneratedColumn<String> lastGrade = GeneratedColumn<String>(
      'last_grade', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('perfect'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        surahNumber,
        startAyah,
        endAyah,
        startPage,
        endPage,
        juzNumber,
        easinessFactor,
        intervalDays,
        repetitions,
        lastReviewedDate,
        nextDueDate,
        lastGrade,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hifz_memorized_ranges';
  @override
  VerificationContext validateIntegrity(
      Insertable<HifzMemorizedRangeRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('start_ayah')) {
      context.handle(_startAyahMeta,
          startAyah.isAcceptableOrUnknown(data['start_ayah']!, _startAyahMeta));
    } else if (isInserting) {
      context.missing(_startAyahMeta);
    }
    if (data.containsKey('end_ayah')) {
      context.handle(_endAyahMeta,
          endAyah.isAcceptableOrUnknown(data['end_ayah']!, _endAyahMeta));
    } else if (isInserting) {
      context.missing(_endAyahMeta);
    }
    if (data.containsKey('start_page')) {
      context.handle(_startPageMeta,
          startPage.isAcceptableOrUnknown(data['start_page']!, _startPageMeta));
    }
    if (data.containsKey('end_page')) {
      context.handle(_endPageMeta,
          endPage.isAcceptableOrUnknown(data['end_page']!, _endPageMeta));
    }
    if (data.containsKey('juz_number')) {
      context.handle(_juzNumberMeta,
          juzNumber.isAcceptableOrUnknown(data['juz_number']!, _juzNumberMeta));
    }
    if (data.containsKey('easiness_factor')) {
      context.handle(
          _easinessFactorMeta,
          easinessFactor.isAcceptableOrUnknown(
              data['easiness_factor']!, _easinessFactorMeta));
    }
    if (data.containsKey('interval_days')) {
      context.handle(
          _intervalDaysMeta,
          intervalDays.isAcceptableOrUnknown(
              data['interval_days']!, _intervalDaysMeta));
    }
    if (data.containsKey('repetitions')) {
      context.handle(
          _repetitionsMeta,
          repetitions.isAcceptableOrUnknown(
              data['repetitions']!, _repetitionsMeta));
    }
    if (data.containsKey('last_reviewed_date')) {
      context.handle(
          _lastReviewedDateMeta,
          lastReviewedDate.isAcceptableOrUnknown(
              data['last_reviewed_date']!, _lastReviewedDateMeta));
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
          _nextDueDateMeta,
          nextDueDate.isAcceptableOrUnknown(
              data['next_due_date']!, _nextDueDateMeta));
    } else if (isInserting) {
      context.missing(_nextDueDateMeta);
    }
    if (data.containsKey('last_grade')) {
      context.handle(_lastGradeMeta,
          lastGrade.isAcceptableOrUnknown(data['last_grade']!, _lastGradeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HifzMemorizedRangeRecord map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HifzMemorizedRangeRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number'])!,
      startAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_ayah'])!,
      endAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_ayah'])!,
      startPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_page'])!,
      endPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_page'])!,
      juzNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}juz_number'])!,
      easinessFactor: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}easiness_factor'])!,
      intervalDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval_days'])!,
      repetitions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repetitions'])!,
      lastReviewedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_reviewed_date']),
      nextDueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_due_date'])!,
      lastGrade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_grade'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HifzMemorizedRangesTable createAlias(String alias) {
    return $HifzMemorizedRangesTable(attachedDatabase, alias);
  }
}

class HifzMemorizedRangeRecord extends DataClass
    implements Insertable<HifzMemorizedRangeRecord> {
  final int id;
  final int surahNumber;
  final int startAyah;
  final int endAyah;
  final int startPage;
  final int endPage;
  final int juzNumber;
  final double easinessFactor;
  final int intervalDays;
  final int repetitions;
  final String? lastReviewedDate;
  final String nextDueDate;
  final String lastGrade;
  final DateTime createdAt;
  const HifzMemorizedRangeRecord(
      {required this.id,
      required this.surahNumber,
      required this.startAyah,
      required this.endAyah,
      required this.startPage,
      required this.endPage,
      required this.juzNumber,
      required this.easinessFactor,
      required this.intervalDays,
      required this.repetitions,
      this.lastReviewedDate,
      required this.nextDueDate,
      required this.lastGrade,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['start_ayah'] = Variable<int>(startAyah);
    map['end_ayah'] = Variable<int>(endAyah);
    map['start_page'] = Variable<int>(startPage);
    map['end_page'] = Variable<int>(endPage);
    map['juz_number'] = Variable<int>(juzNumber);
    map['easiness_factor'] = Variable<double>(easinessFactor);
    map['interval_days'] = Variable<int>(intervalDays);
    map['repetitions'] = Variable<int>(repetitions);
    if (!nullToAbsent || lastReviewedDate != null) {
      map['last_reviewed_date'] = Variable<String>(lastReviewedDate);
    }
    map['next_due_date'] = Variable<String>(nextDueDate);
    map['last_grade'] = Variable<String>(lastGrade);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HifzMemorizedRangesCompanion toCompanion(bool nullToAbsent) {
    return HifzMemorizedRangesCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      startAyah: Value(startAyah),
      endAyah: Value(endAyah),
      startPage: Value(startPage),
      endPage: Value(endPage),
      juzNumber: Value(juzNumber),
      easinessFactor: Value(easinessFactor),
      intervalDays: Value(intervalDays),
      repetitions: Value(repetitions),
      lastReviewedDate: lastReviewedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedDate),
      nextDueDate: Value(nextDueDate),
      lastGrade: Value(lastGrade),
      createdAt: Value(createdAt),
    );
  }

  factory HifzMemorizedRangeRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HifzMemorizedRangeRecord(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      startAyah: serializer.fromJson<int>(json['startAyah']),
      endAyah: serializer.fromJson<int>(json['endAyah']),
      startPage: serializer.fromJson<int>(json['startPage']),
      endPage: serializer.fromJson<int>(json['endPage']),
      juzNumber: serializer.fromJson<int>(json['juzNumber']),
      easinessFactor: serializer.fromJson<double>(json['easinessFactor']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      lastReviewedDate: serializer.fromJson<String?>(json['lastReviewedDate']),
      nextDueDate: serializer.fromJson<String>(json['nextDueDate']),
      lastGrade: serializer.fromJson<String>(json['lastGrade']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'startAyah': serializer.toJson<int>(startAyah),
      'endAyah': serializer.toJson<int>(endAyah),
      'startPage': serializer.toJson<int>(startPage),
      'endPage': serializer.toJson<int>(endPage),
      'juzNumber': serializer.toJson<int>(juzNumber),
      'easinessFactor': serializer.toJson<double>(easinessFactor),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'repetitions': serializer.toJson<int>(repetitions),
      'lastReviewedDate': serializer.toJson<String?>(lastReviewedDate),
      'nextDueDate': serializer.toJson<String>(nextDueDate),
      'lastGrade': serializer.toJson<String>(lastGrade),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HifzMemorizedRangeRecord copyWith(
          {int? id,
          int? surahNumber,
          int? startAyah,
          int? endAyah,
          int? startPage,
          int? endPage,
          int? juzNumber,
          double? easinessFactor,
          int? intervalDays,
          int? repetitions,
          Value<String?> lastReviewedDate = const Value.absent(),
          String? nextDueDate,
          String? lastGrade,
          DateTime? createdAt}) =>
      HifzMemorizedRangeRecord(
        id: id ?? this.id,
        surahNumber: surahNumber ?? this.surahNumber,
        startAyah: startAyah ?? this.startAyah,
        endAyah: endAyah ?? this.endAyah,
        startPage: startPage ?? this.startPage,
        endPage: endPage ?? this.endPage,
        juzNumber: juzNumber ?? this.juzNumber,
        easinessFactor: easinessFactor ?? this.easinessFactor,
        intervalDays: intervalDays ?? this.intervalDays,
        repetitions: repetitions ?? this.repetitions,
        lastReviewedDate: lastReviewedDate.present
            ? lastReviewedDate.value
            : this.lastReviewedDate,
        nextDueDate: nextDueDate ?? this.nextDueDate,
        lastGrade: lastGrade ?? this.lastGrade,
        createdAt: createdAt ?? this.createdAt,
      );
  HifzMemorizedRangeRecord copyWithCompanion(
      HifzMemorizedRangesCompanion data) {
    return HifzMemorizedRangeRecord(
      id: data.id.present ? data.id.value : this.id,
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      startAyah: data.startAyah.present ? data.startAyah.value : this.startAyah,
      endAyah: data.endAyah.present ? data.endAyah.value : this.endAyah,
      startPage: data.startPage.present ? data.startPage.value : this.startPage,
      endPage: data.endPage.present ? data.endPage.value : this.endPage,
      juzNumber: data.juzNumber.present ? data.juzNumber.value : this.juzNumber,
      easinessFactor: data.easinessFactor.present
          ? data.easinessFactor.value
          : this.easinessFactor,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      repetitions:
          data.repetitions.present ? data.repetitions.value : this.repetitions,
      lastReviewedDate: data.lastReviewedDate.present
          ? data.lastReviewedDate.value
          : this.lastReviewedDate,
      nextDueDate:
          data.nextDueDate.present ? data.nextDueDate.value : this.nextDueDate,
      lastGrade: data.lastGrade.present ? data.lastGrade.value : this.lastGrade,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HifzMemorizedRangeRecord(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('startPage: $startPage, ')
          ..write('endPage: $endPage, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('easinessFactor: $easinessFactor, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('lastReviewedDate: $lastReviewedDate, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('lastGrade: $lastGrade, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      surahNumber,
      startAyah,
      endAyah,
      startPage,
      endPage,
      juzNumber,
      easinessFactor,
      intervalDays,
      repetitions,
      lastReviewedDate,
      nextDueDate,
      lastGrade,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HifzMemorizedRangeRecord &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.startAyah == this.startAyah &&
          other.endAyah == this.endAyah &&
          other.startPage == this.startPage &&
          other.endPage == this.endPage &&
          other.juzNumber == this.juzNumber &&
          other.easinessFactor == this.easinessFactor &&
          other.intervalDays == this.intervalDays &&
          other.repetitions == this.repetitions &&
          other.lastReviewedDate == this.lastReviewedDate &&
          other.nextDueDate == this.nextDueDate &&
          other.lastGrade == this.lastGrade &&
          other.createdAt == this.createdAt);
}

class HifzMemorizedRangesCompanion
    extends UpdateCompanion<HifzMemorizedRangeRecord> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> startAyah;
  final Value<int> endAyah;
  final Value<int> startPage;
  final Value<int> endPage;
  final Value<int> juzNumber;
  final Value<double> easinessFactor;
  final Value<int> intervalDays;
  final Value<int> repetitions;
  final Value<String?> lastReviewedDate;
  final Value<String> nextDueDate;
  final Value<String> lastGrade;
  final Value<DateTime> createdAt;
  const HifzMemorizedRangesCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.startPage = const Value.absent(),
    this.endPage = const Value.absent(),
    this.juzNumber = const Value.absent(),
    this.easinessFactor = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.lastReviewedDate = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.lastGrade = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HifzMemorizedRangesCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int startAyah,
    required int endAyah,
    this.startPage = const Value.absent(),
    this.endPage = const Value.absent(),
    this.juzNumber = const Value.absent(),
    this.easinessFactor = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.lastReviewedDate = const Value.absent(),
    required String nextDueDate,
    this.lastGrade = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : surahNumber = Value(surahNumber),
        startAyah = Value(startAyah),
        endAyah = Value(endAyah),
        nextDueDate = Value(nextDueDate);
  static Insertable<HifzMemorizedRangeRecord> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? startAyah,
    Expression<int>? endAyah,
    Expression<int>? startPage,
    Expression<int>? endPage,
    Expression<int>? juzNumber,
    Expression<double>? easinessFactor,
    Expression<int>? intervalDays,
    Expression<int>? repetitions,
    Expression<String>? lastReviewedDate,
    Expression<String>? nextDueDate,
    Expression<String>? lastGrade,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (startAyah != null) 'start_ayah': startAyah,
      if (endAyah != null) 'end_ayah': endAyah,
      if (startPage != null) 'start_page': startPage,
      if (endPage != null) 'end_page': endPage,
      if (juzNumber != null) 'juz_number': juzNumber,
      if (easinessFactor != null) 'easiness_factor': easinessFactor,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (repetitions != null) 'repetitions': repetitions,
      if (lastReviewedDate != null) 'last_reviewed_date': lastReviewedDate,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (lastGrade != null) 'last_grade': lastGrade,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HifzMemorizedRangesCompanion copyWith(
      {Value<int>? id,
      Value<int>? surahNumber,
      Value<int>? startAyah,
      Value<int>? endAyah,
      Value<int>? startPage,
      Value<int>? endPage,
      Value<int>? juzNumber,
      Value<double>? easinessFactor,
      Value<int>? intervalDays,
      Value<int>? repetitions,
      Value<String?>? lastReviewedDate,
      Value<String>? nextDueDate,
      Value<String>? lastGrade,
      Value<DateTime>? createdAt}) {
    return HifzMemorizedRangesCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      juzNumber: juzNumber ?? this.juzNumber,
      easinessFactor: easinessFactor ?? this.easinessFactor,
      intervalDays: intervalDays ?? this.intervalDays,
      repetitions: repetitions ?? this.repetitions,
      lastReviewedDate: lastReviewedDate ?? this.lastReviewedDate,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      lastGrade: lastGrade ?? this.lastGrade,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (startAyah.present) {
      map['start_ayah'] = Variable<int>(startAyah.value);
    }
    if (endAyah.present) {
      map['end_ayah'] = Variable<int>(endAyah.value);
    }
    if (startPage.present) {
      map['start_page'] = Variable<int>(startPage.value);
    }
    if (endPage.present) {
      map['end_page'] = Variable<int>(endPage.value);
    }
    if (juzNumber.present) {
      map['juz_number'] = Variable<int>(juzNumber.value);
    }
    if (easinessFactor.present) {
      map['easiness_factor'] = Variable<double>(easinessFactor.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (lastReviewedDate.present) {
      map['last_reviewed_date'] = Variable<String>(lastReviewedDate.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<String>(nextDueDate.value);
    }
    if (lastGrade.present) {
      map['last_grade'] = Variable<String>(lastGrade.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HifzMemorizedRangesCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('startPage: $startPage, ')
          ..write('endPage: $endPage, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('easinessFactor: $easinessFactor, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('lastReviewedDate: $lastReviewedDate, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('lastGrade: $lastGrade, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HifzReviewEventsTable extends HifzReviewEvents
    with TableInfo<$HifzReviewEventsTable, HifzReviewEventRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HifzReviewEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _rangeIdMeta =
      const VerificationMeta('rangeId');
  @override
  late final GeneratedColumn<int> rangeId = GeneratedColumn<int>(
      'range_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startAyahMeta =
      const VerificationMeta('startAyah');
  @override
  late final GeneratedColumn<int> startAyah = GeneratedColumn<int>(
      'start_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endAyahMeta =
      const VerificationMeta('endAyah');
  @override
  late final GeneratedColumn<int> endAyah = GeneratedColumn<int>(
      'end_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
      'grade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localDateMeta =
      const VerificationMeta('localDate');
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
      'local_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewedAtMeta =
      const VerificationMeta('reviewedAt');
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
      'reviewed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        rangeId,
        surahNumber,
        startAyah,
        endAyah,
        grade,
        localDate,
        reviewedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hifz_review_events';
  @override
  VerificationContext validateIntegrity(
      Insertable<HifzReviewEventRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('range_id')) {
      context.handle(_rangeIdMeta,
          rangeId.isAcceptableOrUnknown(data['range_id']!, _rangeIdMeta));
    } else if (isInserting) {
      context.missing(_rangeIdMeta);
    }
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('start_ayah')) {
      context.handle(_startAyahMeta,
          startAyah.isAcceptableOrUnknown(data['start_ayah']!, _startAyahMeta));
    } else if (isInserting) {
      context.missing(_startAyahMeta);
    }
    if (data.containsKey('end_ayah')) {
      context.handle(_endAyahMeta,
          endAyah.isAcceptableOrUnknown(data['end_ayah']!, _endAyahMeta));
    } else if (isInserting) {
      context.missing(_endAyahMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(_localDateMeta,
          localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta));
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
          _reviewedAtMeta,
          reviewedAt.isAcceptableOrUnknown(
              data['reviewed_at']!, _reviewedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HifzReviewEventRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HifzReviewEventRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      rangeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}range_id'])!,
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number'])!,
      startAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_ayah'])!,
      endAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_ayah'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grade'])!,
      localDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_date'])!,
      reviewedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}reviewed_at'])!,
    );
  }

  @override
  $HifzReviewEventsTable createAlias(String alias) {
    return $HifzReviewEventsTable(attachedDatabase, alias);
  }
}

class HifzReviewEventRecord extends DataClass
    implements Insertable<HifzReviewEventRecord> {
  final int id;
  final int rangeId;
  final int surahNumber;
  final int startAyah;
  final int endAyah;
  final String grade;
  final String localDate;
  final DateTime reviewedAt;
  const HifzReviewEventRecord(
      {required this.id,
      required this.rangeId,
      required this.surahNumber,
      required this.startAyah,
      required this.endAyah,
      required this.grade,
      required this.localDate,
      required this.reviewedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['range_id'] = Variable<int>(rangeId);
    map['surah_number'] = Variable<int>(surahNumber);
    map['start_ayah'] = Variable<int>(startAyah);
    map['end_ayah'] = Variable<int>(endAyah);
    map['grade'] = Variable<String>(grade);
    map['local_date'] = Variable<String>(localDate);
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    return map;
  }

  HifzReviewEventsCompanion toCompanion(bool nullToAbsent) {
    return HifzReviewEventsCompanion(
      id: Value(id),
      rangeId: Value(rangeId),
      surahNumber: Value(surahNumber),
      startAyah: Value(startAyah),
      endAyah: Value(endAyah),
      grade: Value(grade),
      localDate: Value(localDate),
      reviewedAt: Value(reviewedAt),
    );
  }

  factory HifzReviewEventRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HifzReviewEventRecord(
      id: serializer.fromJson<int>(json['id']),
      rangeId: serializer.fromJson<int>(json['rangeId']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      startAyah: serializer.fromJson<int>(json['startAyah']),
      endAyah: serializer.fromJson<int>(json['endAyah']),
      grade: serializer.fromJson<String>(json['grade']),
      localDate: serializer.fromJson<String>(json['localDate']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rangeId': serializer.toJson<int>(rangeId),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'startAyah': serializer.toJson<int>(startAyah),
      'endAyah': serializer.toJson<int>(endAyah),
      'grade': serializer.toJson<String>(grade),
      'localDate': serializer.toJson<String>(localDate),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
    };
  }

  HifzReviewEventRecord copyWith(
          {int? id,
          int? rangeId,
          int? surahNumber,
          int? startAyah,
          int? endAyah,
          String? grade,
          String? localDate,
          DateTime? reviewedAt}) =>
      HifzReviewEventRecord(
        id: id ?? this.id,
        rangeId: rangeId ?? this.rangeId,
        surahNumber: surahNumber ?? this.surahNumber,
        startAyah: startAyah ?? this.startAyah,
        endAyah: endAyah ?? this.endAyah,
        grade: grade ?? this.grade,
        localDate: localDate ?? this.localDate,
        reviewedAt: reviewedAt ?? this.reviewedAt,
      );
  HifzReviewEventRecord copyWithCompanion(HifzReviewEventsCompanion data) {
    return HifzReviewEventRecord(
      id: data.id.present ? data.id.value : this.id,
      rangeId: data.rangeId.present ? data.rangeId.value : this.rangeId,
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      startAyah: data.startAyah.present ? data.startAyah.value : this.startAyah,
      endAyah: data.endAyah.present ? data.endAyah.value : this.endAyah,
      grade: data.grade.present ? data.grade.value : this.grade,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      reviewedAt:
          data.reviewedAt.present ? data.reviewedAt.value : this.reviewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HifzReviewEventRecord(')
          ..write('id: $id, ')
          ..write('rangeId: $rangeId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('grade: $grade, ')
          ..write('localDate: $localDate, ')
          ..write('reviewedAt: $reviewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, rangeId, surahNumber, startAyah, endAyah,
      grade, localDate, reviewedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HifzReviewEventRecord &&
          other.id == this.id &&
          other.rangeId == this.rangeId &&
          other.surahNumber == this.surahNumber &&
          other.startAyah == this.startAyah &&
          other.endAyah == this.endAyah &&
          other.grade == this.grade &&
          other.localDate == this.localDate &&
          other.reviewedAt == this.reviewedAt);
}

class HifzReviewEventsCompanion extends UpdateCompanion<HifzReviewEventRecord> {
  final Value<int> id;
  final Value<int> rangeId;
  final Value<int> surahNumber;
  final Value<int> startAyah;
  final Value<int> endAyah;
  final Value<String> grade;
  final Value<String> localDate;
  final Value<DateTime> reviewedAt;
  const HifzReviewEventsCompanion({
    this.id = const Value.absent(),
    this.rangeId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.grade = const Value.absent(),
    this.localDate = const Value.absent(),
    this.reviewedAt = const Value.absent(),
  });
  HifzReviewEventsCompanion.insert({
    this.id = const Value.absent(),
    required int rangeId,
    required int surahNumber,
    required int startAyah,
    required int endAyah,
    required String grade,
    required String localDate,
    this.reviewedAt = const Value.absent(),
  })  : rangeId = Value(rangeId),
        surahNumber = Value(surahNumber),
        startAyah = Value(startAyah),
        endAyah = Value(endAyah),
        grade = Value(grade),
        localDate = Value(localDate);
  static Insertable<HifzReviewEventRecord> custom({
    Expression<int>? id,
    Expression<int>? rangeId,
    Expression<int>? surahNumber,
    Expression<int>? startAyah,
    Expression<int>? endAyah,
    Expression<String>? grade,
    Expression<String>? localDate,
    Expression<DateTime>? reviewedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rangeId != null) 'range_id': rangeId,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (startAyah != null) 'start_ayah': startAyah,
      if (endAyah != null) 'end_ayah': endAyah,
      if (grade != null) 'grade': grade,
      if (localDate != null) 'local_date': localDate,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
    });
  }

  HifzReviewEventsCompanion copyWith(
      {Value<int>? id,
      Value<int>? rangeId,
      Value<int>? surahNumber,
      Value<int>? startAyah,
      Value<int>? endAyah,
      Value<String>? grade,
      Value<String>? localDate,
      Value<DateTime>? reviewedAt}) {
    return HifzReviewEventsCompanion(
      id: id ?? this.id,
      rangeId: rangeId ?? this.rangeId,
      surahNumber: surahNumber ?? this.surahNumber,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      grade: grade ?? this.grade,
      localDate: localDate ?? this.localDate,
      reviewedAt: reviewedAt ?? this.reviewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rangeId.present) {
      map['range_id'] = Variable<int>(rangeId.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (startAyah.present) {
      map['start_ayah'] = Variable<int>(startAyah.value);
    }
    if (endAyah.present) {
      map['end_ayah'] = Variable<int>(endAyah.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HifzReviewEventsCompanion(')
          ..write('id: $id, ')
          ..write('rangeId: $rangeId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('grade: $grade, ')
          ..write('localDate: $localDate, ')
          ..write('reviewedAt: $reviewedAt')
          ..write(')'))
        .toString();
  }
}

class $HifzMistakeLogsTable extends HifzMistakeLogs
    with TableInfo<$HifzMistakeLogsTable, HifzMistakeLogRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HifzMistakeLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _verseKeyMeta =
      const VerificationMeta('verseKey');
  @override
  late final GeneratedColumn<String> verseKey = GeneratedColumn<String>(
      'verse_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ayahNumberMeta =
      const VerificationMeta('ayahNumber');
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
      'ayah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _wordPositionMeta =
      const VerificationMeta('wordPosition');
  @override
  late final GeneratedColumn<int> wordPosition = GeneratedColumn<int>(
      'word_position', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
      'grade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localDateMeta =
      const VerificationMeta('localDate');
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
      'local_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        verseKey,
        surahNumber,
        ayahNumber,
        wordPosition,
        grade,
        localDate,
        recordedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hifz_mistake_logs';
  @override
  VerificationContext validateIntegrity(
      Insertable<HifzMistakeLogRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('verse_key')) {
      context.handle(_verseKeyMeta,
          verseKey.isAcceptableOrUnknown(data['verse_key']!, _verseKeyMeta));
    } else if (isInserting) {
      context.missing(_verseKeyMeta);
    }
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
          _ayahNumberMeta,
          ayahNumber.isAcceptableOrUnknown(
              data['ayah_number']!, _ayahNumberMeta));
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('word_position')) {
      context.handle(
          _wordPositionMeta,
          wordPosition.isAcceptableOrUnknown(
              data['word_position']!, _wordPositionMeta));
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(_localDateMeta,
          localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta));
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HifzMistakeLogRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HifzMistakeLogRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      verseKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}verse_key'])!,
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number'])!,
      ayahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_number'])!,
      wordPosition: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_position']),
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grade'])!,
      localDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_date'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}recorded_at'])!,
    );
  }

  @override
  $HifzMistakeLogsTable createAlias(String alias) {
    return $HifzMistakeLogsTable(attachedDatabase, alias);
  }
}

class HifzMistakeLogRecord extends DataClass
    implements Insertable<HifzMistakeLogRecord> {
  final int id;
  final String verseKey;
  final int surahNumber;
  final int ayahNumber;
  final int? wordPosition;
  final String grade;
  final String localDate;
  final DateTime recordedAt;
  const HifzMistakeLogRecord(
      {required this.id,
      required this.verseKey,
      required this.surahNumber,
      required this.ayahNumber,
      this.wordPosition,
      required this.grade,
      required this.localDate,
      required this.recordedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['verse_key'] = Variable<String>(verseKey);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    if (!nullToAbsent || wordPosition != null) {
      map['word_position'] = Variable<int>(wordPosition);
    }
    map['grade'] = Variable<String>(grade);
    map['local_date'] = Variable<String>(localDate);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  HifzMistakeLogsCompanion toCompanion(bool nullToAbsent) {
    return HifzMistakeLogsCompanion(
      id: Value(id),
      verseKey: Value(verseKey),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      wordPosition: wordPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(wordPosition),
      grade: Value(grade),
      localDate: Value(localDate),
      recordedAt: Value(recordedAt),
    );
  }

  factory HifzMistakeLogRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HifzMistakeLogRecord(
      id: serializer.fromJson<int>(json['id']),
      verseKey: serializer.fromJson<String>(json['verseKey']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      wordPosition: serializer.fromJson<int?>(json['wordPosition']),
      grade: serializer.fromJson<String>(json['grade']),
      localDate: serializer.fromJson<String>(json['localDate']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'verseKey': serializer.toJson<String>(verseKey),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'wordPosition': serializer.toJson<int?>(wordPosition),
      'grade': serializer.toJson<String>(grade),
      'localDate': serializer.toJson<String>(localDate),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  HifzMistakeLogRecord copyWith(
          {int? id,
          String? verseKey,
          int? surahNumber,
          int? ayahNumber,
          Value<int?> wordPosition = const Value.absent(),
          String? grade,
          String? localDate,
          DateTime? recordedAt}) =>
      HifzMistakeLogRecord(
        id: id ?? this.id,
        verseKey: verseKey ?? this.verseKey,
        surahNumber: surahNumber ?? this.surahNumber,
        ayahNumber: ayahNumber ?? this.ayahNumber,
        wordPosition:
            wordPosition.present ? wordPosition.value : this.wordPosition,
        grade: grade ?? this.grade,
        localDate: localDate ?? this.localDate,
        recordedAt: recordedAt ?? this.recordedAt,
      );
  HifzMistakeLogRecord copyWithCompanion(HifzMistakeLogsCompanion data) {
    return HifzMistakeLogRecord(
      id: data.id.present ? data.id.value : this.id,
      verseKey: data.verseKey.present ? data.verseKey.value : this.verseKey,
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      wordPosition: data.wordPosition.present
          ? data.wordPosition.value
          : this.wordPosition,
      grade: data.grade.present ? data.grade.value : this.grade,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HifzMistakeLogRecord(')
          ..write('id: $id, ')
          ..write('verseKey: $verseKey, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('wordPosition: $wordPosition, ')
          ..write('grade: $grade, ')
          ..write('localDate: $localDate, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, verseKey, surahNumber, ayahNumber,
      wordPosition, grade, localDate, recordedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HifzMistakeLogRecord &&
          other.id == this.id &&
          other.verseKey == this.verseKey &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.wordPosition == this.wordPosition &&
          other.grade == this.grade &&
          other.localDate == this.localDate &&
          other.recordedAt == this.recordedAt);
}

class HifzMistakeLogsCompanion extends UpdateCompanion<HifzMistakeLogRecord> {
  final Value<int> id;
  final Value<String> verseKey;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<int?> wordPosition;
  final Value<String> grade;
  final Value<String> localDate;
  final Value<DateTime> recordedAt;
  const HifzMistakeLogsCompanion({
    this.id = const Value.absent(),
    this.verseKey = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.wordPosition = const Value.absent(),
    this.grade = const Value.absent(),
    this.localDate = const Value.absent(),
    this.recordedAt = const Value.absent(),
  });
  HifzMistakeLogsCompanion.insert({
    this.id = const Value.absent(),
    required String verseKey,
    required int surahNumber,
    required int ayahNumber,
    this.wordPosition = const Value.absent(),
    required String grade,
    required String localDate,
    this.recordedAt = const Value.absent(),
  })  : verseKey = Value(verseKey),
        surahNumber = Value(surahNumber),
        ayahNumber = Value(ayahNumber),
        grade = Value(grade),
        localDate = Value(localDate);
  static Insertable<HifzMistakeLogRecord> custom({
    Expression<int>? id,
    Expression<String>? verseKey,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<int>? wordPosition,
    Expression<String>? grade,
    Expression<String>? localDate,
    Expression<DateTime>? recordedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (verseKey != null) 'verse_key': verseKey,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (wordPosition != null) 'word_position': wordPosition,
      if (grade != null) 'grade': grade,
      if (localDate != null) 'local_date': localDate,
      if (recordedAt != null) 'recorded_at': recordedAt,
    });
  }

  HifzMistakeLogsCompanion copyWith(
      {Value<int>? id,
      Value<String>? verseKey,
      Value<int>? surahNumber,
      Value<int>? ayahNumber,
      Value<int?>? wordPosition,
      Value<String>? grade,
      Value<String>? localDate,
      Value<DateTime>? recordedAt}) {
    return HifzMistakeLogsCompanion(
      id: id ?? this.id,
      verseKey: verseKey ?? this.verseKey,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      wordPosition: wordPosition ?? this.wordPosition,
      grade: grade ?? this.grade,
      localDate: localDate ?? this.localDate,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (verseKey.present) {
      map['verse_key'] = Variable<String>(verseKey.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (wordPosition.present) {
      map['word_position'] = Variable<int>(wordPosition.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HifzMistakeLogsCompanion(')
          ..write('id: $id, ')
          ..write('verseKey: $verseKey, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('wordPosition: $wordPosition, ')
          ..write('grade: $grade, ')
          ..write('localDate: $localDate, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }
}

class $HifzActiveSessionsTable extends HifzActiveSessions
    with TableInfo<$HifzActiveSessionsTable, HifzActiveSessionRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HifzActiveSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sessionModeMeta =
      const VerificationMeta('sessionMode');
  @override
  late final GeneratedColumn<String> sessionMode = GeneratedColumn<String>(
      'session_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('recite_by_number'));
  static const VerificationMeta _rangeIdMeta =
      const VerificationMeta('rangeId');
  @override
  late final GeneratedColumn<int> rangeId = GeneratedColumn<int>(
      'range_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _startAyahMeta =
      const VerificationMeta('startAyah');
  @override
  late final GeneratedColumn<int> startAyah = GeneratedColumn<int>(
      'start_ayah', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _endAyahMeta =
      const VerificationMeta('endAyah');
  @override
  late final GeneratedColumn<int> endAyah = GeneratedColumn<int>(
      'end_ayah', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(7));
  static const VerificationMeta _currentIndexMeta =
      const VerificationMeta('currentIndex');
  @override
  late final GeneratedColumn<int> currentIndex = GeneratedColumn<int>(
      'current_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isRevealedMeta =
      const VerificationMeta('isRevealed');
  @override
  late final GeneratedColumn<bool> isRevealed = GeneratedColumn<bool>(
      'is_revealed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_revealed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _tappedMistakeWordPositionMeta =
      const VerificationMeta('tappedMistakeWordPosition');
  @override
  late final GeneratedColumn<int> tappedMistakeWordPosition =
      GeneratedColumn<int>('tapped_mistake_word_position', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _verseKeysJsonMeta =
      const VerificationMeta('verseKeysJson');
  @override
  late final GeneratedColumn<String> verseKeysJson = GeneratedColumn<String>(
      'verse_keys_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _gradesJsonMeta =
      const VerificationMeta('gradesJson');
  @override
  late final GeneratedColumn<String> gradesJson = GeneratedColumn<String>(
      'grades_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        isActive,
        sessionMode,
        rangeId,
        surahNumber,
        startAyah,
        endAyah,
        currentIndex,
        isRevealed,
        tappedMistakeWordPosition,
        verseKeysJson,
        gradesJson,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hifz_active_sessions';
  @override
  VerificationContext validateIntegrity(
      Insertable<HifzActiveSessionRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('session_mode')) {
      context.handle(
          _sessionModeMeta,
          sessionMode.isAcceptableOrUnknown(
              data['session_mode']!, _sessionModeMeta));
    }
    if (data.containsKey('range_id')) {
      context.handle(_rangeIdMeta,
          rangeId.isAcceptableOrUnknown(data['range_id']!, _rangeIdMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    }
    if (data.containsKey('start_ayah')) {
      context.handle(_startAyahMeta,
          startAyah.isAcceptableOrUnknown(data['start_ayah']!, _startAyahMeta));
    }
    if (data.containsKey('end_ayah')) {
      context.handle(_endAyahMeta,
          endAyah.isAcceptableOrUnknown(data['end_ayah']!, _endAyahMeta));
    }
    if (data.containsKey('current_index')) {
      context.handle(
          _currentIndexMeta,
          currentIndex.isAcceptableOrUnknown(
              data['current_index']!, _currentIndexMeta));
    }
    if (data.containsKey('is_revealed')) {
      context.handle(
          _isRevealedMeta,
          isRevealed.isAcceptableOrUnknown(
              data['is_revealed']!, _isRevealedMeta));
    }
    if (data.containsKey('tapped_mistake_word_position')) {
      context.handle(
          _tappedMistakeWordPositionMeta,
          tappedMistakeWordPosition.isAcceptableOrUnknown(
              data['tapped_mistake_word_position']!,
              _tappedMistakeWordPositionMeta));
    }
    if (data.containsKey('verse_keys_json')) {
      context.handle(
          _verseKeysJsonMeta,
          verseKeysJson.isAcceptableOrUnknown(
              data['verse_keys_json']!, _verseKeysJsonMeta));
    }
    if (data.containsKey('grades_json')) {
      context.handle(
          _gradesJsonMeta,
          gradesJson.isAcceptableOrUnknown(
              data['grades_json']!, _gradesJsonMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HifzActiveSessionRecord map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HifzActiveSessionRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      sessionMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_mode'])!,
      rangeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}range_id']),
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number'])!,
      startAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_ayah'])!,
      endAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_ayah'])!,
      currentIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_index'])!,
      isRevealed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_revealed'])!,
      tappedMistakeWordPosition: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}tapped_mistake_word_position']),
      verseKeysJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}verse_keys_json'])!,
      gradesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grades_json'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $HifzActiveSessionsTable createAlias(String alias) {
    return $HifzActiveSessionsTable(attachedDatabase, alias);
  }
}

class HifzActiveSessionRecord extends DataClass
    implements Insertable<HifzActiveSessionRecord> {
  final int id;
  final bool isActive;
  final String sessionMode;
  final int? rangeId;
  final int surahNumber;
  final int startAyah;
  final int endAyah;
  final int currentIndex;
  final bool isRevealed;
  final int? tappedMistakeWordPosition;
  final String verseKeysJson;
  final String gradesJson;
  final DateTime updatedAt;
  const HifzActiveSessionRecord(
      {required this.id,
      required this.isActive,
      required this.sessionMode,
      this.rangeId,
      required this.surahNumber,
      required this.startAyah,
      required this.endAyah,
      required this.currentIndex,
      required this.isRevealed,
      this.tappedMistakeWordPosition,
      required this.verseKeysJson,
      required this.gradesJson,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_active'] = Variable<bool>(isActive);
    map['session_mode'] = Variable<String>(sessionMode);
    if (!nullToAbsent || rangeId != null) {
      map['range_id'] = Variable<int>(rangeId);
    }
    map['surah_number'] = Variable<int>(surahNumber);
    map['start_ayah'] = Variable<int>(startAyah);
    map['end_ayah'] = Variable<int>(endAyah);
    map['current_index'] = Variable<int>(currentIndex);
    map['is_revealed'] = Variable<bool>(isRevealed);
    if (!nullToAbsent || tappedMistakeWordPosition != null) {
      map['tapped_mistake_word_position'] =
          Variable<int>(tappedMistakeWordPosition);
    }
    map['verse_keys_json'] = Variable<String>(verseKeysJson);
    map['grades_json'] = Variable<String>(gradesJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HifzActiveSessionsCompanion toCompanion(bool nullToAbsent) {
    return HifzActiveSessionsCompanion(
      id: Value(id),
      isActive: Value(isActive),
      sessionMode: Value(sessionMode),
      rangeId: rangeId == null && nullToAbsent
          ? const Value.absent()
          : Value(rangeId),
      surahNumber: Value(surahNumber),
      startAyah: Value(startAyah),
      endAyah: Value(endAyah),
      currentIndex: Value(currentIndex),
      isRevealed: Value(isRevealed),
      tappedMistakeWordPosition:
          tappedMistakeWordPosition == null && nullToAbsent
              ? const Value.absent()
              : Value(tappedMistakeWordPosition),
      verseKeysJson: Value(verseKeysJson),
      gradesJson: Value(gradesJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory HifzActiveSessionRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HifzActiveSessionRecord(
      id: serializer.fromJson<int>(json['id']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sessionMode: serializer.fromJson<String>(json['sessionMode']),
      rangeId: serializer.fromJson<int?>(json['rangeId']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      startAyah: serializer.fromJson<int>(json['startAyah']),
      endAyah: serializer.fromJson<int>(json['endAyah']),
      currentIndex: serializer.fromJson<int>(json['currentIndex']),
      isRevealed: serializer.fromJson<bool>(json['isRevealed']),
      tappedMistakeWordPosition:
          serializer.fromJson<int?>(json['tappedMistakeWordPosition']),
      verseKeysJson: serializer.fromJson<String>(json['verseKeysJson']),
      gradesJson: serializer.fromJson<String>(json['gradesJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isActive': serializer.toJson<bool>(isActive),
      'sessionMode': serializer.toJson<String>(sessionMode),
      'rangeId': serializer.toJson<int?>(rangeId),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'startAyah': serializer.toJson<int>(startAyah),
      'endAyah': serializer.toJson<int>(endAyah),
      'currentIndex': serializer.toJson<int>(currentIndex),
      'isRevealed': serializer.toJson<bool>(isRevealed),
      'tappedMistakeWordPosition':
          serializer.toJson<int?>(tappedMistakeWordPosition),
      'verseKeysJson': serializer.toJson<String>(verseKeysJson),
      'gradesJson': serializer.toJson<String>(gradesJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HifzActiveSessionRecord copyWith(
          {int? id,
          bool? isActive,
          String? sessionMode,
          Value<int?> rangeId = const Value.absent(),
          int? surahNumber,
          int? startAyah,
          int? endAyah,
          int? currentIndex,
          bool? isRevealed,
          Value<int?> tappedMistakeWordPosition = const Value.absent(),
          String? verseKeysJson,
          String? gradesJson,
          DateTime? updatedAt}) =>
      HifzActiveSessionRecord(
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        sessionMode: sessionMode ?? this.sessionMode,
        rangeId: rangeId.present ? rangeId.value : this.rangeId,
        surahNumber: surahNumber ?? this.surahNumber,
        startAyah: startAyah ?? this.startAyah,
        endAyah: endAyah ?? this.endAyah,
        currentIndex: currentIndex ?? this.currentIndex,
        isRevealed: isRevealed ?? this.isRevealed,
        tappedMistakeWordPosition: tappedMistakeWordPosition.present
            ? tappedMistakeWordPosition.value
            : this.tappedMistakeWordPosition,
        verseKeysJson: verseKeysJson ?? this.verseKeysJson,
        gradesJson: gradesJson ?? this.gradesJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  HifzActiveSessionRecord copyWithCompanion(HifzActiveSessionsCompanion data) {
    return HifzActiveSessionRecord(
      id: data.id.present ? data.id.value : this.id,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sessionMode:
          data.sessionMode.present ? data.sessionMode.value : this.sessionMode,
      rangeId: data.rangeId.present ? data.rangeId.value : this.rangeId,
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      startAyah: data.startAyah.present ? data.startAyah.value : this.startAyah,
      endAyah: data.endAyah.present ? data.endAyah.value : this.endAyah,
      currentIndex: data.currentIndex.present
          ? data.currentIndex.value
          : this.currentIndex,
      isRevealed:
          data.isRevealed.present ? data.isRevealed.value : this.isRevealed,
      tappedMistakeWordPosition: data.tappedMistakeWordPosition.present
          ? data.tappedMistakeWordPosition.value
          : this.tappedMistakeWordPosition,
      verseKeysJson: data.verseKeysJson.present
          ? data.verseKeysJson.value
          : this.verseKeysJson,
      gradesJson:
          data.gradesJson.present ? data.gradesJson.value : this.gradesJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HifzActiveSessionRecord(')
          ..write('id: $id, ')
          ..write('isActive: $isActive, ')
          ..write('sessionMode: $sessionMode, ')
          ..write('rangeId: $rangeId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('isRevealed: $isRevealed, ')
          ..write('tappedMistakeWordPosition: $tappedMistakeWordPosition, ')
          ..write('verseKeysJson: $verseKeysJson, ')
          ..write('gradesJson: $gradesJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      isActive,
      sessionMode,
      rangeId,
      surahNumber,
      startAyah,
      endAyah,
      currentIndex,
      isRevealed,
      tappedMistakeWordPosition,
      verseKeysJson,
      gradesJson,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HifzActiveSessionRecord &&
          other.id == this.id &&
          other.isActive == this.isActive &&
          other.sessionMode == this.sessionMode &&
          other.rangeId == this.rangeId &&
          other.surahNumber == this.surahNumber &&
          other.startAyah == this.startAyah &&
          other.endAyah == this.endAyah &&
          other.currentIndex == this.currentIndex &&
          other.isRevealed == this.isRevealed &&
          other.tappedMistakeWordPosition == this.tappedMistakeWordPosition &&
          other.verseKeysJson == this.verseKeysJson &&
          other.gradesJson == this.gradesJson &&
          other.updatedAt == this.updatedAt);
}

class HifzActiveSessionsCompanion
    extends UpdateCompanion<HifzActiveSessionRecord> {
  final Value<int> id;
  final Value<bool> isActive;
  final Value<String> sessionMode;
  final Value<int?> rangeId;
  final Value<int> surahNumber;
  final Value<int> startAyah;
  final Value<int> endAyah;
  final Value<int> currentIndex;
  final Value<bool> isRevealed;
  final Value<int?> tappedMistakeWordPosition;
  final Value<String> verseKeysJson;
  final Value<String> gradesJson;
  final Value<DateTime> updatedAt;
  const HifzActiveSessionsCompanion({
    this.id = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sessionMode = const Value.absent(),
    this.rangeId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.currentIndex = const Value.absent(),
    this.isRevealed = const Value.absent(),
    this.tappedMistakeWordPosition = const Value.absent(),
    this.verseKeysJson = const Value.absent(),
    this.gradesJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HifzActiveSessionsCompanion.insert({
    this.id = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sessionMode = const Value.absent(),
    this.rangeId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.currentIndex = const Value.absent(),
    this.isRevealed = const Value.absent(),
    this.tappedMistakeWordPosition = const Value.absent(),
    this.verseKeysJson = const Value.absent(),
    this.gradesJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<HifzActiveSessionRecord> custom({
    Expression<int>? id,
    Expression<bool>? isActive,
    Expression<String>? sessionMode,
    Expression<int>? rangeId,
    Expression<int>? surahNumber,
    Expression<int>? startAyah,
    Expression<int>? endAyah,
    Expression<int>? currentIndex,
    Expression<bool>? isRevealed,
    Expression<int>? tappedMistakeWordPosition,
    Expression<String>? verseKeysJson,
    Expression<String>? gradesJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isActive != null) 'is_active': isActive,
      if (sessionMode != null) 'session_mode': sessionMode,
      if (rangeId != null) 'range_id': rangeId,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (startAyah != null) 'start_ayah': startAyah,
      if (endAyah != null) 'end_ayah': endAyah,
      if (currentIndex != null) 'current_index': currentIndex,
      if (isRevealed != null) 'is_revealed': isRevealed,
      if (tappedMistakeWordPosition != null)
        'tapped_mistake_word_position': tappedMistakeWordPosition,
      if (verseKeysJson != null) 'verse_keys_json': verseKeysJson,
      if (gradesJson != null) 'grades_json': gradesJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HifzActiveSessionsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? isActive,
      Value<String>? sessionMode,
      Value<int?>? rangeId,
      Value<int>? surahNumber,
      Value<int>? startAyah,
      Value<int>? endAyah,
      Value<int>? currentIndex,
      Value<bool>? isRevealed,
      Value<int?>? tappedMistakeWordPosition,
      Value<String>? verseKeysJson,
      Value<String>? gradesJson,
      Value<DateTime>? updatedAt}) {
    return HifzActiveSessionsCompanion(
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
      sessionMode: sessionMode ?? this.sessionMode,
      rangeId: rangeId ?? this.rangeId,
      surahNumber: surahNumber ?? this.surahNumber,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      currentIndex: currentIndex ?? this.currentIndex,
      isRevealed: isRevealed ?? this.isRevealed,
      tappedMistakeWordPosition:
          tappedMistakeWordPosition ?? this.tappedMistakeWordPosition,
      verseKeysJson: verseKeysJson ?? this.verseKeysJson,
      gradesJson: gradesJson ?? this.gradesJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sessionMode.present) {
      map['session_mode'] = Variable<String>(sessionMode.value);
    }
    if (rangeId.present) {
      map['range_id'] = Variable<int>(rangeId.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (startAyah.present) {
      map['start_ayah'] = Variable<int>(startAyah.value);
    }
    if (endAyah.present) {
      map['end_ayah'] = Variable<int>(endAyah.value);
    }
    if (currentIndex.present) {
      map['current_index'] = Variable<int>(currentIndex.value);
    }
    if (isRevealed.present) {
      map['is_revealed'] = Variable<bool>(isRevealed.value);
    }
    if (tappedMistakeWordPosition.present) {
      map['tapped_mistake_word_position'] =
          Variable<int>(tappedMistakeWordPosition.value);
    }
    if (verseKeysJson.present) {
      map['verse_keys_json'] = Variable<String>(verseKeysJson.value);
    }
    if (gradesJson.present) {
      map['grades_json'] = Variable<String>(gradesJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HifzActiveSessionsCompanion(')
          ..write('id: $id, ')
          ..write('isActive: $isActive, ')
          ..write('sessionMode: $sessionMode, ')
          ..write('rangeId: $rangeId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('isRevealed: $isRevealed, ')
          ..write('tappedMistakeWordPosition: $tappedMistakeWordPosition, ')
          ..write('verseKeysJson: $verseKeysJson, ')
          ..write('gradesJson: $gradesJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $ReadingProgressTable readingProgress =
      $ReadingProgressTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $TasbihEventsTable tasbihEvents = $TasbihEventsTable(this);
  late final $TasbihDailyTable tasbihDaily = $TasbihDailyTable(this);
  late final $DownloadsTable downloads = $DownloadsTable(this);
  late final $CachedChaptersTable cachedChapters = $CachedChaptersTable(this);
  late final $CachedVersesTable cachedVerses = $CachedVersesTable(this);
  late final $CachedResourceCatalogsTable cachedResourceCatalogs =
      $CachedResourceCatalogsTable(this);
  late final $CachedVerseAnnotationsTable cachedVerseAnnotations =
      $CachedVerseAnnotationsTable(this);
  late final $AdhkarDailyProgressTable adhkarDailyProgress =
      $AdhkarDailyProgressTable(this);
  late final $HifzMemorizedRangesTable hifzMemorizedRanges =
      $HifzMemorizedRangesTable(this);
  late final $HifzReviewEventsTable hifzReviewEvents =
      $HifzReviewEventsTable(this);
  late final $HifzMistakeLogsTable hifzMistakeLogs =
      $HifzMistakeLogsTable(this);
  late final $HifzActiveSessionsTable hifzActiveSessions =
      $HifzActiveSessionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        settings,
        bookmarks,
        readingProgress,
        notes,
        tasbihEvents,
        tasbihDaily,
        downloads,
        cachedChapters,
        cachedVerses,
        cachedResourceCatalogs,
        cachedVerseAnnotations,
        adhkarDailyProgress,
        hifzMemorizedRanges,
        hifzReviewEvents,
        hifzMistakeLogs,
        hifzActiveSessions
      ];
}

typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  Value<String> languageCode,
  Value<String> themeMode,
  Value<double> textScaleFactor,
  Value<String> prayerCalculationMethod,
  Value<bool> notificationsEnabled,
  Value<double> readerFontSize,
  Value<double> readerLineSpacing,
  Value<bool> keepScreenAwake,
  Value<int> defaultReciterId,
  Value<String> asrMadhab,
  Value<String> highLatitudeRule,
  Value<int> fajrAdjustmentMinutes,
  Value<int> sunriseAdjustmentMinutes,
  Value<int> dhuhrAdjustmentMinutes,
  Value<int> asrAdjustmentMinutes,
  Value<int> maghribAdjustmentMinutes,
  Value<int> ishaAdjustmentMinutes,
  Value<int> hijriAdjustmentDays,
  Value<double> locationLatitude,
  Value<double> locationLongitude,
  Value<String> locationCityNameAr,
  Value<String> locationCityNameEn,
  Value<String> prayerNotificationsConfigJson,
  Value<bool> wirdReminderEnabled,
  Value<int> wirdReminderHour,
  Value<int> wirdReminderMinute,
  Value<bool> fridayReminderEnabled,
  Value<int> fridayReminderHour,
  Value<int> fridayReminderMinute,
  Value<bool> tasbihReminderEnabled,
  Value<int> tasbihReminderHour,
  Value<int> tasbihReminderMinute,
  Value<bool> tasbihHapticsEnabled,
  Value<int> tasbihTargetPreset,
  Value<String> tasbihCustomLabelsJson,
  Value<bool> morningAdhkarReminderEnabled,
  Value<int> morningAdhkarReminderHour,
  Value<int> morningAdhkarReminderMinute,
  Value<bool> eveningAdhkarReminderEnabled,
  Value<int> eveningAdhkarReminderHour,
  Value<int> eveningAdhkarReminderMinute,
  Value<bool> autoStartReadingMode,
  Value<bool> readingModeDndEnabled,
  Value<String> readingModeDndFilter,
  Value<int?> savedPreviousDndFilter,
  Value<bool> iosFocusTipShown,
  Value<bool> onboardingCompleted,
  Value<int> hifzNewVersesPerDayGoal,
  Value<int> hifzReviewRangesPerDayCap,
  Value<int> hifzCatchUpDays,
  Value<bool> hifzCatchUpModeEnabled,
  Value<bool> hifzReminderEnabled,
  Value<int> hifzReminderHour,
  Value<int> hifzReminderMinute,
  Value<DateTime> updatedAt,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  Value<String> languageCode,
  Value<String> themeMode,
  Value<double> textScaleFactor,
  Value<String> prayerCalculationMethod,
  Value<bool> notificationsEnabled,
  Value<double> readerFontSize,
  Value<double> readerLineSpacing,
  Value<bool> keepScreenAwake,
  Value<int> defaultReciterId,
  Value<String> asrMadhab,
  Value<String> highLatitudeRule,
  Value<int> fajrAdjustmentMinutes,
  Value<int> sunriseAdjustmentMinutes,
  Value<int> dhuhrAdjustmentMinutes,
  Value<int> asrAdjustmentMinutes,
  Value<int> maghribAdjustmentMinutes,
  Value<int> ishaAdjustmentMinutes,
  Value<int> hijriAdjustmentDays,
  Value<double> locationLatitude,
  Value<double> locationLongitude,
  Value<String> locationCityNameAr,
  Value<String> locationCityNameEn,
  Value<String> prayerNotificationsConfigJson,
  Value<bool> wirdReminderEnabled,
  Value<int> wirdReminderHour,
  Value<int> wirdReminderMinute,
  Value<bool> fridayReminderEnabled,
  Value<int> fridayReminderHour,
  Value<int> fridayReminderMinute,
  Value<bool> tasbihReminderEnabled,
  Value<int> tasbihReminderHour,
  Value<int> tasbihReminderMinute,
  Value<bool> tasbihHapticsEnabled,
  Value<int> tasbihTargetPreset,
  Value<String> tasbihCustomLabelsJson,
  Value<bool> morningAdhkarReminderEnabled,
  Value<int> morningAdhkarReminderHour,
  Value<int> morningAdhkarReminderMinute,
  Value<bool> eveningAdhkarReminderEnabled,
  Value<int> eveningAdhkarReminderHour,
  Value<int> eveningAdhkarReminderMinute,
  Value<bool> autoStartReadingMode,
  Value<bool> readingModeDndEnabled,
  Value<String> readingModeDndFilter,
  Value<int?> savedPreviousDndFilter,
  Value<bool> iosFocusTipShown,
  Value<bool> onboardingCompleted,
  Value<int> hifzNewVersesPerDayGoal,
  Value<int> hifzReviewRangesPerDayCap,
  Value<int> hifzCatchUpDays,
  Value<bool> hifzCatchUpModeEnabled,
  Value<bool> hifzReminderEnabled,
  Value<int> hifzReminderHour,
  Value<int> hifzReminderMinute,
  Value<DateTime> updatedAt,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get textScaleFactor => $composableBuilder(
      column: $table.textScaleFactor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prayerCalculationMethod => $composableBuilder(
      column: $table.prayerCalculationMethod,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get readerFontSize => $composableBuilder(
      column: $table.readerFontSize,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get readerLineSpacing => $composableBuilder(
      column: $table.readerLineSpacing,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get keepScreenAwake => $composableBuilder(
      column: $table.keepScreenAwake,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defaultReciterId => $composableBuilder(
      column: $table.defaultReciterId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get asrMadhab => $composableBuilder(
      column: $table.asrMadhab, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get highLatitudeRule => $composableBuilder(
      column: $table.highLatitudeRule,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fajrAdjustmentMinutes => $composableBuilder(
      column: $table.fajrAdjustmentMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sunriseAdjustmentMinutes => $composableBuilder(
      column: $table.sunriseAdjustmentMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dhuhrAdjustmentMinutes => $composableBuilder(
      column: $table.dhuhrAdjustmentMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get asrAdjustmentMinutes => $composableBuilder(
      column: $table.asrAdjustmentMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maghribAdjustmentMinutes => $composableBuilder(
      column: $table.maghribAdjustmentMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ishaAdjustmentMinutes => $composableBuilder(
      column: $table.ishaAdjustmentMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hijriAdjustmentDays => $composableBuilder(
      column: $table.hijriAdjustmentDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLatitude => $composableBuilder(
      column: $table.locationLatitude,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLongitude => $composableBuilder(
      column: $table.locationLongitude,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationCityNameAr => $composableBuilder(
      column: $table.locationCityNameAr,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationCityNameEn => $composableBuilder(
      column: $table.locationCityNameEn,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prayerNotificationsConfigJson => $composableBuilder(
      column: $table.prayerNotificationsConfigJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get wirdReminderEnabled => $composableBuilder(
      column: $table.wirdReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wirdReminderHour => $composableBuilder(
      column: $table.wirdReminderHour,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wirdReminderMinute => $composableBuilder(
      column: $table.wirdReminderMinute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get fridayReminderEnabled => $composableBuilder(
      column: $table.fridayReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fridayReminderHour => $composableBuilder(
      column: $table.fridayReminderHour,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fridayReminderMinute => $composableBuilder(
      column: $table.fridayReminderMinute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get tasbihReminderEnabled => $composableBuilder(
      column: $table.tasbihReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tasbihReminderHour => $composableBuilder(
      column: $table.tasbihReminderHour,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tasbihReminderMinute => $composableBuilder(
      column: $table.tasbihReminderMinute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get tasbihHapticsEnabled => $composableBuilder(
      column: $table.tasbihHapticsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tasbihTargetPreset => $composableBuilder(
      column: $table.tasbihTargetPreset,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tasbihCustomLabelsJson => $composableBuilder(
      column: $table.tasbihCustomLabelsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get morningAdhkarReminderEnabled => $composableBuilder(
      column: $table.morningAdhkarReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get morningAdhkarReminderHour => $composableBuilder(
      column: $table.morningAdhkarReminderHour,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get morningAdhkarReminderMinute => $composableBuilder(
      column: $table.morningAdhkarReminderMinute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get eveningAdhkarReminderEnabled => $composableBuilder(
      column: $table.eveningAdhkarReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get eveningAdhkarReminderHour => $composableBuilder(
      column: $table.eveningAdhkarReminderHour,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get eveningAdhkarReminderMinute => $composableBuilder(
      column: $table.eveningAdhkarReminderMinute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get autoStartReadingMode => $composableBuilder(
      column: $table.autoStartReadingMode,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get readingModeDndEnabled => $composableBuilder(
      column: $table.readingModeDndEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get readingModeDndFilter => $composableBuilder(
      column: $table.readingModeDndFilter,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get savedPreviousDndFilter => $composableBuilder(
      column: $table.savedPreviousDndFilter,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get iosFocusTipShown => $composableBuilder(
      column: $table.iosFocusTipShown,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
      column: $table.onboardingCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hifzNewVersesPerDayGoal => $composableBuilder(
      column: $table.hifzNewVersesPerDayGoal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hifzReviewRangesPerDayCap => $composableBuilder(
      column: $table.hifzReviewRangesPerDayCap,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hifzCatchUpDays => $composableBuilder(
      column: $table.hifzCatchUpDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hifzCatchUpModeEnabled => $composableBuilder(
      column: $table.hifzCatchUpModeEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hifzReminderEnabled => $composableBuilder(
      column: $table.hifzReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hifzReminderHour => $composableBuilder(
      column: $table.hifzReminderHour,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hifzReminderMinute => $composableBuilder(
      column: $table.hifzReminderMinute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageCode => $composableBuilder(
      column: $table.languageCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get textScaleFactor => $composableBuilder(
      column: $table.textScaleFactor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prayerCalculationMethod => $composableBuilder(
      column: $table.prayerCalculationMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get readerFontSize => $composableBuilder(
      column: $table.readerFontSize,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get readerLineSpacing => $composableBuilder(
      column: $table.readerLineSpacing,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get keepScreenAwake => $composableBuilder(
      column: $table.keepScreenAwake,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultReciterId => $composableBuilder(
      column: $table.defaultReciterId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get asrMadhab => $composableBuilder(
      column: $table.asrMadhab, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get highLatitudeRule => $composableBuilder(
      column: $table.highLatitudeRule,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fajrAdjustmentMinutes => $composableBuilder(
      column: $table.fajrAdjustmentMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sunriseAdjustmentMinutes => $composableBuilder(
      column: $table.sunriseAdjustmentMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dhuhrAdjustmentMinutes => $composableBuilder(
      column: $table.dhuhrAdjustmentMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get asrAdjustmentMinutes => $composableBuilder(
      column: $table.asrAdjustmentMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maghribAdjustmentMinutes => $composableBuilder(
      column: $table.maghribAdjustmentMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ishaAdjustmentMinutes => $composableBuilder(
      column: $table.ishaAdjustmentMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hijriAdjustmentDays => $composableBuilder(
      column: $table.hijriAdjustmentDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLatitude => $composableBuilder(
      column: $table.locationLatitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLongitude => $composableBuilder(
      column: $table.locationLongitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationCityNameAr => $composableBuilder(
      column: $table.locationCityNameAr,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationCityNameEn => $composableBuilder(
      column: $table.locationCityNameEn,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prayerNotificationsConfigJson =>
      $composableBuilder(
          column: $table.prayerNotificationsConfigJson,
          builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get wirdReminderEnabled => $composableBuilder(
      column: $table.wirdReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wirdReminderHour => $composableBuilder(
      column: $table.wirdReminderHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wirdReminderMinute => $composableBuilder(
      column: $table.wirdReminderMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get fridayReminderEnabled => $composableBuilder(
      column: $table.fridayReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fridayReminderHour => $composableBuilder(
      column: $table.fridayReminderHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fridayReminderMinute => $composableBuilder(
      column: $table.fridayReminderMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get tasbihReminderEnabled => $composableBuilder(
      column: $table.tasbihReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tasbihReminderHour => $composableBuilder(
      column: $table.tasbihReminderHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tasbihReminderMinute => $composableBuilder(
      column: $table.tasbihReminderMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get tasbihHapticsEnabled => $composableBuilder(
      column: $table.tasbihHapticsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tasbihTargetPreset => $composableBuilder(
      column: $table.tasbihTargetPreset,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tasbihCustomLabelsJson => $composableBuilder(
      column: $table.tasbihCustomLabelsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get morningAdhkarReminderEnabled => $composableBuilder(
      column: $table.morningAdhkarReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get morningAdhkarReminderHour => $composableBuilder(
      column: $table.morningAdhkarReminderHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get morningAdhkarReminderMinute => $composableBuilder(
      column: $table.morningAdhkarReminderMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get eveningAdhkarReminderEnabled => $composableBuilder(
      column: $table.eveningAdhkarReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get eveningAdhkarReminderHour => $composableBuilder(
      column: $table.eveningAdhkarReminderHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get eveningAdhkarReminderMinute => $composableBuilder(
      column: $table.eveningAdhkarReminderMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get autoStartReadingMode => $composableBuilder(
      column: $table.autoStartReadingMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get readingModeDndEnabled => $composableBuilder(
      column: $table.readingModeDndEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get readingModeDndFilter => $composableBuilder(
      column: $table.readingModeDndFilter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get savedPreviousDndFilter => $composableBuilder(
      column: $table.savedPreviousDndFilter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get iosFocusTipShown => $composableBuilder(
      column: $table.iosFocusTipShown,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
      column: $table.onboardingCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hifzNewVersesPerDayGoal => $composableBuilder(
      column: $table.hifzNewVersesPerDayGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hifzReviewRangesPerDayCap => $composableBuilder(
      column: $table.hifzReviewRangesPerDayCap,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hifzCatchUpDays => $composableBuilder(
      column: $table.hifzCatchUpDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hifzCatchUpModeEnabled => $composableBuilder(
      column: $table.hifzCatchUpModeEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hifzReminderEnabled => $composableBuilder(
      column: $table.hifzReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hifzReminderHour => $composableBuilder(
      column: $table.hifzReminderHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hifzReminderMinute => $composableBuilder(
      column: $table.hifzReminderMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<double> get textScaleFactor => $composableBuilder(
      column: $table.textScaleFactor, builder: (column) => column);

  GeneratedColumn<String> get prayerCalculationMethod => $composableBuilder(
      column: $table.prayerCalculationMethod, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled, builder: (column) => column);

  GeneratedColumn<double> get readerFontSize => $composableBuilder(
      column: $table.readerFontSize, builder: (column) => column);

  GeneratedColumn<double> get readerLineSpacing => $composableBuilder(
      column: $table.readerLineSpacing, builder: (column) => column);

  GeneratedColumn<bool> get keepScreenAwake => $composableBuilder(
      column: $table.keepScreenAwake, builder: (column) => column);

  GeneratedColumn<int> get defaultReciterId => $composableBuilder(
      column: $table.defaultReciterId, builder: (column) => column);

  GeneratedColumn<String> get asrMadhab =>
      $composableBuilder(column: $table.asrMadhab, builder: (column) => column);

  GeneratedColumn<String> get highLatitudeRule => $composableBuilder(
      column: $table.highLatitudeRule, builder: (column) => column);

  GeneratedColumn<int> get fajrAdjustmentMinutes => $composableBuilder(
      column: $table.fajrAdjustmentMinutes, builder: (column) => column);

  GeneratedColumn<int> get sunriseAdjustmentMinutes => $composableBuilder(
      column: $table.sunriseAdjustmentMinutes, builder: (column) => column);

  GeneratedColumn<int> get dhuhrAdjustmentMinutes => $composableBuilder(
      column: $table.dhuhrAdjustmentMinutes, builder: (column) => column);

  GeneratedColumn<int> get asrAdjustmentMinutes => $composableBuilder(
      column: $table.asrAdjustmentMinutes, builder: (column) => column);

  GeneratedColumn<int> get maghribAdjustmentMinutes => $composableBuilder(
      column: $table.maghribAdjustmentMinutes, builder: (column) => column);

  GeneratedColumn<int> get ishaAdjustmentMinutes => $composableBuilder(
      column: $table.ishaAdjustmentMinutes, builder: (column) => column);

  GeneratedColumn<int> get hijriAdjustmentDays => $composableBuilder(
      column: $table.hijriAdjustmentDays, builder: (column) => column);

  GeneratedColumn<double> get locationLatitude => $composableBuilder(
      column: $table.locationLatitude, builder: (column) => column);

  GeneratedColumn<double> get locationLongitude => $composableBuilder(
      column: $table.locationLongitude, builder: (column) => column);

  GeneratedColumn<String> get locationCityNameAr => $composableBuilder(
      column: $table.locationCityNameAr, builder: (column) => column);

  GeneratedColumn<String> get locationCityNameEn => $composableBuilder(
      column: $table.locationCityNameEn, builder: (column) => column);

  GeneratedColumn<String> get prayerNotificationsConfigJson =>
      $composableBuilder(
          column: $table.prayerNotificationsConfigJson,
          builder: (column) => column);

  GeneratedColumn<bool> get wirdReminderEnabled => $composableBuilder(
      column: $table.wirdReminderEnabled, builder: (column) => column);

  GeneratedColumn<int> get wirdReminderHour => $composableBuilder(
      column: $table.wirdReminderHour, builder: (column) => column);

  GeneratedColumn<int> get wirdReminderMinute => $composableBuilder(
      column: $table.wirdReminderMinute, builder: (column) => column);

  GeneratedColumn<bool> get fridayReminderEnabled => $composableBuilder(
      column: $table.fridayReminderEnabled, builder: (column) => column);

  GeneratedColumn<int> get fridayReminderHour => $composableBuilder(
      column: $table.fridayReminderHour, builder: (column) => column);

  GeneratedColumn<int> get fridayReminderMinute => $composableBuilder(
      column: $table.fridayReminderMinute, builder: (column) => column);

  GeneratedColumn<bool> get tasbihReminderEnabled => $composableBuilder(
      column: $table.tasbihReminderEnabled, builder: (column) => column);

  GeneratedColumn<int> get tasbihReminderHour => $composableBuilder(
      column: $table.tasbihReminderHour, builder: (column) => column);

  GeneratedColumn<int> get tasbihReminderMinute => $composableBuilder(
      column: $table.tasbihReminderMinute, builder: (column) => column);

  GeneratedColumn<bool> get tasbihHapticsEnabled => $composableBuilder(
      column: $table.tasbihHapticsEnabled, builder: (column) => column);

  GeneratedColumn<int> get tasbihTargetPreset => $composableBuilder(
      column: $table.tasbihTargetPreset, builder: (column) => column);

  GeneratedColumn<String> get tasbihCustomLabelsJson => $composableBuilder(
      column: $table.tasbihCustomLabelsJson, builder: (column) => column);

  GeneratedColumn<bool> get morningAdhkarReminderEnabled => $composableBuilder(
      column: $table.morningAdhkarReminderEnabled, builder: (column) => column);

  GeneratedColumn<int> get morningAdhkarReminderHour => $composableBuilder(
      column: $table.morningAdhkarReminderHour, builder: (column) => column);

  GeneratedColumn<int> get morningAdhkarReminderMinute => $composableBuilder(
      column: $table.morningAdhkarReminderMinute, builder: (column) => column);

  GeneratedColumn<bool> get eveningAdhkarReminderEnabled => $composableBuilder(
      column: $table.eveningAdhkarReminderEnabled, builder: (column) => column);

  GeneratedColumn<int> get eveningAdhkarReminderHour => $composableBuilder(
      column: $table.eveningAdhkarReminderHour, builder: (column) => column);

  GeneratedColumn<int> get eveningAdhkarReminderMinute => $composableBuilder(
      column: $table.eveningAdhkarReminderMinute, builder: (column) => column);

  GeneratedColumn<bool> get autoStartReadingMode => $composableBuilder(
      column: $table.autoStartReadingMode, builder: (column) => column);

  GeneratedColumn<bool> get readingModeDndEnabled => $composableBuilder(
      column: $table.readingModeDndEnabled, builder: (column) => column);

  GeneratedColumn<String> get readingModeDndFilter => $composableBuilder(
      column: $table.readingModeDndFilter, builder: (column) => column);

  GeneratedColumn<int> get savedPreviousDndFilter => $composableBuilder(
      column: $table.savedPreviousDndFilter, builder: (column) => column);

  GeneratedColumn<bool> get iosFocusTipShown => $composableBuilder(
      column: $table.iosFocusTipShown, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
      column: $table.onboardingCompleted, builder: (column) => column);

  GeneratedColumn<int> get hifzNewVersesPerDayGoal => $composableBuilder(
      column: $table.hifzNewVersesPerDayGoal, builder: (column) => column);

  GeneratedColumn<int> get hifzReviewRangesPerDayCap => $composableBuilder(
      column: $table.hifzReviewRangesPerDayCap, builder: (column) => column);

  GeneratedColumn<int> get hifzCatchUpDays => $composableBuilder(
      column: $table.hifzCatchUpDays, builder: (column) => column);

  GeneratedColumn<bool> get hifzCatchUpModeEnabled => $composableBuilder(
      column: $table.hifzCatchUpModeEnabled, builder: (column) => column);

  GeneratedColumn<bool> get hifzReminderEnabled => $composableBuilder(
      column: $table.hifzReminderEnabled, builder: (column) => column);

  GeneratedColumn<int> get hifzReminderHour => $composableBuilder(
      column: $table.hifzReminderHour, builder: (column) => column);

  GeneratedColumn<int> get hifzReminderMinute => $composableBuilder(
      column: $table.hifzReminderMinute, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    SettingRecord,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (
      SettingRecord,
      BaseReferences<_$AppDatabase, $SettingsTable, SettingRecord>
    ),
    SettingRecord,
    PrefetchHooks Function()> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<double> textScaleFactor = const Value.absent(),
            Value<String> prayerCalculationMethod = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<double> readerFontSize = const Value.absent(),
            Value<double> readerLineSpacing = const Value.absent(),
            Value<bool> keepScreenAwake = const Value.absent(),
            Value<int> defaultReciterId = const Value.absent(),
            Value<String> asrMadhab = const Value.absent(),
            Value<String> highLatitudeRule = const Value.absent(),
            Value<int> fajrAdjustmentMinutes = const Value.absent(),
            Value<int> sunriseAdjustmentMinutes = const Value.absent(),
            Value<int> dhuhrAdjustmentMinutes = const Value.absent(),
            Value<int> asrAdjustmentMinutes = const Value.absent(),
            Value<int> maghribAdjustmentMinutes = const Value.absent(),
            Value<int> ishaAdjustmentMinutes = const Value.absent(),
            Value<int> hijriAdjustmentDays = const Value.absent(),
            Value<double> locationLatitude = const Value.absent(),
            Value<double> locationLongitude = const Value.absent(),
            Value<String> locationCityNameAr = const Value.absent(),
            Value<String> locationCityNameEn = const Value.absent(),
            Value<String> prayerNotificationsConfigJson = const Value.absent(),
            Value<bool> wirdReminderEnabled = const Value.absent(),
            Value<int> wirdReminderHour = const Value.absent(),
            Value<int> wirdReminderMinute = const Value.absent(),
            Value<bool> fridayReminderEnabled = const Value.absent(),
            Value<int> fridayReminderHour = const Value.absent(),
            Value<int> fridayReminderMinute = const Value.absent(),
            Value<bool> tasbihReminderEnabled = const Value.absent(),
            Value<int> tasbihReminderHour = const Value.absent(),
            Value<int> tasbihReminderMinute = const Value.absent(),
            Value<bool> tasbihHapticsEnabled = const Value.absent(),
            Value<int> tasbihTargetPreset = const Value.absent(),
            Value<String> tasbihCustomLabelsJson = const Value.absent(),
            Value<bool> morningAdhkarReminderEnabled = const Value.absent(),
            Value<int> morningAdhkarReminderHour = const Value.absent(),
            Value<int> morningAdhkarReminderMinute = const Value.absent(),
            Value<bool> eveningAdhkarReminderEnabled = const Value.absent(),
            Value<int> eveningAdhkarReminderHour = const Value.absent(),
            Value<int> eveningAdhkarReminderMinute = const Value.absent(),
            Value<bool> autoStartReadingMode = const Value.absent(),
            Value<bool> readingModeDndEnabled = const Value.absent(),
            Value<String> readingModeDndFilter = const Value.absent(),
            Value<int?> savedPreviousDndFilter = const Value.absent(),
            Value<bool> iosFocusTipShown = const Value.absent(),
            Value<bool> onboardingCompleted = const Value.absent(),
            Value<int> hifzNewVersesPerDayGoal = const Value.absent(),
            Value<int> hifzReviewRangesPerDayCap = const Value.absent(),
            Value<int> hifzCatchUpDays = const Value.absent(),
            Value<bool> hifzCatchUpModeEnabled = const Value.absent(),
            Value<bool> hifzReminderEnabled = const Value.absent(),
            Value<int> hifzReminderHour = const Value.absent(),
            Value<int> hifzReminderMinute = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              SettingsCompanion(
            id: id,
            languageCode: languageCode,
            themeMode: themeMode,
            textScaleFactor: textScaleFactor,
            prayerCalculationMethod: prayerCalculationMethod,
            notificationsEnabled: notificationsEnabled,
            readerFontSize: readerFontSize,
            readerLineSpacing: readerLineSpacing,
            keepScreenAwake: keepScreenAwake,
            defaultReciterId: defaultReciterId,
            asrMadhab: asrMadhab,
            highLatitudeRule: highLatitudeRule,
            fajrAdjustmentMinutes: fajrAdjustmentMinutes,
            sunriseAdjustmentMinutes: sunriseAdjustmentMinutes,
            dhuhrAdjustmentMinutes: dhuhrAdjustmentMinutes,
            asrAdjustmentMinutes: asrAdjustmentMinutes,
            maghribAdjustmentMinutes: maghribAdjustmentMinutes,
            ishaAdjustmentMinutes: ishaAdjustmentMinutes,
            hijriAdjustmentDays: hijriAdjustmentDays,
            locationLatitude: locationLatitude,
            locationLongitude: locationLongitude,
            locationCityNameAr: locationCityNameAr,
            locationCityNameEn: locationCityNameEn,
            prayerNotificationsConfigJson: prayerNotificationsConfigJson,
            wirdReminderEnabled: wirdReminderEnabled,
            wirdReminderHour: wirdReminderHour,
            wirdReminderMinute: wirdReminderMinute,
            fridayReminderEnabled: fridayReminderEnabled,
            fridayReminderHour: fridayReminderHour,
            fridayReminderMinute: fridayReminderMinute,
            tasbihReminderEnabled: tasbihReminderEnabled,
            tasbihReminderHour: tasbihReminderHour,
            tasbihReminderMinute: tasbihReminderMinute,
            tasbihHapticsEnabled: tasbihHapticsEnabled,
            tasbihTargetPreset: tasbihTargetPreset,
            tasbihCustomLabelsJson: tasbihCustomLabelsJson,
            morningAdhkarReminderEnabled: morningAdhkarReminderEnabled,
            morningAdhkarReminderHour: morningAdhkarReminderHour,
            morningAdhkarReminderMinute: morningAdhkarReminderMinute,
            eveningAdhkarReminderEnabled: eveningAdhkarReminderEnabled,
            eveningAdhkarReminderHour: eveningAdhkarReminderHour,
            eveningAdhkarReminderMinute: eveningAdhkarReminderMinute,
            autoStartReadingMode: autoStartReadingMode,
            readingModeDndEnabled: readingModeDndEnabled,
            readingModeDndFilter: readingModeDndFilter,
            savedPreviousDndFilter: savedPreviousDndFilter,
            iosFocusTipShown: iosFocusTipShown,
            onboardingCompleted: onboardingCompleted,
            hifzNewVersesPerDayGoal: hifzNewVersesPerDayGoal,
            hifzReviewRangesPerDayCap: hifzReviewRangesPerDayCap,
            hifzCatchUpDays: hifzCatchUpDays,
            hifzCatchUpModeEnabled: hifzCatchUpModeEnabled,
            hifzReminderEnabled: hifzReminderEnabled,
            hifzReminderHour: hifzReminderHour,
            hifzReminderMinute: hifzReminderMinute,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<double> textScaleFactor = const Value.absent(),
            Value<String> prayerCalculationMethod = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<double> readerFontSize = const Value.absent(),
            Value<double> readerLineSpacing = const Value.absent(),
            Value<bool> keepScreenAwake = const Value.absent(),
            Value<int> defaultReciterId = const Value.absent(),
            Value<String> asrMadhab = const Value.absent(),
            Value<String> highLatitudeRule = const Value.absent(),
            Value<int> fajrAdjustmentMinutes = const Value.absent(),
            Value<int> sunriseAdjustmentMinutes = const Value.absent(),
            Value<int> dhuhrAdjustmentMinutes = const Value.absent(),
            Value<int> asrAdjustmentMinutes = const Value.absent(),
            Value<int> maghribAdjustmentMinutes = const Value.absent(),
            Value<int> ishaAdjustmentMinutes = const Value.absent(),
            Value<int> hijriAdjustmentDays = const Value.absent(),
            Value<double> locationLatitude = const Value.absent(),
            Value<double> locationLongitude = const Value.absent(),
            Value<String> locationCityNameAr = const Value.absent(),
            Value<String> locationCityNameEn = const Value.absent(),
            Value<String> prayerNotificationsConfigJson = const Value.absent(),
            Value<bool> wirdReminderEnabled = const Value.absent(),
            Value<int> wirdReminderHour = const Value.absent(),
            Value<int> wirdReminderMinute = const Value.absent(),
            Value<bool> fridayReminderEnabled = const Value.absent(),
            Value<int> fridayReminderHour = const Value.absent(),
            Value<int> fridayReminderMinute = const Value.absent(),
            Value<bool> tasbihReminderEnabled = const Value.absent(),
            Value<int> tasbihReminderHour = const Value.absent(),
            Value<int> tasbihReminderMinute = const Value.absent(),
            Value<bool> tasbihHapticsEnabled = const Value.absent(),
            Value<int> tasbihTargetPreset = const Value.absent(),
            Value<String> tasbihCustomLabelsJson = const Value.absent(),
            Value<bool> morningAdhkarReminderEnabled = const Value.absent(),
            Value<int> morningAdhkarReminderHour = const Value.absent(),
            Value<int> morningAdhkarReminderMinute = const Value.absent(),
            Value<bool> eveningAdhkarReminderEnabled = const Value.absent(),
            Value<int> eveningAdhkarReminderHour = const Value.absent(),
            Value<int> eveningAdhkarReminderMinute = const Value.absent(),
            Value<bool> autoStartReadingMode = const Value.absent(),
            Value<bool> readingModeDndEnabled = const Value.absent(),
            Value<String> readingModeDndFilter = const Value.absent(),
            Value<int?> savedPreviousDndFilter = const Value.absent(),
            Value<bool> iosFocusTipShown = const Value.absent(),
            Value<bool> onboardingCompleted = const Value.absent(),
            Value<int> hifzNewVersesPerDayGoal = const Value.absent(),
            Value<int> hifzReviewRangesPerDayCap = const Value.absent(),
            Value<int> hifzCatchUpDays = const Value.absent(),
            Value<bool> hifzCatchUpModeEnabled = const Value.absent(),
            Value<bool> hifzReminderEnabled = const Value.absent(),
            Value<int> hifzReminderHour = const Value.absent(),
            Value<int> hifzReminderMinute = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
            id: id,
            languageCode: languageCode,
            themeMode: themeMode,
            textScaleFactor: textScaleFactor,
            prayerCalculationMethod: prayerCalculationMethod,
            notificationsEnabled: notificationsEnabled,
            readerFontSize: readerFontSize,
            readerLineSpacing: readerLineSpacing,
            keepScreenAwake: keepScreenAwake,
            defaultReciterId: defaultReciterId,
            asrMadhab: asrMadhab,
            highLatitudeRule: highLatitudeRule,
            fajrAdjustmentMinutes: fajrAdjustmentMinutes,
            sunriseAdjustmentMinutes: sunriseAdjustmentMinutes,
            dhuhrAdjustmentMinutes: dhuhrAdjustmentMinutes,
            asrAdjustmentMinutes: asrAdjustmentMinutes,
            maghribAdjustmentMinutes: maghribAdjustmentMinutes,
            ishaAdjustmentMinutes: ishaAdjustmentMinutes,
            hijriAdjustmentDays: hijriAdjustmentDays,
            locationLatitude: locationLatitude,
            locationLongitude: locationLongitude,
            locationCityNameAr: locationCityNameAr,
            locationCityNameEn: locationCityNameEn,
            prayerNotificationsConfigJson: prayerNotificationsConfigJson,
            wirdReminderEnabled: wirdReminderEnabled,
            wirdReminderHour: wirdReminderHour,
            wirdReminderMinute: wirdReminderMinute,
            fridayReminderEnabled: fridayReminderEnabled,
            fridayReminderHour: fridayReminderHour,
            fridayReminderMinute: fridayReminderMinute,
            tasbihReminderEnabled: tasbihReminderEnabled,
            tasbihReminderHour: tasbihReminderHour,
            tasbihReminderMinute: tasbihReminderMinute,
            tasbihHapticsEnabled: tasbihHapticsEnabled,
            tasbihTargetPreset: tasbihTargetPreset,
            tasbihCustomLabelsJson: tasbihCustomLabelsJson,
            morningAdhkarReminderEnabled: morningAdhkarReminderEnabled,
            morningAdhkarReminderHour: morningAdhkarReminderHour,
            morningAdhkarReminderMinute: morningAdhkarReminderMinute,
            eveningAdhkarReminderEnabled: eveningAdhkarReminderEnabled,
            eveningAdhkarReminderHour: eveningAdhkarReminderHour,
            eveningAdhkarReminderMinute: eveningAdhkarReminderMinute,
            autoStartReadingMode: autoStartReadingMode,
            readingModeDndEnabled: readingModeDndEnabled,
            readingModeDndFilter: readingModeDndFilter,
            savedPreviousDndFilter: savedPreviousDndFilter,
            iosFocusTipShown: iosFocusTipShown,
            onboardingCompleted: onboardingCompleted,
            hifzNewVersesPerDayGoal: hifzNewVersesPerDayGoal,
            hifzReviewRangesPerDayCap: hifzReviewRangesPerDayCap,
            hifzCatchUpDays: hifzCatchUpDays,
            hifzCatchUpModeEnabled: hifzCatchUpModeEnabled,
            hifzReminderEnabled: hifzReminderEnabled,
            hifzReminderHour: hifzReminderHour,
            hifzReminderMinute: hifzReminderMinute,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTable,
    SettingRecord,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (
      SettingRecord,
      BaseReferences<_$AppDatabase, $SettingsTable, SettingRecord>
    ),
    SettingRecord,
    PrefetchHooks Function()>;
typedef $$BookmarksTableCreateCompanionBuilder = BookmarksCompanion Function({
  Value<int> id,
  required int surahNumber,
  required int ayahNumber,
  required int pageNumber,
  Value<String> colorHex,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$BookmarksTableUpdateCompanionBuilder = BookmarksCompanion Function({
  Value<int> id,
  Value<int> surahNumber,
  Value<int> ayahNumber,
  Value<int> pageNumber,
  Value<String> colorHex,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BookmarksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BookmarksTable,
    BookmarkRecord,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (
      BookmarkRecord,
      BaseReferences<_$AppDatabase, $BookmarksTable, BookmarkRecord>
    ),
    BookmarkRecord,
    PrefetchHooks Function()> {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> ayahNumber = const Value.absent(),
            Value<int> pageNumber = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              BookmarksCompanion(
            id: id,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            pageNumber: pageNumber,
            colorHex: colorHex,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int surahNumber,
            required int ayahNumber,
            required int pageNumber,
            Value<String> colorHex = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              BookmarksCompanion.insert(
            id: id,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            pageNumber: pageNumber,
            colorHex: colorHex,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BookmarksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BookmarksTable,
    BookmarkRecord,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (
      BookmarkRecord,
      BaseReferences<_$AppDatabase, $BookmarksTable, BookmarkRecord>
    ),
    BookmarkRecord,
    PrefetchHooks Function()>;
typedef $$ReadingProgressTableCreateCompanionBuilder = ReadingProgressCompanion
    Function({
  Value<int> id,
  Value<int> surahNumber,
  Value<int> ayahNumber,
  Value<int> pageNumber,
  Value<int> juzNumber,
  Value<int> khatmahTargetDays,
  Value<DateTime?> khatmahStartDate,
  Value<DateTime> updatedAt,
});
typedef $$ReadingProgressTableUpdateCompanionBuilder = ReadingProgressCompanion
    Function({
  Value<int> id,
  Value<int> surahNumber,
  Value<int> ayahNumber,
  Value<int> pageNumber,
  Value<int> juzNumber,
  Value<int> khatmahTargetDays,
  Value<DateTime?> khatmahStartDate,
  Value<DateTime> updatedAt,
});

class $$ReadingProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get juzNumber => $composableBuilder(
      column: $table.juzNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get khatmahTargetDays => $composableBuilder(
      column: $table.khatmahTargetDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get khatmahStartDate => $composableBuilder(
      column: $table.khatmahStartDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ReadingProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get juzNumber => $composableBuilder(
      column: $table.juzNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get khatmahTargetDays => $composableBuilder(
      column: $table.khatmahTargetDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get khatmahStartDate => $composableBuilder(
      column: $table.khatmahStartDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ReadingProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => column);

  GeneratedColumn<int> get juzNumber =>
      $composableBuilder(column: $table.juzNumber, builder: (column) => column);

  GeneratedColumn<int> get khatmahTargetDays => $composableBuilder(
      column: $table.khatmahTargetDays, builder: (column) => column);

  GeneratedColumn<DateTime> get khatmahStartDate => $composableBuilder(
      column: $table.khatmahStartDate, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ReadingProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReadingProgressTable,
    ReadingProgressRecord,
    $$ReadingProgressTableFilterComposer,
    $$ReadingProgressTableOrderingComposer,
    $$ReadingProgressTableAnnotationComposer,
    $$ReadingProgressTableCreateCompanionBuilder,
    $$ReadingProgressTableUpdateCompanionBuilder,
    (
      ReadingProgressRecord,
      BaseReferences<_$AppDatabase, $ReadingProgressTable,
          ReadingProgressRecord>
    ),
    ReadingProgressRecord,
    PrefetchHooks Function()> {
  $$ReadingProgressTableTableManager(
      _$AppDatabase db, $ReadingProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> ayahNumber = const Value.absent(),
            Value<int> pageNumber = const Value.absent(),
            Value<int> juzNumber = const Value.absent(),
            Value<int> khatmahTargetDays = const Value.absent(),
            Value<DateTime?> khatmahStartDate = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ReadingProgressCompanion(
            id: id,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            pageNumber: pageNumber,
            juzNumber: juzNumber,
            khatmahTargetDays: khatmahTargetDays,
            khatmahStartDate: khatmahStartDate,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> ayahNumber = const Value.absent(),
            Value<int> pageNumber = const Value.absent(),
            Value<int> juzNumber = const Value.absent(),
            Value<int> khatmahTargetDays = const Value.absent(),
            Value<DateTime?> khatmahStartDate = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ReadingProgressCompanion.insert(
            id: id,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            pageNumber: pageNumber,
            juzNumber: juzNumber,
            khatmahTargetDays: khatmahTargetDays,
            khatmahStartDate: khatmahStartDate,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReadingProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReadingProgressTable,
    ReadingProgressRecord,
    $$ReadingProgressTableFilterComposer,
    $$ReadingProgressTableOrderingComposer,
    $$ReadingProgressTableAnnotationComposer,
    $$ReadingProgressTableCreateCompanionBuilder,
    $$ReadingProgressTableUpdateCompanionBuilder,
    (
      ReadingProgressRecord,
      BaseReferences<_$AppDatabase, $ReadingProgressTable,
          ReadingProgressRecord>
    ),
    ReadingProgressRecord,
    PrefetchHooks Function()>;
typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  required int surahNumber,
  required int ayahNumber,
  required String content,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  Value<int> surahNumber,
  Value<int> ayahNumber,
  Value<String> content,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotesTable,
    NoteRecord,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (NoteRecord, BaseReferences<_$AppDatabase, $NotesTable, NoteRecord>),
    NoteRecord,
    PrefetchHooks Function()> {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> ayahNumber = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              NotesCompanion(
            id: id,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            content: content,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int surahNumber,
            required int ayahNumber,
            required String content,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              NotesCompanion.insert(
            id: id,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            content: content,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotesTable,
    NoteRecord,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (NoteRecord, BaseReferences<_$AppDatabase, $NotesTable, NoteRecord>),
    NoteRecord,
    PrefetchHooks Function()>;
typedef $$TasbihEventsTableCreateCompanionBuilder = TasbihEventsCompanion
    Function({
  Value<int> id,
  required String dhikrId,
  required int count,
  Value<DateTime> timestamp,
});
typedef $$TasbihEventsTableUpdateCompanionBuilder = TasbihEventsCompanion
    Function({
  Value<int> id,
  Value<String> dhikrId,
  Value<int> count,
  Value<DateTime> timestamp,
});

class $$TasbihEventsTableFilterComposer
    extends Composer<_$AppDatabase, $TasbihEventsTable> {
  $$TasbihEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dhikrId => $composableBuilder(
      column: $table.dhikrId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$TasbihEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $TasbihEventsTable> {
  $$TasbihEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dhikrId => $composableBuilder(
      column: $table.dhikrId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$TasbihEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasbihEventsTable> {
  $$TasbihEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dhikrId =>
      $composableBuilder(column: $table.dhikrId, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$TasbihEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasbihEventsTable,
    TasbihEventRecord,
    $$TasbihEventsTableFilterComposer,
    $$TasbihEventsTableOrderingComposer,
    $$TasbihEventsTableAnnotationComposer,
    $$TasbihEventsTableCreateCompanionBuilder,
    $$TasbihEventsTableUpdateCompanionBuilder,
    (
      TasbihEventRecord,
      BaseReferences<_$AppDatabase, $TasbihEventsTable, TasbihEventRecord>
    ),
    TasbihEventRecord,
    PrefetchHooks Function()> {
  $$TasbihEventsTableTableManager(_$AppDatabase db, $TasbihEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasbihEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasbihEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasbihEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> dhikrId = const Value.absent(),
            Value<int> count = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              TasbihEventsCompanion(
            id: id,
            dhikrId: dhikrId,
            count: count,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String dhikrId,
            required int count,
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              TasbihEventsCompanion.insert(
            id: id,
            dhikrId: dhikrId,
            count: count,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TasbihEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasbihEventsTable,
    TasbihEventRecord,
    $$TasbihEventsTableFilterComposer,
    $$TasbihEventsTableOrderingComposer,
    $$TasbihEventsTableAnnotationComposer,
    $$TasbihEventsTableCreateCompanionBuilder,
    $$TasbihEventsTableUpdateCompanionBuilder,
    (
      TasbihEventRecord,
      BaseReferences<_$AppDatabase, $TasbihEventsTable, TasbihEventRecord>
    ),
    TasbihEventRecord,
    PrefetchHooks Function()>;
typedef $$TasbihDailyTableCreateCompanionBuilder = TasbihDailyCompanion
    Function({
  required String date,
  required String dhikrId,
  Value<int> total,
  Value<int> rowid,
});
typedef $$TasbihDailyTableUpdateCompanionBuilder = TasbihDailyCompanion
    Function({
  Value<String> date,
  Value<String> dhikrId,
  Value<int> total,
  Value<int> rowid,
});

class $$TasbihDailyTableFilterComposer
    extends Composer<_$AppDatabase, $TasbihDailyTable> {
  $$TasbihDailyTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dhikrId => $composableBuilder(
      column: $table.dhikrId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnFilters(column));
}

class $$TasbihDailyTableOrderingComposer
    extends Composer<_$AppDatabase, $TasbihDailyTable> {
  $$TasbihDailyTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dhikrId => $composableBuilder(
      column: $table.dhikrId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnOrderings(column));
}

class $$TasbihDailyTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasbihDailyTable> {
  $$TasbihDailyTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get dhikrId =>
      $composableBuilder(column: $table.dhikrId, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);
}

class $$TasbihDailyTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasbihDailyTable,
    TasbihDailyRecord,
    $$TasbihDailyTableFilterComposer,
    $$TasbihDailyTableOrderingComposer,
    $$TasbihDailyTableAnnotationComposer,
    $$TasbihDailyTableCreateCompanionBuilder,
    $$TasbihDailyTableUpdateCompanionBuilder,
    (
      TasbihDailyRecord,
      BaseReferences<_$AppDatabase, $TasbihDailyTable, TasbihDailyRecord>
    ),
    TasbihDailyRecord,
    PrefetchHooks Function()> {
  $$TasbihDailyTableTableManager(_$AppDatabase db, $TasbihDailyTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasbihDailyTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasbihDailyTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasbihDailyTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> date = const Value.absent(),
            Value<String> dhikrId = const Value.absent(),
            Value<int> total = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasbihDailyCompanion(
            date: date,
            dhikrId: dhikrId,
            total: total,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String date,
            required String dhikrId,
            Value<int> total = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasbihDailyCompanion.insert(
            date: date,
            dhikrId: dhikrId,
            total: total,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TasbihDailyTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasbihDailyTable,
    TasbihDailyRecord,
    $$TasbihDailyTableFilterComposer,
    $$TasbihDailyTableOrderingComposer,
    $$TasbihDailyTableAnnotationComposer,
    $$TasbihDailyTableCreateCompanionBuilder,
    $$TasbihDailyTableUpdateCompanionBuilder,
    (
      TasbihDailyRecord,
      BaseReferences<_$AppDatabase, $TasbihDailyTable, TasbihDailyRecord>
    ),
    TasbihDailyRecord,
    PrefetchHooks Function()>;
typedef $$DownloadsTableCreateCompanionBuilder = DownloadsCompanion Function({
  Value<int> id,
  required String itemType,
  Value<int?> reciterId,
  Value<int?> surahNumber,
  Value<String?> packId,
  required String localPath,
  Value<String> status,
  Value<double> progress,
  Value<int> totalBytes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$DownloadsTableUpdateCompanionBuilder = DownloadsCompanion Function({
  Value<int> id,
  Value<String> itemType,
  Value<int?> reciterId,
  Value<int?> surahNumber,
  Value<String?> packId,
  Value<String> localPath,
  Value<String> status,
  Value<double> progress,
  Value<int> totalBytes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$DownloadsTableFilterComposer
    extends Composer<_$AppDatabase, $DownloadsTable> {
  $$DownloadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reciterId => $composableBuilder(
      column: $table.reciterId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get packId => $composableBuilder(
      column: $table.packId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalBytes => $composableBuilder(
      column: $table.totalBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DownloadsTableOrderingComposer
    extends Composer<_$AppDatabase, $DownloadsTable> {
  $$DownloadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reciterId => $composableBuilder(
      column: $table.reciterId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get packId => $composableBuilder(
      column: $table.packId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalBytes => $composableBuilder(
      column: $table.totalBytes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DownloadsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DownloadsTable> {
  $$DownloadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<int> get reciterId =>
      $composableBuilder(column: $table.reciterId, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => column);

  GeneratedColumn<String> get packId =>
      $composableBuilder(column: $table.packId, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get totalBytes => $composableBuilder(
      column: $table.totalBytes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DownloadsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DownloadsTable,
    DownloadRecord,
    $$DownloadsTableFilterComposer,
    $$DownloadsTableOrderingComposer,
    $$DownloadsTableAnnotationComposer,
    $$DownloadsTableCreateCompanionBuilder,
    $$DownloadsTableUpdateCompanionBuilder,
    (
      DownloadRecord,
      BaseReferences<_$AppDatabase, $DownloadsTable, DownloadRecord>
    ),
    DownloadRecord,
    PrefetchHooks Function()> {
  $$DownloadsTableTableManager(_$AppDatabase db, $DownloadsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DownloadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DownloadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DownloadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> itemType = const Value.absent(),
            Value<int?> reciterId = const Value.absent(),
            Value<int?> surahNumber = const Value.absent(),
            Value<String?> packId = const Value.absent(),
            Value<String> localPath = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<int> totalBytes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DownloadsCompanion(
            id: id,
            itemType: itemType,
            reciterId: reciterId,
            surahNumber: surahNumber,
            packId: packId,
            localPath: localPath,
            status: status,
            progress: progress,
            totalBytes: totalBytes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String itemType,
            Value<int?> reciterId = const Value.absent(),
            Value<int?> surahNumber = const Value.absent(),
            Value<String?> packId = const Value.absent(),
            required String localPath,
            Value<String> status = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<int> totalBytes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DownloadsCompanion.insert(
            id: id,
            itemType: itemType,
            reciterId: reciterId,
            surahNumber: surahNumber,
            packId: packId,
            localPath: localPath,
            status: status,
            progress: progress,
            totalBytes: totalBytes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DownloadsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DownloadsTable,
    DownloadRecord,
    $$DownloadsTableFilterComposer,
    $$DownloadsTableOrderingComposer,
    $$DownloadsTableAnnotationComposer,
    $$DownloadsTableCreateCompanionBuilder,
    $$DownloadsTableUpdateCompanionBuilder,
    (
      DownloadRecord,
      BaseReferences<_$AppDatabase, $DownloadsTable, DownloadRecord>
    ),
    DownloadRecord,
    PrefetchHooks Function()>;
typedef $$CachedChaptersTableCreateCompanionBuilder = CachedChaptersCompanion
    Function({
  required int chapterId,
  Value<String> languageCode,
  required String nameArabic,
  required String nameSimple,
  required String nameTranslated,
  required String revelationPlace,
  required int revelationOrder,
  required bool bismillahPre,
  required int versesCount,
  required int startPage,
  required int endPage,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$CachedChaptersTableUpdateCompanionBuilder = CachedChaptersCompanion
    Function({
  Value<int> chapterId,
  Value<String> languageCode,
  Value<String> nameArabic,
  Value<String> nameSimple,
  Value<String> nameTranslated,
  Value<String> revelationPlace,
  Value<int> revelationOrder,
  Value<bool> bismillahPre,
  Value<int> versesCount,
  Value<int> startPage,
  Value<int> endPage,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$CachedChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $CachedChaptersTable> {
  $$CachedChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get chapterId => $composableBuilder(
      column: $table.chapterId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameArabic => $composableBuilder(
      column: $table.nameArabic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameSimple => $composableBuilder(
      column: $table.nameSimple, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameTranslated => $composableBuilder(
      column: $table.nameTranslated,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get revelationPlace => $composableBuilder(
      column: $table.revelationPlace,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get revelationOrder => $composableBuilder(
      column: $table.revelationOrder,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get bismillahPre => $composableBuilder(
      column: $table.bismillahPre, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get versesCount => $composableBuilder(
      column: $table.versesCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startPage => $composableBuilder(
      column: $table.startPage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endPage => $composableBuilder(
      column: $table.endPage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedChaptersTable> {
  $$CachedChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get chapterId => $composableBuilder(
      column: $table.chapterId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageCode => $composableBuilder(
      column: $table.languageCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameArabic => $composableBuilder(
      column: $table.nameArabic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameSimple => $composableBuilder(
      column: $table.nameSimple, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameTranslated => $composableBuilder(
      column: $table.nameTranslated,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get revelationPlace => $composableBuilder(
      column: $table.revelationPlace,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get revelationOrder => $composableBuilder(
      column: $table.revelationOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get bismillahPre => $composableBuilder(
      column: $table.bismillahPre,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get versesCount => $composableBuilder(
      column: $table.versesCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startPage => $composableBuilder(
      column: $table.startPage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endPage => $composableBuilder(
      column: $table.endPage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedChaptersTable> {
  $$CachedChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get chapterId =>
      $composableBuilder(column: $table.chapterId, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => column);

  GeneratedColumn<String> get nameArabic => $composableBuilder(
      column: $table.nameArabic, builder: (column) => column);

  GeneratedColumn<String> get nameSimple => $composableBuilder(
      column: $table.nameSimple, builder: (column) => column);

  GeneratedColumn<String> get nameTranslated => $composableBuilder(
      column: $table.nameTranslated, builder: (column) => column);

  GeneratedColumn<String> get revelationPlace => $composableBuilder(
      column: $table.revelationPlace, builder: (column) => column);

  GeneratedColumn<int> get revelationOrder => $composableBuilder(
      column: $table.revelationOrder, builder: (column) => column);

  GeneratedColumn<bool> get bismillahPre => $composableBuilder(
      column: $table.bismillahPre, builder: (column) => column);

  GeneratedColumn<int> get versesCount => $composableBuilder(
      column: $table.versesCount, builder: (column) => column);

  GeneratedColumn<int> get startPage =>
      $composableBuilder(column: $table.startPage, builder: (column) => column);

  GeneratedColumn<int> get endPage =>
      $composableBuilder(column: $table.endPage, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedChaptersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedChaptersTable,
    CachedChapterRecord,
    $$CachedChaptersTableFilterComposer,
    $$CachedChaptersTableOrderingComposer,
    $$CachedChaptersTableAnnotationComposer,
    $$CachedChaptersTableCreateCompanionBuilder,
    $$CachedChaptersTableUpdateCompanionBuilder,
    (
      CachedChapterRecord,
      BaseReferences<_$AppDatabase, $CachedChaptersTable, CachedChapterRecord>
    ),
    CachedChapterRecord,
    PrefetchHooks Function()> {
  $$CachedChaptersTableTableManager(
      _$AppDatabase db, $CachedChaptersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> chapterId = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<String> nameArabic = const Value.absent(),
            Value<String> nameSimple = const Value.absent(),
            Value<String> nameTranslated = const Value.absent(),
            Value<String> revelationPlace = const Value.absent(),
            Value<int> revelationOrder = const Value.absent(),
            Value<bool> bismillahPre = const Value.absent(),
            Value<int> versesCount = const Value.absent(),
            Value<int> startPage = const Value.absent(),
            Value<int> endPage = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedChaptersCompanion(
            chapterId: chapterId,
            languageCode: languageCode,
            nameArabic: nameArabic,
            nameSimple: nameSimple,
            nameTranslated: nameTranslated,
            revelationPlace: revelationPlace,
            revelationOrder: revelationOrder,
            bismillahPre: bismillahPre,
            versesCount: versesCount,
            startPage: startPage,
            endPage: endPage,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int chapterId,
            Value<String> languageCode = const Value.absent(),
            required String nameArabic,
            required String nameSimple,
            required String nameTranslated,
            required String revelationPlace,
            required int revelationOrder,
            required bool bismillahPre,
            required int versesCount,
            required int startPage,
            required int endPage,
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedChaptersCompanion.insert(
            chapterId: chapterId,
            languageCode: languageCode,
            nameArabic: nameArabic,
            nameSimple: nameSimple,
            nameTranslated: nameTranslated,
            revelationPlace: revelationPlace,
            revelationOrder: revelationOrder,
            bismillahPre: bismillahPre,
            versesCount: versesCount,
            startPage: startPage,
            endPage: endPage,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedChaptersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedChaptersTable,
    CachedChapterRecord,
    $$CachedChaptersTableFilterComposer,
    $$CachedChaptersTableOrderingComposer,
    $$CachedChaptersTableAnnotationComposer,
    $$CachedChaptersTableCreateCompanionBuilder,
    $$CachedChaptersTableUpdateCompanionBuilder,
    (
      CachedChapterRecord,
      BaseReferences<_$AppDatabase, $CachedChaptersTable, CachedChapterRecord>
    ),
    CachedChapterRecord,
    PrefetchHooks Function()>;
typedef $$CachedVersesTableCreateCompanionBuilder = CachedVersesCompanion
    Function({
  required String verseKey,
  required int chapterId,
  required int verseNumber,
  required int pageNumber,
  required int juzNumber,
  required int hizbNumber,
  required String textUthmani,
  Value<String> textImlaeiSimple,
  Value<String> wordsJson,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$CachedVersesTableUpdateCompanionBuilder = CachedVersesCompanion
    Function({
  Value<String> verseKey,
  Value<int> chapterId,
  Value<int> verseNumber,
  Value<int> pageNumber,
  Value<int> juzNumber,
  Value<int> hizbNumber,
  Value<String> textUthmani,
  Value<String> textImlaeiSimple,
  Value<String> wordsJson,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$CachedVersesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedVersesTable> {
  $$CachedVersesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get verseKey => $composableBuilder(
      column: $table.verseKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chapterId => $composableBuilder(
      column: $table.chapterId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get verseNumber => $composableBuilder(
      column: $table.verseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get juzNumber => $composableBuilder(
      column: $table.juzNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hizbNumber => $composableBuilder(
      column: $table.hizbNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textUthmani => $composableBuilder(
      column: $table.textUthmani, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textImlaeiSimple => $composableBuilder(
      column: $table.textImlaeiSimple,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wordsJson => $composableBuilder(
      column: $table.wordsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedVersesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedVersesTable> {
  $$CachedVersesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get verseKey => $composableBuilder(
      column: $table.verseKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chapterId => $composableBuilder(
      column: $table.chapterId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get verseNumber => $composableBuilder(
      column: $table.verseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get juzNumber => $composableBuilder(
      column: $table.juzNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hizbNumber => $composableBuilder(
      column: $table.hizbNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textUthmani => $composableBuilder(
      column: $table.textUthmani, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textImlaeiSimple => $composableBuilder(
      column: $table.textImlaeiSimple,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wordsJson => $composableBuilder(
      column: $table.wordsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedVersesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedVersesTable> {
  $$CachedVersesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get verseKey =>
      $composableBuilder(column: $table.verseKey, builder: (column) => column);

  GeneratedColumn<int> get chapterId =>
      $composableBuilder(column: $table.chapterId, builder: (column) => column);

  GeneratedColumn<int> get verseNumber => $composableBuilder(
      column: $table.verseNumber, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => column);

  GeneratedColumn<int> get juzNumber =>
      $composableBuilder(column: $table.juzNumber, builder: (column) => column);

  GeneratedColumn<int> get hizbNumber => $composableBuilder(
      column: $table.hizbNumber, builder: (column) => column);

  GeneratedColumn<String> get textUthmani => $composableBuilder(
      column: $table.textUthmani, builder: (column) => column);

  GeneratedColumn<String> get textImlaeiSimple => $composableBuilder(
      column: $table.textImlaeiSimple, builder: (column) => column);

  GeneratedColumn<String> get wordsJson =>
      $composableBuilder(column: $table.wordsJson, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedVersesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedVersesTable,
    CachedVerseRecord,
    $$CachedVersesTableFilterComposer,
    $$CachedVersesTableOrderingComposer,
    $$CachedVersesTableAnnotationComposer,
    $$CachedVersesTableCreateCompanionBuilder,
    $$CachedVersesTableUpdateCompanionBuilder,
    (
      CachedVerseRecord,
      BaseReferences<_$AppDatabase, $CachedVersesTable, CachedVerseRecord>
    ),
    CachedVerseRecord,
    PrefetchHooks Function()> {
  $$CachedVersesTableTableManager(_$AppDatabase db, $CachedVersesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedVersesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedVersesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedVersesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> verseKey = const Value.absent(),
            Value<int> chapterId = const Value.absent(),
            Value<int> verseNumber = const Value.absent(),
            Value<int> pageNumber = const Value.absent(),
            Value<int> juzNumber = const Value.absent(),
            Value<int> hizbNumber = const Value.absent(),
            Value<String> textUthmani = const Value.absent(),
            Value<String> textImlaeiSimple = const Value.absent(),
            Value<String> wordsJson = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedVersesCompanion(
            verseKey: verseKey,
            chapterId: chapterId,
            verseNumber: verseNumber,
            pageNumber: pageNumber,
            juzNumber: juzNumber,
            hizbNumber: hizbNumber,
            textUthmani: textUthmani,
            textImlaeiSimple: textImlaeiSimple,
            wordsJson: wordsJson,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String verseKey,
            required int chapterId,
            required int verseNumber,
            required int pageNumber,
            required int juzNumber,
            required int hizbNumber,
            required String textUthmani,
            Value<String> textImlaeiSimple = const Value.absent(),
            Value<String> wordsJson = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedVersesCompanion.insert(
            verseKey: verseKey,
            chapterId: chapterId,
            verseNumber: verseNumber,
            pageNumber: pageNumber,
            juzNumber: juzNumber,
            hizbNumber: hizbNumber,
            textUthmani: textUthmani,
            textImlaeiSimple: textImlaeiSimple,
            wordsJson: wordsJson,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedVersesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedVersesTable,
    CachedVerseRecord,
    $$CachedVersesTableFilterComposer,
    $$CachedVersesTableOrderingComposer,
    $$CachedVersesTableAnnotationComposer,
    $$CachedVersesTableCreateCompanionBuilder,
    $$CachedVersesTableUpdateCompanionBuilder,
    (
      CachedVerseRecord,
      BaseReferences<_$AppDatabase, $CachedVersesTable, CachedVerseRecord>
    ),
    CachedVerseRecord,
    PrefetchHooks Function()>;
typedef $$CachedResourceCatalogsTableCreateCompanionBuilder
    = CachedResourceCatalogsCompanion Function({
  required String resourceType,
  required int resourceId,
  Value<String> languageCode,
  required String name,
  Value<String> authorName,
  Value<String> languageName,
  Value<String> slug,
  Value<String> style,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$CachedResourceCatalogsTableUpdateCompanionBuilder
    = CachedResourceCatalogsCompanion Function({
  Value<String> resourceType,
  Value<int> resourceId,
  Value<String> languageCode,
  Value<String> name,
  Value<String> authorName,
  Value<String> languageName,
  Value<String> slug,
  Value<String> style,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$CachedResourceCatalogsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedResourceCatalogsTable> {
  $$CachedResourceCatalogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get resourceType => $composableBuilder(
      column: $table.resourceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authorName => $composableBuilder(
      column: $table.authorName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageName => $composableBuilder(
      column: $table.languageName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get style => $composableBuilder(
      column: $table.style, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedResourceCatalogsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedResourceCatalogsTable> {
  $$CachedResourceCatalogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get resourceType => $composableBuilder(
      column: $table.resourceType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageCode => $composableBuilder(
      column: $table.languageCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorName => $composableBuilder(
      column: $table.authorName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageName => $composableBuilder(
      column: $table.languageName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get style => $composableBuilder(
      column: $table.style, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedResourceCatalogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedResourceCatalogsTable> {
  $$CachedResourceCatalogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get resourceType => $composableBuilder(
      column: $table.resourceType, builder: (column) => column);

  GeneratedColumn<int> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
      column: $table.authorName, builder: (column) => column);

  GeneratedColumn<String> get languageName => $composableBuilder(
      column: $table.languageName, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedResourceCatalogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedResourceCatalogsTable,
    CachedResourceCatalogRecord,
    $$CachedResourceCatalogsTableFilterComposer,
    $$CachedResourceCatalogsTableOrderingComposer,
    $$CachedResourceCatalogsTableAnnotationComposer,
    $$CachedResourceCatalogsTableCreateCompanionBuilder,
    $$CachedResourceCatalogsTableUpdateCompanionBuilder,
    (
      CachedResourceCatalogRecord,
      BaseReferences<_$AppDatabase, $CachedResourceCatalogsTable,
          CachedResourceCatalogRecord>
    ),
    CachedResourceCatalogRecord,
    PrefetchHooks Function()> {
  $$CachedResourceCatalogsTableTableManager(
      _$AppDatabase db, $CachedResourceCatalogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedResourceCatalogsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedResourceCatalogsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedResourceCatalogsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> resourceType = const Value.absent(),
            Value<int> resourceId = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> authorName = const Value.absent(),
            Value<String> languageName = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<String> style = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedResourceCatalogsCompanion(
            resourceType: resourceType,
            resourceId: resourceId,
            languageCode: languageCode,
            name: name,
            authorName: authorName,
            languageName: languageName,
            slug: slug,
            style: style,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String resourceType,
            required int resourceId,
            Value<String> languageCode = const Value.absent(),
            required String name,
            Value<String> authorName = const Value.absent(),
            Value<String> languageName = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<String> style = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedResourceCatalogsCompanion.insert(
            resourceType: resourceType,
            resourceId: resourceId,
            languageCode: languageCode,
            name: name,
            authorName: authorName,
            languageName: languageName,
            slug: slug,
            style: style,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedResourceCatalogsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CachedResourceCatalogsTable,
        CachedResourceCatalogRecord,
        $$CachedResourceCatalogsTableFilterComposer,
        $$CachedResourceCatalogsTableOrderingComposer,
        $$CachedResourceCatalogsTableAnnotationComposer,
        $$CachedResourceCatalogsTableCreateCompanionBuilder,
        $$CachedResourceCatalogsTableUpdateCompanionBuilder,
        (
          CachedResourceCatalogRecord,
          BaseReferences<_$AppDatabase, $CachedResourceCatalogsTable,
              CachedResourceCatalogRecord>
        ),
        CachedResourceCatalogRecord,
        PrefetchHooks Function()>;
typedef $$CachedVerseAnnotationsTableCreateCompanionBuilder
    = CachedVerseAnnotationsCompanion Function({
  required String verseKey,
  required String resourceType,
  required int resourceId,
  Value<String> resourceName,
  required String textContent,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$CachedVerseAnnotationsTableUpdateCompanionBuilder
    = CachedVerseAnnotationsCompanion Function({
  Value<String> verseKey,
  Value<String> resourceType,
  Value<int> resourceId,
  Value<String> resourceName,
  Value<String> textContent,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$CachedVerseAnnotationsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedVerseAnnotationsTable> {
  $$CachedVerseAnnotationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get verseKey => $composableBuilder(
      column: $table.verseKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resourceType => $composableBuilder(
      column: $table.resourceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resourceName => $composableBuilder(
      column: $table.resourceName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textContent => $composableBuilder(
      column: $table.textContent, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedVerseAnnotationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedVerseAnnotationsTable> {
  $$CachedVerseAnnotationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get verseKey => $composableBuilder(
      column: $table.verseKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resourceType => $composableBuilder(
      column: $table.resourceType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resourceName => $composableBuilder(
      column: $table.resourceName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textContent => $composableBuilder(
      column: $table.textContent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedVerseAnnotationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedVerseAnnotationsTable> {
  $$CachedVerseAnnotationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get verseKey =>
      $composableBuilder(column: $table.verseKey, builder: (column) => column);

  GeneratedColumn<String> get resourceType => $composableBuilder(
      column: $table.resourceType, builder: (column) => column);

  GeneratedColumn<int> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => column);

  GeneratedColumn<String> get resourceName => $composableBuilder(
      column: $table.resourceName, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
      column: $table.textContent, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedVerseAnnotationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedVerseAnnotationsTable,
    CachedVerseAnnotationRecord,
    $$CachedVerseAnnotationsTableFilterComposer,
    $$CachedVerseAnnotationsTableOrderingComposer,
    $$CachedVerseAnnotationsTableAnnotationComposer,
    $$CachedVerseAnnotationsTableCreateCompanionBuilder,
    $$CachedVerseAnnotationsTableUpdateCompanionBuilder,
    (
      CachedVerseAnnotationRecord,
      BaseReferences<_$AppDatabase, $CachedVerseAnnotationsTable,
          CachedVerseAnnotationRecord>
    ),
    CachedVerseAnnotationRecord,
    PrefetchHooks Function()> {
  $$CachedVerseAnnotationsTableTableManager(
      _$AppDatabase db, $CachedVerseAnnotationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedVerseAnnotationsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedVerseAnnotationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedVerseAnnotationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> verseKey = const Value.absent(),
            Value<String> resourceType = const Value.absent(),
            Value<int> resourceId = const Value.absent(),
            Value<String> resourceName = const Value.absent(),
            Value<String> textContent = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedVerseAnnotationsCompanion(
            verseKey: verseKey,
            resourceType: resourceType,
            resourceId: resourceId,
            resourceName: resourceName,
            textContent: textContent,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String verseKey,
            required String resourceType,
            required int resourceId,
            Value<String> resourceName = const Value.absent(),
            required String textContent,
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedVerseAnnotationsCompanion.insert(
            verseKey: verseKey,
            resourceType: resourceType,
            resourceId: resourceId,
            resourceName: resourceName,
            textContent: textContent,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedVerseAnnotationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CachedVerseAnnotationsTable,
        CachedVerseAnnotationRecord,
        $$CachedVerseAnnotationsTableFilterComposer,
        $$CachedVerseAnnotationsTableOrderingComposer,
        $$CachedVerseAnnotationsTableAnnotationComposer,
        $$CachedVerseAnnotationsTableCreateCompanionBuilder,
        $$CachedVerseAnnotationsTableUpdateCompanionBuilder,
        (
          CachedVerseAnnotationRecord,
          BaseReferences<_$AppDatabase, $CachedVerseAnnotationsTable,
              CachedVerseAnnotationRecord>
        ),
        CachedVerseAnnotationRecord,
        PrefetchHooks Function()>;
typedef $$AdhkarDailyProgressTableCreateCompanionBuilder
    = AdhkarDailyProgressCompanion Function({
  required String date,
  required String itemId,
  required String category,
  Value<int> currentCount,
  Value<int> targetCount,
  Value<bool> isCompleted,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$AdhkarDailyProgressTableUpdateCompanionBuilder
    = AdhkarDailyProgressCompanion Function({
  Value<String> date,
  Value<String> itemId,
  Value<String> category,
  Value<int> currentCount,
  Value<int> targetCount,
  Value<bool> isCompleted,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$AdhkarDailyProgressTableFilterComposer
    extends Composer<_$AppDatabase, $AdhkarDailyProgressTable> {
  $$AdhkarDailyProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentCount => $composableBuilder(
      column: $table.currentCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetCount => $composableBuilder(
      column: $table.targetCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AdhkarDailyProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $AdhkarDailyProgressTable> {
  $$AdhkarDailyProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentCount => $composableBuilder(
      column: $table.currentCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetCount => $composableBuilder(
      column: $table.targetCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AdhkarDailyProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdhkarDailyProgressTable> {
  $$AdhkarDailyProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get currentCount => $composableBuilder(
      column: $table.currentCount, builder: (column) => column);

  GeneratedColumn<int> get targetCount => $composableBuilder(
      column: $table.targetCount, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AdhkarDailyProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AdhkarDailyProgressTable,
    AdhkarDailyProgressRecord,
    $$AdhkarDailyProgressTableFilterComposer,
    $$AdhkarDailyProgressTableOrderingComposer,
    $$AdhkarDailyProgressTableAnnotationComposer,
    $$AdhkarDailyProgressTableCreateCompanionBuilder,
    $$AdhkarDailyProgressTableUpdateCompanionBuilder,
    (
      AdhkarDailyProgressRecord,
      BaseReferences<_$AppDatabase, $AdhkarDailyProgressTable,
          AdhkarDailyProgressRecord>
    ),
    AdhkarDailyProgressRecord,
    PrefetchHooks Function()> {
  $$AdhkarDailyProgressTableTableManager(
      _$AppDatabase db, $AdhkarDailyProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AdhkarDailyProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AdhkarDailyProgressTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AdhkarDailyProgressTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> date = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int> currentCount = const Value.absent(),
            Value<int> targetCount = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AdhkarDailyProgressCompanion(
            date: date,
            itemId: itemId,
            category: category,
            currentCount: currentCount,
            targetCount: targetCount,
            isCompleted: isCompleted,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String date,
            required String itemId,
            required String category,
            Value<int> currentCount = const Value.absent(),
            Value<int> targetCount = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AdhkarDailyProgressCompanion.insert(
            date: date,
            itemId: itemId,
            category: category,
            currentCount: currentCount,
            targetCount: targetCount,
            isCompleted: isCompleted,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AdhkarDailyProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AdhkarDailyProgressTable,
    AdhkarDailyProgressRecord,
    $$AdhkarDailyProgressTableFilterComposer,
    $$AdhkarDailyProgressTableOrderingComposer,
    $$AdhkarDailyProgressTableAnnotationComposer,
    $$AdhkarDailyProgressTableCreateCompanionBuilder,
    $$AdhkarDailyProgressTableUpdateCompanionBuilder,
    (
      AdhkarDailyProgressRecord,
      BaseReferences<_$AppDatabase, $AdhkarDailyProgressTable,
          AdhkarDailyProgressRecord>
    ),
    AdhkarDailyProgressRecord,
    PrefetchHooks Function()>;
typedef $$HifzMemorizedRangesTableCreateCompanionBuilder
    = HifzMemorizedRangesCompanion Function({
  Value<int> id,
  required int surahNumber,
  required int startAyah,
  required int endAyah,
  Value<int> startPage,
  Value<int> endPage,
  Value<int> juzNumber,
  Value<double> easinessFactor,
  Value<int> intervalDays,
  Value<int> repetitions,
  Value<String?> lastReviewedDate,
  required String nextDueDate,
  Value<String> lastGrade,
  Value<DateTime> createdAt,
});
typedef $$HifzMemorizedRangesTableUpdateCompanionBuilder
    = HifzMemorizedRangesCompanion Function({
  Value<int> id,
  Value<int> surahNumber,
  Value<int> startAyah,
  Value<int> endAyah,
  Value<int> startPage,
  Value<int> endPage,
  Value<int> juzNumber,
  Value<double> easinessFactor,
  Value<int> intervalDays,
  Value<int> repetitions,
  Value<String?> lastReviewedDate,
  Value<String> nextDueDate,
  Value<String> lastGrade,
  Value<DateTime> createdAt,
});

class $$HifzMemorizedRangesTableFilterComposer
    extends Composer<_$AppDatabase, $HifzMemorizedRangesTable> {
  $$HifzMemorizedRangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startPage => $composableBuilder(
      column: $table.startPage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endPage => $composableBuilder(
      column: $table.endPage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get juzNumber => $composableBuilder(
      column: $table.juzNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get easinessFactor => $composableBuilder(
      column: $table.easinessFactor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get repetitions => $composableBuilder(
      column: $table.repetitions, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastReviewedDate => $composableBuilder(
      column: $table.lastReviewedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nextDueDate => $composableBuilder(
      column: $table.nextDueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastGrade => $composableBuilder(
      column: $table.lastGrade, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$HifzMemorizedRangesTableOrderingComposer
    extends Composer<_$AppDatabase, $HifzMemorizedRangesTable> {
  $$HifzMemorizedRangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startPage => $composableBuilder(
      column: $table.startPage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endPage => $composableBuilder(
      column: $table.endPage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get juzNumber => $composableBuilder(
      column: $table.juzNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get easinessFactor => $composableBuilder(
      column: $table.easinessFactor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get repetitions => $composableBuilder(
      column: $table.repetitions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastReviewedDate => $composableBuilder(
      column: $table.lastReviewedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextDueDate => $composableBuilder(
      column: $table.nextDueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastGrade => $composableBuilder(
      column: $table.lastGrade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$HifzMemorizedRangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HifzMemorizedRangesTable> {
  $$HifzMemorizedRangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => column);

  GeneratedColumn<int> get startAyah =>
      $composableBuilder(column: $table.startAyah, builder: (column) => column);

  GeneratedColumn<int> get endAyah =>
      $composableBuilder(column: $table.endAyah, builder: (column) => column);

  GeneratedColumn<int> get startPage =>
      $composableBuilder(column: $table.startPage, builder: (column) => column);

  GeneratedColumn<int> get endPage =>
      $composableBuilder(column: $table.endPage, builder: (column) => column);

  GeneratedColumn<int> get juzNumber =>
      $composableBuilder(column: $table.juzNumber, builder: (column) => column);

  GeneratedColumn<double> get easinessFactor => $composableBuilder(
      column: $table.easinessFactor, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => column);

  GeneratedColumn<int> get repetitions => $composableBuilder(
      column: $table.repetitions, builder: (column) => column);

  GeneratedColumn<String> get lastReviewedDate => $composableBuilder(
      column: $table.lastReviewedDate, builder: (column) => column);

  GeneratedColumn<String> get nextDueDate => $composableBuilder(
      column: $table.nextDueDate, builder: (column) => column);

  GeneratedColumn<String> get lastGrade =>
      $composableBuilder(column: $table.lastGrade, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HifzMemorizedRangesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HifzMemorizedRangesTable,
    HifzMemorizedRangeRecord,
    $$HifzMemorizedRangesTableFilterComposer,
    $$HifzMemorizedRangesTableOrderingComposer,
    $$HifzMemorizedRangesTableAnnotationComposer,
    $$HifzMemorizedRangesTableCreateCompanionBuilder,
    $$HifzMemorizedRangesTableUpdateCompanionBuilder,
    (
      HifzMemorizedRangeRecord,
      BaseReferences<_$AppDatabase, $HifzMemorizedRangesTable,
          HifzMemorizedRangeRecord>
    ),
    HifzMemorizedRangeRecord,
    PrefetchHooks Function()> {
  $$HifzMemorizedRangesTableTableManager(
      _$AppDatabase db, $HifzMemorizedRangesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HifzMemorizedRangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HifzMemorizedRangesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HifzMemorizedRangesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> startAyah = const Value.absent(),
            Value<int> endAyah = const Value.absent(),
            Value<int> startPage = const Value.absent(),
            Value<int> endPage = const Value.absent(),
            Value<int> juzNumber = const Value.absent(),
            Value<double> easinessFactor = const Value.absent(),
            Value<int> intervalDays = const Value.absent(),
            Value<int> repetitions = const Value.absent(),
            Value<String?> lastReviewedDate = const Value.absent(),
            Value<String> nextDueDate = const Value.absent(),
            Value<String> lastGrade = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HifzMemorizedRangesCompanion(
            id: id,
            surahNumber: surahNumber,
            startAyah: startAyah,
            endAyah: endAyah,
            startPage: startPage,
            endPage: endPage,
            juzNumber: juzNumber,
            easinessFactor: easinessFactor,
            intervalDays: intervalDays,
            repetitions: repetitions,
            lastReviewedDate: lastReviewedDate,
            nextDueDate: nextDueDate,
            lastGrade: lastGrade,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int surahNumber,
            required int startAyah,
            required int endAyah,
            Value<int> startPage = const Value.absent(),
            Value<int> endPage = const Value.absent(),
            Value<int> juzNumber = const Value.absent(),
            Value<double> easinessFactor = const Value.absent(),
            Value<int> intervalDays = const Value.absent(),
            Value<int> repetitions = const Value.absent(),
            Value<String?> lastReviewedDate = const Value.absent(),
            required String nextDueDate,
            Value<String> lastGrade = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HifzMemorizedRangesCompanion.insert(
            id: id,
            surahNumber: surahNumber,
            startAyah: startAyah,
            endAyah: endAyah,
            startPage: startPage,
            endPage: endPage,
            juzNumber: juzNumber,
            easinessFactor: easinessFactor,
            intervalDays: intervalDays,
            repetitions: repetitions,
            lastReviewedDate: lastReviewedDate,
            nextDueDate: nextDueDate,
            lastGrade: lastGrade,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HifzMemorizedRangesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HifzMemorizedRangesTable,
    HifzMemorizedRangeRecord,
    $$HifzMemorizedRangesTableFilterComposer,
    $$HifzMemorizedRangesTableOrderingComposer,
    $$HifzMemorizedRangesTableAnnotationComposer,
    $$HifzMemorizedRangesTableCreateCompanionBuilder,
    $$HifzMemorizedRangesTableUpdateCompanionBuilder,
    (
      HifzMemorizedRangeRecord,
      BaseReferences<_$AppDatabase, $HifzMemorizedRangesTable,
          HifzMemorizedRangeRecord>
    ),
    HifzMemorizedRangeRecord,
    PrefetchHooks Function()>;
typedef $$HifzReviewEventsTableCreateCompanionBuilder
    = HifzReviewEventsCompanion Function({
  Value<int> id,
  required int rangeId,
  required int surahNumber,
  required int startAyah,
  required int endAyah,
  required String grade,
  required String localDate,
  Value<DateTime> reviewedAt,
});
typedef $$HifzReviewEventsTableUpdateCompanionBuilder
    = HifzReviewEventsCompanion Function({
  Value<int> id,
  Value<int> rangeId,
  Value<int> surahNumber,
  Value<int> startAyah,
  Value<int> endAyah,
  Value<String> grade,
  Value<String> localDate,
  Value<DateTime> reviewedAt,
});

class $$HifzReviewEventsTableFilterComposer
    extends Composer<_$AppDatabase, $HifzReviewEventsTable> {
  $$HifzReviewEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rangeId => $composableBuilder(
      column: $table.rangeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localDate => $composableBuilder(
      column: $table.localDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => ColumnFilters(column));
}

class $$HifzReviewEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $HifzReviewEventsTable> {
  $$HifzReviewEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rangeId => $composableBuilder(
      column: $table.rangeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localDate => $composableBuilder(
      column: $table.localDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => ColumnOrderings(column));
}

class $$HifzReviewEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HifzReviewEventsTable> {
  $$HifzReviewEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get rangeId =>
      $composableBuilder(column: $table.rangeId, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => column);

  GeneratedColumn<int> get startAyah =>
      $composableBuilder(column: $table.startAyah, builder: (column) => column);

  GeneratedColumn<int> get endAyah =>
      $composableBuilder(column: $table.endAyah, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => column);
}

class $$HifzReviewEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HifzReviewEventsTable,
    HifzReviewEventRecord,
    $$HifzReviewEventsTableFilterComposer,
    $$HifzReviewEventsTableOrderingComposer,
    $$HifzReviewEventsTableAnnotationComposer,
    $$HifzReviewEventsTableCreateCompanionBuilder,
    $$HifzReviewEventsTableUpdateCompanionBuilder,
    (
      HifzReviewEventRecord,
      BaseReferences<_$AppDatabase, $HifzReviewEventsTable,
          HifzReviewEventRecord>
    ),
    HifzReviewEventRecord,
    PrefetchHooks Function()> {
  $$HifzReviewEventsTableTableManager(
      _$AppDatabase db, $HifzReviewEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HifzReviewEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HifzReviewEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HifzReviewEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> rangeId = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> startAyah = const Value.absent(),
            Value<int> endAyah = const Value.absent(),
            Value<String> grade = const Value.absent(),
            Value<String> localDate = const Value.absent(),
            Value<DateTime> reviewedAt = const Value.absent(),
          }) =>
              HifzReviewEventsCompanion(
            id: id,
            rangeId: rangeId,
            surahNumber: surahNumber,
            startAyah: startAyah,
            endAyah: endAyah,
            grade: grade,
            localDate: localDate,
            reviewedAt: reviewedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int rangeId,
            required int surahNumber,
            required int startAyah,
            required int endAyah,
            required String grade,
            required String localDate,
            Value<DateTime> reviewedAt = const Value.absent(),
          }) =>
              HifzReviewEventsCompanion.insert(
            id: id,
            rangeId: rangeId,
            surahNumber: surahNumber,
            startAyah: startAyah,
            endAyah: endAyah,
            grade: grade,
            localDate: localDate,
            reviewedAt: reviewedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HifzReviewEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HifzReviewEventsTable,
    HifzReviewEventRecord,
    $$HifzReviewEventsTableFilterComposer,
    $$HifzReviewEventsTableOrderingComposer,
    $$HifzReviewEventsTableAnnotationComposer,
    $$HifzReviewEventsTableCreateCompanionBuilder,
    $$HifzReviewEventsTableUpdateCompanionBuilder,
    (
      HifzReviewEventRecord,
      BaseReferences<_$AppDatabase, $HifzReviewEventsTable,
          HifzReviewEventRecord>
    ),
    HifzReviewEventRecord,
    PrefetchHooks Function()>;
typedef $$HifzMistakeLogsTableCreateCompanionBuilder = HifzMistakeLogsCompanion
    Function({
  Value<int> id,
  required String verseKey,
  required int surahNumber,
  required int ayahNumber,
  Value<int?> wordPosition,
  required String grade,
  required String localDate,
  Value<DateTime> recordedAt,
});
typedef $$HifzMistakeLogsTableUpdateCompanionBuilder = HifzMistakeLogsCompanion
    Function({
  Value<int> id,
  Value<String> verseKey,
  Value<int> surahNumber,
  Value<int> ayahNumber,
  Value<int?> wordPosition,
  Value<String> grade,
  Value<String> localDate,
  Value<DateTime> recordedAt,
});

class $$HifzMistakeLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HifzMistakeLogsTable> {
  $$HifzMistakeLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get verseKey => $composableBuilder(
      column: $table.verseKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wordPosition => $composableBuilder(
      column: $table.wordPosition, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localDate => $composableBuilder(
      column: $table.localDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));
}

class $$HifzMistakeLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HifzMistakeLogsTable> {
  $$HifzMistakeLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get verseKey => $composableBuilder(
      column: $table.verseKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wordPosition => $composableBuilder(
      column: $table.wordPosition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localDate => $composableBuilder(
      column: $table.localDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));
}

class $$HifzMistakeLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HifzMistakeLogsTable> {
  $$HifzMistakeLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get verseKey =>
      $composableBuilder(column: $table.verseKey, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => column);

  GeneratedColumn<int> get wordPosition => $composableBuilder(
      column: $table.wordPosition, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);
}

class $$HifzMistakeLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HifzMistakeLogsTable,
    HifzMistakeLogRecord,
    $$HifzMistakeLogsTableFilterComposer,
    $$HifzMistakeLogsTableOrderingComposer,
    $$HifzMistakeLogsTableAnnotationComposer,
    $$HifzMistakeLogsTableCreateCompanionBuilder,
    $$HifzMistakeLogsTableUpdateCompanionBuilder,
    (
      HifzMistakeLogRecord,
      BaseReferences<_$AppDatabase, $HifzMistakeLogsTable, HifzMistakeLogRecord>
    ),
    HifzMistakeLogRecord,
    PrefetchHooks Function()> {
  $$HifzMistakeLogsTableTableManager(
      _$AppDatabase db, $HifzMistakeLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HifzMistakeLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HifzMistakeLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HifzMistakeLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> verseKey = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> ayahNumber = const Value.absent(),
            Value<int?> wordPosition = const Value.absent(),
            Value<String> grade = const Value.absent(),
            Value<String> localDate = const Value.absent(),
            Value<DateTime> recordedAt = const Value.absent(),
          }) =>
              HifzMistakeLogsCompanion(
            id: id,
            verseKey: verseKey,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            wordPosition: wordPosition,
            grade: grade,
            localDate: localDate,
            recordedAt: recordedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String verseKey,
            required int surahNumber,
            required int ayahNumber,
            Value<int?> wordPosition = const Value.absent(),
            required String grade,
            required String localDate,
            Value<DateTime> recordedAt = const Value.absent(),
          }) =>
              HifzMistakeLogsCompanion.insert(
            id: id,
            verseKey: verseKey,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            wordPosition: wordPosition,
            grade: grade,
            localDate: localDate,
            recordedAt: recordedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HifzMistakeLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HifzMistakeLogsTable,
    HifzMistakeLogRecord,
    $$HifzMistakeLogsTableFilterComposer,
    $$HifzMistakeLogsTableOrderingComposer,
    $$HifzMistakeLogsTableAnnotationComposer,
    $$HifzMistakeLogsTableCreateCompanionBuilder,
    $$HifzMistakeLogsTableUpdateCompanionBuilder,
    (
      HifzMistakeLogRecord,
      BaseReferences<_$AppDatabase, $HifzMistakeLogsTable, HifzMistakeLogRecord>
    ),
    HifzMistakeLogRecord,
    PrefetchHooks Function()>;
typedef $$HifzActiveSessionsTableCreateCompanionBuilder
    = HifzActiveSessionsCompanion Function({
  Value<int> id,
  Value<bool> isActive,
  Value<String> sessionMode,
  Value<int?> rangeId,
  Value<int> surahNumber,
  Value<int> startAyah,
  Value<int> endAyah,
  Value<int> currentIndex,
  Value<bool> isRevealed,
  Value<int?> tappedMistakeWordPosition,
  Value<String> verseKeysJson,
  Value<String> gradesJson,
  Value<DateTime> updatedAt,
});
typedef $$HifzActiveSessionsTableUpdateCompanionBuilder
    = HifzActiveSessionsCompanion Function({
  Value<int> id,
  Value<bool> isActive,
  Value<String> sessionMode,
  Value<int?> rangeId,
  Value<int> surahNumber,
  Value<int> startAyah,
  Value<int> endAyah,
  Value<int> currentIndex,
  Value<bool> isRevealed,
  Value<int?> tappedMistakeWordPosition,
  Value<String> verseKeysJson,
  Value<String> gradesJson,
  Value<DateTime> updatedAt,
});

class $$HifzActiveSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $HifzActiveSessionsTable> {
  $$HifzActiveSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionMode => $composableBuilder(
      column: $table.sessionMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rangeId => $composableBuilder(
      column: $table.rangeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentIndex => $composableBuilder(
      column: $table.currentIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRevealed => $composableBuilder(
      column: $table.isRevealed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tappedMistakeWordPosition => $composableBuilder(
      column: $table.tappedMistakeWordPosition,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get verseKeysJson => $composableBuilder(
      column: $table.verseKeysJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gradesJson => $composableBuilder(
      column: $table.gradesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$HifzActiveSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HifzActiveSessionsTable> {
  $$HifzActiveSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionMode => $composableBuilder(
      column: $table.sessionMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rangeId => $composableBuilder(
      column: $table.rangeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentIndex => $composableBuilder(
      column: $table.currentIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRevealed => $composableBuilder(
      column: $table.isRevealed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tappedMistakeWordPosition => $composableBuilder(
      column: $table.tappedMistakeWordPosition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get verseKeysJson => $composableBuilder(
      column: $table.verseKeysJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gradesJson => $composableBuilder(
      column: $table.gradesJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$HifzActiveSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HifzActiveSessionsTable> {
  $$HifzActiveSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get sessionMode => $composableBuilder(
      column: $table.sessionMode, builder: (column) => column);

  GeneratedColumn<int> get rangeId =>
      $composableBuilder(column: $table.rangeId, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => column);

  GeneratedColumn<int> get startAyah =>
      $composableBuilder(column: $table.startAyah, builder: (column) => column);

  GeneratedColumn<int> get endAyah =>
      $composableBuilder(column: $table.endAyah, builder: (column) => column);

  GeneratedColumn<int> get currentIndex => $composableBuilder(
      column: $table.currentIndex, builder: (column) => column);

  GeneratedColumn<bool> get isRevealed => $composableBuilder(
      column: $table.isRevealed, builder: (column) => column);

  GeneratedColumn<int> get tappedMistakeWordPosition => $composableBuilder(
      column: $table.tappedMistakeWordPosition, builder: (column) => column);

  GeneratedColumn<String> get verseKeysJson => $composableBuilder(
      column: $table.verseKeysJson, builder: (column) => column);

  GeneratedColumn<String> get gradesJson => $composableBuilder(
      column: $table.gradesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HifzActiveSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HifzActiveSessionsTable,
    HifzActiveSessionRecord,
    $$HifzActiveSessionsTableFilterComposer,
    $$HifzActiveSessionsTableOrderingComposer,
    $$HifzActiveSessionsTableAnnotationComposer,
    $$HifzActiveSessionsTableCreateCompanionBuilder,
    $$HifzActiveSessionsTableUpdateCompanionBuilder,
    (
      HifzActiveSessionRecord,
      BaseReferences<_$AppDatabase, $HifzActiveSessionsTable,
          HifzActiveSessionRecord>
    ),
    HifzActiveSessionRecord,
    PrefetchHooks Function()> {
  $$HifzActiveSessionsTableTableManager(
      _$AppDatabase db, $HifzActiveSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HifzActiveSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HifzActiveSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HifzActiveSessionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> sessionMode = const Value.absent(),
            Value<int?> rangeId = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> startAyah = const Value.absent(),
            Value<int> endAyah = const Value.absent(),
            Value<int> currentIndex = const Value.absent(),
            Value<bool> isRevealed = const Value.absent(),
            Value<int?> tappedMistakeWordPosition = const Value.absent(),
            Value<String> verseKeysJson = const Value.absent(),
            Value<String> gradesJson = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HifzActiveSessionsCompanion(
            id: id,
            isActive: isActive,
            sessionMode: sessionMode,
            rangeId: rangeId,
            surahNumber: surahNumber,
            startAyah: startAyah,
            endAyah: endAyah,
            currentIndex: currentIndex,
            isRevealed: isRevealed,
            tappedMistakeWordPosition: tappedMistakeWordPosition,
            verseKeysJson: verseKeysJson,
            gradesJson: gradesJson,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> sessionMode = const Value.absent(),
            Value<int?> rangeId = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> startAyah = const Value.absent(),
            Value<int> endAyah = const Value.absent(),
            Value<int> currentIndex = const Value.absent(),
            Value<bool> isRevealed = const Value.absent(),
            Value<int?> tappedMistakeWordPosition = const Value.absent(),
            Value<String> verseKeysJson = const Value.absent(),
            Value<String> gradesJson = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HifzActiveSessionsCompanion.insert(
            id: id,
            isActive: isActive,
            sessionMode: sessionMode,
            rangeId: rangeId,
            surahNumber: surahNumber,
            startAyah: startAyah,
            endAyah: endAyah,
            currentIndex: currentIndex,
            isRevealed: isRevealed,
            tappedMistakeWordPosition: tappedMistakeWordPosition,
            verseKeysJson: verseKeysJson,
            gradesJson: gradesJson,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HifzActiveSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HifzActiveSessionsTable,
    HifzActiveSessionRecord,
    $$HifzActiveSessionsTableFilterComposer,
    $$HifzActiveSessionsTableOrderingComposer,
    $$HifzActiveSessionsTableAnnotationComposer,
    $$HifzActiveSessionsTableCreateCompanionBuilder,
    $$HifzActiveSessionsTableUpdateCompanionBuilder,
    (
      HifzActiveSessionRecord,
      BaseReferences<_$AppDatabase, $HifzActiveSessionsTable,
          HifzActiveSessionRecord>
    ),
    HifzActiveSessionRecord,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$ReadingProgressTableTableManager get readingProgress =>
      $$ReadingProgressTableTableManager(_db, _db.readingProgress);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$TasbihEventsTableTableManager get tasbihEvents =>
      $$TasbihEventsTableTableManager(_db, _db.tasbihEvents);
  $$TasbihDailyTableTableManager get tasbihDaily =>
      $$TasbihDailyTableTableManager(_db, _db.tasbihDaily);
  $$DownloadsTableTableManager get downloads =>
      $$DownloadsTableTableManager(_db, _db.downloads);
  $$CachedChaptersTableTableManager get cachedChapters =>
      $$CachedChaptersTableTableManager(_db, _db.cachedChapters);
  $$CachedVersesTableTableManager get cachedVerses =>
      $$CachedVersesTableTableManager(_db, _db.cachedVerses);
  $$CachedResourceCatalogsTableTableManager get cachedResourceCatalogs =>
      $$CachedResourceCatalogsTableTableManager(
          _db, _db.cachedResourceCatalogs);
  $$CachedVerseAnnotationsTableTableManager get cachedVerseAnnotations =>
      $$CachedVerseAnnotationsTableTableManager(
          _db, _db.cachedVerseAnnotations);
  $$AdhkarDailyProgressTableTableManager get adhkarDailyProgress =>
      $$AdhkarDailyProgressTableTableManager(_db, _db.adhkarDailyProgress);
  $$HifzMemorizedRangesTableTableManager get hifzMemorizedRanges =>
      $$HifzMemorizedRangesTableTableManager(_db, _db.hifzMemorizedRanges);
  $$HifzReviewEventsTableTableManager get hifzReviewEvents =>
      $$HifzReviewEventsTableTableManager(_db, _db.hifzReviewEvents);
  $$HifzMistakeLogsTableTableManager get hifzMistakeLogs =>
      $$HifzMistakeLogsTableTableManager(_db, _db.hifzMistakeLogs);
  $$HifzActiveSessionsTableTableManager get hifzActiveSessions =>
      $$HifzActiveSessionsTableTableManager(_db, _db.hifzActiveSessions);
}
