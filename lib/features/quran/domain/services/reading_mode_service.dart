import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../entities/reading_mode_entities.dart';
import 'dnd_platform_gateway.dart';

/// Phase 9 Reading Mode & Crash-Safe Do Not Disturb Service:
/// - All platforms:
///   - Keeps the screen awake while Reading Mode is active
///   - Holds Qandil's own non-Adhan in-app notifications while reading (queues them) and flushes them on exit
///   - Drives dimmed UI chrome state in the Quran Reader
/// - Android only:
///   - Checks Notification Policy Access (`isNotificationPolicyAccessGranted()`)
///   - On enter: saves the current interruption filter to Drift (`savedPreviousDndFilter`) BEFORE applying the chosen filter
///   - On exit: restores the saved interruption filter and clears `savedPreviousDndFilter`
///   - On next app launch (`restoreCrashedDndSessionIfNeeded()`): if a saved filter exists from a crashed or killed session,
///     restores it immediately so the phone is NEVER left in DND silently.
/// - iOS only:
///   - Never claims programmatic DND; triggers a one-time tip on creating an iOS Focus mode or Shortcuts automation.
class ReadingModeService {
  ReadingModeService({
    required AppDatabase database,
    required DndPlatformGateway dndGateway,
  })  : _database = database,
        _dndGateway = dndGateway;

  final AppDatabase _database;
  final DndPlatformGateway _dndGateway;

  bool _isReadingModeActive = false;
  final List<HeldInAppNotification> _heldNotifications = [];

  bool get isReadingModeActive => _isReadingModeActive;
  bool get isAndroid => _dndGateway.isAndroid;
  bool get isIOS => _dndGateway.isIOS;

  List<HeldInAppNotification> get heldNotifications =>
      List.unmodifiable(_heldNotifications);

  /// Must be called on app startup (`registerDependencies` / `SettingsCubit.loadSettings`).
  ///
  /// If a previous session crashed or was killed while Qandil had applied DND (`savedPreviousDndFilter != null`),
  /// restores that exact interruption filter immediately and clears the persisted crash marker.
  /// Returns the restored filter value if crash recovery occurred, or `null` otherwise.
  Future<int?> restoreCrashedDndSessionIfNeeded() async {
    final row = await _database.getOrCreateSettings();
    final savedFilter = row.savedPreviousDndFilter;
    if (savedFilter == null) {
      return null;
    }

    if (_dndGateway.isAndroid) {
      final hasAccess = await _dndGateway.isNotificationPolicyAccessGranted();
      if (hasAccess) {
        await _dndGateway.setInterruptionFilter(savedFilter);
      }
    }

    await _database.updateSettings(
      const SettingsCompanion(
        savedPreviousDndFilter: Value(null),
      ),
    );
    return savedFilter;
  }

  Future<bool> isNotificationPolicyAccessGranted() {
    return _dndGateway.isNotificationPolicyAccessGranted();
  }

  Future<void> openNotificationPolicyAccessSettings() {
    return _dndGateway.openNotificationPolicyAccessSettings();
  }

  /// Enters Reading Mode:
  /// - Activates Reading Mode state (wakelock + dim UI chrome + notification hold queue)
  /// - On Android, if `readingModeDndEnabled` is true:
  ///   - Verifies Notification Policy Access; if missing, returns `needsAndroidPolicyPermission: true` without applying DND
  ///   - Otherwise saves the current OS interruption filter to Drift first and applies the user's chosen filter
  /// - On iOS, if `iosFocusTipShown` is false, marks it shown and returns `shouldShowIosFocusTip: true`.
  Future<ReadingModeEnterOutcome> enterReadingMode() async {
    final row = await _database.getOrCreateSettings();
    _isReadingModeActive = true;

    if (_dndGateway.isAndroid && row.readingModeDndEnabled) {
      final hasAccess = await _dndGateway.isNotificationPolicyAccessGranted();
      if (!hasAccess) {
        return const ReadingModeEnterOutcome(
          isActive: true,
          needsAndroidPolicyPermission: true,
        );
      }

      // Save current filter BEFORE modifying OS DND state (only if not already saved)
      if (row.savedPreviousDndFilter == null) {
        final currentFilter = await _dndGateway.getCurrentInterruptionFilter();
        await _database.updateSettings(
          SettingsCompanion(
            savedPreviousDndFilter: Value(currentFilter),
          ),
        );
      }

      final chosenOption = ReadingDndFilterOption.fromCode(
        row.readingModeDndFilter,
      );
      await _dndGateway.setInterruptionFilter(chosenOption.androidFilterValue);

      return ReadingModeEnterOutcome(
        isActive: true,
        appliedDndFilter: chosenOption,
      );
    }

    if (_dndGateway.isIOS && !row.iosFocusTipShown) {
      await _database.updateSettings(
        const SettingsCompanion(
          iosFocusTipShown: Value(true),
        ),
      );
      return const ReadingModeEnterOutcome(
        isActive: true,
        shouldShowIosFocusTip: true,
      );
    }

    return const ReadingModeEnterOutcome(isActive: true);
  }

  /// Exits Reading Mode:
  /// - Always restores the saved Android interruption filter (if any) and clears `savedPreviousDndFilter` in Drift
  /// - Flushes and returns any held in-app notifications queued during the reading session.
  Future<List<HeldInAppNotification>> exitReadingMode() async {
    _isReadingModeActive = false;

    final row = await _database.getOrCreateSettings();
    final savedFilter = row.savedPreviousDndFilter;
    if (savedFilter != null) {
      if (_dndGateway.isAndroid) {
        final hasAccess = await _dndGateway.isNotificationPolicyAccessGranted();
        if (hasAccess) {
          await _dndGateway.setInterruptionFilter(savedFilter);
        }
      }
      await _database.updateSettings(
        const SettingsCompanion(
          savedPreviousDndFilter: Value(null),
        ),
      );
    }

    return flushHeldNotifications();
  }

  /// Holds an in-app notification while Reading Mode is active.
  /// Returns `true` if the notification was queued (held), or `false` if Reading Mode is not active
  /// (or if it is an Adhan prayer notification while the user chose a filter that allows Adhan).
  bool holdNotificationIfReading({
    required HeldInAppNotification notification,
    bool isPrayerAdhan = false,
    ReadingDndFilterOption currentFilter = ReadingDndFilterOption.priority,
  }) {
    if (!_isReadingModeActive) {
      return false;
    }
    if (isPrayerAdhan && currentFilter.allowsAdhan) {
      return false;
    }
    _heldNotifications.add(notification);
    return true;
  }

  /// Empties and returns all queued notifications held during Reading Mode.
  List<HeldInAppNotification> flushHeldNotifications() {
    if (_heldNotifications.isEmpty) return const [];
    final flushed = List<HeldInAppNotification>.from(_heldNotifications);
    _heldNotifications.clear();
    return flushed;
  }
}
