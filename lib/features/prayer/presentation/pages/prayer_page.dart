import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../calendar/domain/services/hijri_calendar_service.dart';
import '../../../calendar/presentation/widgets/hijri_calendar_view.dart';
import '../../../qibla/presentation/widgets/qibla_compass_view.dart';
import '../../../settings/domain/entities/app_settings.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';
import '../../data/services/location_service.dart';
import '../../domain/entities/prayer_entities.dart';
import '../cubit/prayer_cubit.dart';
import '../cubit/prayer_state.dart';

/// Phase 5 Prayer Times, Qibla Compass, and Hijri Calendar screen:
/// 1. Prayer Times tab: Next prayer hero countdown, location selector (GPS + manual city search),
///    calculation options (Egyptian General Authority default, Asr school, High-latitude rule,
///    per-prayer minute adjustments), Today (5 times + Sunrise), Tomorrow, and 30-Day List.
/// 2. Qibla tab: Live compass with `flutter_compass`, `adhan` bearing, calibration hint,
///    low-accuracy warning, and static bearing fallback.
/// 3. Hijri Calendar tab: Umm al-Qura calendar (`hijri_core`) with `-2..+2` day moon-sighting
///    adjustment and Islamic Occasions.
class PrayerPage extends StatefulWidget {
  const PrayerPage({super.key});

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  late final PrayerCubit _prayerCubit;
  int _selectedScheduleRangeIndex =
      0; // 0 = Today, 1 = Tomorrow, 2 = 30-Day List

  @override
  void initState() {
    super.initState();
    _prayerCubit = getIt<PrayerCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final settings = context.read<SettingsCubit>().state.settings;
      _prayerCubit.recomputeFromSettings(
        settings,
        startCountdownTicker: true,
      );
    });
  }

  @override
  void dispose() {
    _prayerCubit.close();
    super.dispose();
  }

  void _openManualCitySearchSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final settingsCubit = context.read<SettingsCubit>();
    var query = '';

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setSheetState) {
          final results = LocationService.searchCities(query);
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.72,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.prayerManualCitySearchTitle,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _prayerCubit.requestGpsLocation(settingsCubit);
                            },
                            icon:
                                const Icon(Icons.my_location_rounded, size: 18),
                            label: Text(l10n.prayerUseGpsAction),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: l10n.prayerManualCitySearchHint,
                          prefixIcon: const Icon(Icons.search_rounded),
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (val) => setSheetState(() => query = val),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final city = results[index];
                          return ListTile(
                            leading: const Icon(Icons.location_city_rounded),
                            title: Text(city.displayName(lang)),
                            subtitle: Text(
                              '${city.latitude.toStringAsFixed(2)}°, ${city.longitude.toStringAsFixed(2)}°',
                            ),
                            onTap: () {
                              _prayerCubit.selectManualCity(
                                city,
                                settingsCubit,
                              );
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openPrayerCalculationOptionsSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider<PrayerCubit>.value(
        value: _prayerCubit,
        child: const _PrayerCalculationOptionsSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;

    return BlocProvider<PrayerCubit>.value(
      value: _prayerCubit,
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, settingsState) {
          _prayerCubit.recomputeFromSettings(settingsState.settings);
        },
        child: BlocBuilder<PrayerCubit, PrayerState>(
          builder: (context, state) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(l10n.prayerShellTitle),
                  actions: [
                    IconButton(
                      tooltip: l10n.prayerManualCitySearchTitle,
                      icon: const Icon(Icons.edit_location_alt_outlined),
                      onPressed: () => _openManualCitySearchSheet(context),
                    ),
                    IconButton(
                      tooltip: l10n.prayerCalculationSettingsTitle,
                      icon: const Icon(Icons.tune_rounded),
                      onPressed: () =>
                          _openPrayerCalculationOptionsSheet(context),
                    ),
                  ],
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: const Icon(Icons.access_time_rounded),
                        text: l10n.prayerTabTimes,
                      ),
                      Tab(
                        icon: const Icon(Icons.explore_outlined),
                        text: l10n.prayerTabQibla,
                      ),
                      Tab(
                        icon: const Icon(Icons.calendar_month_outlined),
                        text: l10n.prayerTabHijri,
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    // 1. Prayer Times Tab
                    _buildPrayerTimesTab(context, l10n, lang, state),

                    // 2. Qibla Compass Tab
                    QiblaCompassView(
                      qiblaBearingDegrees: state.qiblaBearingDegrees,
                      cityName: state.cityName(lang),
                    ),

                    // 3. Hijri Calendar Tab
                    const HijriCalendarView(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPrayerTimesTab(
    BuildContext context,
    AppLocalizations l10n,
    String lang,
    PrayerState state,
  ) {
    final theme = Theme.of(context);
    final nextPrayer = state.nextPrayer;
    final timeFormat = DateFormat('hh:mm a', lang);

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        // 1. Next Prayer & Location Hero Card
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      color: AppColors.lantern,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        state.cityName(lang),
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _openManualCitySearchSheet(context),
                      child: Text(l10n.prayerManualCitySearchTitle),
                    ),
                  ],
                ),
                if (state.hijriToday != null) ...[
                  Text(
                    '${state.hijriToday!.format(languageCode: lang)} • ${state.gregorianTodayFormatted(lang)}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
                const Divider(height: 24),
                if (nextPrayer != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.nextPrayerCardTitle,
                              style: theme.textTheme.labelMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.prayerNextCountdownLabel(
                                _slotName(l10n, nextPrayer.slot),
                                _formatCountdown(nextPrayer.remaining),
                              ),
                              style: theme.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lantern,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          timeFormat.format(nextPrayer.prayerTime),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.night,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 2. Today | Tomorrow | 30-Day List Selector
        SegmentedButton<int>(
          segments: [
            ButtonSegment(
              value: 0,
              label: Text(l10n.prayerScheduleToday),
            ),
            ButtonSegment(
              value: 1,
              label: Text(l10n.prayerScheduleTomorrow),
            ),
            ButtonSegment(
              value: 2,
              label: Text(l10n.prayerScheduleThirtyDays),
            ),
          ],
          selected: {_selectedScheduleRangeIndex},
          onSelectionChanged: (sel) {
            setState(() => _selectedScheduleRangeIndex = sel.first);
          },
        ),
        const SizedBox(height: 16),

        // 3. Schedule View
        if (_selectedScheduleRangeIndex == 0 && state.todaySchedule != null)
          _buildSingleDayCard(
            context,
            l10n,
            timeFormat,
            state.todaySchedule!,
            highlightSlot:
                nextPrayer?.isTomorrowFajr == false ? nextPrayer?.slot : null,
          )
        else if (_selectedScheduleRangeIndex == 1 &&
            state.tomorrowSchedule != null)
          _buildSingleDayCard(
            context,
            l10n,
            timeFormat,
            state.tomorrowSchedule!,
            highlightSlot: null,
          )
        else if (_selectedScheduleRangeIndex == 2)
          ...state.thirtyDaySchedules.map(
            (daySchedule) => Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: _buildThirtyDayRowCard(
                context,
                l10n,
                lang,
                timeFormat,
                daySchedule,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSingleDayCard(
    BuildContext context,
    AppLocalizations l10n,
    DateFormat timeFormat,
    DailyPrayerSchedule schedule, {
    required PrayerSlot? highlightSlot,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        children: PrayerSlot.values.map((slot) {
          final isHighlighted = slot == highlightSlot;
          final time = schedule.timeForSlot(slot);

          return Container(
            decoration: BoxDecoration(
              color: isHighlighted
                  ? AppColors.lantern.withValues(alpha: 0.18)
                  : null,
            ),
            child: ListTile(
              leading: Icon(
                _slotIcon(slot),
                color: isHighlighted
                    ? AppColors.lantern
                    : theme.colorScheme.primary,
              ),
              title: Text(
                _slotName(l10n, slot),
                style: isHighlighted
                    ? theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      )
                    : theme.textTheme.titleMedium,
              ),
              trailing: Text(
                timeFormat.format(time),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildThirtyDayRowCard(
    BuildContext context,
    AppLocalizations l10n,
    String lang,
    DateFormat timeFormat,
    DailyPrayerSchedule schedule,
  ) {
    final theme = Theme.of(context);
    final hijri = HijriCalendarService.fromGregorian(schedule.date);
    final gregLabel = HijriCalendarService.formatGregorianDate(
      schedule.date,
      languageCode: lang,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gregLabel,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  hijri.format(languageCode: lang),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: PrayerSlot.values.map((slot) {
                return Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text(
                    '${_slotName(l10n, slot)}: ${timeFormat.format(schedule.timeForSlot(slot))}',
                    style: theme.textTheme.labelSmall,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
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

  IconData _slotIcon(PrayerSlot slot) {
    return switch (slot) {
      PrayerSlot.fajr => Icons.wb_twilight_rounded,
      PrayerSlot.sunrise => Icons.wb_sunny_outlined,
      PrayerSlot.dhuhr => Icons.light_mode_rounded,
      PrayerSlot.asr => Icons.wb_cloudy_outlined,
      PrayerSlot.maghrib => Icons.nights_stay_outlined,
      PrayerSlot.isha => Icons.dark_mode_rounded,
    };
  }

  String _formatCountdown(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}

class _PrayerCalculationOptionsSheet extends StatelessWidget {
  const _PrayerCalculationOptionsSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final settings = state.settings;
        final cubit = context.read<SettingsCubit>();
        final adjustments = settings.prayerAdjustments;

        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: ListView(
              padding: const EdgeInsetsDirectional.all(20),
              children: [
                Text(
                  l10n.prayerCalculationSettingsTitle,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // 1. Calculation Method Selector
                Text(
                  l10n.settingsPrayerMethod,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<PrayerCalculationMethodOption>(
                  initialValue: settings.prayerCalculationMethod,
                  isExpanded: true,
                  items: PrayerCalculationMethodOption.values.map((m) {
                    return DropdownMenuItem(
                      value: m,
                      child: Text(_methodLabel(l10n, m)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) cubit.updatePrayerCalculationMethod(val);
                  },
                ),
                const SizedBox(height: 16),

                // 2. Asr School Option
                Text(
                  l10n.prayerAsrSchoolLabel,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SegmentedButton<AsrMadhabOption>(
                  segments: [
                    ButtonSegment(
                      value: AsrMadhabOption.shafi,
                      label: Text(l10n.prayerAsrShafi),
                    ),
                    ButtonSegment(
                      value: AsrMadhabOption.hanafi,
                      label: Text(l10n.prayerAsrHanafi),
                    ),
                  ],
                  selected: {settings.asrMadhab},
                  onSelectionChanged: (sel) => cubit.updateAsrMadhab(sel.first),
                ),
                const SizedBox(height: 16),

                // 3. High-Latitude Rule
                Text(
                  l10n.prayerHighLatitudeRuleLabel,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<HighLatitudeRuleOption>(
                  initialValue: settings.highLatitudeRule,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      value: HighLatitudeRuleOption.middleOfTheNight,
                      child: Text(l10n.highLatMiddleOfNight),
                    ),
                    DropdownMenuItem(
                      value: HighLatitudeRuleOption.seventhOfTheNight,
                      child: Text(l10n.highLatSeventhOfNight),
                    ),
                    DropdownMenuItem(
                      value: HighLatitudeRuleOption.twilightAngle,
                      child: Text(l10n.highLatTwilightAngle),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) cubit.updateHighLatitudeRule(val);
                  },
                ),
                const Divider(height: 32),

                // 4. Manual Minute Adjustments per Prayer
                Text(
                  l10n.prayerManualAdjustmentsSection,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                _buildAdjustmentRow(
                  context,
                  label: l10n.prayerFajr,
                  minutes: adjustments.fajr,
                  onChanged: (v) => cubit.updatePrayerAdjustments(
                    adjustments.copyWith(fajr: v),
                  ),
                ),
                _buildAdjustmentRow(
                  context,
                  label: l10n.prayerSunrise,
                  minutes: adjustments.sunrise,
                  onChanged: (v) => cubit.updatePrayerAdjustments(
                    adjustments.copyWith(sunrise: v),
                  ),
                ),
                _buildAdjustmentRow(
                  context,
                  label: l10n.prayerDhuhr,
                  minutes: adjustments.dhuhr,
                  onChanged: (v) => cubit.updatePrayerAdjustments(
                    adjustments.copyWith(dhuhr: v),
                  ),
                ),
                _buildAdjustmentRow(
                  context,
                  label: l10n.prayerAsr,
                  minutes: adjustments.asr,
                  onChanged: (v) => cubit.updatePrayerAdjustments(
                    adjustments.copyWith(asr: v),
                  ),
                ),
                _buildAdjustmentRow(
                  context,
                  label: l10n.prayerMaghrib,
                  minutes: adjustments.maghrib,
                  onChanged: (v) => cubit.updatePrayerAdjustments(
                    adjustments.copyWith(maghrib: v),
                  ),
                ),
                _buildAdjustmentRow(
                  context,
                  label: l10n.prayerIsha,
                  minutes: adjustments.isha,
                  onChanged: (v) => cubit.updatePrayerAdjustments(
                    adjustments.copyWith(isha: v),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdjustmentRow(
    BuildContext context, {
    required String label,
    required int minutes,
    required ValueChanged<int> onChanged,
  }) {
    final sign = minutes > 0 ? '+$minutes' : '$minutes';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline_rounded),
              onPressed: minutes > -30 ? () => onChanged(minutes - 1) : null,
            ),
            SizedBox(
              width: 44,
              child: Text(
                '$sign m',
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline_rounded),
              onPressed: minutes < 30 ? () => onChanged(minutes + 1) : null,
            ),
          ],
        ),
      ],
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
