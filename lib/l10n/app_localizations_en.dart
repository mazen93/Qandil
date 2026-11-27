// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Qandil';

  @override
  String get appTagline => 'Light for your day.';

  @override
  String get navHome => 'Home';

  @override
  String get navQuran => 'Quran';

  @override
  String get navPrayer => 'Prayer';

  @override
  String get navDhikr => 'Dhikr';

  @override
  String get navMore => 'More';

  @override
  String get homeGreeting => 'Peace be upon you';

  @override
  String get nextPrayerCardTitle => 'Next Prayer';

  @override
  String get nextPrayerPlaceholder =>
      'On-device prayer schedule and countdown will appear here once location is configured.';

  @override
  String get todaysWirdCardTitle => 'Today\'s Wird';

  @override
  String get todaysWirdPlaceholder =>
      'Continue reading from your saved Mushaf page and track your daily Khatmah progress.';

  @override
  String get continueReadingAction => 'Continue Reading';

  @override
  String savedReadingPositionSummary(
      String surahName, int ayahNumber, int pageNumber, int juzNumber) {
    return 'Surah $surahName • Ayah $ayahNumber • Page $pageNumber (Juz $juzNumber)';
  }

  @override
  String khatmahDailyGoalLabel(int pages, int percent) {
    return 'Daily target: $pages pages/day ($percent% complete)';
  }

  @override
  String get tasbihCardTitle => 'Daily Tasbih';

  @override
  String get tasbihPlaceholder =>
      'Track your daily dhikr counts and streak locally on your device.';

  @override
  String get verseOfTheDayCardTitle => 'Verse of the Day';

  @override
  String get verseOfTheDayPlaceholder =>
      'Loads deterministically from the verified local Quran Foundation dataset (Phase 2). No text is ever generated from memory.';

  @override
  String get quranShellTitle => 'Holy Quran';

  @override
  String get quranShellDescription =>
      'Mushaf page view, verse list, verified tafsir, translations, and recitations.';

  @override
  String get readerModeMushafPage => 'Mushaf Page';

  @override
  String get readerModeVerseList => 'Verse List';

  @override
  String get readerNavSurah => 'Surah';

  @override
  String get readerNavJuz => 'Juz';

  @override
  String get readerNavPage => 'Page';

  @override
  String get readerJumpToPage => 'Jump to Page';

  @override
  String get readerJumpToPageHint => 'Enter Mushaf page (1 - 604)';

  @override
  String get readerJumpAction => 'Go';

  @override
  String get readerSearchHint => 'Search Arabic Quran text...';

  @override
  String get readerSearchNoResults =>
      'No matching verses found in the loaded pages.';

  @override
  String readerPageHeader(int pageNumber, int juzNumber) {
    return 'Page $pageNumber • Juz $juzNumber';
  }

  @override
  String get readerSelectNavigationTitle => 'Navigate Quran';

  @override
  String get khatmahPlannerTitle => 'Khatmah Planner';

  @override
  String get khatmahTargetDaysLabel => 'Days to complete Khatmah';

  @override
  String khatmahPagesPerDayResult(int pages) {
    return '$pages pages per day';
  }

  @override
  String khatmahCatchUpWarning(
      int behindPages, int catchUpPages, int remainingDays) {
    return 'Behind by $behindPages pages • Catch-up pace: $catchUpPages pages/day over $remainingDays remaining days.';
  }

  @override
  String get khatmahOnTrackMessage =>
      'You are on track with your daily Khatmah schedule.';

  @override
  String get khatmahSavePlanAction => 'Save Khatmah Plan';

  @override
  String get readerSettingsTitle => 'Reading Settings';

  @override
  String get readerFontSizeLabel => 'Mushaf Font Size';

  @override
  String get readerLineSpacingLabel => 'Line Spacing';

  @override
  String get readerNightModeLabel => 'Night Mode (Dark)';

  @override
  String get readerKeepScreenAwakeLabel => 'Keep Screen Awake While Reading';

  @override
  String get verseSheetTafsirTab => 'Tafsir';

  @override
  String get verseSheetTranslationTab => 'Translation';

  @override
  String get verseSheetWordByWordTab => 'Word by Word';

  @override
  String get verseSheetBookmarkNoteTab => 'Bookmark & Note';

  @override
  String get verseSheetSelectTafsir => 'Select Tafsir';

  @override
  String get verseSheetSelectTranslation => 'Select Translation';

  @override
  String get verseSheetBookmarkColorLabel => 'Bookmark Color';

  @override
  String get verseSheetRemoveBookmark => 'Remove Bookmark';

  @override
  String get verseSheetNoteLabel => 'Personal Reflection Note';

  @override
  String get verseSheetNoteHint => 'Write your personal note on this verse...';

  @override
  String get verseSheetSaveNote => 'Save Note';

  @override
  String get verseSheetShareText => 'Share Text';

  @override
  String get verseSheetShareImage => 'Share Image';

  @override
  String get verseShareCreditLine =>
      'Source: King Fahd Glorious Quran Printing Complex via Quran Foundation (quran.com) — Shared via Qandil';

  @override
  String get audioModeVerseByVerse => 'Verse by Verse';

  @override
  String get audioModeFullSurah => 'Full Surah';

  @override
  String get audioSelectReciterTitle => 'Select Reciter';

  @override
  String get audioEgyptianReciterBadge => 'Egyptian Qari';

  @override
  String get audioRepeatTitle => 'Repeat Verse or Range';

  @override
  String get audioRepeatEnable => 'Enable Repeat';

  @override
  String get audioRepeatStartAyah => 'From Ayah';

  @override
  String get audioRepeatEndAyah => 'To Ayah';

  @override
  String get audioRepeatCountLabel => 'Repeat Count';

  @override
  String get audioContinueNextSurah => 'Continue to Next Surah Automatically';

  @override
  String get audioApplyAction => 'Apply';

  @override
  String get audioSleepTimerTitle => 'Sleep Timer';

  @override
  String get audioSleepTimerOff => 'Off';

  @override
  String audioSleepTimerMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get audioDownloadsTitle => 'Offline Audio & Storage';

  @override
  String audioStorageUsedLabel(String sizeText) {
    return 'App-Private Storage Used: $sizeText';
  }

  @override
  String audioReciterCreditBanner(String reciterName) {
    return 'Recitations provided via Quran Foundation (quran.com). Active Reciter: $reciterName';
  }

  @override
  String get audioDownloadSurahAction => 'Download for Offline Use';

  @override
  String get audioPauseDownloadAction => 'Pause';

  @override
  String get audioResumeDownloadAction => 'Resume';

  @override
  String get audioDeleteDownloadAction => 'Delete';

  @override
  String get audioDownloadedBadge => 'Available Offline';

  @override
  String get prayerTabTimes => 'Prayer Times';

  @override
  String get prayerTabQibla => 'Qibla';

  @override
  String get prayerTabHijri => 'Hijri Calendar';

  @override
  String get prayerScheduleToday => 'Today';

  @override
  String get prayerScheduleTomorrow => 'Tomorrow';

  @override
  String get prayerScheduleThirtyDays => '30-Day List';

  @override
  String get prayerFajr => 'Fajr';

  @override
  String get prayerSunrise => 'Sunrise';

  @override
  String get prayerDhuhr => 'Dhuhr';

  @override
  String get prayerAsr => 'Asr';

  @override
  String get prayerMaghrib => 'Maghrib';

  @override
  String get prayerIsha => 'Isha';

  @override
  String prayerNextCountdownLabel(String prayerName, String countdown) {
    return '$prayerName in $countdown';
  }

  @override
  String get prayerUseGpsAction => 'Detect GPS Location';

  @override
  String get prayerManualCitySearchTitle => 'Select City Manually';

  @override
  String get prayerManualCitySearchHint =>
      'Search city (e.g. Cairo, Alexandria, Makkah)...';

  @override
  String get prayerCalculationSettingsTitle => 'Prayer Calculation Options';

  @override
  String get prayerAsrSchoolLabel => 'Asr Juristic Method';

  @override
  String get prayerAsrShafi => 'Standard (Shafi\'i, Maliki, Hanbali)';

  @override
  String get prayerAsrHanafi => 'Hanafi';

  @override
  String get prayerHighLatitudeRuleLabel => 'High-Latitude Rule';

  @override
  String get highLatMiddleOfNight => 'Middle of the Night';

  @override
  String get highLatSeventhOfNight => 'Seventh of the Night';

  @override
  String get highLatTwilightAngle => 'Twilight Angle';

  @override
  String get prayerManualAdjustmentsSection =>
      'Manual Minute Adjustments (-30 to +30 min)';

  @override
  String qiblaBearingLabel(String bearing) {
    return 'Qibla Bearing: $bearing';
  }

  @override
  String get qiblaAlignedStatus => 'Aligned with Qibla';

  @override
  String get qiblaCalibrationHint =>
      'Calibration Tip: Move your phone in a figure-8 motion away from metal objects or magnetic cases.';

  @override
  String get qiblaLowAccuracyWarning =>
      'Low compass sensor accuracy detected. Please calibrate your device by tilting it in a figure-8 pattern.';

  @override
  String get qiblaNoSensorFallbackTitle =>
      'Static Qibla Bearing (No Compass Sensor)';

  @override
  String qiblaNoSensorFallbackBody(String bearing) {
    return 'Your device does not report live compass sensor headings. Face $bearing clockwise from True North.';
  }

  @override
  String get hijriAdjustmentLabel => 'Hijri Moon-Sighting Adjustment (Days)';

  @override
  String get hijriAdjustmentSubtitle =>
      'Adjust Umm al-Qura Hijri date by -2 to +2 days to match local moon sighting.';

  @override
  String get islamicOccasionsTitle => 'Islamic Occasions';

  @override
  String get notifSettingsTitle => 'Notifications & Reminders';

  @override
  String get notifConfigureAction =>
      'Configure Prayer Alerts, Reminders & Health';

  @override
  String get notifMissingAdhanAssetBanner =>
      'Custom Adhan audio files (assets/audio/adhan.mp3) are not yet bundled. Using the system default notification sound until Adhan audio files are added.';

  @override
  String get notifPerPrayerSectionTitle => 'Five Daily Prayer Alerts';

  @override
  String get notifAtPrayerTime => 'At Prayer Time';

  @override
  String notifMinutesBefore(int minutes) {
    return '$minutes min before';
  }

  @override
  String get notifSoundAdhan => 'Adhan / Default Sound';

  @override
  String get notifSoundSilent => 'Silent';

  @override
  String get notifWirdReminderTitle => 'Daily Quran Wird Reminder';

  @override
  String get notifFridayReminderTitle => 'Friday Reminder (Surah Al-Kahf)';

  @override
  String get notifTasbihReminderTitle => 'Daily Tasbih Reminder';

  @override
  String get notifMorningAdhkarReminderTitle => 'Morning Adhkar Reminder';

  @override
  String get notifEveningAdhkarReminderTitle => 'Evening Adhkar Reminder';

  @override
  String get notifHealthTitle => 'Notification Health & Status';

  @override
  String get notifHealthPermissionLabel =>
      'Notifications Permission (Android 13+ / iOS)';

  @override
  String get notifHealthExactAlarmLabel =>
      'Exact Alarms Access (Android 14+ SCHEDULE_EXACT_ALARM)';

  @override
  String get notifHealthStatusGranted => 'Granted';

  @override
  String get notifHealthStatusRequired => 'Action Needed';

  @override
  String get notifHealthGrantAction => 'Grant / Open Settings';

  @override
  String get notifHealthBudgetLabel =>
      'Scheduled Pending Items (7-Day Rolling Window)';

  @override
  String notifHealthBudgetValue(int count, int maxBudget) {
    return '$count / $maxBudget budgeted (iOS max 64)';
  }

  @override
  String get notifHealthNextThreeTitle => 'Next 3 Scheduled Times';

  @override
  String get notifHealthNoScheduled => 'No upcoming notifications scheduled.';

  @override
  String get batteryHelpTitle => 'Battery Optimization Help';

  @override
  String get batteryHelpIntro =>
      'Some phone manufacturers restrict background alarms after the app is closed. Follow the steps for your device brand below so prayer alerts always fire on time:';

  @override
  String get batteryHelpSamsungTitle => 'Samsung (One UI)';

  @override
  String get batteryHelpSamsungBody =>
      'Open Settings → Apps → Qandil → Battery → Select \'Unrestricted\'. Also ensure Qandil is not in \'Sleeping apps\' under Device Care.';

  @override
  String get batteryHelpXiaomiTitle => 'Xiaomi / Redmi / POCO (MIUI & HyperOS)';

  @override
  String get batteryHelpXiaomiBody =>
      'Open Settings → Apps → Manage apps → Qandil → Enable \'Autostart\', then tap Battery saver and select \'No restrictions\'.';

  @override
  String get batteryHelpHuaweiTitle => 'Huawei / Honor (EMUI)';

  @override
  String get batteryHelpHuaweiBody =>
      'Open Settings → Battery → App launch → Find Qandil → Turn off \'Manage automatically\' and enable Auto-launch, Secondary launch, and Run in background.';

  @override
  String get batteryHelpOnePlusOppoTitle =>
      'OnePlus / Oppo / Realme (OxygenOS & ColorOS)';

  @override
  String get batteryHelpOnePlusOppoBody =>
      'Open Settings → Apps → App Management → Qandil → Battery Usage → Enable \'Allow background activity\' and \'Allow auto launch\'.';

  @override
  String get tasbihTabCounter => 'Tasbih Counter';

  @override
  String get tasbihTabStats => 'Statistics';

  @override
  String get tasbihSelectDhikrLabel => 'Active Dhikr';

  @override
  String get tasbihAddCustomDhikrTitle => 'Add Custom Dhikr Label';

  @override
  String get tasbihAddCustomDhikrHint => 'Type your custom dhikr label...';

  @override
  String get tasbihTargetPresetLabel => 'Target';

  @override
  String get tasbihCustomTargetTitle => 'Custom Target Count';

  @override
  String get tasbihCustomTargetHint => 'Enter target count (e.g. 500)';

  @override
  String get tasbihHapticsTooltip => 'Toggle Haptic Vibration';

  @override
  String get tasbihTapPrompt => 'Tap anywhere inside the circle to count';

  @override
  String tasbihCompletedRoundsLabel(int rounds, int todayTotal) {
    return 'Rounds: $rounds • Today: $todayTotal';
  }

  @override
  String get tasbihUndoAction => 'Undo';

  @override
  String get tasbihResetAction => 'Reset Lap';

  @override
  String get tasbihSaveSessionAction => 'Save Session';

  @override
  String get tasbihPeriodToday => 'Today';

  @override
  String get tasbihPeriodSevenDays => '7 Days';

  @override
  String get tasbihPeriodThirtyDays => '30 Days';

  @override
  String get tasbihPeriodAllTime => 'All Time';

  @override
  String get tasbihCurrentStreakLabel => 'Current Streak';

  @override
  String get tasbihBestStreakLabel => 'Best Streak';

  @override
  String get tasbihPerDhikrBreakdownTitle => 'Per-Dhikr Breakdown';

  @override
  String get tasbihEmptyStatsMessage =>
      'No tasbih counts recorded yet. Start tapping on the Counter tab to build your daily streak.';

  @override
  String get tasbihExportJsonAction => 'Export Stats as JSON';

  @override
  String get prayerShellTitle => 'Prayer Times & Qibla';

  @override
  String get prayerShellDescription =>
      'On-device prayer calculations, Qibla compass, and Umm al-Qura Hijri calendar.';

  @override
  String get dhikrShellTitle => 'Adhkar & Tasbih';

  @override
  String get dhikrShellDescription =>
      'Verified morning and evening adhkar, prophetic duas, and tasbih counter with statistics.';

  @override
  String get settingsTitle => 'Settings & More';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get settingsTheme => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light (Ivory)';

  @override
  String get themeDark => 'Dark (Night)';

  @override
  String get settingsTextSize => 'UI Text Size';

  @override
  String get settingsTextSizePreview =>
      'Read, listen and keep your daily wird.';

  @override
  String get settingsPrayerMethod => 'Prayer Calculation Method';

  @override
  String get prayerMethodEgyptian => 'Egyptian General Authority of Survey';

  @override
  String get prayerMethodUmmAlQura => 'Umm al-Qura University, Makkah';

  @override
  String get prayerMethodMuslimWorldLeague => 'Muslim World League';

  @override
  String get prayerMethodKarachi => 'University of Islamic Sciences, Karachi';

  @override
  String get prayerMethodNorthAmerica => 'ISNA (North America)';

  @override
  String get settingsNotifications => 'Prayer & Wird Reminders';

  @override
  String get settingsNotificationsSubtitle =>
      'Receive local reminders for prayers, daily wird, and adhkar.';

  @override
  String get settingsAboutCredits => 'About & Credits';

  @override
  String get settingsAboutCreditsSubtitle =>
      'Data sources, Quran Foundation attribution, fonts, and open-source licenses.';

  @override
  String get creditsTitle => 'About & Credits';

  @override
  String get creditsContentIntegrityTitle => 'Content Integrity Pledge';

  @override
  String get creditsContentIntegrityBody =>
      'Qandil never generates, alters, normalizes, or machine-translates Quranic text, tafsir, translations, adhkar, or duas. All religious content is loaded unaltered from verified scholarly sources.';

  @override
  String get creditsQuranSourceTitle =>
      'Quran Text, Tafsir, Translations & Audio';

  @override
  String get creditsQuranSourceBody =>
      'Provided by Quran Foundation (quran.com / api-docs.quran.com). Default Arabic Tafsir: Al-Tafsir Al-Muyassar (King Fahd Glorious Quran Printing Complex). Default English Translation: The Clear Quran (Dr. Mustafa Khattab).';

  @override
  String get creditsAdhkarSourceTitle => 'Morning & Evening Adhkar and Duas';

  @override
  String get creditsAdhkarSourceBody =>
      'Morning and evening adhkar from Seen-Arabic/Morning-And-Evening-Adhkar-DB (MIT License), based on Hisn al-Muslim by Sa\'id bin Ali bin Wahf al-Qahtani.';

  @override
  String get creditsFontsTitle => 'Typography & Mushaf Script';

  @override
  String get creditsFontsBody =>
      'Quranic script rendered in KFGQPC Uthmanic Script Hafs Ver 18 (King Fahd Glorious Quran Printing Complex via Quran Foundation). Headings and brand wordmark set in Reem Kufi (by Khaled Hosny, SIL Open Font License 1.1). User interface set in IBM Plex Sans Arabic (by IBM Corp., SIL Open Font License 1.1).';

  @override
  String get creditsOpenSourceLicenses => 'View Open-Source Licenses';

  @override
  String tasbihCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasbihs',
      one: '1 tasbih',
      zero: 'No tasbih today',
    );
    return '$_temp0';
  }

  @override
  String verseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count verses',
      one: '1 verse',
      zero: 'No verses',
    );
    return '$_temp0';
  }

  @override
  String pageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1 page',
      zero: 'No pages',
    );
    return '$_temp0';
  }

  @override
  String dayStreakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days streak',
      one: '1 day streak',
      zero: 'No streak yet',
    );
    return '$_temp0';
  }

  @override
  String get adhkarTabTitle => 'Adhkar & Duas';

  @override
  String get tasbihTabTitle => 'Tasbih Counter';

  @override
  String get morningAdhkarBannerTitle => 'Morning Adhkar';

  @override
  String get morningAdhkarBannerSubtitle =>
      'Begin your day with remembrance and serenity';

  @override
  String get eveningAdhkarBannerTitle => 'Evening Adhkar';

  @override
  String get eveningAdhkarBannerSubtitle =>
      'End your day with peace and protection';

  @override
  String get readAdhkarAction => 'Read Adhkar';

  @override
  String get categoryPendingNotice => 'Pending import';

  @override
  String get categoryEmptyTitle => 'No Adhkar in this category yet';

  @override
  String get categoryEmptyDescription =>
      'This category is currently pending verification and import from authentic sources.';

  @override
  String adhkarProgressCompleted(int completed, int total) {
    return '$completed of $total completed';
  }

  @override
  String adhkarItemCounter(int current, int total) {
    return '$current of $total';
  }

  @override
  String get adhkarSourceLabel => 'Source';

  @override
  String get adhkarFadlLabel => 'Virtue';

  @override
  String get adhkarMarkCompletedAction => 'Mark Read';

  @override
  String get adhkarResetCategoryAction => 'Reset Today\'s Progress';

  @override
  String get adhkarResetCategoryConfirm =>
      'Do you want to reset today\'s progress for this category?';

  @override
  String get adhkarFontSizeLabel => 'Font Size';

  @override
  String get adhkarShareCredit => 'Qandil App — Light for your day';

  @override
  String get readingModeTitle => 'Reading & Focus Mode';

  @override
  String get readingModeActivePill => 'Reading Mode Active — Tap to Exit';

  @override
  String get readingModeToggleTooltip => 'Toggle Reading Mode';

  @override
  String get readingModeAutoStartLabel => 'Start Reading Mode automatically';

  @override
  String get readingModeAutoStartSubtitle =>
      'Keep screen awake, dim UI chrome, and hold in-app reminders while reading.';

  @override
  String get readingModeDndEnabledLabel =>
      'Do Not Disturb while reading (Android)';

  @override
  String get readingModeDndEnabledSubtitle =>
      'Saves your previous DND filter before reading and always restores it on exit or next launch.';

  @override
  String get readingModeDndFilterLabel => 'Android Interruption Filter';

  @override
  String get readingModeDndFilterPriorityTitle =>
      'Priority & Adhan Allowed (Recommended)';

  @override
  String get readingModeDndFilterPrioritySubtitle =>
      'Lets Qandil\'s Adhan, alarms, and priority contacts through while silencing general notifications.';

  @override
  String get readingModeDndFilterAlarmsTitle => 'Alarms & Adhan Only';

  @override
  String get readingModeDndFilterAlarmsSubtitle =>
      'Blocks calls and messages; only lets system alarms and Qandil\'s alarm-category Adhan through.';

  @override
  String get readingModeDndFilterNoneTitle =>
      'Total Silence (Mutes Adhan & Alarms)';

  @override
  String get readingModeDndFilterNoneSubtitle =>
      'Blocks all sounds and notifications, including Adhan and alarms.';

  @override
  String get readingModeAndroidPermissionTitle =>
      'Notification Policy Access Required';

  @override
  String get readingModeAndroidPermissionBody =>
      'To enable Do Not Disturb while reading, Qandil needs Android Notification Policy access. Qandil saves your current filter before reading and always restores it on exit — never leaving your phone in DND silently.';

  @override
  String get readingModeOpenAndroidDndSettingsAction =>
      'Open Notification Policy Settings';

  @override
  String get readingModeVerifyDndPermissionAction => 'Verify & Enable Now';

  @override
  String get readingModeDndPermissionNotGrantedWarning =>
      'Permission has not been granted in system settings yet.';

  @override
  String get readingModeIosFocusTipTitle => 'iOS Focus Mode & Shortcuts Tip';

  @override
  String get readingModeIosFocusTipBody =>
      'iOS does not allow apps to toggle Do Not Disturb programmatically. To enjoy distraction-free reading on iPhone:\n1. Open the Apple Shortcuts app > Automation.\n2. Create a Personal Automation: When \'Qandil\' is Opened → Set Focus to \'Reading\' (or Do Not Disturb) until you leave the app.';

  @override
  String get readingModeIosFocusTipButton =>
      'How to set up iOS Focus Mode for Qandil';

  @override
  String get readingModeGotItAction => 'Got It';

  @override
  String readingModeHeldNotificationsToast(int count) {
    return '$count in-app reminder(s) were held while you were reading.';
  }

  @override
  String get onboardingSkipAction => 'Skip';

  @override
  String get onboardingNextAction => 'Next';

  @override
  String get onboardingStartAction => 'Begin with Qandil';

  @override
  String get onboardingReadTitle => 'Read with Calm & Reflection';

  @override
  String get onboardingReadSubtitle =>
      'Authentic Madani Uthmanic Mushaf script, scholarly tafsir, translations, word-by-word meanings, and distraction-free Reading Mode.';

  @override
  String get onboardingListenTitle => 'Listen to Renowned Reciters';

  @override
  String get onboardingListenSubtitle =>
      'Beloved Egyptian and world Qaris with live verse highlighting, range repeat, and offline surah downloads.';

  @override
  String get onboardingWirdTitle => 'Keep Your Daily Wird';

  @override
  String get onboardingWirdSubtitle =>
      'A gentle Khatmah planner, on-device prayer times and Qibla, verified morning and evening adhkar, and daily tasbih.';

  @override
  String get settingsReplayOnboarding => 'Qandil Welcome Tour';

  @override
  String get settingsReplayOnboardingSubtitle =>
      'View the 3-screen introduction to reading, listening, and keeping your daily wird.';

  @override
  String get homeGreetingMorning => 'Good morning — light for your day';

  @override
  String get homeGreetingAfternoon => 'Good afternoon — peace for your day';

  @override
  String get homeGreetingEvening => 'Good evening — serenity for your night';

  @override
  String get homeMissingLocationPlaceholder =>
      'Select your city on the Prayer screen to view prayer times and live countdown.';

  @override
  String get homeQuickTasbihAction => 'Quick Tasbih (+1)';

  @override
  String get homeMorningAdhkarShortcut => 'Morning Adhkar';

  @override
  String get homeEveningAdhkarShortcut => 'Evening Adhkar';

  @override
  String get homeOpenVerseWithTafsirAction => 'Read Verse & Tafsir';

  @override
  String get hifzTitle => 'Memorization & Review (Hifz)';

  @override
  String get hifzTabPlan => 'Plan & Queue';

  @override
  String get hifzTabTest => 'Test & Recite';

  @override
  String get hifzTabMistakes => 'Weak Spots';

  @override
  String get hifzTabStats => 'Stats & Teacher';

  @override
  String get hifzAddRangeTitle => 'Add Memorized Verse Range';

  @override
  String get hifzAddRangeAction => 'Add Memorized Range';

  @override
  String get hifzDailyGoalsTitle => 'Daily Hifz & Review Goals';

  @override
  String get hifzNewVersesPerDayLabel => 'New verses per day';

  @override
  String get hifzReviewsPerDayCapLabel => 'Daily review queue cap';

  @override
  String get hifzCatchUpModeLabel =>
      'Catch-Up Mode (spread missed overdue reviews across days)';

  @override
  String get hifzDueQueueTitle => 'Today\'s Due Review Queue';

  @override
  String get hifzDueQueueEmpty =>
      'No review ranges due right now. Add a memorized range or start a test session.';

  @override
  String get hifzAudioHelperTitle => 'Hifz Audio Loop Helper';

  @override
  String get hifzAudioPauseGapLabel =>
      'Pause gap to repeat after reciter (seconds)';

  @override
  String get hifzStartAudioLoopAction => 'Loop Range with Reciter';

  @override
  String get hifzTestModeByNumber => 'Recite by Verse #';

  @override
  String get hifzTestModeNextVerse => 'What\'s Next Verse?';

  @override
  String get hifzTestModeMistakes => 'Review My Mistakes';

  @override
  String get hifzRevealVerseAction => 'Reveal Verse to Check';

  @override
  String get hifzTapMistakeWordHint =>
      'Tap any word you hesitated on (optional), then self-grade:';

  @override
  String get hifzGradePerfect => 'Perfect';

  @override
  String get hifzGradeHesitated => 'Hesitated';

  @override
  String get hifzGradeForgot => 'Forgot';

  @override
  String get hifzWeakSpotsTitle => 'Weak Spots & Mistake Log';

  @override
  String get hifzWeakSpotsEmpty =>
      'No mistakes logged yet. Verses graded Hesitated or Forgot will appear here.';

  @override
  String get hifzMutashabihatTitle =>
      'Similar Verses (Mutashabihat — Verified Extension Point)';

  @override
  String get hifzMutashabihatNotice =>
      'To preserve strict Quranic content integrity, Qandil never generates mutashabihat pairs automatically. Verified pairs will appear here once assets/data/mutashabihat.json is supplied.';

  @override
  String get hifzStatsMemorizedVerses => 'Memorized Verses';

  @override
  String get hifzStatsMemorizedPages => 'Pages';

  @override
  String get hifzStatsMemorizedJuz => 'Juz';

  @override
  String get hifzStatsReviewStreak => 'Review Streak';

  @override
  String get hifzStatsWeeklyAccuracy => '7-Day Accuracy';

  @override
  String get hifzStatsProjectedCompletion => 'Projected Completion Date';

  @override
  String get hifzTeacherExportAction => 'Export Teacher Progress Report (JSON)';

  @override
  String get hifzHideModeTitle => 'Hifz Reader Hide Mode';

  @override
  String get hifzHideModeNone => 'Normal Display (No Hiding)';

  @override
  String get hifzHideModeAll => 'Hide All Words';

  @override
  String get hifzHideModeFirstWord => 'Show Only First Word of Each Verse';

  @override
  String get hifzHideModeRandom => 'Hide Random % of Words';

  @override
  String get hifzHideModeUntilTapped => 'Hide Verse Until Tapped';

  @override
  String get hifzHideModeWordByWord => 'Reveal Word by Word on Tap';

  @override
  String get creditsRecitersTitle => 'Quran Reciters & Audio Sources';

  @override
  String get creditsRecitersBody =>
      'Audio recitations are streamed and downloaded with permission via Quran Foundation (quran.com), featuring prioritized Egyptian Qaris: Sheikh Mahmoud Khalil Al-Husary (Murattal & Muallim), Sheikh AbdulBaset AbdulSamad (Mujawwad & Murattal), Sheikh Mohamed Siddiq al-Minshawi (Murattal & Mujawwad), Sheikh Mishari Rashid al-`Afasy, Sheikh Abdur-Rahman as-Sudais, Sheikh Sa`ud ash-Shuraym, Sheikh Saad al-Ghamdi, Sheikh Abu Bakr al-Shatri, and Sheikh Hani ar-Rifai.';

  @override
  String get creditsTafsirTranslationsTitle => 'Tafsir & Translations';

  @override
  String get creditsTafsirTranslationsBody =>
      'Default Arabic Tafsir: Al-Tafsir Al-Muyassar (King Fahd Glorious Quran Printing Complex) and Tafsir Ibn Kathir via Quran Foundation API. English Translations: Saheeh International and The Clear Quran (Dr. Mustafa Khattab) via Quran Foundation API.';

  @override
  String get creditsPrayerHijriTitle => 'Prayer Times, Qibla & Hijri Calendar';

  @override
  String get creditsPrayerHijriBody =>
      'Prayer times and Qibla bearing are computed 100% on-device using the adhan astronomical library (defaulting to the Egyptian General Authority of Survey). Hijri dates use the Umm al-Qura calendar (hijri_core) with a -2 to +2 day moon-sighting adjustment.';

  @override
  String get creditsPrivacyTitle => 'Privacy Policy & On-Device Guarantee';

  @override
  String get creditsPrivacyBody =>
      'Qandil requires no account, displays zero ads, and includes zero analytics or tracking SDKs. Your foreground location is used solely on your device to calculate prayer times and Qibla direction and is never sent to any server. All personal worship data (bookmarks, notes, Khatmah, Hifz progress, and Tasbih stats) is stored locally on your device.';

  @override
  String get retry => 'Retry';

  @override
  String get notFoundTitle => 'Page Not Found';

  @override
  String get notFoundMessage => 'The page you are looking for does not exist.';

  @override
  String get backToHome => 'Back to Home';
}
