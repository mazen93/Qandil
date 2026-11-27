import 'dart:io';

import 'package:do_not_disturb/do_not_disturb.dart';

/// Gateway abstracting Android Do Not Disturb (`do_not_disturb: ^1.0.3`) and platform detection
/// so all Phase 9 Reading Mode and DND state-restoration logic is 100% unit-testable.
abstract interface class DndPlatformGateway {
  bool get isAndroid;
  bool get isIOS;

  /// Returns `true` on Android when the user has granted Notification Policy Access to Qandil.
  Future<bool> isNotificationPolicyAccessGranted();

  /// Opens the Android system "Do Not Disturb access" (`ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS`) screen.
  Future<void> openNotificationPolicyAccessSettings();

  /// Returns the current Android `NotificationManager` interruption filter integer:
  /// - `1` = `InterruptionFilter.all` (Normal / DND Off)
  /// - `2` = `InterruptionFilter.priority` (Priority Only)
  /// - `3` = `InterruptionFilter.none` (Total Silence)
  /// - `4` = `InterruptionFilter.alarms` (Alarms Only)
  Future<int> getCurrentInterruptionFilter();

  /// Sets the Android `NotificationManager` interruption filter integer (`1..4`).
  Future<void> setInterruptionFilter(int filterValue);
}

/// Production implementation of [DndPlatformGateway] powered by `do_not_disturb: ^1.0.3`.
class PluginDndPlatformGateway implements DndPlatformGateway {
  PluginDndPlatformGateway({DoNotDisturbPlugin? plugin})
      : _plugin = plugin ?? DoNotDisturbPlugin();

  final DoNotDisturbPlugin _plugin;

  @override
  bool get isAndroid => Platform.isAndroid;

  @override
  bool get isIOS => Platform.isIOS;

  @override
  Future<bool> isNotificationPolicyAccessGranted() async {
    if (!isAndroid) return false;
    try {
      return await _plugin.isNotificationPolicyAccessGranted();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> openNotificationPolicyAccessSettings() async {
    if (!isAndroid) return;
    try {
      await _plugin.openNotificationPolicyAccessSettings();
    } catch (_) {}
  }

  @override
  Future<int> getCurrentInterruptionFilter() async {
    if (!isAndroid) return InterruptionFilter.all.value;
    try {
      final status = await _plugin.getDNDStatus();
      return status.value;
    } catch (_) {
      return InterruptionFilter.all.value;
    }
  }

  @override
  Future<void> setInterruptionFilter(int filterValue) async {
    if (!isAndroid) return;
    try {
      final filter = InterruptionFilter.fromValue(filterValue);
      await _plugin.setInterruptionFilter(filter);
    } catch (_) {}
  }
}
