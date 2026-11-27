import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer/presentation/cubit/prayer_cubit.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';
import '../../domain/services/hijri_calendar_service.dart';

/// Phase 5 Hijri Calendar View:
/// - Umm al-Qura Hijri & Gregorian dates
/// - User setting of `-2` to `+2` days for local moon sighting adjustments
/// - Complete list of major Islamic occasions
class HijriCalendarView extends StatelessWidget {
  const HijriCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        final settings = settingsState.settings;
        final settingsCubit = context.read<SettingsCubit>();
        final prayerCubit = context.read<PrayerCubit>();

        final now = DateTime.now();
        final hijriToday = HijriCalendarService.fromGregorian(
          now,
          adjustmentDays: settings.hijriAdjustmentDays,
        );
        final gregorianToday = HijriCalendarService.formatGregorianDate(
          now,
          languageCode: lang,
        );
        final todayOccasion = HijriCalendarService.occasionForDate(hijriToday);

        return ListView(
          padding: const EdgeInsetsDirectional.all(16),
          children: [
            // 1. Today's Hijri & Gregorian Hero Card
            Card(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(20),
                child: Column(
                  children: [
                    Text(
                      hijriToday.format(languageCode: lang),
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      gregorianToday,
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    if (todayOccasion != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lantern,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          todayOccasion.title(lang),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: AppColors.night,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Moon Sighting Day Adjustment (-2 to +2 days)
            Card(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.hijriAdjustmentLabel,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.hijriAdjustmentSubtitle,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [-2, -1, 0, 1, 2].map((offset) {
                        final label = offset > 0 ? '+$offset' : '$offset';
                        final isSelected =
                            settings.hijriAdjustmentDays == offset;
                        return ChoiceChip(
                          label: Text(label),
                          selected: isSelected,
                          onSelected: (_) async {
                            await settingsCubit.updateHijriAdjustmentDays(
                              offset,
                            );
                            prayerCubit.recomputeFromSettings(
                              settingsCubit.state.settings,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Islamic Occasions Section
            Text(
              l10n.islamicOccasionsTitle,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            ...HijriCalendarService.islamicOccasions.map((occasion) {
              final monthName = lang == 'ar'
                  ? HijriCalendarService.arabicMonthNames[occasion.hMonth - 1]
                  : HijriCalendarService.englishMonthNames[occasion.hMonth - 1];
              final isCurrentMonth = occasion.hMonth == hijriToday.hMonth;

              return Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: isCurrentMonth
                          ? AppColors.lantern
                          : theme.colorScheme.outline,
                      width: isCurrentMonth ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.lantern,
                      foregroundColor: AppColors.night,
                      child: Text('${occasion.hDay}'),
                    ),
                    title: Text(occasion.title(lang)),
                    subtitle: Text('${occasion.hDay} $monthName'),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
