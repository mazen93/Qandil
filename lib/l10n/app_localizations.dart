import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Application brand name
  ///
  /// In en, this message translates to:
  /// **'Qandil'**
  String get appTitle;

  /// Qandil brand tagline
  ///
  /// In en, this message translates to:
  /// **'Light for your day.'**
  String get appTagline;

  /// Bottom navigation label for Home tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom navigation label for Quran tab
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get navQuran;

  /// Bottom navigation label for Prayer tab
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get navPrayer;

  /// Bottom navigation label for Dhikr tab
  ///
  /// In en, this message translates to:
  /// **'Dhikr'**
  String get navDhikr;

  /// Bottom navigation label for More/Settings tab
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// Calm greeting on the Home header
  ///
  /// In en, this message translates to:
  /// **'Peace be upon you'**
  String get homeGreeting;

  /// Title of the Next Prayer card on Home
  ///
  /// In en, this message translates to:
  /// **'Next Prayer'**
  String get nextPrayerCardTitle;

  /// Placeholder text for Next Prayer card in Phase 1
  ///
  /// In en, this message translates to:
  /// **'On-device prayer schedule and countdown will appear here once location is configured.'**
  String get nextPrayerPlaceholder;

  /// Title of Today's Wird card on Home
  ///
  /// In en, this message translates to:
  /// **'Today\'s Wird'**
  String get todaysWirdCardTitle;

  /// Placeholder text for Today's Wird card in Phase 1
  ///
  /// In en, this message translates to:
  /// **'Continue reading from your saved Mushaf page and track your daily Khatmah progress.'**
  String get todaysWirdPlaceholder;

  /// CTA button to resume reading from saved position
  ///
  /// In en, this message translates to:
  /// **'Continue Reading'**
  String get continueReadingAction;

  /// Summary of saved reading position on Home card
  ///
  /// In en, this message translates to:
  /// **'Surah {surahName} • Ayah {ayahNumber} • Page {pageNumber} (Juz {juzNumber})'**
  String savedReadingPositionSummary(
      String surahName, int ayahNumber, int pageNumber, int juzNumber);

  /// Khatmah daily goal summary
  ///
  /// In en, this message translates to:
  /// **'Daily target: {pages} pages/day ({percent}% complete)'**
  String khatmahDailyGoalLabel(int pages, int percent);

  /// Title of Tasbih card on Home
  ///
  /// In en, this message translates to:
  /// **'Daily Tasbih'**
  String get tasbihCardTitle;

  /// Placeholder text for Tasbih card in Phase 1
  ///
  /// In en, this message translates to:
  /// **'Track your daily dhikr counts and streak locally on your device.'**
  String get tasbihPlaceholder;

  /// Title of Verse of the Day card on Home
  ///
  /// In en, this message translates to:
  /// **'Verse of the Day'**
  String get verseOfTheDayCardTitle;

  /// Placeholder text for Verse of the Day card ensuring strict content integrity
  ///
  /// In en, this message translates to:
  /// **'Loads deterministically from the verified local Quran Foundation dataset (Phase 2). No text is ever generated from memory.'**
  String get verseOfTheDayPlaceholder;

  /// Title for Quran tab shell
  ///
  /// In en, this message translates to:
  /// **'Holy Quran'**
  String get quranShellTitle;

  /// Description on Quran tab shell
  ///
  /// In en, this message translates to:
  /// **'Mushaf page view, verse list, verified tafsir, translations, and recitations.'**
  String get quranShellDescription;

  /// Mushaf page view toggle label
  ///
  /// In en, this message translates to:
  /// **'Mushaf Page'**
  String get readerModeMushafPage;

  /// Verse list view toggle label
  ///
  /// In en, this message translates to:
  /// **'Verse List'**
  String get readerModeVerseList;

  /// Browse by Surah tab label
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get readerNavSurah;

  /// Browse by Juz tab label
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get readerNavJuz;

  /// Browse by Page tab label
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get readerNavPage;

  /// Jump to page dialog title and action
  ///
  /// In en, this message translates to:
  /// **'Jump to Page'**
  String get readerJumpToPage;

  /// Input hint for jump to page
  ///
  /// In en, this message translates to:
  /// **'Enter Mushaf page (1 - 604)'**
  String get readerJumpToPageHint;

  /// Confirm jump to page button
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get readerJumpAction;

  /// Search input placeholder in Quran reader
  ///
  /// In en, this message translates to:
  /// **'Search Arabic Quran text...'**
  String get readerSearchHint;

  /// Empty state for Quran search
  ///
  /// In en, this message translates to:
  /// **'No matching verses found in the loaded pages.'**
  String get readerSearchNoResults;

  /// Header bar inside Mushaf page view
  ///
  /// In en, this message translates to:
  /// **'Page {pageNumber} • Juz {juzNumber}'**
  String readerPageHeader(int pageNumber, int juzNumber);

  /// Title for Surah/Juz/Page navigation sheet
  ///
  /// In en, this message translates to:
  /// **'Navigate Quran'**
  String get readerSelectNavigationTitle;

  /// Title of Khatmah planner bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Khatmah Planner'**
  String get khatmahPlannerTitle;

  /// Label for selecting Khatmah duration in days
  ///
  /// In en, this message translates to:
  /// **'Days to complete Khatmah'**
  String get khatmahTargetDaysLabel;

  /// Computed pages per day
  ///
  /// In en, this message translates to:
  /// **'{pages} pages per day'**
  String khatmahPagesPerDayResult(int pages);

  /// Catch-up alert when behind schedule
  ///
  /// In en, this message translates to:
  /// **'Behind by {behindPages} pages • Catch-up pace: {catchUpPages} pages/day over {remainingDays} remaining days.'**
  String khatmahCatchUpWarning(
      int behindPages, int catchUpPages, int remainingDays);

  /// Message shown when Khatmah is on track
  ///
  /// In en, this message translates to:
  /// **'You are on track with your daily Khatmah schedule.'**
  String get khatmahOnTrackMessage;

  /// Button to save Khatmah plan
  ///
  /// In en, this message translates to:
  /// **'Save Khatmah Plan'**
  String get khatmahSavePlanAction;

  /// Title of Quran reading settings bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Reading Settings'**
  String get readerSettingsTitle;

  /// Slider label for Mushaf font size
  ///
  /// In en, this message translates to:
  /// **'Mushaf Font Size'**
  String get readerFontSizeLabel;

  /// Slider label for Mushaf line spacing
  ///
  /// In en, this message translates to:
  /// **'Line Spacing'**
  String get readerLineSpacingLabel;

  /// Toggle for Night mode inside reader
  ///
  /// In en, this message translates to:
  /// **'Night Mode (Dark)'**
  String get readerNightModeLabel;

  /// Toggle for wakelock while reading
  ///
  /// In en, this message translates to:
  /// **'Keep Screen Awake While Reading'**
  String get readerKeepScreenAwakeLabel;

  /// Tafsir tab in verse action sheet
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get verseSheetTafsirTab;

  /// Translation tab in verse action sheet
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get verseSheetTranslationTab;

  /// Word by word tab in verse action sheet
  ///
  /// In en, this message translates to:
  /// **'Word by Word'**
  String get verseSheetWordByWordTab;

  /// Bookmark and note tab in verse action sheet
  ///
  /// In en, this message translates to:
  /// **'Bookmark & Note'**
  String get verseSheetBookmarkNoteTab;

  /// Dropdown label for selecting Tafsir
  ///
  /// In en, this message translates to:
  /// **'Select Tafsir'**
  String get verseSheetSelectTafsir;

  /// Dropdown label for selecting Translation
  ///
  /// In en, this message translates to:
  /// **'Select Translation'**
  String get verseSheetSelectTranslation;

  /// Label for bookmark color picker
  ///
  /// In en, this message translates to:
  /// **'Bookmark Color'**
  String get verseSheetBookmarkColorLabel;

  /// Action to remove bookmark
  ///
  /// In en, this message translates to:
  /// **'Remove Bookmark'**
  String get verseSheetRemoveBookmark;

  /// Label for verse note text field
  ///
  /// In en, this message translates to:
  /// **'Personal Reflection Note'**
  String get verseSheetNoteLabel;

  /// Hint for verse note text field
  ///
  /// In en, this message translates to:
  /// **'Write your personal note on this verse...'**
  String get verseSheetNoteHint;

  /// Button to save verse note
  ///
  /// In en, this message translates to:
  /// **'Save Note'**
  String get verseSheetSaveNote;

  /// Button to share verse as text with credit line
  ///
  /// In en, this message translates to:
  /// **'Share Text'**
  String get verseSheetShareText;

  /// Button to share verse as image card with credit line
  ///
  /// In en, this message translates to:
  /// **'Share Image'**
  String get verseSheetShareImage;

  /// Mandatory attribution credit line included when sharing a verse
  ///
  /// In en, this message translates to:
  /// **'Source: King Fahd Glorious Quran Printing Complex via Quran Foundation (quran.com) — Shared via Qandil'**
  String get verseShareCreditLine;

  /// Verse by verse audio playback mode
  ///
  /// In en, this message translates to:
  /// **'Verse by Verse'**
  String get audioModeVerseByVerse;

  /// Full surah continuous audio playback mode
  ///
  /// In en, this message translates to:
  /// **'Full Surah'**
  String get audioModeFullSurah;

  /// Title of reciter picker sheet
  ///
  /// In en, this message translates to:
  /// **'Select Reciter'**
  String get audioSelectReciterTitle;

  /// Badge shown next to prioritized Egyptian reciters
  ///
  /// In en, this message translates to:
  /// **'Egyptian Qari'**
  String get audioEgyptianReciterBadge;

  /// Title of repeat range dialog
  ///
  /// In en, this message translates to:
  /// **'Repeat Verse or Range'**
  String get audioRepeatTitle;

  /// Toggle for enabling verse/range repeat
  ///
  /// In en, this message translates to:
  /// **'Enable Repeat'**
  String get audioRepeatEnable;

  /// Start ayah input label
  ///
  /// In en, this message translates to:
  /// **'From Ayah'**
  String get audioRepeatStartAyah;

  /// End ayah input label
  ///
  /// In en, this message translates to:
  /// **'To Ayah'**
  String get audioRepeatEndAyah;

  /// Label for number of times to repeat
  ///
  /// In en, this message translates to:
  /// **'Repeat Count'**
  String get audioRepeatCountLabel;

  /// Toggle to auto-advance to next surah
  ///
  /// In en, this message translates to:
  /// **'Continue to Next Surah Automatically'**
  String get audioContinueNextSurah;

  /// Confirm button for audio repeat settings
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get audioApplyAction;

  /// Title of sleep timer sheet
  ///
  /// In en, this message translates to:
  /// **'Sleep Timer'**
  String get audioSleepTimerTitle;

  /// Disable sleep timer option
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get audioSleepTimerOff;

  /// Sleep timer duration in minutes
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String audioSleepTimerMinutes(int minutes);

  /// Title for Offline Audio Downloads and Storage Usage screen
  ///
  /// In en, this message translates to:
  /// **'Offline Audio & Storage'**
  String get audioDownloadsTitle;

  /// Total disk storage used by offline recitations
  ///
  /// In en, this message translates to:
  /// **'App-Private Storage Used: {sizeText}'**
  String audioStorageUsedLabel(String sizeText);

  /// Explicit reciter credit banner on the offline downloads screen
  ///
  /// In en, this message translates to:
  /// **'Recitations provided via Quran Foundation (quran.com). Active Reciter: {reciterName}'**
  String audioReciterCreditBanner(String reciterName);

  /// Tooltip/action to download a surah for offline listening
  ///
  /// In en, this message translates to:
  /// **'Download for Offline Use'**
  String get audioDownloadSurahAction;

  /// Pause active audio download
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get audioPauseDownloadAction;

  /// Resume paused audio download
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get audioResumeDownloadAction;

  /// Delete downloaded offline audio
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get audioDeleteDownloadAction;

  /// Status label for completed offline audio download
  ///
  /// In en, this message translates to:
  /// **'Available Offline'**
  String get audioDownloadedBadge;

  /// Prayer times sub-tab label
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTabTimes;

  /// Qibla compass sub-tab label
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get prayerTabQibla;

  /// Hijri calendar sub-tab label
  ///
  /// In en, this message translates to:
  /// **'Hijri Calendar'**
  String get prayerTabHijri;

  /// Today's prayer schedule filter
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get prayerScheduleToday;

  /// Tomorrow's prayer schedule filter
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get prayerScheduleTomorrow;

  /// 30-day prayer schedule list filter
  ///
  /// In en, this message translates to:
  /// **'30-Day List'**
  String get prayerScheduleThirtyDays;

  /// Fajr prayer name
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get prayerFajr;

  /// Sunrise time label
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get prayerSunrise;

  /// Dhuhr prayer name
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get prayerDhuhr;

  /// Asr prayer name
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get prayerAsr;

  /// Maghrib prayer name
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get prayerMaghrib;

  /// Isha prayer name
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get prayerIsha;

  /// Next prayer and live countdown label
  ///
  /// In en, this message translates to:
  /// **'{prayerName} in {countdown}'**
  String prayerNextCountdownLabel(String prayerName, String countdown);

  /// Action to request foreground GPS location
  ///
  /// In en, this message translates to:
  /// **'Detect GPS Location'**
  String get prayerUseGpsAction;

  /// Title of manual city search fallback sheet
  ///
  /// In en, this message translates to:
  /// **'Select City Manually'**
  String get prayerManualCitySearchTitle;

  /// Search input hint for manual city search
  ///
  /// In en, this message translates to:
  /// **'Search city (e.g. Cairo, Alexandria, Makkah)...'**
  String get prayerManualCitySearchHint;

  /// Title of prayer calculation options sheet
  ///
  /// In en, this message translates to:
  /// **'Prayer Calculation Options'**
  String get prayerCalculationSettingsTitle;

  /// Label for Asr juristic option
  ///
  /// In en, this message translates to:
  /// **'Asr Juristic Method'**
  String get prayerAsrSchoolLabel;

  /// Standard Shafi Asr shadow factor 1
  ///
  /// In en, this message translates to:
  /// **'Standard (Shafi\'i, Maliki, Hanbali)'**
  String get prayerAsrShafi;

  /// Hanafi Asr shadow factor 2
  ///
  /// In en, this message translates to:
  /// **'Hanafi'**
  String get prayerAsrHanafi;

  /// Label for high-latitude calculation rule
  ///
  /// In en, this message translates to:
  /// **'High-Latitude Rule'**
  String get prayerHighLatitudeRuleLabel;

  /// Middle of the night rule
  ///
  /// In en, this message translates to:
  /// **'Middle of the Night'**
  String get highLatMiddleOfNight;

  /// One-seventh of the night rule
  ///
  /// In en, this message translates to:
  /// **'Seventh of the Night'**
  String get highLatSeventhOfNight;

  /// Twilight angle rule
  ///
  /// In en, this message translates to:
  /// **'Twilight Angle'**
  String get highLatTwilightAngle;

  /// Section title for manual minute adjustments per prayer
  ///
  /// In en, this message translates to:
  /// **'Manual Minute Adjustments (-30 to +30 min)'**
  String get prayerManualAdjustmentsSection;

  /// Qibla direction in degrees from North
  ///
  /// In en, this message translates to:
  /// **'Qibla Bearing: {bearing}'**
  String qiblaBearingLabel(String bearing);

  /// Badge shown when phone points directly toward the Kaaba
  ///
  /// In en, this message translates to:
  /// **'Aligned with Qibla'**
  String get qiblaAlignedStatus;

  /// Compass calibration instruction
  ///
  /// In en, this message translates to:
  /// **'Calibration Tip: Move your phone in a figure-8 motion away from metal objects or magnetic cases.'**
  String get qiblaCalibrationHint;

  /// Warning banner when compass interference is high
  ///
  /// In en, this message translates to:
  /// **'Low compass sensor accuracy detected. Please calibrate your device by tilting it in a figure-8 pattern.'**
  String get qiblaLowAccuracyWarning;

  /// Title shown when device lacks a magnetometer sensor
  ///
  /// In en, this message translates to:
  /// **'Static Qibla Bearing (No Compass Sensor)'**
  String get qiblaNoSensorFallbackTitle;

  /// Static bearing guidance when compass sensor is absent
  ///
  /// In en, this message translates to:
  /// **'Your device does not report live compass sensor headings. Face {bearing} clockwise from True North.'**
  String qiblaNoSensorFallbackBody(String bearing);

  /// Label for -2 to +2 Hijri day adjustment
  ///
  /// In en, this message translates to:
  /// **'Hijri Moon-Sighting Adjustment (Days)'**
  String get hijriAdjustmentLabel;

  /// Explanation of Hijri day adjustment
  ///
  /// In en, this message translates to:
  /// **'Adjust Umm al-Qura Hijri date by -2 to +2 days to match local moon sighting.'**
  String get hijriAdjustmentSubtitle;

  /// Section heading for Islamic occasions on Hijri calendar
  ///
  /// In en, this message translates to:
  /// **'Islamic Occasions'**
  String get islamicOccasionsTitle;

  /// Title of Notification Settings screen
  ///
  /// In en, this message translates to:
  /// **'Notifications & Reminders'**
  String get notifSettingsTitle;

  /// Button in Settings to open Notification Settings screen
  ///
  /// In en, this message translates to:
  /// **'Configure Prayer Alerts, Reminders & Health'**
  String get notifConfigureAction;

  /// Notice when custom Adhan audio files are missing from assets
  ///
  /// In en, this message translates to:
  /// **'Custom Adhan audio files (assets/audio/adhan.mp3) are not yet bundled. Using the system default notification sound until Adhan audio files are added.'**
  String get notifMissingAdhanAssetBanner;

  /// Section heading for per-prayer alerts
  ///
  /// In en, this message translates to:
  /// **'Five Daily Prayer Alerts'**
  String get notifPerPrayerSectionTitle;

  /// 0 minutes before prayer option
  ///
  /// In en, this message translates to:
  /// **'At Prayer Time'**
  String get notifAtPrayerTime;

  /// Minutes before prayer option
  ///
  /// In en, this message translates to:
  /// **'{minutes} min before'**
  String notifMinutesBefore(int minutes);

  /// Sound enabled option for prayer alert
  ///
  /// In en, this message translates to:
  /// **'Adhan / Default Sound'**
  String get notifSoundAdhan;

  /// Silent option for prayer alert
  ///
  /// In en, this message translates to:
  /// **'Silent'**
  String get notifSoundSilent;

  /// Daily wird reminder toggle title
  ///
  /// In en, this message translates to:
  /// **'Daily Quran Wird Reminder'**
  String get notifWirdReminderTitle;

  /// Friday reminder toggle title
  ///
  /// In en, this message translates to:
  /// **'Friday Reminder (Surah Al-Kahf)'**
  String get notifFridayReminderTitle;

  /// Tasbih reminder toggle title
  ///
  /// In en, this message translates to:
  /// **'Daily Tasbih Reminder'**
  String get notifTasbihReminderTitle;

  /// Morning Adhkar reminder toggle title
  ///
  /// In en, this message translates to:
  /// **'Morning Adhkar Reminder'**
  String get notifMorningAdhkarReminderTitle;

  /// Evening Adhkar reminder toggle title
  ///
  /// In en, this message translates to:
  /// **'Evening Adhkar Reminder'**
  String get notifEveningAdhkarReminderTitle;

  /// Title of Notification Health screen
  ///
  /// In en, this message translates to:
  /// **'Notification Health & Status'**
  String get notifHealthTitle;

  /// Label for notifications permission status
  ///
  /// In en, this message translates to:
  /// **'Notifications Permission (Android 13+ / iOS)'**
  String get notifHealthPermissionLabel;

  /// Label for exact alarm permission status
  ///
  /// In en, this message translates to:
  /// **'Exact Alarms Access (Android 14+ SCHEDULE_EXACT_ALARM)'**
  String get notifHealthExactAlarmLabel;

  /// Permission granted status badge
  ///
  /// In en, this message translates to:
  /// **'Granted'**
  String get notifHealthStatusGranted;

  /// Permission missing status badge
  ///
  /// In en, this message translates to:
  /// **'Action Needed'**
  String get notifHealthStatusRequired;

  /// Button to request permission or deep-link to system settings
  ///
  /// In en, this message translates to:
  /// **'Grant / Open Settings'**
  String get notifHealthGrantAction;

  /// Label for number of pending scheduled items
  ///
  /// In en, this message translates to:
  /// **'Scheduled Pending Items (7-Day Rolling Window)'**
  String get notifHealthBudgetLabel;

  /// Scheduled count vs iOS 64 limit
  ///
  /// In en, this message translates to:
  /// **'{count} / {maxBudget} budgeted (iOS max 64)'**
  String notifHealthBudgetValue(int count, int maxBudget);

  /// Section title for next 3 scheduled notifications
  ///
  /// In en, this message translates to:
  /// **'Next 3 Scheduled Times'**
  String get notifHealthNextThreeTitle;

  /// Empty state when no notifications are scheduled
  ///
  /// In en, this message translates to:
  /// **'No upcoming notifications scheduled.'**
  String get notifHealthNoScheduled;

  /// Title of OEM Battery Optimization Help screen
  ///
  /// In en, this message translates to:
  /// **'Battery Optimization Help'**
  String get batteryHelpTitle;

  /// Introduction text on Battery Optimization Help screen
  ///
  /// In en, this message translates to:
  /// **'Some phone manufacturers restrict background alarms after the app is closed. Follow the steps for your device brand below so prayer alerts always fire on time:'**
  String get batteryHelpIntro;

  /// Samsung brand heading
  ///
  /// In en, this message translates to:
  /// **'Samsung (One UI)'**
  String get batteryHelpSamsungTitle;

  /// Samsung instructions
  ///
  /// In en, this message translates to:
  /// **'Open Settings → Apps → Qandil → Battery → Select \'Unrestricted\'. Also ensure Qandil is not in \'Sleeping apps\' under Device Care.'**
  String get batteryHelpSamsungBody;

  /// Xiaomi brand heading
  ///
  /// In en, this message translates to:
  /// **'Xiaomi / Redmi / POCO (MIUI & HyperOS)'**
  String get batteryHelpXiaomiTitle;

  /// Xiaomi instructions
  ///
  /// In en, this message translates to:
  /// **'Open Settings → Apps → Manage apps → Qandil → Enable \'Autostart\', then tap Battery saver and select \'No restrictions\'.'**
  String get batteryHelpXiaomiBody;

  /// Huawei brand heading
  ///
  /// In en, this message translates to:
  /// **'Huawei / Honor (EMUI)'**
  String get batteryHelpHuaweiTitle;

  /// Huawei instructions
  ///
  /// In en, this message translates to:
  /// **'Open Settings → Battery → App launch → Find Qandil → Turn off \'Manage automatically\' and enable Auto-launch, Secondary launch, and Run in background.'**
  String get batteryHelpHuaweiBody;

  /// OnePlus/Oppo/Realme brand heading
  ///
  /// In en, this message translates to:
  /// **'OnePlus / Oppo / Realme (OxygenOS & ColorOS)'**
  String get batteryHelpOnePlusOppoTitle;

  /// OnePlus/Oppo/Realme instructions
  ///
  /// In en, this message translates to:
  /// **'Open Settings → Apps → App Management → Qandil → Battery Usage → Enable \'Allow background activity\' and \'Allow auto launch\'.'**
  String get batteryHelpOnePlusOppoBody;

  /// Counter tab label on Tasbih screen
  ///
  /// In en, this message translates to:
  /// **'Tasbih Counter'**
  String get tasbihTabCounter;

  /// Statistics tab label on Tasbih screen
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get tasbihTabStats;

  /// Label for dhikr picker
  ///
  /// In en, this message translates to:
  /// **'Active Dhikr'**
  String get tasbihSelectDhikrLabel;

  /// Dialog title for typing a custom dhikr label
  ///
  /// In en, this message translates to:
  /// **'Add Custom Dhikr Label'**
  String get tasbihAddCustomDhikrTitle;

  /// Input hint for custom dhikr label
  ///
  /// In en, this message translates to:
  /// **'Type your custom dhikr label...'**
  String get tasbihAddCustomDhikrHint;

  /// Label for target preset chips (33, 99, 100, Custom)
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get tasbihTargetPresetLabel;

  /// Dialog title for custom target count
  ///
  /// In en, this message translates to:
  /// **'Custom Target Count'**
  String get tasbihCustomTargetTitle;

  /// Input hint for custom target count
  ///
  /// In en, this message translates to:
  /// **'Enter target count (e.g. 500)'**
  String get tasbihCustomTargetHint;

  /// Tooltip for haptics toggle
  ///
  /// In en, this message translates to:
  /// **'Toggle Haptic Vibration'**
  String get tasbihHapticsTooltip;

  /// Instruction inside large tap area
  ///
  /// In en, this message translates to:
  /// **'Tap anywhere inside the circle to count'**
  String get tasbihTapPrompt;

  /// Shows completed laps in current session and today's total
  ///
  /// In en, this message translates to:
  /// **'Rounds: {rounds} • Today: {todayTotal}'**
  String tasbihCompletedRoundsLabel(int rounds, int todayTotal);

  /// Undo last tasbih tap
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get tasbihUndoAction;

  /// Reset current session lap counter
  ///
  /// In en, this message translates to:
  /// **'Reset Lap'**
  String get tasbihResetAction;

  /// Save and finish current session lap
  ///
  /// In en, this message translates to:
  /// **'Save Session'**
  String get tasbihSaveSessionAction;

  /// Today filter on stats screen
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tasbihPeriodToday;

  /// 7 days filter on stats screen
  ///
  /// In en, this message translates to:
  /// **'7 Days'**
  String get tasbihPeriodSevenDays;

  /// 30 days filter on stats screen
  ///
  /// In en, this message translates to:
  /// **'30 Days'**
  String get tasbihPeriodThirtyDays;

  /// All time filter on stats screen
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get tasbihPeriodAllTime;

  /// Current daily streak metric card title
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get tasbihCurrentStreakLabel;

  /// Best daily streak metric card title
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get tasbihBestStreakLabel;

  /// Section title for per-dhikr breakdown
  ///
  /// In en, this message translates to:
  /// **'Per-Dhikr Breakdown'**
  String get tasbihPerDhikrBreakdownTitle;

  /// Calm empty state on Tasbih stats screen
  ///
  /// In en, this message translates to:
  /// **'No tasbih counts recorded yet. Start tapping on the Counter tab to build your daily streak.'**
  String get tasbihEmptyStatsMessage;

  /// Button to export tasbih stats as JSON via share sheet
  ///
  /// In en, this message translates to:
  /// **'Export Stats as JSON'**
  String get tasbihExportJsonAction;

  /// Title for Prayer tab shell
  ///
  /// In en, this message translates to:
  /// **'Prayer Times & Qibla'**
  String get prayerShellTitle;

  /// Description on Prayer tab shell
  ///
  /// In en, this message translates to:
  /// **'On-device prayer calculations, Qibla compass, and Umm al-Qura Hijri calendar.'**
  String get prayerShellDescription;

  /// Title for Dhikr tab shell
  ///
  /// In en, this message translates to:
  /// **'Adhkar & Tasbih'**
  String get dhikrShellTitle;

  /// Description on Dhikr tab shell
  ///
  /// In en, this message translates to:
  /// **'Verified morning and evening adhkar, prophetic duas, and tasbih counter with statistics.'**
  String get dhikrShellDescription;

  /// Title for Settings/More screen
  ///
  /// In en, this message translates to:
  /// **'Settings & More'**
  String get settingsTitle;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// Arabic language option
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Theme mode setting label
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsTheme;

  /// Follow system theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light (Ivory)'**
  String get themeLight;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark (Night)'**
  String get themeDark;

  /// Text size scaling setting label
  ///
  /// In en, this message translates to:
  /// **'UI Text Size'**
  String get settingsTextSize;

  /// Sample preview text for text size scaling
  ///
  /// In en, this message translates to:
  /// **'Read, listen and keep your daily wird.'**
  String get settingsTextSizePreview;

  /// Prayer calculation method setting label
  ///
  /// In en, this message translates to:
  /// **'Prayer Calculation Method'**
  String get settingsPrayerMethod;

  /// Egyptian General Authority calculation method
  ///
  /// In en, this message translates to:
  /// **'Egyptian General Authority of Survey'**
  String get prayerMethodEgyptian;

  /// Umm al-Qura calculation method
  ///
  /// In en, this message translates to:
  /// **'Umm al-Qura University, Makkah'**
  String get prayerMethodUmmAlQura;

  /// Muslim World League calculation method
  ///
  /// In en, this message translates to:
  /// **'Muslim World League'**
  String get prayerMethodMuslimWorldLeague;

  /// Karachi calculation method
  ///
  /// In en, this message translates to:
  /// **'University of Islamic Sciences, Karachi'**
  String get prayerMethodKarachi;

  /// North America calculation method
  ///
  /// In en, this message translates to:
  /// **'ISNA (North America)'**
  String get prayerMethodNorthAmerica;

  /// Notifications toggle label
  ///
  /// In en, this message translates to:
  /// **'Prayer & Wird Reminders'**
  String get settingsNotifications;

  /// Notifications toggle subtitle
  ///
  /// In en, this message translates to:
  /// **'Receive local reminders for prayers, daily wird, and adhkar.'**
  String get settingsNotificationsSubtitle;

  /// About and Credits screen navigation label
  ///
  /// In en, this message translates to:
  /// **'About & Credits'**
  String get settingsAboutCredits;

  /// Subtitle for About and Credits row
  ///
  /// In en, this message translates to:
  /// **'Data sources, Quran Foundation attribution, fonts, and open-source licenses.'**
  String get settingsAboutCreditsSubtitle;

  /// Title of About and Credits screen
  ///
  /// In en, this message translates to:
  /// **'About & Credits'**
  String get creditsTitle;

  /// Section title for Content Integrity on Credits screen
  ///
  /// In en, this message translates to:
  /// **'Content Integrity Pledge'**
  String get creditsContentIntegrityTitle;

  /// Explanation of Qandil content integrity rules
  ///
  /// In en, this message translates to:
  /// **'Qandil never generates, alters, normalizes, or machine-translates Quranic text, tafsir, translations, adhkar, or duas. All religious content is loaded unaltered from verified scholarly sources.'**
  String get creditsContentIntegrityBody;

  /// Heading for Quran Foundation credit
  ///
  /// In en, this message translates to:
  /// **'Quran Text, Tafsir, Translations & Audio'**
  String get creditsQuranSourceTitle;

  /// Details for Quran Foundation credit
  ///
  /// In en, this message translates to:
  /// **'Provided by Quran Foundation (quran.com / api-docs.quran.com). Default Arabic Tafsir: Al-Tafsir Al-Muyassar (King Fahd Glorious Quran Printing Complex). Default English Translation: The Clear Quran (Dr. Mustafa Khattab).'**
  String get creditsQuranSourceBody;

  /// Title for Adhkar source credit card
  ///
  /// In en, this message translates to:
  /// **'Morning & Evening Adhkar and Duas'**
  String get creditsAdhkarSourceTitle;

  /// Description of Adhkar content sources
  ///
  /// In en, this message translates to:
  /// **'Morning and evening adhkar from Seen-Arabic/Morning-And-Evening-Adhkar-DB (MIT License), based on Hisn al-Muslim by Sa\'id bin Ali bin Wahf al-Qahtani.'**
  String get creditsAdhkarSourceBody;

  /// Heading for fonts credit
  ///
  /// In en, this message translates to:
  /// **'Typography & Mushaf Script'**
  String get creditsFontsTitle;

  /// Details for bundled fonts credit
  ///
  /// In en, this message translates to:
  /// **'Quranic script rendered in KFGQPC Uthmanic Script Hafs Ver 18 (King Fahd Glorious Quran Printing Complex via Quran Foundation). Headings and brand wordmark set in Reem Kufi (by Khaled Hosny, SIL Open Font License 1.1). User interface set in IBM Plex Sans Arabic (by IBM Corp., SIL Open Font License 1.1).'**
  String get creditsFontsBody;

  /// Button to open Flutter LicensePage
  ///
  /// In en, this message translates to:
  /// **'View Open-Source Licenses'**
  String get creditsOpenSourceLicenses;

  /// ICU plural count for tasbihs
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No tasbih today} =1{1 tasbih} other{{count} tasbihs}}'**
  String tasbihCount(int count);

  /// ICU plural count for Quran verses
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No verses} =1{1 verse} other{{count} verses}}'**
  String verseCount(int count);

  /// ICU plural count for Mushaf pages
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No pages} =1{1 page} other{{count} pages}}'**
  String pageCount(int count);

  /// ICU plural count for daily streak
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No streak yet} =1{1 day streak} other{{count} days streak}}'**
  String dayStreakCount(int count);

  /// Title for Adhkar tab in hub
  ///
  /// In en, this message translates to:
  /// **'Adhkar & Duas'**
  String get adhkarTabTitle;

  /// Title for Tasbih tab in hub
  ///
  /// In en, this message translates to:
  /// **'Tasbih Counter'**
  String get tasbihTabTitle;

  /// Morning banner title
  ///
  /// In en, this message translates to:
  /// **'Morning Adhkar'**
  String get morningAdhkarBannerTitle;

  /// Morning banner subtitle
  ///
  /// In en, this message translates to:
  /// **'Begin your day with remembrance and serenity'**
  String get morningAdhkarBannerSubtitle;

  /// Evening banner title
  ///
  /// In en, this message translates to:
  /// **'Evening Adhkar'**
  String get eveningAdhkarBannerTitle;

  /// Evening banner subtitle
  ///
  /// In en, this message translates to:
  /// **'End your day with peace and protection'**
  String get eveningAdhkarBannerSubtitle;

  /// Action button to open reader
  ///
  /// In en, this message translates to:
  /// **'Read Adhkar'**
  String get readAdhkarAction;

  /// Badge when category is not yet imported
  ///
  /// In en, this message translates to:
  /// **'Pending import'**
  String get categoryPendingNotice;

  /// Empty state title
  ///
  /// In en, this message translates to:
  /// **'No Adhkar in this category yet'**
  String get categoryEmptyTitle;

  /// Empty state description
  ///
  /// In en, this message translates to:
  /// **'This category is currently pending verification and import from authentic sources.'**
  String get categoryEmptyDescription;

  /// Category progress label
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} completed'**
  String adhkarProgressCompleted(int completed, int total);

  /// Reader counter badge
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String adhkarItemCounter(int current, int total);

  /// Source label
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get adhkarSourceLabel;

  /// Virtue label
  ///
  /// In en, this message translates to:
  /// **'Virtue'**
  String get adhkarFadlLabel;

  /// Mark completed action
  ///
  /// In en, this message translates to:
  /// **'Mark Read'**
  String get adhkarMarkCompletedAction;

  /// Reset category action
  ///
  /// In en, this message translates to:
  /// **'Reset Today\'s Progress'**
  String get adhkarResetCategoryAction;

  /// Confirm dialog for resetting category
  ///
  /// In en, this message translates to:
  /// **'Do you want to reset today\'s progress for this category?'**
  String get adhkarResetCategoryConfirm;

  /// Font size adjustment label
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get adhkarFontSizeLabel;

  /// Credit line when sharing adhkar
  ///
  /// In en, this message translates to:
  /// **'Qandil App — Light for your day'**
  String get adhkarShareCredit;

  /// Title for Phase 9 Reading Mode
  ///
  /// In en, this message translates to:
  /// **'Reading & Focus Mode'**
  String get readingModeTitle;

  /// Dimmed floating pill shown while Reading Mode is active
  ///
  /// In en, this message translates to:
  /// **'Reading Mode Active — Tap to Exit'**
  String get readingModeActivePill;

  /// Tooltip for Reading Mode toggle button in Quran Reader
  ///
  /// In en, this message translates to:
  /// **'Toggle Reading Mode'**
  String get readingModeToggleTooltip;

  /// Setting toggle to auto-start Reading Mode when opening Quran Reader
  ///
  /// In en, this message translates to:
  /// **'Start Reading Mode automatically'**
  String get readingModeAutoStartLabel;

  /// Subtitle for auto-start Reading Mode
  ///
  /// In en, this message translates to:
  /// **'Keep screen awake, dim UI chrome, and hold in-app reminders while reading.'**
  String get readingModeAutoStartSubtitle;

  /// Toggle for optional Android DND during Reading Mode
  ///
  /// In en, this message translates to:
  /// **'Do Not Disturb while reading (Android)'**
  String get readingModeDndEnabledLabel;

  /// Subtitle explaining crash-safe DND restoration
  ///
  /// In en, this message translates to:
  /// **'Saves your previous DND filter before reading and always restores it on exit or next launch.'**
  String get readingModeDndEnabledSubtitle;

  /// Label for selecting which Android DND filter to apply
  ///
  /// In en, this message translates to:
  /// **'Android Interruption Filter'**
  String get readingModeDndFilterLabel;

  /// Priority interruption filter option
  ///
  /// In en, this message translates to:
  /// **'Priority & Adhan Allowed (Recommended)'**
  String get readingModeDndFilterPriorityTitle;

  /// Explanation of Priority filter and Adhan delivery
  ///
  /// In en, this message translates to:
  /// **'Lets Qandil\'s Adhan, alarms, and priority contacts through while silencing general notifications.'**
  String get readingModeDndFilterPrioritySubtitle;

  /// Alarms interruption filter option
  ///
  /// In en, this message translates to:
  /// **'Alarms & Adhan Only'**
  String get readingModeDndFilterAlarmsTitle;

  /// Explanation of Alarms filter and Adhan delivery
  ///
  /// In en, this message translates to:
  /// **'Blocks calls and messages; only lets system alarms and Qandil\'s alarm-category Adhan through.'**
  String get readingModeDndFilterAlarmsSubtitle;

  /// Total silence interruption filter option
  ///
  /// In en, this message translates to:
  /// **'Total Silence (Mutes Adhan & Alarms)'**
  String get readingModeDndFilterNoneTitle;

  /// Explanation of Total Silence filter
  ///
  /// In en, this message translates to:
  /// **'Blocks all sounds and notifications, including Adhan and alarms.'**
  String get readingModeDndFilterNoneSubtitle;

  /// Title of Android DND permission explanation sheet
  ///
  /// In en, this message translates to:
  /// **'Notification Policy Access Required'**
  String get readingModeAndroidPermissionTitle;

  /// Body of Android DND permission explanation sheet
  ///
  /// In en, this message translates to:
  /// **'To enable Do Not Disturb while reading, Qandil needs Android Notification Policy access. Qandil saves your current filter before reading and always restores it on exit — never leaving your phone in DND silently.'**
  String get readingModeAndroidPermissionBody;

  /// Button to open Android Notification Policy settings
  ///
  /// In en, this message translates to:
  /// **'Open Notification Policy Settings'**
  String get readingModeOpenAndroidDndSettingsAction;

  /// Button to verify permission after returning from Android settings
  ///
  /// In en, this message translates to:
  /// **'Verify & Enable Now'**
  String get readingModeVerifyDndPermissionAction;

  /// Warning shown when user taps verify but permission is still denied
  ///
  /// In en, this message translates to:
  /// **'Permission has not been granted in system settings yet.'**
  String get readingModeDndPermissionNotGrantedWarning;

  /// Title of one-time iOS Focus tip sheet
  ///
  /// In en, this message translates to:
  /// **'iOS Focus Mode & Shortcuts Tip'**
  String get readingModeIosFocusTipTitle;

  /// One-time iOS Focus tip explanation
  ///
  /// In en, this message translates to:
  /// **'iOS does not allow apps to toggle Do Not Disturb programmatically. To enjoy distraction-free reading on iPhone:\n1. Open the Apple Shortcuts app > Automation.\n2. Create a Personal Automation: When \'Qandil\' is Opened → Set Focus to \'Reading\' (or Do Not Disturb) until you leave the app.'**
  String get readingModeIosFocusTipBody;

  /// Button in settings to view the iOS Focus tip
  ///
  /// In en, this message translates to:
  /// **'How to set up iOS Focus Mode for Qandil'**
  String get readingModeIosFocusTipButton;

  /// Dismiss button for tip sheet
  ///
  /// In en, this message translates to:
  /// **'Got It'**
  String get readingModeGotItAction;

  /// Toast shown when held notifications are flushed on exiting Reading Mode
  ///
  /// In en, this message translates to:
  /// **'{count} in-app reminder(s) were held while you were reading.'**
  String readingModeHeldNotificationsToast(int count);

  /// Button to skip onboarding
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkipAction;

  /// Button to advance to next onboarding slide
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNextAction;

  /// Button on final onboarding slide
  ///
  /// In en, this message translates to:
  /// **'Begin with Qandil'**
  String get onboardingStartAction;

  /// Onboarding slide 1 title (Read)
  ///
  /// In en, this message translates to:
  /// **'Read with Calm & Reflection'**
  String get onboardingReadTitle;

  /// Onboarding slide 1 description
  ///
  /// In en, this message translates to:
  /// **'Authentic Madani Uthmanic Mushaf script, scholarly tafsir, translations, word-by-word meanings, and distraction-free Reading Mode.'**
  String get onboardingReadSubtitle;

  /// Onboarding slide 2 title (Listen)
  ///
  /// In en, this message translates to:
  /// **'Listen to Renowned Reciters'**
  String get onboardingListenTitle;

  /// Onboarding slide 2 description
  ///
  /// In en, this message translates to:
  /// **'Beloved Egyptian and world Qaris with live verse highlighting, range repeat, and offline surah downloads.'**
  String get onboardingListenSubtitle;

  /// Onboarding slide 3 title (Daily Wird)
  ///
  /// In en, this message translates to:
  /// **'Keep Your Daily Wird'**
  String get onboardingWirdTitle;

  /// Onboarding slide 3 description
  ///
  /// In en, this message translates to:
  /// **'A gentle Khatmah planner, on-device prayer times and Qibla, verified morning and evening adhkar, and daily tasbih.'**
  String get onboardingWirdSubtitle;

  /// Button in Settings to view the 3-screen onboarding tour
  ///
  /// In en, this message translates to:
  /// **'Qandil Welcome Tour'**
  String get settingsReplayOnboarding;

  /// Subtitle for welcome tour in Settings
  ///
  /// In en, this message translates to:
  /// **'View the 3-screen introduction to reading, listening, and keeping your daily wird.'**
  String get settingsReplayOnboardingSubtitle;

  /// Morning greeting on Home header
  ///
  /// In en, this message translates to:
  /// **'Good morning — light for your day'**
  String get homeGreetingMorning;

  /// Afternoon greeting on Home header
  ///
  /// In en, this message translates to:
  /// **'Good afternoon — peace for your day'**
  String get homeGreetingAfternoon;

  /// Evening greeting on Home header
  ///
  /// In en, this message translates to:
  /// **'Good evening — serenity for your night'**
  String get homeGreetingEvening;

  /// Friendly placeholder when location is missing
  ///
  /// In en, this message translates to:
  /// **'Select your city on the Prayer screen to view prayer times and live countdown.'**
  String get homeMissingLocationPlaceholder;

  /// Quick-start +1 tasbih counter button on Home Dhikr card
  ///
  /// In en, this message translates to:
  /// **'Quick Tasbih (+1)'**
  String get homeQuickTasbihAction;

  /// Shortcut pill to Morning Adhkar on Home Dhikr card
  ///
  /// In en, this message translates to:
  /// **'Morning Adhkar'**
  String get homeMorningAdhkarShortcut;

  /// Shortcut pill to Evening Adhkar on Home Dhikr card
  ///
  /// In en, this message translates to:
  /// **'Evening Adhkar'**
  String get homeEveningAdhkarShortcut;

  /// Action on Verse of the Day card to open verse with tafsir
  ///
  /// In en, this message translates to:
  /// **'Read Verse & Tafsir'**
  String get homeOpenVerseWithTafsirAction;

  /// Title for Phase 12 Hifz Hub
  ///
  /// In en, this message translates to:
  /// **'Memorization & Review (Hifz)'**
  String get hifzTitle;

  /// Hifz tab 1
  ///
  /// In en, this message translates to:
  /// **'Plan & Queue'**
  String get hifzTabPlan;

  /// Hifz tab 2
  ///
  /// In en, this message translates to:
  /// **'Test & Recite'**
  String get hifzTabTest;

  /// Hifz tab 3
  ///
  /// In en, this message translates to:
  /// **'Weak Spots'**
  String get hifzTabMistakes;

  /// Hifz tab 4
  ///
  /// In en, this message translates to:
  /// **'Stats & Teacher'**
  String get hifzTabStats;

  /// Heading for adding a memorized verse range
  ///
  /// In en, this message translates to:
  /// **'Add Memorized Verse Range'**
  String get hifzAddRangeTitle;

  /// Button to add memorized range
  ///
  /// In en, this message translates to:
  /// **'Add Memorized Range'**
  String get hifzAddRangeAction;

  /// Heading for Hifz daily goals
  ///
  /// In en, this message translates to:
  /// **'Daily Hifz & Review Goals'**
  String get hifzDailyGoalsTitle;

  /// Label for new verses per day goal
  ///
  /// In en, this message translates to:
  /// **'New verses per day'**
  String get hifzNewVersesPerDayLabel;

  /// Label for daily review queue cap
  ///
  /// In en, this message translates to:
  /// **'Daily review queue cap'**
  String get hifzReviewsPerDayCapLabel;

  /// Toggle for Catch-Up Mode in SM-2 scheduler
  ///
  /// In en, this message translates to:
  /// **'Catch-Up Mode (spread missed overdue reviews across days)'**
  String get hifzCatchUpModeLabel;

  /// Heading for daily review queue
  ///
  /// In en, this message translates to:
  /// **'Today\'s Due Review Queue'**
  String get hifzDueQueueTitle;

  /// Empty state for daily review queue
  ///
  /// In en, this message translates to:
  /// **'No review ranges due right now. Add a memorized range or start a test session.'**
  String get hifzDueQueueEmpty;

  /// Heading for Hifz audio loop helper
  ///
  /// In en, this message translates to:
  /// **'Hifz Audio Loop Helper'**
  String get hifzAudioHelperTitle;

  /// Label for audio pause gap
  ///
  /// In en, this message translates to:
  /// **'Pause gap to repeat after reciter (seconds)'**
  String get hifzAudioPauseGapLabel;

  /// Button to start audio range loop
  ///
  /// In en, this message translates to:
  /// **'Loop Range with Reciter'**
  String get hifzStartAudioLoopAction;

  /// Test mode 1
  ///
  /// In en, this message translates to:
  /// **'Recite by Verse #'**
  String get hifzTestModeByNumber;

  /// Test mode 2
  ///
  /// In en, this message translates to:
  /// **'What\'s Next Verse?'**
  String get hifzTestModeNextVerse;

  /// Test mode 3
  ///
  /// In en, this message translates to:
  /// **'Review My Mistakes'**
  String get hifzTestModeMistakes;

  /// Button to reveal hidden verse in test mode
  ///
  /// In en, this message translates to:
  /// **'Reveal Verse to Check'**
  String get hifzRevealVerseAction;

  /// Hint above words in revealed test mode
  ///
  /// In en, this message translates to:
  /// **'Tap any word you hesitated on (optional), then self-grade:'**
  String get hifzTapMistakeWordHint;

  /// Self-grade Perfect
  ///
  /// In en, this message translates to:
  /// **'Perfect'**
  String get hifzGradePerfect;

  /// Self-grade Hesitated
  ///
  /// In en, this message translates to:
  /// **'Hesitated'**
  String get hifzGradeHesitated;

  /// Self-grade Forgot
  ///
  /// In en, this message translates to:
  /// **'Forgot'**
  String get hifzGradeForgot;

  /// Heading for weak spots tab
  ///
  /// In en, this message translates to:
  /// **'Weak Spots & Mistake Log'**
  String get hifzWeakSpotsTitle;

  /// Empty state for weak spots
  ///
  /// In en, this message translates to:
  /// **'No mistakes logged yet. Verses graded Hesitated or Forgot will appear here.'**
  String get hifzWeakSpotsEmpty;

  /// Heading for Mutashabihat extension point card
  ///
  /// In en, this message translates to:
  /// **'Similar Verses (Mutashabihat — Verified Extension Point)'**
  String get hifzMutashabihatTitle;

  /// Explanation of Mutashabihat extension point
  ///
  /// In en, this message translates to:
  /// **'To preserve strict Quranic content integrity, Qandil never generates mutashabihat pairs automatically. Verified pairs will appear here once assets/data/mutashabihat.json is supplied.'**
  String get hifzMutashabihatNotice;

  /// Stats label for memorized verses
  ///
  /// In en, this message translates to:
  /// **'Memorized Verses'**
  String get hifzStatsMemorizedVerses;

  /// Stats label for memorized pages
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get hifzStatsMemorizedPages;

  /// Stats label for memorized juz
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get hifzStatsMemorizedJuz;

  /// Stats label for review streak
  ///
  /// In en, this message translates to:
  /// **'Review Streak'**
  String get hifzStatsReviewStreak;

  /// Stats label for weekly accuracy
  ///
  /// In en, this message translates to:
  /// **'7-Day Accuracy'**
  String get hifzStatsWeeklyAccuracy;

  /// Stats label for projected completion date
  ///
  /// In en, this message translates to:
  /// **'Projected Completion Date'**
  String get hifzStatsProjectedCompletion;

  /// Button to share Hifz progress report JSON
  ///
  /// In en, this message translates to:
  /// **'Export Teacher Progress Report (JSON)'**
  String get hifzTeacherExportAction;

  /// Title for Hifz hide mode picker in Quran Reader
  ///
  /// In en, this message translates to:
  /// **'Hifz Reader Hide Mode'**
  String get hifzHideModeTitle;

  /// Hide mode none
  ///
  /// In en, this message translates to:
  /// **'Normal Display (No Hiding)'**
  String get hifzHideModeNone;

  /// Hide mode hide all
  ///
  /// In en, this message translates to:
  /// **'Hide All Words'**
  String get hifzHideModeAll;

  /// Hide mode first word only
  ///
  /// In en, this message translates to:
  /// **'Show Only First Word of Each Verse'**
  String get hifzHideModeFirstWord;

  /// Hide mode random percent
  ///
  /// In en, this message translates to:
  /// **'Hide Random % of Words'**
  String get hifzHideModeRandom;

  /// Hide mode hide until tapped
  ///
  /// In en, this message translates to:
  /// **'Hide Verse Until Tapped'**
  String get hifzHideModeUntilTapped;

  /// Hide mode reveal word by word
  ///
  /// In en, this message translates to:
  /// **'Reveal Word by Word on Tap'**
  String get hifzHideModeWordByWord;

  /// Heading for reciters credit card
  ///
  /// In en, this message translates to:
  /// **'Quran Reciters & Audio Sources'**
  String get creditsRecitersTitle;

  /// Details for reciters attribution
  ///
  /// In en, this message translates to:
  /// **'Audio recitations are streamed and downloaded with permission via Quran Foundation (quran.com), featuring prioritized Egyptian Qaris: Sheikh Mahmoud Khalil Al-Husary (Murattal & Muallim), Sheikh AbdulBaset AbdulSamad (Mujawwad & Murattal), Sheikh Mohamed Siddiq al-Minshawi (Murattal & Mujawwad), Sheikh Mishari Rashid al-`Afasy, Sheikh Abdur-Rahman as-Sudais, Sheikh Sa`ud ash-Shuraym, Sheikh Saad al-Ghamdi, Sheikh Abu Bakr al-Shatri, and Sheikh Hani ar-Rifai.'**
  String get creditsRecitersBody;

  /// Heading for tafsir and translations credit card
  ///
  /// In en, this message translates to:
  /// **'Tafsir & Translations'**
  String get creditsTafsirTranslationsTitle;

  /// Details for tafsir and translations attribution
  ///
  /// In en, this message translates to:
  /// **'Default Arabic Tafsir: Al-Tafsir Al-Muyassar (King Fahd Glorious Quran Printing Complex) and Tafsir Ibn Kathir via Quran Foundation API. English Translations: Saheeh International and The Clear Quran (Dr. Mustafa Khattab) via Quran Foundation API.'**
  String get creditsTafsirTranslationsBody;

  /// Heading for prayer times and Hijri calendar credit card
  ///
  /// In en, this message translates to:
  /// **'Prayer Times, Qibla & Hijri Calendar'**
  String get creditsPrayerHijriTitle;

  /// Details for prayer and Hijri calculations
  ///
  /// In en, this message translates to:
  /// **'Prayer times and Qibla bearing are computed 100% on-device using the adhan astronomical library (defaulting to the Egyptian General Authority of Survey). Hijri dates use the Umm al-Qura calendar (hijri_core) with a -2 to +2 day moon-sighting adjustment.'**
  String get creditsPrayerHijriBody;

  /// Heading for privacy policy card on Credits screen
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy & On-Device Guarantee'**
  String get creditsPrivacyTitle;

  /// Privacy policy summary on Credits screen
  ///
  /// In en, this message translates to:
  /// **'Qandil requires no account, displays zero ads, and includes zero analytics or tracking SDKs. Your foreground location is used solely on your device to calculate prayer times and Qibla direction and is never sent to any server. All personal worship data (bookmarks, notes, Khatmah, Hifz progress, and Tasbih stats) is stored locally on your device.'**
  String get creditsPrivacyBody;

  /// Button label to retry after failure
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Title for 404 page
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get notFoundTitle;

  /// Message for 404 page
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for does not exist.'**
  String get notFoundMessage;

  /// Button to navigate back to home screen
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
