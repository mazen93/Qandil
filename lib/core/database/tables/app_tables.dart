import 'package:drift/drift.dart';

/// 1. Settings table storing user preferences (single row id = 1).
@DataClassName('SettingRecord')
class Settings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get languageCode => text().withDefault(const Constant('ar'))();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  RealColumn get textScaleFactor => real().withDefault(const Constant(1.0))();
  TextColumn get prayerCalculationMethod =>
      text().withDefault(const Constant('egyptian'))();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
  RealColumn get readerFontSize => real().withDefault(const Constant(26.0))();
  RealColumn get readerLineSpacing => real().withDefault(const Constant(1.9))();
  BoolColumn get keepScreenAwake =>
      boolean().withDefault(const Constant(true))();
  IntColumn get defaultReciterId => integer().withDefault(const Constant(6))();
  TextColumn get asrMadhab => text().withDefault(const Constant('shafi'))();
  TextColumn get highLatitudeRule =>
      text().withDefault(const Constant('middle_of_the_night'))();
  IntColumn get fajrAdjustmentMinutes =>
      integer().withDefault(const Constant(0))();
  IntColumn get sunriseAdjustmentMinutes =>
      integer().withDefault(const Constant(0))();
  IntColumn get dhuhrAdjustmentMinutes =>
      integer().withDefault(const Constant(0))();
  IntColumn get asrAdjustmentMinutes =>
      integer().withDefault(const Constant(0))();
  IntColumn get maghribAdjustmentMinutes =>
      integer().withDefault(const Constant(0))();
  IntColumn get ishaAdjustmentMinutes =>
      integer().withDefault(const Constant(0))();
  IntColumn get hijriAdjustmentDays =>
      integer().withDefault(const Constant(0))();
  RealColumn get locationLatitude =>
      real().withDefault(const Constant(30.0444))();
  RealColumn get locationLongitude =>
      real().withDefault(const Constant(31.2357))();
  TextColumn get locationCityNameAr =>
      text().withDefault(const Constant('القاهرة، مصر'))();
  TextColumn get locationCityNameEn =>
      text().withDefault(const Constant('Cairo, Egypt'))();
  TextColumn get prayerNotificationsConfigJson =>
      text().withDefault(const Constant('{}'))();
  BoolColumn get wirdReminderEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get wirdReminderHour => integer().withDefault(const Constant(20))();
  IntColumn get wirdReminderMinute =>
      integer().withDefault(const Constant(0))();
  BoolColumn get fridayReminderEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get fridayReminderHour =>
      integer().withDefault(const Constant(10))();
  IntColumn get fridayReminderMinute =>
      integer().withDefault(const Constant(0))();
  BoolColumn get tasbihReminderEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get tasbihReminderHour =>
      integer().withDefault(const Constant(21))();
  IntColumn get tasbihReminderMinute =>
      integer().withDefault(const Constant(0))();
  BoolColumn get tasbihHapticsEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get tasbihTargetPreset =>
      integer().withDefault(const Constant(33))();
  TextColumn get tasbihCustomLabelsJson =>
      text().withDefault(const Constant('[]'))();
  BoolColumn get morningAdhkarReminderEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get morningAdhkarReminderHour =>
      integer().withDefault(const Constant(7))();
  IntColumn get morningAdhkarReminderMinute =>
      integer().withDefault(const Constant(0))();
  BoolColumn get eveningAdhkarReminderEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get eveningAdhkarReminderHour =>
      integer().withDefault(const Constant(17))();
  IntColumn get eveningAdhkarReminderMinute =>
      integer().withDefault(const Constant(0))();
  BoolColumn get autoStartReadingMode =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get readingModeDndEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get readingModeDndFilter =>
      text().withDefault(const Constant('priority'))();
  IntColumn get savedPreviousDndFilter => integer().nullable()();
  BoolColumn get iosFocusTipShown =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
  IntColumn get hifzNewVersesPerDayGoal =>
      integer().withDefault(const Constant(5))();
  IntColumn get hifzReviewRangesPerDayCap =>
      integer().withDefault(const Constant(5))();
  IntColumn get hifzCatchUpDays => integer().withDefault(const Constant(3))();
  BoolColumn get hifzCatchUpModeEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get hifzReminderEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get hifzReminderHour => integer().withDefault(const Constant(6))();
  IntColumn get hifzReminderMinute =>
      integer().withDefault(const Constant(30))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// 2. Bookmarks table storing verse/page bookmarks with color markers.
@DataClassName('BookmarkRecord')
class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  IntColumn get pageNumber => integer()();
  TextColumn get colorHex => text().withDefault(const Constant('#F2A93B'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 3. Reading progress table tracking current Mushaf position and Khatmah plan.
@DataClassName('ReadingProgressRecord')
class ReadingProgress extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get surahNumber => integer().withDefault(const Constant(1))();
  IntColumn get ayahNumber => integer().withDefault(const Constant(1))();
  IntColumn get pageNumber => integer().withDefault(const Constant(1))();
  IntColumn get juzNumber => integer().withDefault(const Constant(1))();
  IntColumn get khatmahTargetDays =>
      integer().withDefault(const Constant(30))();
  DateTimeColumn get khatmahStartDate => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// 4. Notes table storing personal reflections attached to verses.
@DataClassName('NoteRecord')
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 5. Tasbih events table storing individual counter sessions/increments.
@DataClassName('TasbihEventRecord')
class TasbihEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get dhikrId => text()();
  IntColumn get count => integer()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}

/// 6. Tasbih daily table storing aggregated daily totals per dhikr in the same transaction.
@DataClassName('TasbihDailyRecord')
class TasbihDaily extends Table {
  /// Local calendar date formatted as YYYY-MM-DD.
  TextColumn get date => text()();
  TextColumn get dhikrId => text()();
  IntColumn get total => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {date, dhikrId};
}

/// 7. Downloads table tracking user-initiated offline audio and text packs.
@DataClassName('DownloadRecord')
class Downloads extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemType => text()(); // 'audio' or 'text_pack'
  IntColumn get reciterId => integer().nullable()();
  IntColumn get surahNumber => integer().nullable()();
  TextColumn get packId => text().nullable()();
  TextColumn get localPath => text()();
  TextColumn get status => text().withDefault(
        const Constant('pending'),
      )(); // pending, active, completed, failed
  RealColumn get progress => real().withDefault(const Constant(0.0))();
  IntColumn get totalBytes => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 8. Cached Quran chapters metadata (7-day cache TTL per Quran Foundation terms).
@DataClassName('CachedChapterRecord')
class CachedChapters extends Table {
  IntColumn get chapterId => integer()();
  TextColumn get languageCode => text().withDefault(const Constant('ar'))();
  TextColumn get nameArabic => text()();
  TextColumn get nameSimple => text()();
  TextColumn get nameTranslated => text()();
  TextColumn get revelationPlace => text()();
  IntColumn get revelationOrder => integer()();
  BoolColumn get bismillahPre => boolean()();
  IntColumn get versesCount => integer()();
  IntColumn get startPage => integer()();
  IntColumn get endPage => integer()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {chapterId, languageCode};
}

/// 9. Cached Quran verses (Uthmani text, word-by-word JSON, page/juz metadata; 7-day cache TTL).
@DataClassName('CachedVerseRecord')
class CachedVerses extends Table {
  TextColumn get verseKey => text()(); // e.g. '1:1'
  IntColumn get chapterId => integer()();
  IntColumn get verseNumber => integer()();
  IntColumn get pageNumber => integer()();
  IntColumn get juzNumber => integer()();
  IntColumn get hizbNumber => integer()();
  TextColumn get textUthmani => text()();
  TextColumn get textImlaeiSimple => text().withDefault(const Constant(''))();
  TextColumn get wordsJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {verseKey};
}

/// 10. Cached resource catalogs (tafsirs, translations, recitations; 7-day cache TTL).
@DataClassName('CachedResourceCatalogRecord')
class CachedResourceCatalogs extends Table {
  TextColumn get resourceType =>
      text()(); // 'tafsir' | 'translation' | 'recitation'
  IntColumn get resourceId => integer()();
  TextColumn get languageCode => text().withDefault(const Constant('ar'))();
  TextColumn get name => text()();
  TextColumn get authorName => text().withDefault(const Constant(''))();
  TextColumn get languageName => text().withDefault(const Constant(''))();
  TextColumn get slug => text().withDefault(const Constant(''))();
  TextColumn get style => text().withDefault(const Constant(''))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey =>
      {resourceType, resourceId, languageCode};
}

/// 11. Cached per-verse tafsir and translation texts (7-day cache TTL).
@DataClassName('CachedVerseAnnotationRecord')
class CachedVerseAnnotations extends Table {
  TextColumn get verseKey => text()();
  TextColumn get resourceType => text()(); // 'tafsir' | 'translation'
  IntColumn get resourceId => integer()();
  TextColumn get resourceName => text().withDefault(const Constant(''))();
  TextColumn get textContent => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {verseKey, resourceType, resourceId};
}

/// 12. Adhkar daily progress table (tracks counts per item per day, resets automatically each calendar day).
@DataClassName('AdhkarDailyProgressRecord')
class AdhkarDailyProgress extends Table {
  TextColumn get date => text()(); // 'YYYY-MM-DD'
  TextColumn get itemId => text()();
  TextColumn get category => text()();
  IntColumn get currentCount => integer().withDefault(const Constant(0))();
  IntColumn get targetCount => integer().withDefault(const Constant(1))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {date, itemId};
}

/// 13. Memorized verse ranges tracked by the Phase 12 SM-2 Hifz spaced-review scheduler.
@DataClassName('HifzMemorizedRangeRecord')
class HifzMemorizedRanges extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get startAyah => integer()();
  IntColumn get endAyah => integer()();
  IntColumn get startPage => integer().withDefault(const Constant(1))();
  IntColumn get endPage => integer().withDefault(const Constant(1))();
  IntColumn get juzNumber => integer().withDefault(const Constant(1))();
  RealColumn get easinessFactor => real().withDefault(const Constant(2.5))();
  IntColumn get intervalDays => integer().withDefault(const Constant(1))();
  IntColumn get repetitions => integer().withDefault(const Constant(0))();
  TextColumn get lastReviewedDate => text().nullable()(); // 'YYYY-MM-DD'
  TextColumn get nextDueDate => text()(); // 'YYYY-MM-DD'
  TextColumn get lastGrade => text().withDefault(const Constant('perfect'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 14. Append-only Hifz review history events used for streak and 7-day accuracy metrics.
@DataClassName('HifzReviewEventRecord')
class HifzReviewEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get rangeId => integer()();
  IntColumn get surahNumber => integer()();
  IntColumn get startAyah => integer()();
  IntColumn get endAyah => integer()();
  TextColumn get grade => text()(); // 'perfect' | 'hesitated' | 'forgot'
  TextColumn get localDate => text()(); // 'YYYY-MM-DD'
  DateTimeColumn get reviewedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 15. Hifz mistake log recording Forgot/Hesitated verses, optional tapped word position, and date.
@DataClassName('HifzMistakeLogRecord')
class HifzMistakeLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get verseKey => text()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  IntColumn get wordPosition => integer().nullable()();
  TextColumn get grade => text()(); // 'hesitated' | 'forgot'
  TextColumn get localDate => text()(); // 'YYYY-MM-DD'
  DateTimeColumn get recordedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 16. Singleton active Hifz test/review session (`id = 1`) so an in-progress session survives app kill.
@DataClassName('HifzActiveSessionRecord')
class HifzActiveSessions extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  TextColumn get sessionMode =>
      text().withDefault(const Constant('recite_by_number'))();
  IntColumn get rangeId => integer().nullable()();
  IntColumn get surahNumber => integer().withDefault(const Constant(1))();
  IntColumn get startAyah => integer().withDefault(const Constant(1))();
  IntColumn get endAyah => integer().withDefault(const Constant(7))();
  IntColumn get currentIndex => integer().withDefault(const Constant(0))();
  BoolColumn get isRevealed => boolean().withDefault(const Constant(false))();
  IntColumn get tappedMistakeWordPosition => integer().nullable()();
  TextColumn get verseKeysJson => text().withDefault(const Constant('[]'))();
  TextColumn get gradesJson => text().withDefault(const Constant('{}'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
