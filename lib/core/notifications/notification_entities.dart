import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../features/prayer/domain/entities/prayer_entities.dart';

/// Phase 6 Notification channels: prayer, wird, tasbih, general.
enum QandilNotificationChannel {
  prayer('qandil_prayer', 'Prayer Alerts & Adhan'),
  wird('qandil_wird', 'Daily Wird & Friday Reminders'),
  tasbih('qandil_tasbih', 'Daily Tasbih Reminders'),
  general('qandil_general', 'General Qandil Notifications');

  const QandilNotificationChannel(this.id, this.defaultName);
  final String id;
  final String defaultName;
}

/// Sound mode for per-prayer alerts (`adhan` vs `silent`).
enum PrayerNotificationSoundMode {
  adhan('adhan'),
  silent('silent');

  const PrayerNotificationSoundMode(this.code);
  final String code;

  static PrayerNotificationSoundMode fromCode(String raw) {
    return raw == 'silent'
        ? PrayerNotificationSoundMode.silent
        : PrayerNotificationSoundMode.adhan;
  }
}

/// Configuration for an individual prayer's notification (Fajr, Dhuhr, Asr, Maghrib, Isha).
@immutable
class PerPrayerNotificationConfig {
  const PerPrayerNotificationConfig({
    this.enabled = true,
    this.minutesBefore = 0,
    this.soundMode = PrayerNotificationSoundMode.adhan,
  });

  factory PerPrayerNotificationConfig.fromJson(Map<String, dynamic> json) {
    return PerPrayerNotificationConfig(
      enabled: json['enabled'] as bool? ?? true,
      minutesBefore: ((json['minutesBefore'] as num?)?.toInt() ?? 0).clamp(
        0,
        60,
      ),
      soundMode: PrayerNotificationSoundMode.fromCode(
        json['soundMode'] as String? ?? 'adhan',
      ),
    );
  }

  final bool enabled;
  final int minutesBefore;
  final PrayerNotificationSoundMode soundMode;

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'minutesBefore': minutesBefore,
        'soundMode': soundMode.code,
      };

  PerPrayerNotificationConfig copyWith({
    bool? enabled,
    int? minutesBefore,
    PrayerNotificationSoundMode? soundMode,
  }) {
    return PerPrayerNotificationConfig(
      enabled: enabled ?? this.enabled,
      minutesBefore: (minutesBefore ?? this.minutesBefore).clamp(0, 60),
      soundMode: soundMode ?? this.soundMode,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerPrayerNotificationConfig &&
          runtimeType == other.runtimeType &&
          enabled == other.enabled &&
          minutesBefore == other.minutesBefore &&
          soundMode == other.soundMode;

  @override
  int get hashCode => Object.hash(enabled, minutesBefore, soundMode);
}

/// Complete map of per-prayer notification settings across the 5 daily prayers.
@immutable
class PrayerNotificationsScheduleConfig {
  const PrayerNotificationsScheduleConfig({
    this.fajr = const PerPrayerNotificationConfig(),
    this.dhuhr = const PerPrayerNotificationConfig(),
    this.asr = const PerPrayerNotificationConfig(),
    this.maghrib = const PerPrayerNotificationConfig(),
    this.isha = const PerPrayerNotificationConfig(),
  });

  factory PrayerNotificationsScheduleConfig.fromJsonString(String rawJson) {
    if (rawJson.trim().isEmpty || rawJson.trim() == '{}') {
      return const PrayerNotificationsScheduleConfig();
    }
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        return const PrayerNotificationsScheduleConfig();
      }
      return PrayerNotificationsScheduleConfig(
        fajr: decoded['fajr'] is Map<String, dynamic>
            ? PerPrayerNotificationConfig.fromJson(
                decoded['fajr'] as Map<String, dynamic>,
              )
            : const PerPrayerNotificationConfig(),
        dhuhr: decoded['dhuhr'] is Map<String, dynamic>
            ? PerPrayerNotificationConfig.fromJson(
                decoded['dhuhr'] as Map<String, dynamic>,
              )
            : const PerPrayerNotificationConfig(),
        asr: decoded['asr'] is Map<String, dynamic>
            ? PerPrayerNotificationConfig.fromJson(
                decoded['asr'] as Map<String, dynamic>,
              )
            : const PerPrayerNotificationConfig(),
        maghrib: decoded['maghrib'] is Map<String, dynamic>
            ? PerPrayerNotificationConfig.fromJson(
                decoded['maghrib'] as Map<String, dynamic>,
              )
            : const PerPrayerNotificationConfig(),
        isha: decoded['isha'] is Map<String, dynamic>
            ? PerPrayerNotificationConfig.fromJson(
                decoded['isha'] as Map<String, dynamic>,
              )
            : const PerPrayerNotificationConfig(),
      );
    } catch (_) {
      return const PrayerNotificationsScheduleConfig();
    }
  }

  final PerPrayerNotificationConfig fajr;
  final PerPrayerNotificationConfig dhuhr;
  final PerPrayerNotificationConfig asr;
  final PerPrayerNotificationConfig maghrib;
  final PerPrayerNotificationConfig isha;

  PerPrayerNotificationConfig forSlot(PrayerSlot slot) {
    return switch (slot) {
      PrayerSlot.fajr => fajr,
      PrayerSlot.sunrise => const PerPrayerNotificationConfig(enabled: false),
      PrayerSlot.dhuhr => dhuhr,
      PrayerSlot.asr => asr,
      PrayerSlot.maghrib => maghrib,
      PrayerSlot.isha => isha,
    };
  }

  PrayerNotificationsScheduleConfig updateSlot(
    PrayerSlot slot,
    PerPrayerNotificationConfig updated,
  ) {
    return switch (slot) {
      PrayerSlot.fajr => copyWith(fajr: updated),
      PrayerSlot.sunrise => this,
      PrayerSlot.dhuhr => copyWith(dhuhr: updated),
      PrayerSlot.asr => copyWith(asr: updated),
      PrayerSlot.maghrib => copyWith(maghrib: updated),
      PrayerSlot.isha => copyWith(isha: updated),
    };
  }

  String toJsonString() {
    return jsonEncode({
      'fajr': fajr.toJson(),
      'dhuhr': dhuhr.toJson(),
      'asr': asr.toJson(),
      'maghrib': maghrib.toJson(),
      'isha': isha.toJson(),
    });
  }

  PrayerNotificationsScheduleConfig copyWith({
    PerPrayerNotificationConfig? fajr,
    PerPrayerNotificationConfig? dhuhr,
    PerPrayerNotificationConfig? asr,
    PerPrayerNotificationConfig? maghrib,
    PerPrayerNotificationConfig? isha,
  }) {
    return PrayerNotificationsScheduleConfig(
      fajr: fajr ?? this.fajr,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerNotificationsScheduleConfig &&
          runtimeType == other.runtimeType &&
          fajr == other.fajr &&
          dhuhr == other.dhuhr &&
          asr == other.asr &&
          maghrib == other.maghrib &&
          isha == other.isha;

  @override
  int get hashCode => Object.hash(fajr, dhuhr, asr, maghrib, isha);
}

/// Planned notification entry inside the rolling 7-day window.
@immutable
class PlannedNotificationItem {
  const PlannedNotificationItem({
    required this.id,
    required this.channel,
    required this.title,
    required this.body,
    required this.scheduledAt,
    required this.playSound,
    this.payload = '',
  });

  final int id;
  final QandilNotificationChannel channel;
  final String title;
  final String body;
  final DateTime scheduledAt;
  final bool playSound;
  final String payload;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlannedNotificationItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          channel == other.channel &&
          title == other.title &&
          body == other.body &&
          scheduledAt == other.scheduledAt &&
          playSound == other.playSound &&
          payload == other.payload;

  @override
  int get hashCode => Object.hash(
        id,
        channel,
        title,
        body,
        scheduledAt,
        playSound,
        payload,
      );
}

/// Snapshot displayed on the Phase 6 Notification Health screen.
@immutable
class NotificationHealthStatus {
  const NotificationHealthStatus({
    required this.permissionGranted,
    required this.exactAlarmGranted,
    required this.hasBundledAdhanAudio,
    required this.scheduledCount,
    required this.maxBudget,
    required this.nextThreeScheduled,
  });

  final bool permissionGranted;
  final bool exactAlarmGranted;
  final bool hasBundledAdhanAudio;
  final int scheduledCount;
  final int maxBudget;
  final List<PlannedNotificationItem> nextThreeScheduled;
}
