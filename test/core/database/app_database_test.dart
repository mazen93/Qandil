import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('AppDatabase (Drift SQLite)', () {
    test(
        'opens, runs onCreate migration, and seeds default settings & reading_progress',
        () async {
      expect(db.schemaVersion, 11);

      final settingsRow = await db.getOrCreateSettings();
      expect(settingsRow.id, 1);
      expect(settingsRow.languageCode, 'ar');
      expect(settingsRow.themeMode, 'system');
      expect(settingsRow.textScaleFactor, 1.0);
      expect(settingsRow.prayerCalculationMethod, 'egyptian');
      expect(settingsRow.notificationsEnabled, isTrue);

      final progressRow = await db.select(db.readingProgress).getSingle();
      expect(progressRow.id, 1);
      expect(progressRow.surahNumber, 1);
      expect(progressRow.ayahNumber, 1);
      expect(progressRow.pageNumber, 1);
      expect(progressRow.juzNumber, 1);
      expect(progressRow.khatmahTargetDays, 30);
    });

    test('updates settings row cleanly', () async {
      final updated = await db.updateSettings(
        const SettingsCompanion(
          languageCode: Value('en'),
          themeMode: Value('dark'),
          textScaleFactor: Value(1.2),
          prayerCalculationMethod: Value('umm_al_qura'),
          notificationsEnabled: Value(false),
        ),
      );

      expect(updated.languageCode, 'en');
      expect(updated.themeMode, 'dark');
      expect(updated.textScaleFactor, 1.2);
      expect(updated.prayerCalculationMethod, 'umm_al_qura');
      expect(updated.notificationsEnabled, isFalse);
    });

    test('supports CRUD on bookmarks, notes, and downloads tables', () async {
      // Bookmarks
      final bookmarkId = await db.into(db.bookmarks).insert(
            BookmarksCompanion.insert(
              surahNumber: 2,
              ayahNumber: 255,
              pageNumber: 42,
              colorHex: const Value('#1F6F5C'),
            ),
          );
      final bookmark = await (db.select(db.bookmarks)
            ..where((t) => t.id.equals(bookmarkId)))
          .getSingle();
      expect(bookmark.surahNumber, 2);
      expect(bookmark.ayahNumber, 255);
      expect(bookmark.pageNumber, 42);
      expect(bookmark.colorHex, '#1F6F5C');

      // Notes
      final noteId = await db.into(db.notes).insert(
            NotesCompanion.insert(
              surahNumber: 1,
              ayahNumber: 1,
              content: 'Personal reflection note',
            ),
          );
      final note = await (db.select(db.notes)
            ..where((t) => t.id.equals(noteId)))
          .getSingle();
      expect(note.content, 'Personal reflection note');

      // Downloads
      final downloadId = await db.into(db.downloads).insert(
            DownloadsCompanion.insert(
              itemType: 'audio',
              reciterId: const Value(7),
              surahNumber: const Value(1),
              localPath: '/app_private/audio/7/001.mp3',
              status: const Value('completed'),
              progress: const Value(1.0),
              totalBytes: const Value(512000),
            ),
          );
      final download = await (db.select(db.downloads)
            ..where((t) => t.id.equals(downloadId)))
          .getSingle();
      expect(download.itemType, 'audio');
      expect(download.reciterId, 7);
      expect(download.status, 'completed');
    });

    test(
        'recordTasbihIncrement writes event and updates tasbih_daily in same transaction',
        () async {
      await db.recordTasbihIncrement(
        dhikrId: 'subhanallah',
        count: 33,
        localDate: '2026-11-26',
      );
      await db.recordTasbihIncrement(
        dhikrId: 'subhanallah',
        count: 33,
        localDate: '2026-11-26',
      );

      final events = await db.select(db.tasbihEvents).get();
      expect(events.length, 2);

      final daily = await (db.select(db.tasbihDaily)
            ..where(
              (t) =>
                  t.date.equals('2026-11-26') & t.dhikrId.equals('subhanallah'),
            ))
          .getSingle();
      expect(daily.total, 66);
    });

    test('upserts adhkar daily progress and resets by category on same date',
        () async {
      await db.upsertAdhkarItemProgress(
        date: '2026-11-27',
        itemId: 'morning_01',
        category: 'morning',
        currentCount: 3,
        targetCount: 3,
        isCompleted: true,
      );

      final recordsBeforeReset =
          await db.getAdhkarDailyProgressForDate('2026-11-27');
      expect(recordsBeforeReset.length, 1);
      expect(recordsBeforeReset.first.itemId, 'morning_01');
      expect(recordsBeforeReset.first.isCompleted, isTrue);

      await db.resetAdhkarProgressForCategory(
        date: '2026-11-27',
        category: 'morning',
      );

      final recordsAfterReset =
          await db.getAdhkarDailyProgressForDate('2026-11-27');
      expect(recordsAfterReset, isEmpty);
    });
  });
}
