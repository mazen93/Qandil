import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/notifications/local_notification_service.dart';
import '../../../../core/notifications/notification_entities.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer/domain/entities/prayer_entities.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import 'battery_optimization_help_page.dart';
import 'notification_health_page.dart';

/// Phase 6 Notification & Reminder Configuration screen:
/// - Missing Adhan asset fallback notice banner
/// - Per-prayer controls (On/Off, Minutes before [0, 5, 10, 15, 30], Adhan sound vs Silent)
/// - Daily Wird reminder toggle + time picker
/// - Weekly Friday reminder toggle + time picker
/// - Daily Tasbih reminder toggle + time picker
/// - Shortcuts to Notification Health & Battery Optimization Help screens
class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  static const List<int> _minutesBeforeOptions = [0, 5, 10, 15, 30];
  static const List<PrayerSlot> _obligatorySlots = [
    PrayerSlot.fajr,
    PrayerSlot.dhuhr,
    PrayerSlot.asr,
    PrayerSlot.maghrib,
    PrayerSlot.isha,
  ];

  Future<void> _pickTime(
    BuildContext context, {
    required int currentHour,
    required int currentMinute,
    required void Function(int hour, int minute) onPicked,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: currentHour, minute: currentMinute),
    );
    if (picked != null) {
      onPicked(picked.hour, picked.minute);
    }
  }

  String _formatHourMinute(int hour, int minute) {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final notifService = getIt<LocalNotificationService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notifSettingsTitle),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final settings = state.settings;
          final cubit = context.read<SettingsCubit>();

          return ListView(
            padding: const EdgeInsetsDirectional.all(16),
            children: [
              // 1. Missing Adhan Audio Asset Fallback Notice
              if (!notifService.hasBundledAdhanAudio) ...[
                Container(
                  padding: const EdgeInsetsDirectional.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.lantern.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.lantern),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.volume_up_rounded,
                        color: AppColors.lantern,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.notifMissingAdhanAssetBanner,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // 2. Notification Health & Battery Optimization Shortcuts
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const NotificationHealthPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.health_and_safety_outlined),
                      label: Text(l10n.notifHealthTitle),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const BatteryOptimizationHelpPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.battery_saver_rounded),
                      label: Text(l10n.batteryHelpTitle),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3. Per-Prayer Controls (Fajr, Dhuhr, Asr, Maghrib, Isha)
              Text(
                l10n.notifPerPrayerSectionTitle,
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              ..._obligatorySlots.map((slot) {
                final config = settings.prayerNotificationsConfig.forSlot(slot);

                return Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 12),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              _slotName(l10n, slot),
                              style: theme.textTheme.titleMedium,
                            ),
                            value: config.enabled,
                            onChanged: (val) {
                              cubit.updatePerPrayerNotificationConfig(
                                slot,
                                config.copyWith(enabled: val),
                              );
                            },
                          ),
                          if (config.enabled) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    initialValue: _minutesBeforeOptions
                                            .contains(config.minutesBefore)
                                        ? config.minutesBefore
                                        : 0,
                                    isExpanded: true,
                                    items: _minutesBeforeOptions.map((mins) {
                                      return DropdownMenuItem<int>(
                                        value: mins,
                                        child: Text(
                                          mins == 0
                                              ? l10n.notifAtPrayerTime
                                              : l10n.notifMinutesBefore(mins),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (mins) {
                                      if (mins != null) {
                                        cubit.updatePerPrayerNotificationConfig(
                                          slot,
                                          config.copyWith(minutesBefore: mins),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<
                                      PrayerNotificationSoundMode>(
                                    initialValue: config.soundMode,
                                    isExpanded: true,
                                    items: [
                                      DropdownMenuItem(
                                        value:
                                            PrayerNotificationSoundMode.adhan,
                                        child: Text(l10n.notifSoundAdhan),
                                      ),
                                      DropdownMenuItem(
                                        value:
                                            PrayerNotificationSoundMode.silent,
                                        child: Text(l10n.notifSoundSilent),
                                      ),
                                    ],
                                    onChanged: (mode) {
                                      if (mode != null) {
                                        cubit.updatePerPrayerNotificationConfig(
                                          slot,
                                          config.copyWith(soundMode: mode),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 12),

              // 4. Daily Wird Reminder
              Card(
                child: ListTile(
                  title: Text(l10n.notifWirdReminderTitle),
                  subtitle: Text(
                    _formatHourMinute(
                      settings.wirdReminderHour,
                      settings.wirdReminderMinute,
                    ),
                  ),
                  onTap: () => _pickTime(
                    context,
                    currentHour: settings.wirdReminderHour,
                    currentMinute: settings.wirdReminderMinute,
                    onPicked: (h, m) =>
                        cubit.updateWirdReminder(hour: h, minute: m),
                  ),
                  trailing: Switch(
                    value: settings.wirdReminderEnabled,
                    onChanged: (val) => cubit.updateWirdReminder(enabled: val),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // 5. Optional Friday Reminder
              Card(
                child: ListTile(
                  title: Text(l10n.notifFridayReminderTitle),
                  subtitle: Text(
                    _formatHourMinute(
                      settings.fridayReminderHour,
                      settings.fridayReminderMinute,
                    ),
                  ),
                  onTap: () => _pickTime(
                    context,
                    currentHour: settings.fridayReminderHour,
                    currentMinute: settings.fridayReminderMinute,
                    onPicked: (h, m) =>
                        cubit.updateFridayReminder(hour: h, minute: m),
                  ),
                  trailing: Switch(
                    value: settings.fridayReminderEnabled,
                    onChanged: (val) =>
                        cubit.updateFridayReminder(enabled: val),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // 6. Tasbih Reminder
              Card(
                child: ListTile(
                  title: Text(l10n.notifTasbihReminderTitle),
                  subtitle: Text(
                    _formatHourMinute(
                      settings.tasbihReminderHour,
                      settings.tasbihReminderMinute,
                    ),
                  ),
                  onTap: () => _pickTime(
                    context,
                    currentHour: settings.tasbihReminderHour,
                    currentMinute: settings.tasbihReminderMinute,
                    onPicked: (h, m) =>
                        cubit.updateTasbihReminder(hour: h, minute: m),
                  ),
                  trailing: Switch(
                    value: settings.tasbihReminderEnabled,
                    onChanged: (val) =>
                        cubit.updateTasbihReminder(enabled: val),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // 7. Morning Adhkar Reminder
              Card(
                child: ListTile(
                  title: Text(l10n.notifMorningAdhkarReminderTitle),
                  subtitle: Text(
                    _formatHourMinute(
                      settings.morningAdhkarReminderHour,
                      settings.morningAdhkarReminderMinute,
                    ),
                  ),
                  onTap: () => _pickTime(
                    context,
                    currentHour: settings.morningAdhkarReminderHour,
                    currentMinute: settings.morningAdhkarReminderMinute,
                    onPicked: (h, m) =>
                        cubit.updateMorningAdhkarReminder(hour: h, minute: m),
                  ),
                  trailing: Switch(
                    value: settings.morningAdhkarReminderEnabled,
                    onChanged: (val) =>
                        cubit.updateMorningAdhkarReminder(enabled: val),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // 8. Evening Adhkar Reminder
              Card(
                child: ListTile(
                  title: Text(l10n.notifEveningAdhkarReminderTitle),
                  subtitle: Text(
                    _formatHourMinute(
                      settings.eveningAdhkarReminderHour,
                      settings.eveningAdhkarReminderMinute,
                    ),
                  ),
                  onTap: () => _pickTime(
                    context,
                    currentHour: settings.eveningAdhkarReminderHour,
                    currentMinute: settings.eveningAdhkarReminderMinute,
                    onPicked: (h, m) =>
                        cubit.updateEveningAdhkarReminder(hour: h, minute: m),
                  ),
                  trailing: Switch(
                    value: settings.eveningAdhkarReminderEnabled,
                    onChanged: (val) =>
                        cubit.updateEveningAdhkarReminder(enabled: val),
                  ),
                ),
              ),
              // ── DEV-ONLY: Test Adhan notification ──────────────────────
              if (kDebugMode) ...[
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  '🔧 Developer Tools',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                FilledButton.icon(
                  onPressed: () async {
                    await notifService.triggerTestAdhanNotification(
                      delay: const Duration(seconds: 3),
                      title: 'Qandil — Test Adhan 🕌',
                      body: 'الله أكبر • Testing Adhan sound (3s delay)',
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Test Adhan scheduled in 3 seconds — lock the screen!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.volume_up_rounded),
                  label: const Text('Test Adhan (3 s delay)'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () async {
                    await notifService.triggerTestAdhanNotification(
                      title: 'Qandil — Instant Adhan Test 🕌',
                      body: 'الله أكبر • Instant test notification',
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Instant Adhan notification fired!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.notifications_active_rounded),
                  label: const Text('Trigger Adhan Now'),
                ),
                const SizedBox(height: 16),
              ],
            ],
          );
        },
      ),
    );
  }

  String _slotName(AppLocalizations l10n, PrayerSlot slot) {
    return switch (slot) {
      PrayerSlot.fajr => l10n.prayerFajr,
      PrayerSlot.sunrise => l10n.prayerSunrise,
      PrayerSlot.dhuhr => l10n.prayerDhuhr,
      PrayerSlot.asr => l10n.prayerAsr,
      PrayerSlot.maghrib => l10n.prayerMaghrib,
      PrayerSlot.isha => l10n.prayerIsha,
    };
  }
}
