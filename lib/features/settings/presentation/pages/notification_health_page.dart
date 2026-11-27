import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/notifications/local_notification_service.dart';
import '../../../../core/notifications/notification_entities.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/settings_cubit.dart';
import 'battery_optimization_help_page.dart';

/// Phase 6 Notification Health Screen:
/// - Permission status (`POST_NOTIFICATIONS` / iOS alert permission)
/// - Exact-alarm status (`SCHEDULE_EXACT_ALARM` on Android 14+ with deep link to settings)
/// - Number of scheduled items vs 56/64 iOS budget
/// - Next 3 scheduled notification times
class NotificationHealthPage extends StatefulWidget {
  const NotificationHealthPage({super.key});

  @override
  State<NotificationHealthPage> createState() => _NotificationHealthPageState();
}

class _NotificationHealthPageState extends State<NotificationHealthPage> {
  late final LocalNotificationService _service;
  NotificationHealthStatus? _healthStatus;

  @override
  void initState() {
    super.initState();
    _service = getIt<LocalNotificationService>();
    _refreshHealth();
  }

  Future<void> _refreshHealth() async {
    final settings = context.read<SettingsCubit>().state.settings;
    final status = await _service.getHealthStatus(settings);
    if (mounted) {
      setState(() => _healthStatus = status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final status = _healthStatus;
    final dateTimeFormat = DateFormat('EEE, MMM d • hh:mm a', lang);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notifHealthTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () async {
              await context.read<SettingsCubit>().rescheduleNotifications();
              await _refreshHealth();
            },
          ),
        ],
      ),
      body: status == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView(
              padding: const EdgeInsetsDirectional.all(16),
              children: [
                // 1. Notifications Runtime Permission Status
                _buildPermissionCard(
                  context,
                  l10n: l10n,
                  title: l10n.notifHealthPermissionLabel,
                  granted: status.permissionGranted,
                  onRequest: () async {
                    await _service.requestNotificationsPermission();
                    await _refreshHealth();
                  },
                ),
                const SizedBox(height: 12),

                // 2. Android 14+ Exact Alarm Status (SCHEDULE_EXACT_ALARM)
                _buildPermissionCard(
                  context,
                  l10n: l10n,
                  title: l10n.notifHealthExactAlarmLabel,
                  granted: status.exactAlarmGranted,
                  onRequest: () async {
                    await _service.requestExactAlarmPermission();
                    await _refreshHealth();
                  },
                ),
                const SizedBox(height: 12),

                // 3. Scheduled Count vs iOS 64 Budget
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.event_available_rounded,
                      color: AppColors.lantern,
                    ),
                    title: Text(l10n.notifHealthBudgetLabel),
                    subtitle: Text(
                      l10n.notifHealthBudgetValue(
                        status.scheduledCount,
                        status.maxBudget,
                      ),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Next 3 Scheduled Times
                Text(
                  l10n.notifHealthNextThreeTitle,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                if (status.nextThreeScheduled.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.all(16),
                      child: Text(l10n.notifHealthNoScheduled),
                    ),
                  )
                else
                  ...status.nextThreeScheduled.map(
                    (item) => Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 10),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.lantern,
                            foregroundColor: AppColors.night,
                            child: Icon(
                              item.playSound
                                  ? Icons.notifications_active_rounded
                                  : Icons.notifications_off_outlined,
                              size: 20,
                            ),
                          ),
                          title: Text(item.title),
                          subtitle: Text(
                            '${dateTimeFormat.format(item.scheduledAt)}\n${item.body}',
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const BatteryOptimizationHelpPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.battery_alert_rounded),
                  label: Text(l10n.batteryHelpTitle),
                ),
              ],
            ),
    );
  }

  Widget _buildPermissionCard(
    BuildContext context, {
    required AppLocalizations l10n,
    required String title,
    required bool granted,
    required VoidCallback onRequest,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  granted
                      ? Icons.check_circle_rounded
                      : Icons.warning_amber_rounded,
                  color:
                      granted ? theme.colorScheme.primary : AppColors.lantern,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: granted
                        ? theme.colorScheme.primary.withValues(alpha: 0.15)
                        : AppColors.lantern.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    granted
                        ? l10n.notifHealthStatusGranted
                        : l10n.notifHealthStatusRequired,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (!granted) ...[
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onRequest,
                child: Text(l10n.notifHealthGrantAction),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
