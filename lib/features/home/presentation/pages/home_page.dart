import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/widgets/qandil_lantern_mark.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../adhkar/domain/entities/adhkar_entities.dart';
import '../../../prayer/domain/entities/prayer_entities.dart';
import '../../../quran/presentation/widgets/khatmah_planner_sheet.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';
import '../../domain/entities/home_entities.dart';
import '../cubit/home_view_model.dart';

/// Phase 11 Home screen with real data driven by a single [HomeViewModel]:
/// - Header: Gregorian and Hijri dates, localized time-of-day greeting, and current city.
/// - 1. Next Prayer Card: prayer name, time, live countdown (shows tomorrow's Fajr after Isha; handles missing location), tap opens Prayer screen.
/// - 2. Today's Wird Card: Khatmah progress for today and a Continue Reading button that opens the saved position.
/// - 3. Dhikr Card: today's tasbih total and streak, quick-start (`+1`) counter, and a shortcut to Morning or Evening Adhkar highlighted at the right time of day.
/// - 4. Verse of the Day Card: picked deterministically by date from local Quran data (no network, no AI-generated text); tap opens the verse with tafsir.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _viewModel;
  StreamSubscription<ReadingProgressRecord>? _progressSub;
  StreamSubscription<List<TasbihDailyRecord>>? _tasbihSub;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<HomeViewModel>();
    final db = getIt<AppDatabase>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _triggerRefresh();

      _progressSub = db.watchReadingProgress().listen((_) {
        if (mounted) _triggerRefresh();
      });
      _tasbihSub = db.watchAllTasbihDaily().listen((_) {
        if (mounted) _triggerRefresh();
      });
    });
  }

  void _triggerRefresh() {
    if (!mounted) return;
    try {
      final settings = context.read<SettingsCubit>().state.settings;
      final isDark = Theme.of(context).brightness == Brightness.dark;
      _viewModel.refresh(settings, isDarkThemeOverride: isDark);
    } catch (_) {}
  }

  @override
  void dispose() {
    _progressSub?.cancel();
    _tasbihSub?.cancel();
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final isAr = lang == 'ar';

    return BlocProvider<HomeViewModel>.value(
      value: _viewModel,
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, settingsState) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          _viewModel.refresh(
            settingsState.settings,
            isDarkThemeOverride: isDark,
          );
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            final settings = settingsState.settings;

            return BlocBuilder<HomeViewModel, HomeViewState>(
              builder: (context, homeState) {
                final greeting = _greetingForPeriod(
                  l10n,
                  homeState.timeOfDayPeriod,
                );
                final nextPrayer = homeState.nextPrayer;
                final timeFormat = DateFormat('hh:mm a', lang);
                final nextPrayerName = nextPrayer != null
                    ? _slotName(l10n, nextPrayer.slot)
                    : l10n.nextPrayerCardTitle;
                final nextPrayerTimeStr = nextPrayer != null
                    ? timeFormat.format(nextPrayer.prayerTime)
                    : '--:--';
                final countdownStr = nextPrayer != null
                    ? HomeViewModel.formatCountdown(nextPrayer.remaining)
                    : '--';

                final khatmah = homeState.khatmahSummary;
                final khatmahPercent = khatmah != null
                    ? (khatmah.progressFraction * 100).round()
                    : 0;
                final khatmahDailyPages = khatmah?.catchUpPagesPerDay ?? 20;
                final surahLabel = isAr
                    ? homeState.savedSurahNameArabic
                    : homeState.savedSurahNameSimple;

                final isMorningAdhkarHighlighted =
                    homeState.highlightedAdhkarCategory ==
                        AdhkarCategory.morning;
                final highlightedAdhkarLabel = isMorningAdhkarHighlighted
                    ? l10n.homeMorningAdhkarShortcut
                    : l10n.homeEveningAdhkarShortcut;
                final verseOfTheDay = homeState.verseOfTheDay;

                return Scaffold(
                  appBar: AppBar(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const QandilLanternMark(size: 32),
                        const SizedBox(width: 10),
                        Text(l10n.appTitle),
                      ],
                    ),
                  ),
                  body: ListView(
                    padding: const EdgeInsetsDirectional.all(16),
                    children: [
                      // Home Header: Time-of-Day Greeting, Hijri & Gregorian Dates, and Current City
                      Text(
                        greeting,
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      if (homeState.hijriDateFormatted.isNotEmpty)
                        Text(
                          '${homeState.hijriDateFormatted} • ${homeState.gregorianDateFormatted}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      const SizedBox(height: 2),
                      Text(
                        homeState.hasValidLocation
                            ? '${homeState.cityDisplayName} — ${l10n.appTagline}'
                            : l10n.homeMissingLocationPlaceholder,
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),

                      // 1. Next Prayer Card (handles after-Isha tomorrow's Fajr & missing location)
                      _HomeSectionCard(
                        icon: Icons.access_time_rounded,
                        title: l10n.nextPrayerCardTitle,
                        description: homeState.hasValidLocation &&
                                nextPrayer != null
                            ? '${l10n.prayerNextCountdownLabel(nextPrayerName, countdownStr)} • ${homeState.cityDisplayName}'
                            : l10n.homeMissingLocationPlaceholder,
                        badgeText:
                            homeState.hasValidLocation && nextPrayer != null
                                ? '$nextPrayerName $nextPrayerTimeStr'
                                : '--:--',
                        onTap: () => context.goNamed(AppRoutes.prayerName),
                      ),
                      const SizedBox(height: 12),

                      // 2. Today's Wird / Continue Reading Card
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => context.goNamed(
                            AppRoutes.quranName,
                            queryParameters: {
                              'page': '${homeState.savedPageNumber}',
                            },
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.lantern,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.menu_book_rounded,
                                        color: AppColors.night,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            l10n.todaysWirdCardTitle,
                                            style: theme.textTheme.titleLarge,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            l10n.savedReadingPositionSummary(
                                              surahLabel,
                                              homeState.savedAyahNumber,
                                              homeState.savedPageNumber,
                                              homeState.savedJuzNumber,
                                            ),
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    KhatmahProgressRing(
                                      progress:
                                          khatmah?.progressFraction ?? 0.0,
                                      size: 48,
                                      label: '$khatmahPercent%',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  l10n.khatmahDailyGoalLabel(
                                    khatmahDailyPages,
                                    khatmahPercent,
                                  ),
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 12),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: ElevatedButton.icon(
                                    onPressed: () => context.goNamed(
                                      AppRoutes.quranName,
                                      queryParameters: {
                                        'page': '${homeState.savedPageNumber}',
                                      },
                                    ),
                                    icon: const Icon(
                                      Icons.play_arrow_rounded,
                                      size: 18,
                                    ),
                                    label: Text(l10n.continueReadingAction),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 3. Dhikr Card: Today's Tasbih Total & Streak, Quick-Start (+1) Counter, and Time-Highlighted Morning/Evening Adhkar Shortcut
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => context.goNamed(AppRoutes.dhikrName),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.lantern,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.touch_app_rounded,
                                        color: AppColors.night,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            l10n.tasbihCardTitle,
                                            style: theme.textTheme.titleLarge,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            l10n.dayStreakCount(
                                              homeState.currentTasbihStreakDays,
                                            ),
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.14),
                                        borderRadius:
                                            BorderRadius.circular(999),
                                      ),
                                      child: Text(
                                        l10n.tasbihCount(
                                          homeState.todayTasbihTotal,
                                        ),
                                        style: theme.textTheme.labelMedium
                                            ?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  l10n.tasbihPlaceholder,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 8,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    // Quick-start counter button (+1)
                                    OutlinedButton.icon(
                                      onPressed: () async {
                                        if (settings.tasbihHapticsEnabled) {
                                          try {
                                            await HapticFeedback.lightImpact();
                                          } catch (_) {}
                                        }
                                        await _viewModel.quickIncrementTasbih(
                                          settings,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline_rounded,
                                        size: 18,
                                      ),
                                      label: Text(l10n.homeQuickTasbihAction),
                                    ),

                                    // Time-highlighted Morning or Evening Adhkar shortcut
                                    FilledButton.icon(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: AppColors.lantern,
                                        foregroundColor: AppColors.night,
                                      ),
                                      onPressed: () {
                                        context.pushNamed(
                                          AppRoutes.adhkarCategoryName,
                                          pathParameters: {
                                            'categoryId': homeState
                                                .highlightedAdhkarCategory.key,
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        isMorningAdhkarHighlighted
                                            ? Icons.wb_sunny_outlined
                                            : Icons.nightlight_round_outlined,
                                        size: 18,
                                      ),
                                      label: Text(highlightedAdhkarLabel),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 4. Deterministic Offline Verse of the Day Card (Tap opens the verse with Tafsir)
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            if (verseOfTheDay != null) {
                              context.goNamed(
                                AppRoutes.quranName,
                                queryParameters: {
                                  'page': '${verseOfTheDay.pageNumber}',
                                  'verseKey': verseOfTheDay.verse.verseKey,
                                  'openTafsir': 'true',
                                },
                              );
                            } else {
                              context.goNamed(AppRoutes.quranName);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsetsDirectional.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.lantern,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.wb_incandescent_outlined,
                                        color: AppColors.night,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        l10n.verseOfTheDayCardTitle,
                                        style: theme.textTheme.titleLarge,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.14),
                                        borderRadius:
                                            BorderRadius.circular(999),
                                      ),
                                      child: Text(
                                        verseOfTheDay != null
                                            ? '${isAr ? verseOfTheDay.surahNameArabic : verseOfTheDay.surahNameSimple} (${verseOfTheDay.verse.verseKey})'
                                            : l10n.verseCount(1),
                                        style: theme.textTheme.labelMedium
                                            ?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                if (verseOfTheDay != null) ...[
                                  Text(
                                    verseOfTheDay.verse.textUthmani,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: AppTypography.mushafVerseStyle(
                                      color: theme.colorScheme.onSurface,
                                      fontSize: 24,
                                      height: 1.85,
                                    ),
                                  ),
                                  if (verseOfTheDay.tafsirSnippet != null &&
                                      verseOfTheDay
                                          .tafsirSnippet!.isNotEmpty) ...[
                                    const SizedBox(height: 10),
                                    Text(
                                      verseOfTheDay.tafsirSnippet!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                  const SizedBox(height: 12),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        context.goNamed(
                                          AppRoutes.quranName,
                                          queryParameters: {
                                            'page':
                                                '${verseOfTheDay.pageNumber}',
                                            'verseKey':
                                                verseOfTheDay.verse.verseKey,
                                            'openTafsir': 'true',
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.menu_book_outlined,
                                        size: 18,
                                      ),
                                      label: Text(
                                        l10n.homeOpenVerseWithTafsirAction,
                                      ),
                                    ),
                                  ),
                                ] else
                                  Text(
                                    l10n.verseOfTheDayPlaceholder,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _greetingForPeriod(
    AppLocalizations l10n,
    HomeTimeOfDayPeriod period,
  ) {
    return switch (period) {
      HomeTimeOfDayPeriod.morning => l10n.homeGreetingMorning,
      HomeTimeOfDayPeriod.afternoon => l10n.homeGreetingAfternoon,
      HomeTimeOfDayPeriod.evening => l10n.homeGreetingEvening,
    };
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

class _HomeSectionCard extends StatelessWidget {
  const _HomeSectionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final String badgeText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: '$title. $badgeText. $description',
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.lantern,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon,
                        color: AppColors.night,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          badgeText,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
