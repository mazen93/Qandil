import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';
import '../../domain/entities/reading_mode_entities.dart';
import '../../domain/services/reading_mode_service.dart';
import 'reading_mode_dnd_sheets.dart';

/// Phase 3 Reading Settings bottom sheet:
/// - Mushaf font size (18..42)
/// - Line spacing (1.4..2.4)
/// - Night mode toggle (Dark vs Light)
/// - Keep screen awake while reading (`WakelockPlus`)
class ReaderSettingsSheet extends StatelessWidget {
  const ReaderSettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final settings = state.settings;
        final cubit = context.read<SettingsCubit>();
        final isDark = theme.brightness == Brightness.dark;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.readerSettingsTitle,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // 1. Mushaf Font Size
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.readerFontSizeLabel,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '${settings.readerFontSize.round()} pt',
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
                Slider(
                  value: settings.readerFontSize,
                  min: 18.0,
                  max: 42.0,
                  divisions: 12,
                  onChanged: cubit.updateReaderFontSize,
                ),
                const SizedBox(height: 8),

                // 2. Line Spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.readerLineSpacingLabel,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '${settings.readerLineSpacing.toStringAsFixed(1)}x',
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
                Slider(
                  value: settings.readerLineSpacing,
                  min: 1.4,
                  max: 2.4,
                  divisions: 10,
                  onChanged: cubit.updateReaderLineSpacing,
                ),
                const Divider(),

                // 3. Night Mode Toggle
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    l10n.readerNightModeLabel,
                    style: theme.textTheme.titleMedium,
                  ),
                  value: isDark,
                  onChanged: (enableDark) {
                    cubit.updateThemeMode(
                      enableDark ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),

                // 4. Keep Screen Awake Toggle
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    l10n.readerKeepScreenAwakeLabel,
                    style: theme.textTheme.titleMedium,
                  ),
                  value: settings.keepScreenAwake,
                  onChanged: (keepAwake) async {
                    await cubit.updateKeepScreenAwake(keepAwake);
                    try {
                      await WakelockPlus.toggle(enable: keepAwake);
                    } catch (_) {
                      // Ignore platform channel errors in headless unit test environments.
                    }
                  },
                ),
                const Divider(),

                // 5. Phase 9: Auto-start Reading Mode
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    l10n.readingModeAutoStartLabel,
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    l10n.readingModeAutoStartSubtitle,
                    style: theme.textTheme.bodySmall,
                  ),
                  value: settings.autoStartReadingMode,
                  onChanged: cubit.updateAutoStartReadingMode,
                ),

                // 6. Phase 9: Android DND while reading / iOS Focus Tip
                if (getIt.isRegistered<ReadingModeService>() &&
                    getIt<ReadingModeService>().isAndroid) ...[
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      l10n.readingModeDndEnabledLabel,
                      style: theme.textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      l10n.readingModeDndEnabledSubtitle,
                      style: theme.textTheme.bodySmall,
                    ),
                    value: settings.readingModeDndEnabled,
                    onChanged: (enabled) async {
                      final rmService = getIt<ReadingModeService>();
                      if (enabled) {
                        final granted =
                            await rmService.isNotificationPolicyAccessGranted();
                        if (!granted && context.mounted) {
                          await showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => AndroidDndPermissionSheet(
                              readingModeService: rmService,
                              selectedFilter: settings.readingModeDndFilter,
                              onFilterChanged: cubit.updateReadingModeDndFilter,
                              onPermissionGranted: () {
                                cubit.updateReadingModeDndEnabled(true);
                              },
                            ),
                          );
                          return;
                        }
                      }
                      await cubit.updateReadingModeDndEnabled(enabled);
                    },
                  ),
                  if (settings.readingModeDndEnabled)
                    DropdownButtonFormField<ReadingDndFilterOption>(
                      initialValue: settings.readingModeDndFilter,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: l10n.readingModeDndFilterLabel,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: ReadingDndFilterOption.priority,
                          child: Text(l10n.readingModeDndFilterPriorityTitle),
                        ),
                        DropdownMenuItem(
                          value: ReadingDndFilterOption.alarms,
                          child: Text(l10n.readingModeDndFilterAlarmsTitle),
                        ),
                        DropdownMenuItem(
                          value: ReadingDndFilterOption.totalSilence,
                          child: Text(l10n.readingModeDndFilterNoneTitle),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          cubit.updateReadingModeDndFilter(val);
                        }
                      },
                    ),
                ] else ...[
                  TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => const IosFocusModeTipSheet(),
                      );
                    },
                    icon: const Icon(Icons.bedtime_outlined),
                    label: Text(l10n.readingModeIosFocusTipButton),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
