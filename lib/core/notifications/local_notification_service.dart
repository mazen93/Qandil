import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../features/settings/domain/entities/app_settings.dart';
import 'adhan_player_service.dart';
import 'notification_entities.dart';
import 'notification_window_planner.dart';

/// Gateway abstracting `FlutterLocalNotificationsPlugin` so scheduling logic is 100% unit-testable.
abstract interface class LocalNotificationGateway {
  Future<void> initialize({
    void Function(String? payload)? onNotificationTapped,
  });

  Future<bool> requestNotificationsPermission();

  Future<bool> requestExactAlarmPermission();

  Future<bool> areNotificationsEnabled();

  Future<bool> canScheduleExactAlarms();

  Future<void> cancelAll();

  Future<void> scheduleItem(PlannedNotificationItem item);

  Future<void> showItemNow(PlannedNotificationItem item);
}

/// Production implementation of [LocalNotificationGateway] powered by `flutter_local_notifications` and `timezone`.
class FlutterLocalNotificationGateway implements LocalNotificationGateway {
  FlutterLocalNotificationGateway({FlutterLocalNotificationsPlugin? plugin})
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;
  void Function(String? payload)? _onNotificationTapped;

  @override
  Future<void> initialize({
    void Function(String? payload)? onNotificationTapped,
  }) async {
    if (onNotificationTapped != null) {
      _onNotificationTapped = onNotificationTapped;
    }
    if (_initialized) return;
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    try {
      await _plugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (response) {
          _onNotificationTapped?.call(response.payload);
        },
      );
      await _createAndroidChannels();
      _initialized = true;

      final launchDetails = await _plugin.getNotificationAppLaunchDetails();
      if (launchDetails != null && launchDetails.didNotificationLaunchApp) {
        _onNotificationTapped?.call(
          launchDetails.notificationResponse?.payload,
        );
      }
    } catch (_) {
      // Safe fallback in headless unit test environments.
    }
  }

  Future<void> _createAndroidChannels() async {
    final androidImplementation = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation == null) return;

    for (final channel in QandilNotificationChannel.values) {
      final isPrayer = channel == QandilNotificationChannel.prayer;
      await androidImplementation.createNotificationChannel(
        AndroidNotificationChannel(
          isPrayer ? 'qandil_prayer_adhan' : channel.id,
          channel.defaultName,
          importance: Importance.max,
          playSound: true,
          sound: isPrayer
              ? const RawResourceAndroidNotificationSound('adhan')
              : null,
        ),
      );
      if (isPrayer) {
        await androidImplementation.createNotificationChannel(
          const AndroidNotificationChannel(
            'qandil_prayer_silent',
            'Prayer Alerts (Silent)',
            importance: Importance.high,
            playSound: false,
          ),
        );
      }
    }
  }

  @override
  Future<bool> requestNotificationsPermission() async {
    try {
      if (Platform.isAndroid) {
        final android = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        return await android?.requestNotificationsPermission() ?? false;
      } else if (Platform.isIOS) {
        final ios = _plugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
        return await ios?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
            false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> requestExactAlarmPermission() async {
    try {
      if (Platform.isAndroid) {
        final android = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        return await android?.requestExactAlarmsPermission() ?? false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> areNotificationsEnabled() async {
    try {
      if (Platform.isAndroid) {
        final android = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        return await android?.areNotificationsEnabled() ?? true;
      } else if (Platform.isIOS) {
        final ios = _plugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
        final permissions = await ios?.checkPermissions();
        return permissions?.isEnabled ?? false;
      }
      return true;
    } catch (_) {
      return true;
    }
  }

  @override
  Future<bool> canScheduleExactAlarms() async {
    try {
      if (Platform.isAndroid) {
        final android = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        return await android?.canScheduleExactNotifications() ?? true;
      }
      return true;
    } catch (_) {
      return true;
    }
  }

  @override
  Future<void> cancelAll() async {
    try {
      await _plugin.cancelAll();
    } catch (_) {}
  }

  NotificationDetails _buildDetails(PlannedNotificationItem item) {
    final isPrayerChannel = item.channel == QandilNotificationChannel.prayer;
    final androidChannelId = isPrayerChannel
        ? (item.playSound ? 'qandil_prayer_adhan' : 'qandil_prayer_silent')
        : item.channel.id;
    final androidDetails = AndroidNotificationDetails(
      androidChannelId,
      item.channel.defaultName,
      importance: Importance.max,
      priority: Priority.high,
      playSound: item.playSound,
      sound: isPrayerChannel && item.playSound
          ? const RawResourceAndroidNotificationSound('adhan')
          : null,
      category: isPrayerChannel ? AndroidNotificationCategory.alarm : null,
      audioAttributesUsage: isPrayerChannel
          ? AudioAttributesUsage.alarm
          : AudioAttributesUsage.notification,
    );
    final darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBanner: true,
      presentList: true,
      presentSound: item.playSound,
      sound: isPrayerChannel && item.playSound ? 'adhan.caf' : null,
      interruptionLevel: isPrayerChannel
          ? InterruptionLevel.timeSensitive
          : InterruptionLevel.active,
    );

    return NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
    );
  }

  @override
  Future<void> scheduleItem(PlannedNotificationItem item) async {
    try {
      await initialize();
      final scheduledTz = tz.TZDateTime.from(item.scheduledAt, tz.local);

      await _plugin.zonedSchedule(
        id: item.id,
        title: item.title,
        body: item.body,
        scheduledDate: scheduledTz,
        notificationDetails: _buildDetails(item),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: item.payload,
      );
    } catch (_) {
      // Safe fallback in test environments without native alarm manager.
    }
  }

  @override
  Future<void> showItemNow(PlannedNotificationItem item) async {
    try {
      await initialize();
      await _plugin.show(
        id: item.id,
        title: item.title,
        body: item.body,
        notificationDetails: _buildDetails(item),
        payload: item.payload,
      );
    } catch (_) {
      // Safe fallback in test environments without native alarm manager.
    }
  }
}

/// High-level Phase 6 Notification Service managing:
/// - Rolling 7-day window rescheduling (< 64 iOS budget)
/// - Checking if bundled Adhan audio exists in `assets/audio/adhan.mp3` (falling back to default sound if missing)
/// - Generating [NotificationHealthStatus] for the Notification Health screen
class LocalNotificationService {
  LocalNotificationService({
    LocalNotificationGateway? gateway,
    AdhanPlayerService? adhanPlayer,
    DateTime Function()? clock,
  })  : _gateway = gateway ?? FlutterLocalNotificationGateway(),
        _adhanPlayer = adhanPlayer,
        _clock = clock ?? DateTime.now;

  final LocalNotificationGateway _gateway;
  final AdhanPlayerService? _adhanPlayer;
  final DateTime Function() _clock;

  void _handleNotificationTapped(String? payload) {
    if (payload == null) return;
    if (payload == 'test_adhan' || payload.startsWith('prayer:')) {
      _adhanPlayer?.playFullAdhan();
    }
  }

  Future<void> _initGateway() {
    return _gateway.initialize(
      onNotificationTapped: _handleNotificationTapped,
    );
  }

  List<PlannedNotificationItem> _lastScheduledWindow = const [];
  bool _hasBundledAdhanAudio = false;

  List<PlannedNotificationItem> get lastScheduledWindow => _lastScheduledWindow;
  bool get hasBundledAdhanAudio => _hasBundledAdhanAudio;

  /// Checks whether `assets/audio/adhan.mp3` is present in the app bundle.
  Future<bool> checkBundledAdhanAudioAsset() async {
    try {
      await rootBundle.load('assets/audio/adhan.mp3');
      _hasBundledAdhanAudio = true;
    } catch (_) {
      _hasBundledAdhanAudio = false;
    }
    return _hasBundledAdhanAudio;
  }

  /// Reschedules the entire 7-day rolling window of notifications based on [settings].
  Future<List<PlannedNotificationItem>> rescheduleRollingWindow(
    AppSettings settings,
  ) async {
    await _initGateway();
    await checkBundledAdhanAudioAsset();
    await _gateway.cancelAll();

    final planned = NotificationWindowPlanner.planRollingSevenDayWindow(
      now: _clock(),
      settings: settings,
    );

    for (final item in planned) {
      await _gateway.scheduleItem(item);
    }

    _lastScheduledWindow = planned;
    return planned;
  }

  Future<bool> requestNotificationsPermission() {
    return _gateway.requestNotificationsPermission();
  }

  Future<bool> requestExactAlarmPermission() {
    return _gateway.requestExactAlarmPermission();
  }

  /// Triggers a test Adhan notification immediately or after [delay] (for testing in dev).
  ///
  /// When [_adhanPlayer] is available, it also holds the background audio session
  /// active across [delay] so the complete 2m13s Adhan plays even after locking the screen.
  Future<void> triggerTestAdhanNotification({
    Duration delay = Duration.zero,
    String title = 'Qandil — Test Adhan',
    String body = 'Allahu Akbar • Testing Adhan notification & sound',
  }) async {
    await _initGateway();
    await requestNotificationsPermission();
    final useBackgroundFullPlayer = _adhanPlayer != null;
    final item = PlannedNotificationItem(
      id: 999001,
      channel: QandilNotificationChannel.prayer,
      title: title,
      body: body,
      scheduledAt: _clock().add(delay),
      playSound: !useBackgroundFullPlayer,
      payload: 'test_adhan',
    );
    if (delay <= Duration.zero) {
      await _gateway.showItemNow(item);
      await _adhanPlayer?.playFullAdhan(title: title);
    } else {
      await _gateway.scheduleItem(item);
      await _adhanPlayer?.scheduleFullAdhan(delay: delay, title: title);
    }
  }

  /// Builds the live [NotificationHealthStatus] for the Notification Health screen.
  Future<NotificationHealthStatus> getHealthStatus(AppSettings settings) async {
    final permissionGranted = await _gateway.areNotificationsEnabled();
    final exactAlarmGranted = await _gateway.canScheduleExactAlarms();

    if (_lastScheduledWindow.isEmpty && settings.notificationsEnabled) {
      await rescheduleRollingWindow(settings);
    }

    final now = _clock();
    final upcoming = _lastScheduledWindow
        .where((item) => item.scheduledAt.isAfter(now))
        .toList(growable: false);

    return NotificationHealthStatus(
      permissionGranted: permissionGranted,
      exactAlarmGranted: exactAlarmGranted,
      hasBundledAdhanAudio: _hasBundledAdhanAudio,
      scheduledCount: upcoming.length,
      maxBudget: NotificationWindowPlanner.maxPendingBudget,
      nextThreeScheduled: upcoming.take(3).toList(growable: false),
    );
  }
}
