import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/core/notifications/local_notification_service.dart';
import 'package:qandil/core/notifications/notification_entities.dart';
import 'package:qandil/core/notifications/notification_window_planner.dart';
import 'package:qandil/features/settings/domain/entities/app_settings.dart';

class FakeLocalNotificationGateway implements LocalNotificationGateway {
  final List<PlannedNotificationItem> scheduledItems = [];
  int cancelAllCalls = 0;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> areNotificationsEnabled() async => true;

  @override
  Future<bool> canScheduleExactAlarms() async => true;

  @override
  Future<bool> requestNotificationsPermission() async => true;

  @override
  Future<bool> requestExactAlarmPermission() async => true;

  @override
  Future<void> cancelAll() async {
    cancelAllCalls++;
    scheduledItems.clear();
  }

  @override
  Future<void> scheduleItem(PlannedNotificationItem item) async {
    scheduledItems.add(item);
  }
}

void main() {
  group('Phase 6: NotificationWindowPlanner & LocalNotificationService', () {
    test(
        'plans rolling 7-day window strictly under 64 notifications (max 56) even when all prayers, wird, Friday, and tasbih reminders are enabled',
        () {
      // Morning of Thursday, Nov 26, 2026 at 04:00 AM (before Fajr)
      final now = DateTime(2026, 11, 26, 4, 0);
      const settings = AppSettings(
        notificationsEnabled: true,
        wirdReminderEnabled: true,
        wirdReminderHour: 20,
        wirdReminderMinute: 0,
        fridayReminderEnabled: true,
        fridayReminderHour: 10,
        fridayReminderMinute: 0,
        tasbihReminderEnabled: true,
        tasbihReminderHour: 21,
        tasbihReminderMinute: 30,
      );

      final planned = NotificationWindowPlanner.planRollingSevenDayWindow(
        now: now,
        settings: settings,
        utcOffset: const Duration(hours: 2),
      );

      // Must be non-empty, sorted chronologically, all in the future, and strictly < 64 (<= 56)
      expect(planned, isNotEmpty);
      expect(planned.length, lessThanOrEqualTo(56));
      expect(planned.length, lessThan(64));

      for (var i = 0; i < planned.length; i++) {
        expect(planned[i].scheduledAt.isAfter(now), isTrue);
        if (i > 0) {
          expect(
            !planned[i].scheduledAt.isBefore(planned[i - 1].scheduledAt),
            isTrue,
          );
        }
      }

      // Check channels present: prayer, wird (daily + Friday), tasbih
      expect(
        planned.any((item) => item.channel == QandilNotificationChannel.prayer),
        isTrue,
      );
      expect(
        planned.any((item) => item.payload == 'wird:daily'),
        isTrue,
      );
      expect(
        planned.any((item) => item.payload == 'wird:friday'),
        isTrue,
      );
      expect(
        planned.any((item) => item.channel == QandilNotificationChannel.tasbih),
        isTrue,
      );
      expect(
        planned.any((item) => item.payload == 'adhkar:morning'),
        isTrue,
      );
      expect(
        planned.any((item) => item.payload == 'adhkar:evening'),
        isTrue,
      );
    });

    test(
        'respects per-prayer minutesBefore offset, silent mode, and individual prayer on/off toggles',
        () {
      final now = DateTime(2026, 11, 26, 4, 0);
      const customConfig = PrayerNotificationsScheduleConfig(
        fajr: PerPrayerNotificationConfig(
          enabled: true,
          minutesBefore: 15,
          soundMode: PrayerNotificationSoundMode.silent,
        ),
        dhuhr: PerPrayerNotificationConfig(enabled: false),
      );

      const settings = AppSettings(
        notificationsEnabled: true,
        prayerNotificationsConfig: customConfig,
        wirdReminderEnabled: false,
        fridayReminderEnabled: false,
        tasbihReminderEnabled: false,
        morningAdhkarReminderEnabled: false,
        eveningAdhkarReminderEnabled: false,
      );

      final planned = NotificationWindowPlanner.planRollingSevenDayWindow(
        now: now,
        settings: settings,
        utcOffset: const Duration(hours: 2),
      );

      // Dhuhr is disabled -> 4 prayers/day * 7 days = 28 items
      expect(planned.length, 28);
      expect(planned.any((i) => i.payload == 'prayer:dhuhr'), isFalse);

      final firstFajr = planned.firstWhere((i) => i.payload == 'prayer:fajr');
      expect(firstFajr.playSound, isFalse); // Silent mode
      expect(firstFajr.body, contains('15')); // 15 min before
    });

    test(
        'LocalNotificationService cancels existing alarms, schedules rolling window, and reports next 3 scheduled items on Health status',
        () async {
      final fakeNow = DateTime(2026, 11, 26, 4, 0);
      final fakeGateway = FakeLocalNotificationGateway();
      final service = LocalNotificationService(
        gateway: fakeGateway,
        clock: () => fakeNow,
      );

      const settings = AppSettings(notificationsEnabled: true);
      final scheduled = await service.rescheduleRollingWindow(settings);

      expect(fakeGateway.cancelAllCalls, 1);
      expect(fakeGateway.scheduledItems.length, scheduled.length);

      final health = await service.getHealthStatus(settings);
      expect(health.permissionGranted, isTrue);
      expect(health.exactAlarmGranted, isTrue);
      expect(health.scheduledCount, scheduled.length);
      expect(health.nextThreeScheduled.length, 3);
      expect(
        health.nextThreeScheduled[0].scheduledAt.isBefore(
          health.nextThreeScheduled[1].scheduledAt,
        ),
        isTrue,
      );
    });
  });
}
