import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/core/database/app_database.dart';
import 'package:qandil/features/quran/domain/entities/reading_mode_entities.dart';
import 'package:qandil/features/quran/domain/services/dnd_platform_gateway.dart';
import 'package:qandil/features/quran/domain/services/reading_mode_service.dart';

class FakeDndPlatformGateway implements DndPlatformGateway {
  FakeDndPlatformGateway({
    this.isAndroid = true,
    this.isIOS = false,
    this.policyAccessGranted = true,
    this.currentFilter = 1, // 1 = InterruptionFilter.all (DND off)
  });

  @override
  bool isAndroid;

  @override
  bool isIOS;

  bool policyAccessGranted;
  int currentFilter;
  int openPolicySettingsCalls = 0;
  final List<int> appliedFiltersHistory = [];

  @override
  Future<bool> isNotificationPolicyAccessGranted() async => policyAccessGranted;

  @override
  Future<void> openNotificationPolicyAccessSettings() async {
    openPolicySettingsCalls++;
  }

  @override
  Future<int> getCurrentInterruptionFilter() async => currentFilter;

  @override
  Future<void> setInterruptionFilter(int filterValue) async {
    currentFilter = filterValue;
    appliedFiltersHistory.add(filterValue);
  }
}

void main() {
  late AppDatabase db;
  late FakeDndPlatformGateway fakeGateway;
  late ReadingModeService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    fakeGateway = FakeDndPlatformGateway();
    service = ReadingModeService(
      database: db,
      dndGateway: fakeGateway,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('Phase 9: ReadingModeService & Crash-Safe DND State Restoration', () {
    test(
        'on enter saves current Android interruption filter to Drift, applies chosen filter, and restores original filter on exit',
        () async {
      // Enable DND while reading with Alarms & Adhan Only filter (value = 4)
      await db.updateSettings(
        const SettingsCompanion(
          readingModeDndEnabled: Value(true),
          readingModeDndFilter: Value('alarms'),
        ),
      );
      fakeGateway.currentFilter = 1; // Phone starts in Normal mode (1 = All)

      final outcome = await service.enterReadingMode();
      expect(outcome.isActive, isTrue);
      expect(outcome.appliedDndFilter, ReadingDndFilterOption.alarms);
      expect(outcome.needsAndroidPolicyPermission, isFalse);

      // Verify OS filter changed to 4 (INTERRUPTION_FILTER_ALARMS) and previous filter (1) is persisted in Drift
      expect(fakeGateway.currentFilter, 4);
      final rowDuringReading = await db.getOrCreateSettings();
      expect(rowDuringReading.savedPreviousDndFilter, 1);

      // Exit Reading Mode -> must restore filter 1 and clear savedPreviousDndFilter
      await service.exitReadingMode();
      expect(service.isReadingModeActive, isFalse);
      expect(fakeGateway.currentFilter, 1);

      final rowAfterExit = await db.getOrCreateSettings();
      expect(rowAfterExit.savedPreviousDndFilter, isNull);
    });

    test(
        'CRASH RECOVERY: if app crashes or is killed while in DND, restoreCrashedDndSessionIfNeeded restores previous filter on next launch',
        () async {
      await db.updateSettings(
        const SettingsCompanion(
          readingModeDndEnabled: Value(true),
          readingModeDndFilter: Value('none'), // Total silence (3)
        ),
      );
      fakeGateway.currentFilter = 2; // User previously had Priority mode (2)

      // Enter Reading Mode -> phone switched to Total Silence (3), savedPreviousDndFilter = 2 in SQLite
      await service.enterReadingMode();
      expect(fakeGateway.currentFilter, 3);
      expect((await db.getOrCreateSettings()).savedPreviousDndFilter, 2);

      // Simulate app crash / force kill: create a brand-new ReadingModeService on next launch without calling exitReadingMode()
      final nextLaunchService = ReadingModeService(
        database: db,
        dndGateway: fakeGateway,
      );

      final restoredFilter =
          await nextLaunchService.restoreCrashedDndSessionIfNeeded();

      // Verify original filter (2) was restored immediately and crash marker cleared
      expect(restoredFilter, 2);
      expect(fakeGateway.currentFilter, 2);
      expect((await db.getOrCreateSettings()).savedPreviousDndFilter, isNull);
    });

    test(
        'never changes OS DND state if Notification Policy Access is not granted, and requests permission explanation flow',
        () async {
      await db.updateSettings(
        const SettingsCompanion(
          readingModeDndEnabled: Value(true),
          readingModeDndFilter: Value('priority'),
        ),
      );
      fakeGateway.policyAccessGranted = false;
      fakeGateway.currentFilter = 1;

      final outcome = await service.enterReadingMode();

      expect(outcome.isActive, isTrue);
      expect(outcome.needsAndroidPolicyPermission, isTrue);
      expect(outcome.appliedDndFilter, isNull);
      expect(fakeGateway.currentFilter, 1);
      expect(fakeGateway.appliedFiltersHistory, isEmpty);
      expect((await db.getOrCreateSettings()).savedPreviousDndFilter, isNull);
    });

    test(
        'holds in-app non-Adhan notifications while reading and flushes on exit, while allowing Adhan through under Priority and Alarms filters',
        () async {
      await service.enterReadingMode();

      final wirdNotification = HeldInAppNotification(
        id: 2001,
        title: 'Daily Quran Wird',
        body: 'Time for your daily wird',
        payload: 'wird:daily',
        queuedAt: DateTime(2026, 11, 27, 20, 0),
      );
      final adhanNotification = HeldInAppNotification(
        id: 1001,
        title: 'Maghrib Prayer Time',
        body: 'It is now time for Maghrib',
        payload: 'prayer:maghrib',
        queuedAt: DateTime(2026, 11, 27, 17, 0),
      );

      // 1. Non-Adhan reminder is held while reading
      final heldWird = service.holdNotificationIfReading(
        notification: wirdNotification,
      );
      expect(heldWird, isTrue);
      expect(service.heldNotifications.length, 1);

      // 2. Adhan is NOT held under Priority Only (allowsAdhan: true) or Alarms Only (allowsAdhan: true)
      expect(ReadingDndFilterOption.priority.allowsAdhan, isTrue);
      expect(ReadingDndFilterOption.alarms.allowsAdhan, isTrue);
      expect(ReadingDndFilterOption.totalSilence.allowsAdhan, isFalse);

      final heldAdhanUnderPriority = service.holdNotificationIfReading(
        notification: adhanNotification,
        isPrayerAdhan: true,
        currentFilter: ReadingDndFilterOption.priority,
      );
      expect(heldAdhanUnderPriority, isFalse);

      final heldAdhanUnderAlarms = service.holdNotificationIfReading(
        notification: adhanNotification,
        isPrayerAdhan: true,
        currentFilter: ReadingDndFilterOption.alarms,
      );
      expect(heldAdhanUnderAlarms, isFalse);

      // 3. Exiting Reading Mode flushes the held Wird reminder
      final flushed = await service.exitReadingMode();
      expect(flushed.length, 1);
      expect(flushed.first.id, 2001);
      expect(service.heldNotifications, isEmpty);
    });

    test(
        'iOS: shows one-time Focus / Shortcuts tip on first enter and never again automatically',
        () async {
      fakeGateway.isAndroid = false;
      fakeGateway.isIOS = true;

      final firstEnter = await service.enterReadingMode();
      expect(firstEnter.shouldShowIosFocusTip, isTrue);
      expect((await db.getOrCreateSettings()).iosFocusTipShown, isTrue);
      await service.exitReadingMode();

      final secondEnter = await service.enterReadingMode();
      expect(secondEnter.shouldShowIosFocusTip, isFalse);
    });
  });
}
