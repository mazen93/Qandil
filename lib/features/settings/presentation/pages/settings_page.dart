import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../onboarding/presentation/pages/onboarding_page.dart';
import '../../../quran/domain/entities/reading_mode_entities.dart';
import '../../../quran/domain/services/reading_mode_service.dart';
import '../../../quran/presentation/widgets/reading_mode_dnd_sheets.dart';
import '../../domain/entities/app_settings.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import 'notification_settings_page.dart';

/// Phase 1 Settings shell page ("More" tab) providing language, theme, text size,
/// prayer calculation method, notifications toggle, and About/Credits navigation.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final settings = state.settings;
          final cubit = context.read<SettingsCubit>();

          return ListView(
            padding: const EdgeInsetsDirectional.all(16),
            children: [
              // 1. Language Switcher
              Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.settingsLanguage,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<String>(
                          segments: [
                            ButtonSegment<String>(
                              value: 'ar',
                              label: Text(l10n.languageArabic),
                            ),
                            ButtonSegment<String>(
                              value: 'en',
                              label: Text(l10n.languageEnglish),
                            ),
                          ],
                          selected: {settings.languageCode},
                          onSelectionChanged: (selection) {
                            cubit.updateLanguage(selection.first);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 2. Theme Mode Switcher
              Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.settingsTheme,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<ThemeMode>(
                          segments: [
                            ButtonSegment<ThemeMode>(
                              value: ThemeMode.system,
                              label: Text(l10n.themeSystem),
                            ),
                            ButtonSegment<ThemeMode>(
                              value: ThemeMode.light,
                              label: Text(l10n.themeLight),
                            ),
                            ButtonSegment<ThemeMode>(
                              value: ThemeMode.dark,
                              label: Text(l10n.themeDark),
                            ),
                          ],
                          selected: {settings.themeMode},
                          onSelectionChanged: (selection) {
                            cubit.updateThemeMode(selection.first);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 3. Text Size Slider
              Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.settingsTextSize,
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            '${(settings.textScaleFactor * 100).round()}%',
                            style: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                      Slider(
                        value: settings.textScaleFactor,
                        min: 0.85,
                        max: 1.4,
                        divisions: 11,
                        label: '${(settings.textScaleFactor * 100).round()}%',
                        onChanged: cubit.updateTextScaleFactor,
                      ),
                      Text(
                        l10n.settingsTextSizePreview,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 4. Prayer Calculation Method
              Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.settingsPrayerMethod,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<PrayerCalculationMethodOption>(
                        initialValue: settings.prayerCalculationMethod,
                        isExpanded: true,
                        items: PrayerCalculationMethodOption.values
                            .map(
                              (method) => DropdownMenuItem(
                                value: method,
                                child: Text(_methodLabel(l10n, method)),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            cubit.updatePrayerCalculationMethod(value);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 5. Notifications Toggle & Detailed Configuration Screen
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text(
                        l10n.settingsNotifications,
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        l10n.settingsNotificationsSubtitle,
                        style: theme.textTheme.bodySmall,
                      ),
                      value: settings.notificationsEnabled,
                      onChanged: cubit.updateNotificationsEnabled,
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.notifications_active_outlined),
                      title: Text(
                        l10n.notifConfigureAction,
                        style: theme.textTheme.bodyMedium,
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => BlocProvider<SettingsCubit>.value(
                              value: cubit,
                              child: const NotificationSettingsPage(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // 6. Phase 9: Reading Mode & Do Not Disturb
              Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.readingModeTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.readingModeAutoStartLabel),
                        subtitle: Text(
                          l10n.readingModeAutoStartSubtitle,
                          style: theme.textTheme.bodySmall,
                        ),
                        value: settings.autoStartReadingMode,
                        onChanged: cubit.updateAutoStartReadingMode,
                      ),
                      if (getIt.isRegistered<ReadingModeService>() &&
                          getIt<ReadingModeService>().isAndroid) ...[
                        const Divider(),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.readingModeDndEnabledLabel),
                          subtitle: Text(
                            l10n.readingModeDndEnabledSubtitle,
                            style: theme.textTheme.bodySmall,
                          ),
                          value: settings.readingModeDndEnabled,
                          onChanged: (enabled) async {
                            final rmService = getIt<ReadingModeService>();
                            if (enabled) {
                              final granted = await rmService
                                  .isNotificationPolicyAccessGranted();
                              if (!granted && context.mounted) {
                                await showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (_) => AndroidDndPermissionSheet(
                                    readingModeService: rmService,
                                    selectedFilter:
                                        settings.readingModeDndFilter,
                                    onFilterChanged:
                                        cubit.updateReadingModeDndFilter,
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
                        const SizedBox(height: 8),
                        DropdownButtonFormField<ReadingDndFilterOption>(
                          initialValue: settings.readingModeDndFilter,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: l10n.readingModeDndFilterLabel,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: ReadingDndFilterOption.priority,
                              child: Text(
                                l10n.readingModeDndFilterPriorityTitle,
                              ),
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
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.bedtime_outlined),
                          title: Text(l10n.readingModeIosFocusTipButton),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) => const IosFocusModeTipSheet(),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 7. About / Credits & Welcome Tour
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.auto_awesome_outlined),
                      title: Text(
                        l10n.settingsReplayOnboarding,
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        l10n.settingsReplayOnboardingSubtitle,
                        style: theme.textTheme.bodySmall,
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => BlocProvider<SettingsCubit>.value(
                              value: cubit,
                              child: const OnboardingPage(),
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.verified_outlined),
                      title: Text(
                        l10n.settingsAboutCredits,
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        l10n.settingsAboutCreditsSubtitle,
                        style: theme.textTheme.bodySmall,
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.goNamed(AppRoutes.creditsName),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _methodLabel(
    AppLocalizations l10n,
    PrayerCalculationMethodOption method,
  ) {
    return switch (method) {
      PrayerCalculationMethodOption.egyptian => l10n.prayerMethodEgyptian,
      PrayerCalculationMethodOption.ummAlQura => l10n.prayerMethodUmmAlQura,
      PrayerCalculationMethodOption.muslimWorldLeague =>
        l10n.prayerMethodMuslimWorldLeague,
      PrayerCalculationMethodOption.karachi => l10n.prayerMethodKarachi,
      PrayerCalculationMethodOption.northAmerica =>
        l10n.prayerMethodNorthAmerica,
    };
  }
}
