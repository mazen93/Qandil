import 'dart:convert';

import 'package:home_widget/home_widget.dart';

import '../entities/home_entities.dart';

/// Gateway abstracting `home_widget: ^0.10.0` so the Phase 11 widget data-sharing
/// layer is 100% unit-testable in headless Dart tests.
abstract interface class HomeWidgetSyncGateway {
  Future<void> setAppGroupId(String appGroupId);
  Future<void> saveData(String key, Object value);
  Future<void> updateWidget({
    required String androidName,
    required String qualifiedAndroidName,
    required String iOSName,
  });
}

/// Production implementation of [HomeWidgetSyncGateway] powered by `home_widget: ^0.10.0`.
class PluginHomeWidgetSyncGateway implements HomeWidgetSyncGateway {
  const PluginHomeWidgetSyncGateway();

  @override
  Future<void> setAppGroupId(String appGroupId) async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
    } catch (_) {}
  }

  @override
  Future<void> saveData(String key, Object value) async {
    try {
      await HomeWidget.saveWidgetData<Object>(key, value);
    } catch (_) {}
  }

  @override
  Future<void> updateWidget({
    required String androidName,
    required String qualifiedAndroidName,
    required String iOSName,
  }) async {
    try {
      await HomeWidget.updateWidget(
        name: androidName,
        androidName: androidName,
        qualifiedAndroidName: qualifiedAndroidName,
        iOSName: iOSName,
      );
    } catch (_) {}
  }
}

/// Service that synchronizes [HomeWidgetPayload] to SharedPreferences (`HomeWidgetPreferences` on Android)
/// and App Group `UserDefaults` (`group.com.mmazin.qandil` on iOS) and triggers timeline reloads for
/// all 4 Qandil Home-Screen Widgets:
/// 1. Small: Next Prayer with countdown (`QandilNextPrayerWidget`)
/// 2. Medium: Five Prayer Times (`QandilFivePrayersWidget`)
/// 3. Small: Tasbih Counter with today's total (`QandilTasbihWidget`)
/// 4. Medium: Today's Wird Progress & Continue Reading (`QandilWirdWidget`)
class HomeWidgetSyncService {
  HomeWidgetSyncService({HomeWidgetSyncGateway? gateway})
      : _gateway = gateway ?? const PluginHomeWidgetSyncGateway();

  static const String iosAppGroupId = 'group.com.mmazin.qandil';
  static const String androidPackagePrefix = 'com.mmazin.qandil.widgets.';

  static const List<({String androidClass, String iosKind})> registeredWidgets =
      [
    (
      androidClass: 'QandilNextPrayerWidgetProvider',
      iosKind: 'QandilNextPrayerWidget',
    ),
    (
      androidClass: 'QandilFivePrayersWidgetProvider',
      iosKind: 'QandilFivePrayersWidget',
    ),
    (
      androidClass: 'QandilTasbihWidgetProvider',
      iosKind: 'QandilTasbihWidget',
    ),
    (
      androidClass: 'QandilWirdWidgetProvider',
      iosKind: 'QandilWirdWidget',
    ),
  ];

  final HomeWidgetSyncGateway _gateway;
  bool _appGroupInitialized = false;
  HomeWidgetPayload? _lastPayload;

  HomeWidgetPayload? get lastPayload => _lastPayload;

  /// Writes all key-value pairs and a full JSON snapshot to shared storage,
  /// then notifies all 4 Android AppWidgetProviders and iOS WidgetKit timelines to reload.
  Future<void> syncPayload(HomeWidgetPayload payload) async {
    if (!_appGroupInitialized) {
      await _gateway.setAppGroupId(iosAppGroupId);
      _appGroupInitialized = true;
    }

    final map = payload.toKeyValueMap();
    for (final entry in map.entries) {
      await _gateway.saveData(entry.key, entry.value);
    }

    // Also store a single JSON blob for atomic reads in Swift WidgetKit & Kotlin AppWidgetProviders
    await _gateway.saveData('qandil_payload_json', jsonEncode(map));

    for (final w in registeredWidgets) {
      await _gateway.updateWidget(
        androidName: 'widgets.${w.androidClass}',
        qualifiedAndroidName: '$androidPackagePrefix${w.androidClass}',
        iOSName: w.iosKind,
      );
    }

    _lastPayload = payload;
  }
}
