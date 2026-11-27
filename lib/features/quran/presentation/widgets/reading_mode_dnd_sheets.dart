import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/reading_mode_entities.dart';
import '../../domain/services/reading_mode_service.dart';

/// Android explanation & Notification Policy Access permission bottom sheet:
/// - Explains why Qandil needs Notification Policy access
/// - Documents which interruption filter lets the Adhan through (`Priority Only` & `Alarms & Adhan Only`)
/// - Opens Android Notification Policy settings and verifies access when the user taps "Verify & Enable Now".
class AndroidDndPermissionSheet extends StatefulWidget {
  const AndroidDndPermissionSheet({
    super.key,
    required this.readingModeService,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onPermissionGranted,
  });

  final ReadingModeService readingModeService;
  final ReadingDndFilterOption selectedFilter;
  final ValueChanged<ReadingDndFilterOption> onFilterChanged;
  final VoidCallback onPermissionGranted;

  @override
  State<AndroidDndPermissionSheet> createState() =>
      _AndroidDndPermissionSheetState();
}

class _AndroidDndPermissionSheetState extends State<AndroidDndPermissionSheet> {
  late ReadingDndFilterOption _currentFilter;
  bool _showNotGrantedWarning = false;

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.selectedFilter;
  }

  Future<void> _verifyAndContinue() async {
    final granted =
        await widget.readingModeService.isNotificationPolicyAccessGranted();
    if (!mounted) return;
    if (granted) {
      Navigator.of(context).pop();
      widget.onPermissionGranted();
    } else {
      setState(() {
        _showNotGrantedWarning = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.lantern.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.do_not_disturb_on_outlined,
                    color: AppColors.lantern,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.readingModeAndroidPermissionTitle,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.readingModeAndroidPermissionBody,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.readingModeDndFilterLabel,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            for (final option in ReadingDndFilterOption.values)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  _currentFilter == option
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  color: _currentFilter == option ? AppColors.lantern : null,
                ),
                title: Text(_filterTitle(l10n, option)),
                subtitle: Text(
                  _filterSubtitle(l10n, option),
                  style: theme.textTheme.bodySmall,
                ),
                onTap: () {
                  setState(() => _currentFilter = option);
                  widget.onFilterChanged(option);
                },
              ),
            if (_showNotGrantedWarning) ...[
              const SizedBox(height: 8),
              Text(
                l10n.readingModeDndPermissionNotGrantedWarning,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                widget.readingModeService
                    .openNotificationPolicyAccessSettings();
              },
              icon: const Icon(Icons.settings_outlined),
              label: Text(l10n.readingModeOpenAndroidDndSettingsAction),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _verifyAndContinue,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.lantern,
                foregroundColor: AppColors.night,
              ),
              icon: const Icon(Icons.check_circle_outline_rounded),
              label: Text(l10n.readingModeVerifyDndPermissionAction),
            ),
          ],
        ),
      ),
    );
  }

  String _filterTitle(AppLocalizations l10n, ReadingDndFilterOption option) {
    return switch (option) {
      ReadingDndFilterOption.priority => l10n.readingModeDndFilterPriorityTitle,
      ReadingDndFilterOption.alarms => l10n.readingModeDndFilterAlarmsTitle,
      ReadingDndFilterOption.totalSilence => l10n.readingModeDndFilterNoneTitle,
    };
  }

  String _filterSubtitle(AppLocalizations l10n, ReadingDndFilterOption option) {
    return switch (option) {
      ReadingDndFilterOption.priority =>
        l10n.readingModeDndFilterPrioritySubtitle,
      ReadingDndFilterOption.alarms => l10n.readingModeDndFilterAlarmsSubtitle,
      ReadingDndFilterOption.totalSilence =>
        l10n.readingModeDndFilterNoneSubtitle,
    };
  }
}

/// One-time iOS Focus Mode & Shortcuts Automation tip sheet.
/// Never claims the app can toggle iOS Focus programmatically.
class IosFocusModeTipSheet extends StatelessWidget {
  const IosFocusModeTipSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.lantern.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.bedtime_outlined,
                    color: AppColors.lantern,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.readingModeIosFocusTipTitle,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.readingModeIosFocusTipBody,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.55),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.lantern,
                foregroundColor: AppColors.night,
              ),
              child: Text(l10n.readingModeGotItAction),
            ),
          ],
        ),
      ),
    );
  }
}
