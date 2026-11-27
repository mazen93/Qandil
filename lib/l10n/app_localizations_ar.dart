// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'قنديل';

  @override
  String get appTagline => 'نورٌ يرافق يومك.';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navQuran => 'القرآن';

  @override
  String get navPrayer => 'الصلاة';

  @override
  String get navDhikr => 'الأذكار';

  @override
  String get navMore => 'المزيد';

  @override
  String get homeGreeting => 'السلام عليكم ورحمة الله';

  @override
  String get nextPrayerCardTitle => 'الصلاة القادمة';

  @override
  String get nextPrayerPlaceholder =>
      'سيظهر هنا موعد الصلاة القادمة والعد التنازلي محلياً على جهازك بعد تحديد الموقع.';

  @override
  String get todaysWirdCardTitle => 'وِرد اليوم';

  @override
  String get todaysWirdPlaceholder =>
      'تابع القراءة من موضعك المحفوظ في المصحف الشريف وتعرّف على تقدم ختمتك اليومية.';

  @override
  String get continueReadingAction => 'متابعة القراءة';

  @override
  String savedReadingPositionSummary(
      String surahName, int ayahNumber, int pageNumber, int juzNumber) {
    return 'سورة $surahName • الآية $ayahNumber • صفحة $pageNumber (الجزء $juzNumber)';
  }

  @override
  String khatmahDailyGoalLabel(int pages, int percent) {
    return 'الورد اليومي: $pages صفحة/يوم (مكتمل $percent%)';
  }

  @override
  String get tasbihCardTitle => 'التسبيح اليومي';

  @override
  String get tasbihPlaceholder =>
      'سبّح وتابع إحصاءات أذكارك وأيام المواظبة محلياً على جهازك.';

  @override
  String get verseOfTheDayCardTitle => 'آية اليوم';

  @override
  String get verseOfTheDayPlaceholder =>
      'تُحمَّل آية اليوم تلقائياً من قاعدة بيانات القرآن الكريم المعتمدة (المرحلة الثانية) دون أي توليد آلي للنصوص.';

  @override
  String get quranShellTitle => 'القرآن الكريم';

  @override
  String get quranShellDescription =>
      'عرض صفحات المصحف الشريف، قائمة الآيات، التفسير المعتمد، الترجمات، والتلاوات الصوتية.';

  @override
  String get readerModeMushafPage => 'صفحة المصحف';

  @override
  String get readerModeVerseList => 'قائمة الآيات';

  @override
  String get readerNavSurah => 'السورة';

  @override
  String get readerNavJuz => 'الجزء';

  @override
  String get readerNavPage => 'الصفحة';

  @override
  String get readerJumpToPage => 'انتقال إلى صفحة';

  @override
  String get readerJumpToPageHint => 'أدخل رقم الصفحة (١ - ٦٠٤)';

  @override
  String get readerJumpAction => 'انتقال';

  @override
  String get readerSearchHint => 'ابحث في آيات القرآن الكريم...';

  @override
  String get readerSearchNoResults =>
      'لم يتم العثور على آيات مطابقة في الصفحات المحمّلة.';

  @override
  String readerPageHeader(int pageNumber, int juzNumber) {
    return 'صفحة $pageNumber • الجزء $juzNumber';
  }

  @override
  String get readerSelectNavigationTitle => 'فهرس المصحف الشريف';

  @override
  String get khatmahPlannerTitle => 'مخطط الختمة';

  @override
  String get khatmahTargetDaysLabel => 'عدد أيام الختمة';

  @override
  String khatmahPagesPerDayResult(int pages) {
    return '$pages صفحة يومياً';
  }

  @override
  String khatmahCatchUpWarning(
      int behindPages, int catchUpPages, int remainingDays) {
    return 'متأخر بمقدار $behindPages صفحة • ورد التعويض المقترح: $catchUpPages صفحة/يوم خلال $remainingDays يوم متبقٍ.';
  }

  @override
  String get khatmahOnTrackMessage => 'أنت منتظم على جدول ختمتك اليومية.';

  @override
  String get khatmahSavePlanAction => 'حفظ خطة الختمة';

  @override
  String get readerSettingsTitle => 'إعدادات القراءة';

  @override
  String get readerFontSizeLabel => 'حجم خط المصحف';

  @override
  String get readerLineSpacingLabel => 'تباعد الأسطر';

  @override
  String get readerNightModeLabel => 'الوضع الليلي (داكن)';

  @override
  String get readerKeepScreenAwakeLabel => 'إبقاء الشاشة مضاءة أثناء القراءة';

  @override
  String get verseSheetTafsirTab => 'التفسير';

  @override
  String get verseSheetTranslationTab => 'الترجمة';

  @override
  String get verseSheetWordByWordTab => 'كلمة بكلمة';

  @override
  String get verseSheetBookmarkNoteTab => 'علامة وملاحظة';

  @override
  String get verseSheetSelectTafsir => 'اختر التفسير';

  @override
  String get verseSheetSelectTranslation => 'اختر الترجمة';

  @override
  String get verseSheetBookmarkColorLabel => 'لون الفاصلة المرجعية';

  @override
  String get verseSheetRemoveBookmark => 'إزالة الفاصلة';

  @override
  String get verseSheetNoteLabel => 'خاطرة أو ملاحظة شخصية';

  @override
  String get verseSheetNoteHint => 'اكتب تدبّرك أو ملاحظتك حول هذه الآية...';

  @override
  String get verseSheetSaveNote => 'حفظ الملاحظة';

  @override
  String get verseSheetShareText => 'مشاركة كنص';

  @override
  String get verseSheetShareImage => 'مشاركة كصورة';

  @override
  String get verseShareCreditLine =>
      'المصدر: مجمع الملك فهد لطباعة المصحف الشريف عبر Quran Foundation (quran.com) — تطبيق قنديل';

  @override
  String get audioModeVerseByVerse => 'آية بآية';

  @override
  String get audioModeFullSurah => 'السورة كاملة';

  @override
  String get audioSelectReciterTitle => 'اختر القارئ المفضل';

  @override
  String get audioEgyptianReciterBadge => 'قرّاء مصر';

  @override
  String get audioRepeatTitle => 'تكرار آية أو نطاق آيات';

  @override
  String get audioRepeatEnable => 'تفعيل التكرار';

  @override
  String get audioRepeatStartAyah => 'من الآية';

  @override
  String get audioRepeatEndAyah => 'إلى الآية';

  @override
  String get audioRepeatCountLabel => 'عدد مرات التكرار';

  @override
  String get audioContinueNextSurah => 'الانتقال للسورة التالية تلقائياً';

  @override
  String get audioApplyAction => 'تطبيق';

  @override
  String get audioSleepTimerTitle => 'مؤقت النوم';

  @override
  String get audioSleepTimerOff => 'إيقاف المؤقت';

  @override
  String audioSleepTimerMinutes(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get audioDownloadsTitle => 'التحميلات الصوتية والتخزين';

  @override
  String audioStorageUsedLabel(String sizeText) {
    return 'المساحة المستخدمة في ذاكرة التطبيق: $sizeText';
  }

  @override
  String audioReciterCreditBanner(String reciterName) {
    return 'التلاوات الصوتية عبر مؤسسة القرآن الكريم (Quran Foundation). القارئ الحالي: $reciterName';
  }

  @override
  String get audioDownloadSurahAction => 'تحميل للاستماع دون إنترنت';

  @override
  String get audioPauseDownloadAction => 'إيقاف مؤقت';

  @override
  String get audioResumeDownloadAction => 'استئناف';

  @override
  String get audioDeleteDownloadAction => 'حذف';

  @override
  String get audioDownloadedBadge => 'محمّلة للاستماع دون إنترنت';

  @override
  String get prayerTabTimes => 'مواقيت الصلاة';

  @override
  String get prayerTabQibla => 'القبلة';

  @override
  String get prayerTabHijri => 'التقويم الهجري';

  @override
  String get prayerScheduleToday => 'اليوم';

  @override
  String get prayerScheduleTomorrow => 'غداً';

  @override
  String get prayerScheduleThirtyDays => 'جدول ٣٠ يوماً';

  @override
  String get prayerFajr => 'الفجر';

  @override
  String get prayerSunrise => 'الشروق';

  @override
  String get prayerDhuhr => 'الظهر';

  @override
  String get prayerAsr => 'العصر';

  @override
  String get prayerMaghrib => 'المغرب';

  @override
  String get prayerIsha => 'العشاء';

  @override
  String prayerNextCountdownLabel(String prayerName, String countdown) {
    return '$prayerName بعد $countdown';
  }

  @override
  String get prayerUseGpsAction => 'تحديد الموقع تلقائياً (GPS)';

  @override
  String get prayerManualCitySearchTitle => 'اختيار المدينة يدوياً';

  @override
  String get prayerManualCitySearchHint =>
      'ابحث عن مدينتك (مثل: القاهرة، الإسكندرية، مكة)...';

  @override
  String get prayerCalculationSettingsTitle => 'خيارات حساب المواقيت';

  @override
  String get prayerAsrSchoolLabel => 'مذهب حساب صلاة العصر';

  @override
  String get prayerAsrShafi => 'الجمهور (الشافعي، المالكي، الحنبلي)';

  @override
  String get prayerAsrHanafi => 'المذهب الحنفي';

  @override
  String get prayerHighLatitudeRuleLabel => 'قاعدة خطوط العرض العليا';

  @override
  String get highLatMiddleOfNight => 'منتصف الليل';

  @override
  String get highLatSeventhOfNight => 'سُبع الليل';

  @override
  String get highLatTwilightAngle => 'زاوية الشفق';

  @override
  String get prayerManualAdjustmentsSection =>
      'تعديل الدقائق يدوياً لكل صلاة (-٣٠ إلى +٣٠ دقيقة)';

  @override
  String qiblaBearingLabel(String bearing) {
    return 'اتجاه القبلة: $bearing';
  }

  @override
  String get qiblaAlignedStatus => 'متجه نحو القبلة';

  @override
  String get qiblaCalibrationHint =>
      'نصيحة المعايرة: حرّك الهاتف على شكل رقم (8) بعيداً عن المعادن أو الأغطية المغناطيسية.';

  @override
  String get qiblaLowAccuracyWarning =>
      'دقة مستشعر البوصلة منخفضة حالياً. يُرجى معايرة الهاتف بتحريكه على شكل رقم 8.';

  @override
  String get qiblaNoSensorFallbackTitle =>
      'زاوية القبلة الثابتة (لا يتوفر مستشعر بوصلة)';

  @override
  String qiblaNoSensorFallbackBody(String bearing) {
    return 'لا يتوفر مستشعر بوصلة حي في هذا الجهاز. اتجه بزاوية $bearing باتجاه عقارب الساعة من الشمال الحقيقي.';
  }

  @override
  String get hijriAdjustmentLabel =>
      'تعديل التاريخ الهجري حسب رؤية الهلال (أيام)';

  @override
  String get hijriAdjustmentSubtitle =>
      'تعديل تقويم أم القرى بمقدار -٢ إلى +٢ يوم ليتوافق مع الرؤية المحلية للهلال.';

  @override
  String get islamicOccasionsTitle => 'المناسبات الإسلامية';

  @override
  String get notifSettingsTitle => 'التنبيهات والتذكيرات';

  @override
  String get notifConfigureAction =>
      'ضبط تنبيهات الصلوات والأوراد وحالة المنبّه';

  @override
  String get notifMissingAdhanAssetBanner =>
      'لم يتم تضمين ملف صوت الأذان المخصص (assets/audio/adhan.mp3) بعد. سيتم استخدام صوت التنبيه الافتراضي للنظام حتى تتم إضافة ملفات الأذان.';

  @override
  String get notifPerPrayerSectionTitle => 'تنبيهات الصلوات الخمس';

  @override
  String get notifAtPrayerTime => 'عند الأذان';

  @override
  String notifMinutesBefore(int minutes) {
    return 'قبل $minutes د';
  }

  @override
  String get notifSoundAdhan => 'صوت الأذان / افتراضي';

  @override
  String get notifSoundSilent => 'صامت';

  @override
  String get notifWirdReminderTitle => 'تذكير وِرد القرآن اليومي';

  @override
  String get notifFridayReminderTitle => 'تذكير يوم الجمعة (سورة الكهف)';

  @override
  String get notifTasbihReminderTitle => 'تذكير التسبيح اليومي';

  @override
  String get notifMorningAdhkarReminderTitle => 'تذكير أذكار الصباح';

  @override
  String get notifEveningAdhkarReminderTitle => 'تذكير أذكار المساء';

  @override
  String get notifHealthTitle => 'حالة التنبيهات وفحص المنبّه';

  @override
  String get notifHealthPermissionLabel => 'إذن الإشعارات (Android 13+ / iOS)';

  @override
  String get notifHealthExactAlarmLabel =>
      'إذن المنبّه الدقيق (Android 14+ SCHEDULE_EXACT_ALARM)';

  @override
  String get notifHealthStatusGranted => 'مفعّل';

  @override
  String get notifHealthStatusRequired => 'يتطلب تفعيل';

  @override
  String get notifHealthGrantAction => 'تفعيل / فتح الإعدادات';

  @override
  String get notifHealthBudgetLabel =>
      'عدد التنبيهات المجدولة (نافذة ٧ أيام متجددة)';

  @override
  String notifHealthBudgetValue(int count, int maxBudget) {
    return '$count / $maxBudget مجدول (الحد الأقصى لنظام iOS هو ٦٤)';
  }

  @override
  String get notifHealthNextThreeTitle => 'المواعيد الثلاثة القادمة المجدولة';

  @override
  String get notifHealthNoScheduled => 'لا توجد تنبيهات قادمة مجدولة حالياً.';

  @override
  String get batteryHelpTitle => 'إرشادات استثناء البطارية';

  @override
  String get batteryHelpIntro =>
      'تقوم بعض شركات الهواتف بإيقاف المنبهات الخلفية عند إغلاق التطبيق. اتبع الخطوات الخاصة بنوع هاتفك لضمان عمل تنبيهات الصلاة بدقة:';

  @override
  String get batteryHelpSamsungTitle => 'سامسونج (Samsung One UI)';

  @override
  String get batteryHelpSamsungBody =>
      'افتح الضبط ← التطبيقات ← قنديل ← البطارية ← اختر «غير مقيد (Unrestricted)»، وتأكد من عدم وجود التطبيق في قائمة التطبيقات الخاملة.';

  @override
  String get batteryHelpXiaomiTitle => 'شاومي / ريدمي / بوكو (MIUI & HyperOS)';

  @override
  String get batteryHelpXiaomiBody =>
      'افتح الإعدادات ← التطبيقات ← إدارة التطبيقات ← قنديل ← فعّل «التشغيل التلقائي (Autostart)»، ثم في موفر البطارية اختر «لا توجد قيود».';

  @override
  String get batteryHelpHuaweiTitle => 'هواوي / هونر (EMUI)';

  @override
  String get batteryHelpHuaweiBody =>
      'افتح الإعدادات ← البطارية ← تشغيل التطبيقات ← ابحث عن قنديل ← أوقف «الإدارة تلقائياً» وفعّل التشغيل التلقائي والتشغيل في الخلفية.';

  @override
  String get batteryHelpOnePlusOppoTitle =>
      'ون بلس / أوبو / ريلمي (OxygenOS & ColorOS)';

  @override
  String get batteryHelpOnePlusOppoBody =>
      'افتح الإعدادات ← التطبيقات ← إدارة التطبيقات ← قنديل ← استخدام البطارية ← فعّل «السماح بالنشاط في الخلفية» و«التشغيل التلقائي».';

  @override
  String get tasbihTabCounter => 'المسبحة';

  @override
  String get tasbihTabStats => 'الإحصاءات';

  @override
  String get tasbihSelectDhikrLabel => 'الذكر الحالي';

  @override
  String get tasbihAddCustomDhikrTitle => 'إضافة ذكر أو عنوان مخصص';

  @override
  String get tasbihAddCustomDhikrHint => 'اكتب عنوان الذكر المخصص...';

  @override
  String get tasbihTargetPresetLabel => 'الهدف';

  @override
  String get tasbihCustomTargetTitle => 'هدف مخصص';

  @override
  String get tasbihCustomTargetHint => 'أدخل العدد المستهدف (مثال: ٥٠٠)';

  @override
  String get tasbihHapticsTooltip => 'تفعيل أو إيقاف الاهتزاز عند التسبيح';

  @override
  String get tasbihTapPrompt => 'اضغط في أي موضع داخل الدائرة للتسبيح';

  @override
  String tasbihCompletedRoundsLabel(int rounds, int todayTotal) {
    return 'الدورات: $rounds • إجمالي اليوم: $todayTotal';
  }

  @override
  String get tasbihUndoAction => 'تراجع';

  @override
  String get tasbihResetAction => 'تصفير الدورة';

  @override
  String get tasbihSaveSessionAction => 'حفظ الجلسة';

  @override
  String get tasbihPeriodToday => 'اليوم';

  @override
  String get tasbihPeriodSevenDays => '٧ أيام';

  @override
  String get tasbihPeriodThirtyDays => '٣٠ يوماً';

  @override
  String get tasbihPeriodAllTime => 'كل الأوقات';

  @override
  String get tasbihCurrentStreakLabel => 'التتابع الحالي';

  @override
  String get tasbihBestStreakLabel => 'أفضل تتابع';

  @override
  String get tasbihPerDhikrBreakdownTitle => 'التفصيل حسب الذكر';

  @override
  String get tasbihEmptyStatsMessage =>
      'لم يتم تسجيل أي تسبيحات بعد. ابدأ التسبيح من تبويب المسبحة لبناء تتابعك اليومي.';

  @override
  String get tasbihExportJsonAction => 'تصدير الإحصاءات كملف JSON';

  @override
  String get prayerShellTitle => 'مواقيت الصلاة والقبلة';

  @override
  String get prayerShellDescription =>
      'حساب مواقيت الصلاة على الجهاز، بوصلة القبلة، والتقويم الهجري (أم القرى).';

  @override
  String get dhikrShellTitle => 'الأذكار والتسبيح';

  @override
  String get dhikrShellDescription =>
      'أذكار الصباح والمساء والأدعية المأثورة من مصادرها المعتمدة مع مسبحة إلكترونية وإحصاءات يومية.';

  @override
  String get settingsTitle => 'الإعدادات والمزيد';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get themeSystem => 'تلقائي (النظام)';

  @override
  String get themeLight => 'فاتح (عاجي)';

  @override
  String get themeDark => 'داكن (ليلي)';

  @override
  String get settingsTextSize => 'حجم خط الواجهة';

  @override
  String get settingsTextSizePreview => 'اقرأ واستمع وحافظ على وردك اليومي.';

  @override
  String get settingsPrayerMethod => 'طريقة حساب مواقيت الصلاة';

  @override
  String get prayerMethodEgyptian => 'الهيئة المصرية العامة للمساحة';

  @override
  String get prayerMethodUmmAlQura => 'جامعة أم القرى، مكة المكرمة';

  @override
  String get prayerMethodMuslimWorldLeague => 'رابطة العالم الإسلامي';

  @override
  String get prayerMethodKarachi => 'جامعة العلوم الإسلامية، كراتشي';

  @override
  String get prayerMethodNorthAmerica =>
      'الجمعية الإسلامية لأمريكا الشمالية (ISNA)';

  @override
  String get settingsNotifications => 'تنبيهات الصلاة والوِرد اليومي';

  @override
  String get settingsNotificationsSubtitle =>
      'تفعيل التنبيهات المحلية لمواقيت الصلاة، وِرد القرآن، والأذكار.';

  @override
  String get settingsAboutCredits => 'عن التطبيق والمصادر';

  @override
  String get settingsAboutCreditsSubtitle =>
      'توثيق مصادر القرآن الكريم والتفاسير والخطوط والتراخيص مفتوحة المصدر.';

  @override
  String get creditsTitle => 'عن التطبيق والمصادر';

  @override
  String get creditsContentIntegrityTitle => 'ميثاق أمانة المحتوى الديني';

  @override
  String get creditsContentIntegrityBody =>
      'لا يقوم تطبيق قنديل بتوليد أو تعديل أو تطبيع أو ترجمة أي نص قرآني أو تفسير أو ذكر أو دعاء آلياً. تُعرض جميع النصوص الشرعية كما وردت من مصادرها المعتمدة دون أي تغيير.';

  @override
  String get creditsQuranSourceTitle =>
      'نص القرآن الكريم والتفاسير والترجمات والتلاوات';

  @override
  String get creditsQuranSourceBody =>
      'بالتعاون مع مؤسسة القرآن الكريم (Quran Foundation — quran.com). التفسير العربي الافتراضي: التفسير الميسر (مجمع الملك فهد لطباعة المصحف الشريف). الترجمة الإنجليزية الافتراضية: The Clear Quran (د. مصطفى خطاب).';

  @override
  String get creditsAdhkarSourceTitle => 'أذكار الصباح والمساء والأدعية';

  @override
  String get creditsAdhkarSourceBody =>
      'أذكار الصباح والمساء من قاعدة بيانات (Seen-Arabic/Morning-And-Evening-Adhkar-DB — رخصة MIT)، مستندة إلى كتاب حصن المسلم للشيخ سعيد بن علي بن وهف القحطاني رحمه الله.';

  @override
  String get creditsFontsTitle => 'خط المصحف الشريف والهوية البصرية';

  @override
  String get creditsFontsBody =>
      'يُعرض النص القرآني بخط مصحف المدينة النبوية (حفص — مجمع الملك فهد لطباعة المصحف الشريف الإصدار ١٨ عبر Quran Foundation). العناوين والشعار بخط ريم كوفي (Reem Kufi — تصميم خالد حسني، رخصة SIL OFL 1.1). نصوص الواجهة بخط IBM Plex Sans Arabic (رخصة SIL OFL 1.1).';

  @override
  String get creditsOpenSourceLicenses => 'عرض تراخيص البرمجيات مفتوحة المصدر';

  @override
  String tasbihCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تسبيحة',
      many: '$count تسبيحة',
      few: '$count تسبيحات',
      two: 'تسبيحتان',
      one: 'تسبيحة واحدة',
      zero: 'لا تسبيحات اليوم',
    );
    return '$_temp0';
  }

  @override
  String verseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count آية',
      many: '$count آية',
      few: '$count آيات',
      two: 'آيتان',
      one: 'آية واحدة',
      zero: 'لا آيات',
    );
    return '$_temp0';
  }

  @override
  String pageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count صفحة',
      many: '$count صفحة',
      few: '$count صفحات',
      two: 'صفحتان',
      one: 'صفحة واحدة',
      zero: 'لا صفحات',
    );
    return '$_temp0';
  }

  @override
  String dayStreakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count يوم متتالي',
      many: '$count يوماً متتالياً',
      few: '$count أيام متتالية',
      two: 'يومان متتاليان',
      one: 'يوم واحد متتالي',
      zero: 'لم يبدأ التتابع بعد',
    );
    return '$_temp0';
  }

  @override
  String get adhkarTabTitle => 'الأذكار والأدعية';

  @override
  String get tasbihTabTitle => 'المسبحة';

  @override
  String get morningAdhkarBannerTitle => 'أذكار الصباح';

  @override
  String get morningAdhkarBannerSubtitle =>
      'ابدأ يومك بذكر الله وحصّن نفسك بالسكينة';

  @override
  String get eveningAdhkarBannerTitle => 'أذكار المساء';

  @override
  String get eveningAdhkarBannerSubtitle =>
      'اختم نهارك بالسكينة وحفظ الله تعالى';

  @override
  String get readAdhkarAction => 'قراءة الأذكار';

  @override
  String get categoryPendingNotice => 'قيد الاستيراد والتوثيق';

  @override
  String get categoryEmptyTitle => 'لا توجد أذكار في هذا القسم حالياً';

  @override
  String get categoryEmptyDescription =>
      'سيتم إضافة وتوثيق أذكار هذا القسم من مصادرها الشرعية المعتمدة.';

  @override
  String adhkarProgressCompleted(int completed, int total) {
    return '$completed من $total مكتمل';
  }

  @override
  String adhkarItemCounter(int current, int total) {
    return '$current من $total';
  }

  @override
  String get adhkarSourceLabel => 'المصدر';

  @override
  String get adhkarFadlLabel => 'الفضل';

  @override
  String get adhkarMarkCompletedAction => 'تمت القراءة';

  @override
  String get adhkarResetCategoryAction => 'إعادة ضبط تقدم اليوم';

  @override
  String get adhkarResetCategoryConfirm =>
      'هل تريد تصفير تقدم هذا القسم والبدء من جديد اليوم؟';

  @override
  String get adhkarFontSizeLabel => 'حجم الخط';

  @override
  String get adhkarShareCredit => 'تطبيق قنديل — نورٌ يرافق يومك';

  @override
  String get readingModeTitle => 'وضع القراءة والخشوع';

  @override
  String get readingModeActivePill => 'وضع القراءة مفعّل — اضغط للإنهاء';

  @override
  String get readingModeToggleTooltip => 'تفعيل أو إنهاء وضع القراءة والخشوع';

  @override
  String get readingModeAutoStartLabel =>
      'بدء وضع القراءة تلقائياً عند فتح المصحف';

  @override
  String get readingModeAutoStartSubtitle =>
      'إبقاء الشاشة مضاءة وتخفيف عناصر الواجهة وتأجيل تنبيهات التطبيق الداخلية أثناء القراءة.';

  @override
  String get readingModeDndEnabledLabel =>
      'تفعيل عدم الإزعاج (DND) أثناء القراءة (أندرويد)';

  @override
  String get readingModeDndEnabledSubtitle =>
      'يحفظ حالة هاتفك الحالية قبل القراءة ويعيدها تلقائياً فور الخروج أو عند إعادة تشغيل التطبيق.';

  @override
  String get readingModeDndFilterLabel =>
      'مستوى فلتر عدم الإزعاج أثناء القراءة';

  @override
  String get readingModeDndFilterPriorityTitle =>
      'الأولوية والأذان فقط (مُوصى به)';

  @override
  String get readingModeDndFilterPrioritySubtitle =>
      'يسمح بمرور أذان الصلاة والمنبّهات وجهات الاتصال ذات الأولوية، ويكتم الإشعارات العامة.';

  @override
  String get readingModeDndFilterAlarmsTitle => 'المنبّهات وأذان الصلاة فقط';

  @override
  String get readingModeDndFilterAlarmsSubtitle =>
      'يكتم المكالمات والرسائل، ويسمح فقط بمرور منبّهات النظام وأذان الصلاة المصنّف كمنبّه.';

  @override
  String get readingModeDndFilterNoneTitle => 'صمت تام (كتم الأذان والمنبّهات)';

  @override
  String get readingModeDndFilterNoneSubtitle =>
      'يكتم جميع الأصوات والإشعارات بما في ذلك الأذان والمنبّهات.';

  @override
  String get readingModeAndroidPermissionTitle =>
      'إذن إدارة عدم الإزعاج أثناء القراءة';

  @override
  String get readingModeAndroidPermissionBody =>
      'لتفعيل عدم الإزعاج تلقائياً أثناء تلاوة القرآن، يحتاج قنديل إلى إذن (الوصول إلى سياسة الإشعارات) في أندرويد. يحفظ التطبيق إعدادك السابق دائماً ويعيده فور خروجك من وضع القراءة ولن يترك هاتفك صامتاً أبداً.';

  @override
  String get readingModeOpenAndroidDndSettingsAction =>
      'فتح إعدادات عدم الإزعاج';

  @override
  String get readingModeVerifyDndPermissionAction => 'تحقّق وتفعيل الآن';

  @override
  String get readingModeDndPermissionNotGrantedWarning =>
      'لم يتم منح الإذن بعد من إعدادات النظام.';

  @override
  String get readingModeIosFocusTipTitle => 'نصيحة وضع التركيز (Focus) على iOS';

  @override
  String get readingModeIosFocusTipBody =>
      'لا يسمح نظام iOS لأي تطبيق بتشغيل وضع عدم الإزعاج برمجياً. للحصول على تجربة خاشعة بلا مقاطعة على آيفون:\n١. افتح تطبيق الإعدادات > التركيز (Focus) أو تطبيق الاختصارات (Shortcuts).\n٢. أنشئ تحكماً تلقائياً (Automation): عند فتح تطبيق «قنديل» ← تفعيل وضع التركيز (القراءة).';

  @override
  String get readingModeIosFocusTipButton =>
      'كيفية إعداد وضع التركيز على آيفون';

  @override
  String get readingModeGotItAction => 'حسناً، فهمت';

  @override
  String readingModeHeldNotificationsToast(int count) {
    return 'تم تأجيل $count من التنبيهات الداخلية أثناء قراءتك.';
  }

  @override
  String get onboardingSkipAction => 'تخطي';

  @override
  String get onboardingNextAction => 'التالي';

  @override
  String get onboardingStartAction => 'ابدأ مع قنديل';

  @override
  String get onboardingReadTitle => 'اقرأ بتدبّر وسكينة';

  @override
  String get onboardingReadSubtitle =>
      'مصحف المدينة النبوية بالرسم العثماني الأصيل، مع التفسير والترجمة ومعاني الكلمات ووضع القراءة والخشوع بلا مقاطعة.';

  @override
  String get onboardingListenTitle => 'استمع لكبار القرّاء';

  @override
  String get onboardingListenSubtitle =>
      'تلاوات خاشعة لكبار قرّاء مصر والعالم الإسلامي، مع متابعة الآيات وتنزيل السور للاستماع دون اتصال.';

  @override
  String get onboardingWirdTitle => 'واظب على وردك اليومي';

  @override
  String get onboardingWirdSubtitle =>
      'خطة ختمة ميسّرة، مواقيت صلاة دقيقة واتجاه القبلة، أذكار الصباح والمساء الموثّقة، ومسبحة يومية تحفظ تتابعك.';

  @override
  String get settingsReplayOnboarding => 'جولة تعريفية بتطبيق قنديل';

  @override
  String get settingsReplayOnboardingSubtitle =>
      'استعراض شاشات الترحيب الثلاث وهوية قنديل.';

  @override
  String get homeGreetingMorning => 'صباح النور والسكينة';

  @override
  String get homeGreetingAfternoon => 'طاب يومك بذكر الله';

  @override
  String get homeGreetingEvening => 'مساء السكينة والقرآن';

  @override
  String get homeMissingLocationPlaceholder =>
      'يرجى تحديد موقعك من شاشة الصلاة لعرض المواقيت والعد التنازلي.';

  @override
  String get homeQuickTasbihAction => 'تسبيح سريع (+1)';

  @override
  String get homeMorningAdhkarShortcut => 'أذكار الصباح الآن';

  @override
  String get homeEveningAdhkarShortcut => 'أذكار المساء الآن';

  @override
  String get homeOpenVerseWithTafsirAction => 'فتح الآية مع التفسير';

  @override
  String get hifzTitle => 'التحفيظ والمراجعة (الحفظ)';

  @override
  String get hifzTabPlan => 'الخطة والمراجعة';

  @override
  String get hifzTabTest => 'الاختبار والتسميع';

  @override
  String get hifzTabMistakes => 'نقاط الضعف';

  @override
  String get hifzTabStats => 'الإحصاءات والمعلّم';

  @override
  String get hifzAddRangeTitle => 'إضافة مقطع محفوظ';

  @override
  String get hifzAddRangeAction => 'إضافة للمحفوظ';

  @override
  String get hifzDailyGoalsTitle => 'أهداف الحفظ والمراجعة اليومية';

  @override
  String get hifzNewVersesPerDayLabel => 'آيات جديدة يومياً';

  @override
  String get hifzReviewsPerDayCapLabel => 'الحد الأقصى لمقاطع المراجعة يومياً';

  @override
  String get hifzCatchUpModeLabel =>
      'وضع الاستدراك (توزيع المراجعات الفائتة على عدة أيام)';

  @override
  String get hifzDueQueueTitle => 'مراجعات اليوم المستحقة';

  @override
  String get hifzDueQueueEmpty =>
      'لا توجد مقاطع مستحقة للمراجعة الآن. أضف مقطعاً محفوظاً أو ابدأ اختبار تسميع.';

  @override
  String get hifzAudioHelperTitle => 'مساعد التكرار الصوتي للحفظ';

  @override
  String get hifzAudioPauseGapLabel => 'وقفة الترديد بعد القارئ (بالثواني)';

  @override
  String get hifzStartAudioLoopAction => 'تكرار المقطع صوتياً';

  @override
  String get hifzTestModeByNumber => 'تسميع برقم الآية';

  @override
  String get hifzTestModeNextVerse => 'ما الآية التالية؟';

  @override
  String get hifzTestModeMistakes => 'مراجعة أخطائي';

  @override
  String get hifzRevealVerseAction => 'إظهار الآية للتحقق';

  @override
  String get hifzTapMistakeWordHint =>
      'اضغط على الكلمة التي أخطأت فيها (اختياري) ثم قيّم تسميعك:';

  @override
  String get hifzGradePerfect => 'متقن';

  @override
  String get hifzGradeHesitated => 'تردّد';

  @override
  String get hifzGradeForgot => 'نسيت';

  @override
  String get hifzWeakSpotsTitle => 'نقاط الضعف وسجل الأخطاء';

  @override
  String get hifzWeakSpotsEmpty =>
      'لم تُسجّل أي أخطاء بعد. عند اختيار (تردّد) أو (نسيت) أثناء التسميع ستظهر الآيات هنا لمراجعتها.';

  @override
  String get hifzMutashabihatTitle => 'المتشابهات اللفظية (نقطة توسعة معتمدة)';

  @override
  String get hifzMutashabihatNotice =>
      'حفاظاً على أمانة النص القرآني، لا يقوم التطبيق بتوليد المتشابهات آلياً. سيتم عرض المتشابهات هنا فور تزويد ملف البيانات الموثّق (assets/data/mutashabihat.json).';

  @override
  String get hifzStatsMemorizedVerses => 'الآيات المحفوظة';

  @override
  String get hifzStatsMemorizedPages => 'الصفحات';

  @override
  String get hifzStatsMemorizedJuz => 'الأجزاء';

  @override
  String get hifzStatsReviewStreak => 'تتابع المراجعة';

  @override
  String get hifzStatsWeeklyAccuracy => 'دقة التسميع الأسبوعية';

  @override
  String get hifzStatsProjectedCompletion => 'التاريخ المتوقع لختم الحفظ';

  @override
  String get hifzTeacherExportAction => 'مشاركة تقرير التقدم للمعلّم (JSON)';

  @override
  String get hifzHideModeTitle => 'وضع إخفاء الآيات للتسميع';

  @override
  String get hifzHideModeNone => 'عرض عادي (بدون إخفاء)';

  @override
  String get hifzHideModeAll => 'إخفاء جميع الكلمات';

  @override
  String get hifzHideModeFirstWord => 'إظهار الكلمة الأولى فقط من كل آية';

  @override
  String get hifzHideModeRandom => 'إخفاء نسبة عشوائية من الكلمات';

  @override
  String get hifzHideModeUntilTapped => 'إخفاء الآية حتى الضغط عليها';

  @override
  String get hifzHideModeWordByWord => 'إظهار كلمة بكلمة عند الضغط';

  @override
  String get creditsRecitersTitle => 'القرّاء والتلاوات الصوتية';

  @override
  String get creditsRecitersBody =>
      'تُوفَّر التلاوات الصوتية عبر واجهة مؤسسة القرآن (Quran Foundation / quran.com)، مع إبراز قرّاء المدرسة المصرية الأصيلة: الشيخ محمود خليل الحصري (المصحف المرتل والمعلّم)، الشيخ عبد الباسط عبد الصمد (المجود والمرتل)، الشيخ محمد صديق المنشاوي (المرتل والمجود)، الشيخ مشاري راشد العفاسي، الشيخ عبد الرحمن السديس، الشيخ سعود الشريم، الشيخ سعد الغامدي، الشيخ أبو بكر الشاطري، والشيخ هاني الرفاعي.';

  @override
  String get creditsTafsirTranslationsTitle => 'التفاسير والترجمات المعتمدة';

  @override
  String get creditsTafsirTranslationsBody =>
      'التفسير العربي الافتراضي: «التفسير الميسر» الصادر عن مجمع الملك فهد لطباعة المصحف الشريف، و«تفسير ابن كثير» عبر مؤسسة القرآن. الترجمات المعتمدة: «Saheeh International» و«The Clear Quran» (د. مصطفى خطاب) عبر مؤسسة القرآن.';

  @override
  String get creditsPrayerHijriTitle => 'مواقيت الصلاة والقبلة والتقويم الهجري';

  @override
  String get creditsPrayerHijriBody =>
      'تُحسب مواقيت الصلاة واتجاه القبلة فلكياً بالكامل داخل جهازك باستخدام مكتبة (adhan) مع ضبط الهيئة المصرية العامة للمساحة كخيار افتراضي. يعتمد التقويم الهجري على تقويم أم القرى (hijri_core) مع إمكانية تعديل الرؤية المحلية للهلال (-٢ إلى +٢ يوم).';

  @override
  String get creditsPrivacyTitle => 'سياسة الخصوصية وحماية البيانات';

  @override
  String get creditsPrivacyBody =>
      'يعمل تطبيق «قنديل» دون حسابات، ودون إعلانات، ودون أي أدوات تتبّع أو تحليلات سلوكية. يُستخدم موقعك الجغرافي (أثناء فتح التطبيق فقط) لحساب مواقيت الصلاة واتجاه القبلة محلياً على جهازك ولا يُرسل إلى أي خادم خارجي. تُحفظ جميع بيانات عبادتك (الختمة، العلامات المرجعية، الملاحظات، خطة الحفظ، وإحصاءات التسبيح) في قاعدة بيانات جهازك فقط.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get notFoundTitle => 'الصفحة غير موجودة';

  @override
  String get notFoundMessage => 'الصفحة التي تبحث عنها غير متوفرة.';

  @override
  String get backToHome => 'العودة إلى الرئيسية';
}
