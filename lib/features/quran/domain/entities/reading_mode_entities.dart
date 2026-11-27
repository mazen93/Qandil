import 'package:flutter/foundation.dart';

/// Supported Android Do Not Disturb interruption filter choices while reading in Qandil.
///
/// Android `android.app.NotificationManager` filter constants:
/// - `INTERRUPTION_FILTER_ALL` (`1`): Normal mode (DND off).
/// - `INTERRUPTION_FILTER_PRIORITY` (`2`): Priority notifications, alarms, and Qandil's Adhan allowed.
/// - `INTERRUPTION_FILTER_NONE` (`3`): Total silence (blocks everything, including Adhan and alarms).
/// - `INTERRUPTION_FILTER_ALARMS` (`4`): Alarms only (blocks calls/messages, lets alarms & Qandil's Adhan alarm category through).
enum ReadingDndFilterOption {
  priority('priority', 2, allowsAdhan: true),
  alarms('alarms', 4, allowsAdhan: true),
  totalSilence('none', 3, allowsAdhan: false);

  const ReadingDndFilterOption(
    this.code,
    this.androidFilterValue, {
    required this.allowsAdhan,
  });

  final String code;

  /// Raw Android `NotificationManager.INTERRUPTION_FILTER_*` value (`do_not_disturb` `InterruptionFilter.value`).
  final int androidFilterValue;

  /// Whether Qandil's Prayer Adhan notification (`AndroidNotificationCategory.alarm`) sounds under this filter.
  final bool allowsAdhan;

  static ReadingDndFilterOption fromCode(String raw) {
    for (final option in values) {
      if (option.code == raw) return option;
    }
    return ReadingDndFilterOption.priority;
  }
}

/// Represents one of Qandil's own non-Adhan in-app notifications held (queued)
/// while the user is actively reading in Reading Mode.
@immutable
class HeldInAppNotification {
  const HeldInAppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.queuedAt,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
  final DateTime queuedAt;
}

/// Result returned when entering Reading Mode.
@immutable
class ReadingModeEnterOutcome {
  const ReadingModeEnterOutcome({
    required this.isActive,
    this.appliedDndFilter,
    this.needsAndroidPolicyPermission = false,
    this.shouldShowIosFocusTip = false,
  });

  final bool isActive;
  final ReadingDndFilterOption? appliedDndFilter;
  final bool needsAndroidPolicyPermission;
  final bool shouldShowIosFocusTip;
}
