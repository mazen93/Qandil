import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/app_tables.dart';

part 'app_database.g.dart';

/// Core offline-first SQLite database for Qandil with migration strategy from day one.
@DriftDatabase(
  tables: [
    Settings,
    Bookmarks,
    ReadingProgress,
    Notes,
    TasbihEvents,
    TasbihDaily,
    Downloads,
    CachedChapters,
    CachedVerses,
    CachedResourceCatalogs,
    CachedVerseAnnotations,
    AdhkarDailyProgress,
    HifzMemorizedRanges,
    HifzReviewEvents,
    HifzMistakeLogs,
    HifzActiveSessions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// Maximum allowed cache lifetime for Quran Foundation API content (7 days).
  static const Duration quranCacheMaxAge = Duration(days: 7);

  @override
  int get schemaVersion => 11;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Seed default singleton settings row and initial reading progress row
        await into(settings).insert(
          SettingsCompanion.insert(),
          mode: InsertMode.insertOrIgnore,
        );
        await into(readingProgress).insert(
          ReadingProgressCompanion.insert(),
          mode: InsertMode.insertOrIgnore,
        );
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(cachedChapters);
          await m.createTable(cachedVerses);
          await m.createTable(cachedResourceCatalogs);
          await m.createTable(cachedVerseAnnotations);
        }
        if (from < 3) {
          await m.addColumn(settings, settings.readerFontSize);
          await m.addColumn(settings, settings.readerLineSpacing);
          await m.addColumn(settings, settings.keepScreenAwake);
        }
        if (from < 4) {
          await m.addColumn(settings, settings.defaultReciterId);
        }
        if (from < 5) {
          await m.addColumn(settings, settings.asrMadhab);
          await m.addColumn(settings, settings.highLatitudeRule);
          await m.addColumn(settings, settings.fajrAdjustmentMinutes);
          await m.addColumn(settings, settings.sunriseAdjustmentMinutes);
          await m.addColumn(settings, settings.dhuhrAdjustmentMinutes);
          await m.addColumn(settings, settings.asrAdjustmentMinutes);
          await m.addColumn(settings, settings.maghribAdjustmentMinutes);
          await m.addColumn(settings, settings.ishaAdjustmentMinutes);
          await m.addColumn(settings, settings.hijriAdjustmentDays);
          await m.addColumn(settings, settings.locationLatitude);
          await m.addColumn(settings, settings.locationLongitude);
          await m.addColumn(settings, settings.locationCityNameAr);
          await m.addColumn(settings, settings.locationCityNameEn);
        }
        if (from < 6) {
          await m.addColumn(settings, settings.prayerNotificationsConfigJson);
          await m.addColumn(settings, settings.wirdReminderEnabled);
          await m.addColumn(settings, settings.wirdReminderHour);
          await m.addColumn(settings, settings.wirdReminderMinute);
          await m.addColumn(settings, settings.fridayReminderEnabled);
          await m.addColumn(settings, settings.fridayReminderHour);
          await m.addColumn(settings, settings.fridayReminderMinute);
          await m.addColumn(settings, settings.tasbihReminderEnabled);
          await m.addColumn(settings, settings.tasbihReminderHour);
          await m.addColumn(settings, settings.tasbihReminderMinute);
        }
        if (from < 7) {
          await m.addColumn(settings, settings.tasbihHapticsEnabled);
          await m.addColumn(settings, settings.tasbihTargetPreset);
          await m.addColumn(settings, settings.tasbihCustomLabelsJson);
        }
        if (from < 8) {
          await m.createTable(adhkarDailyProgress);
          await m.addColumn(settings, settings.morningAdhkarReminderEnabled);
          await m.addColumn(settings, settings.morningAdhkarReminderHour);
          await m.addColumn(settings, settings.morningAdhkarReminderMinute);
          await m.addColumn(settings, settings.eveningAdhkarReminderEnabled);
          await m.addColumn(settings, settings.eveningAdhkarReminderHour);
          await m.addColumn(settings, settings.eveningAdhkarReminderMinute);
        }
        if (from < 9) {
          await m.addColumn(settings, settings.autoStartReadingMode);
          await m.addColumn(settings, settings.readingModeDndEnabled);
          await m.addColumn(settings, settings.readingModeDndFilter);
          await m.addColumn(settings, settings.savedPreviousDndFilter);
          await m.addColumn(settings, settings.iosFocusTipShown);
        }
        if (from < 10) {
          await m.addColumn(settings, settings.onboardingCompleted);
        }
        if (from < 11) {
          await m.createTable(hifzMemorizedRanges);
          await m.createTable(hifzReviewEvents);
          await m.createTable(hifzMistakeLogs);
          await m.createTable(hifzActiveSessions);
          await m.addColumn(settings, settings.hifzNewVersesPerDayGoal);
          await m.addColumn(settings, settings.hifzReviewRangesPerDayCap);
          await m.addColumn(settings, settings.hifzCatchUpDays);
          await m.addColumn(settings, settings.hifzCatchUpModeEnabled);
          await m.addColumn(settings, settings.hifzReminderEnabled);
          await m.addColumn(settings, settings.hifzReminderHour);
          await m.addColumn(settings, settings.hifzReminderMinute);
        }
      },
      beforeOpen: (OpeningDetails details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  /// Purges any cached Quran Foundation API records older than [maxAge] (defaults to 7 days).
  Future<int> purgeExpiredQuranCache({
    DateTime? now,
    Duration maxAge = quranCacheMaxAge,
  }) async {
    final cutoff = (now ?? DateTime.now().toUtc()).subtract(maxAge);
    var deletedCount = 0;

    await transaction(() async {
      deletedCount += await (delete(cachedChapters)
            ..where((t) => t.cachedAt.isSmallerThanValue(cutoff)))
          .go();
      deletedCount += await (delete(cachedVerses)
            ..where((t) => t.cachedAt.isSmallerThanValue(cutoff)))
          .go();
      deletedCount += await (delete(cachedResourceCatalogs)
            ..where((t) => t.cachedAt.isSmallerThanValue(cutoff)))
          .go();
      deletedCount += await (delete(cachedVerseAnnotations)
            ..where((t) => t.cachedAt.isSmallerThanValue(cutoff)))
          .go();
    });

    return deletedCount;
  }

  /// Fetches the singleton settings row, creating default settings if absent.
  Future<SettingRecord> getOrCreateSettings() async {
    final existing = await (select(settings)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    if (existing != null) {
      return existing;
    }
    await into(settings).insert(
      SettingsCompanion.insert(),
      mode: InsertMode.insertOrIgnore,
    );
    return (select(settings)..where((t) => t.id.equals(1))).getSingle();
  }

  /// Updates the singleton settings row.
  Future<SettingRecord> updateSettings(SettingsCompanion companion) async {
    await (update(settings)..where((t) => t.id.equals(1))).write(companion);
    return getOrCreateSettings();
  }

  // ---------------------------------------------------------------------------
  // Reading Progress & Khatmah Plan DAO Methods
  // ---------------------------------------------------------------------------

  Future<ReadingProgressRecord> getOrCreateReadingProgress() async {
    final existing = await (select(readingProgress)
          ..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    if (existing != null) {
      return existing;
    }
    await into(readingProgress).insert(
      ReadingProgressCompanion.insert(),
      mode: InsertMode.insertOrIgnore,
    );
    return (select(readingProgress)..where((t) => t.id.equals(1))).getSingle();
  }

  Stream<ReadingProgressRecord> watchReadingProgress() {
    return (select(readingProgress)..where((t) => t.id.equals(1)))
        .watchSingleOrNull()
        .map(
          (row) =>
              row ??
              ReadingProgressRecord(
                id: 1,
                surahNumber: 1,
                ayahNumber: 1,
                pageNumber: 1,
                juzNumber: 1,
                khatmahTargetDays: 30,
                khatmahStartDate: null,
                updatedAt: DateTime.now().toUtc(),
              ),
        );
  }

  Future<ReadingProgressRecord> saveReadingPosition({
    required int surahNumber,
    required int ayahNumber,
    required int pageNumber,
    required int juzNumber,
  }) async {
    await getOrCreateReadingProgress();
    await (update(readingProgress)..where((t) => t.id.equals(1))).write(
      ReadingProgressCompanion(
        surahNumber: Value(surahNumber),
        ayahNumber: Value(ayahNumber),
        pageNumber: Value(pageNumber),
        juzNumber: Value(juzNumber),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
    return getOrCreateReadingProgress();
  }

  Future<ReadingProgressRecord> saveKhatmahPlan({
    required int targetDays,
    required DateTime startDate,
  }) async {
    await getOrCreateReadingProgress();
    await (update(readingProgress)..where((t) => t.id.equals(1))).write(
      ReadingProgressCompanion(
        khatmahTargetDays: Value(targetDays),
        khatmahStartDate: Value(startDate),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
    return getOrCreateReadingProgress();
  }

  // ---------------------------------------------------------------------------
  // Bookmarks & Notes DAO Methods
  // ---------------------------------------------------------------------------

  Future<List<BookmarkRecord>> getAllBookmarks() {
    return (select(bookmarks)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();
  }

  Future<BookmarkRecord?> getBookmarkForVerse({
    required int surahNumber,
    required int ayahNumber,
  }) {
    return (select(bookmarks)
          ..where(
            (t) =>
                t.surahNumber.equals(surahNumber) &
                t.ayahNumber.equals(ayahNumber),
          ))
        .getSingleOrNull();
  }

  Future<void> upsertBookmark({
    required int surahNumber,
    required int ayahNumber,
    required int pageNumber,
    required String colorHex,
  }) async {
    final existing = await getBookmarkForVerse(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
    );
    final now = DateTime.now().toUtc();
    if (existing == null) {
      await into(bookmarks).insert(
        BookmarksCompanion.insert(
          surahNumber: surahNumber,
          ayahNumber: ayahNumber,
          pageNumber: pageNumber,
          colorHex: Value(colorHex),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    } else {
      await (update(bookmarks)..where((t) => t.id.equals(existing.id))).write(
        BookmarksCompanion(
          pageNumber: Value(pageNumber),
          colorHex: Value(colorHex),
          updatedAt: Value(now),
        ),
      );
    }
  }

  Future<void> deleteBookmarkForVerse({
    required int surahNumber,
    required int ayahNumber,
  }) async {
    await (delete(bookmarks)
          ..where(
            (t) =>
                t.surahNumber.equals(surahNumber) &
                t.ayahNumber.equals(ayahNumber),
          ))
        .go();
  }

  Future<NoteRecord?> getNoteForVerse({
    required int surahNumber,
    required int ayahNumber,
  }) {
    return (select(notes)
          ..where(
            (t) =>
                t.surahNumber.equals(surahNumber) &
                t.ayahNumber.equals(ayahNumber),
          ))
        .getSingleOrNull();
  }

  Future<void> saveNoteForVerse({
    required int surahNumber,
    required int ayahNumber,
    required String content,
  }) async {
    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      await (delete(notes)
            ..where(
              (t) =>
                  t.surahNumber.equals(surahNumber) &
                  t.ayahNumber.equals(ayahNumber),
            ))
          .go();
      return;
    }

    final existing = await getNoteForVerse(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
    );
    final now = DateTime.now().toUtc();
    if (existing == null) {
      await into(notes).insert(
        NotesCompanion.insert(
          surahNumber: surahNumber,
          ayahNumber: ayahNumber,
          content: trimmed,
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    } else {
      await (update(notes)..where((t) => t.id.equals(existing.id))).write(
        NotesCompanion(
          content: Value(trimmed),
          updatedAt: Value(now),
        ),
      );
    }
  }

  /// Records a tasbih increment and updates the daily aggregate in the same transaction.
  Future<void> recordTasbihIncrement({
    required String dhikrId,
    required int count,
    required String localDate,
    DateTime? timestamp,
  }) async {
    await transaction(() async {
      await into(tasbihEvents).insert(
        TasbihEventsCompanion.insert(
          dhikrId: dhikrId,
          count: count,
          timestamp:
              timestamp != null ? Value(timestamp) : const Value.absent(),
        ),
      );

      final existingDaily = await (select(tasbihDaily)
            ..where(
              (t) => t.date.equals(localDate) & t.dhikrId.equals(dhikrId),
            ))
          .getSingleOrNull();

      if (existingDaily == null) {
        await into(tasbihDaily).insert(
          TasbihDailyCompanion.insert(
            date: localDate,
            dhikrId: dhikrId,
            total: Value(count),
          ),
        );
      } else {
        await (update(tasbihDaily)
              ..where(
                (t) => t.date.equals(localDate) & t.dhikrId.equals(dhikrId),
              ))
            .write(
          TasbihDailyCompanion(
            total: Value(existingDaily.total + count),
          ),
        );
      }
    });
  }

  /// Undoes the most recent tasbih event for [dhikrId] and decrements `tasbih_daily`
  /// in the same SQLite transaction. Returns the decremented count (or 0 if none).
  Future<int> undoLastTasbihIncrement({
    required String dhikrId,
    required String localDate,
  }) async {
    return transaction(() async {
      final latestEvents = await (select(tasbihEvents)
            ..where((t) => t.dhikrId.equals(dhikrId))
            ..orderBy([
              (t) => OrderingTerm.desc(t.timestamp),
              (t) => OrderingTerm.desc(t.id),
            ])
            ..limit(1))
          .get();

      if (latestEvents.isEmpty) {
        return 0;
      }

      final lastEvent = latestEvents.first;
      await (delete(tasbihEvents)..where((t) => t.id.equals(lastEvent.id)))
          .go();

      final existingDaily = await (select(tasbihDaily)
            ..where(
              (t) => t.date.equals(localDate) & t.dhikrId.equals(dhikrId),
            ))
          .getSingleOrNull();

      if (existingDaily != null) {
        final newTotal = existingDaily.total - lastEvent.count;
        if (newTotal <= 0) {
          await (delete(tasbihDaily)
                ..where(
                  (t) => t.date.equals(localDate) & t.dhikrId.equals(dhikrId),
                ))
              .go();
        } else {
          await (update(tasbihDaily)
                ..where(
                  (t) => t.date.equals(localDate) & t.dhikrId.equals(dhikrId),
                ))
              .write(
            TasbihDailyCompanion(total: Value(newTotal)),
          );
        }
      }

      return lastEvent.count;
    });
  }

  /// Streams all rows from `tasbih_daily` ordered by date ascending.
  Stream<List<TasbihDailyRecord>> watchAllTasbihDaily() {
    return (select(tasbihDaily)..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .watch();
  }

  /// Fetches all rows from `tasbih_daily` ordered by date ascending.
  Future<List<TasbihDailyRecord>> getAllTasbihDaily() {
    return (select(tasbihDaily)..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
  }

  /// Fetches all rows from `tasbih_events` ordered by timestamp descending.
  Future<List<TasbihEventRecord>> getAllTasbihEvents() {
    return (select(tasbihEvents)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  /// Streams daily progress for adhkar on a specific calendar date ([date] = `YYYY-MM-DD`).
  Stream<List<AdhkarDailyProgressRecord>> watchAdhkarDailyProgressForDate(
    String date,
  ) {
    return (select(adhkarDailyProgress)..where((t) => t.date.equals(date)))
        .watch();
  }

  /// Fetches daily progress for adhkar on a specific calendar date ([date] = `YYYY-MM-DD`).
  Future<List<AdhkarDailyProgressRecord>> getAdhkarDailyProgressForDate(
    String date,
  ) {
    return (select(adhkarDailyProgress)..where((t) => t.date.equals(date)))
        .get();
  }

  /// Upserts daily progress for a single dhikr item on [date].
  Future<AdhkarDailyProgressRecord> upsertAdhkarItemProgress({
    required String date,
    required String itemId,
    required String category,
    required int currentCount,
    required int targetCount,
    required bool isCompleted,
  }) async {
    return into(adhkarDailyProgress).insertReturning(
      AdhkarDailyProgressCompanion(
        date: Value(date),
        itemId: Value(itemId),
        category: Value(category),
        currentCount: Value(currentCount),
        targetCount: Value(targetCount),
        isCompleted: Value(isCompleted),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  /// Resets daily progress for all items in a specific category on [date].
  Future<int> resetAdhkarProgressForCategory({
    required String date,
    required String category,
  }) async {
    return (delete(adhkarDailyProgress)
          ..where((t) => t.date.equals(date) & t.category.equals(category)))
        .go();
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'qandil_db');
  }
}
