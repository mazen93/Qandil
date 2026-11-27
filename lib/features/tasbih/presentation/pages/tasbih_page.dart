import 'dart:convert';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/result/result.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../quran/presentation/widgets/khatmah_planner_sheet.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/tasbih_entities.dart';
import '../../domain/services/tasbih_stats_calculator.dart';
import '../cubit/tasbih_cubit.dart';
import '../cubit/tasbih_state.dart';

/// Phase 7 Tasbih Counter and Statistics Screen:
/// 1. Counter Tab:
///    - Dhikr picker (Phase 8 data + custom user-typed labels)
///    - Target presets (33, 99, 100, Custom) + Haptics toggle
///    - Large accessible circular tap area with Lantern progress ring
///    - Undo, Reset lap, and Session save actions
/// 2. Statistics Tab:
///    - Period filters (Today, 7 Days, 30 Days, All Time)
///    - Current streak, Best streak, and Period total hero cards
///    - `fl_chart` BarChart of daily totals
///    - Per-dhikr breakdown & calm empty states
///    - Adaptive daily reminder preview & Export stats as JSON file via Share Sheet
class TasbihPage extends StatefulWidget {
  const TasbihPage({super.key});

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  late final TasbihCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<TasbihCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final lang = Localizations.localeOf(context).languageCode;
      int preset = 33;
      bool haptics = true;
      try {
        final settings = context.read<SettingsCubit>().state.settings;
        preset = settings.tasbihTargetPreset;
        haptics = settings.tasbihHapticsEnabled;
      } catch (_) {}

      _cubit.initialize(
        languageCode: lang,
        initialTargetPreset: preset,
        initialHapticsEnabled: haptics,
      );
    });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _openAddCustomDhikrDialog(BuildContext context, AppLocalizations l10n) {
    final controller = TextEditingController();
    final lang = Localizations.localeOf(context).languageCode;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.tasbihAddCustomDhikrTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: l10n.tasbihAddCustomDhikrHint,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final text = controller.text.trim();
              Navigator.of(dialogContext).pop();
              if (text.isNotEmpty) {
                _cubit.addCustomDhikr(label: text, languageCode: lang);
              }
            },
            child: Text(l10n.audioApplyAction),
          ),
        ],
      ),
    );
  }

  void _openCustomTargetDialog(BuildContext context, AppLocalizations l10n) {
    final controller = TextEditingController(
      text: '${_cubit.state.targetPreset}',
    );

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.tasbihCustomTargetTitle),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            hintText: l10n.tasbihCustomTargetHint,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final parsed = int.tryParse(controller.text.trim());
              Navigator.of(dialogContext).pop();
              if (parsed != null && parsed > 0) {
                _cubit.setTargetPreset(parsed);
              }
            },
            child: Text(l10n.audioApplyAction),
          ),
        ],
      ),
    );
  }

  Future<void> _exportJsonStats(BuildContext context) async {
    final result = await _cubit.buildExportJson();
    if (result case Success(:final value)) {
      final bytes = Uint8List.fromList(utf8.encode(value));
      final xFile = XFile.fromData(
        bytes,
        mimeType: 'application/json',
        name: 'qandil_tasbih_stats.json',
      );
      await SharePlus.instance.share(
        ShareParams(
          files: [xFile],
          text: 'Qandil Tasbih Statistics JSON Export',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider<TasbihCubit>.value(
      value: _cubit,
      child: BlocBuilder<TasbihCubit, TasbihState>(
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(l10n.dhikrShellTitle),
                actions: [
                  IconButton(
                    tooltip: l10n.tasbihHapticsTooltip,
                    icon: Icon(
                      state.hapticsEnabled
                          ? Icons.vibration_rounded
                          : Icons.phone_android_rounded,
                      color: state.hapticsEnabled ? AppColors.lantern : null,
                    ),
                    onPressed: () =>
                        _cubit.toggleHaptics(!state.hapticsEnabled),
                  ),
                ],
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: const Icon(Icons.touch_app_rounded),
                      text: l10n.tasbihTabCounter,
                    ),
                    Tab(
                      icon: const Icon(Icons.bar_chart_rounded),
                      text: l10n.tasbihTabStats,
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _buildCounterTab(context, l10n, state),
                  _buildStatsTab(context, l10n, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCounterTab(
    BuildContext context,
    AppLocalizations l10n,
    TasbihState state,
  ) {
    final theme = Theme.of(context);
    final todayTotal = state.statsSummary?.todayTotal ?? 0;
    const presetTargets = [33, 99, 100];
    final isCustomTarget = !presetTargets.contains(state.targetPreset);

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        // 1. Dhikr Picker + Custom Label Button
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Text(
                      l10n.tasbihSelectDhikrLabel,
                      style: theme.textTheme.labelLarge,
                    ),
                    TextButton.icon(
                      onPressed: () => _openAddCustomDhikrDialog(context, l10n),
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: Text(l10n.tasbihAddCustomDhikrTitle),
                    ),
                  ],
                ),
                if (state.dhikrOptions.isNotEmpty)
                  DropdownButtonFormField<String>(
                    initialValue: state.dhikrOptions.any(
                      (o) => o.id == state.selectedDhikrId,
                    )
                        ? state.selectedDhikrId
                        : state.dhikrOptions.first.id,
                    isExpanded: true,
                    items: state.dhikrOptions.map((option) {
                      return DropdownMenuItem<String>(
                        value: option.id,
                        child: Text(
                          option.label,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (id) {
                      if (id != null) _cubit.selectDhikr(id);
                    },
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 2. Target Presets (33, 99, 100, Custom)
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '${l10n.tasbihTargetPresetLabel}:',
              style: theme.textTheme.titleSmall,
            ),
            ...presetTargets.map((preset) {
              return ChoiceChip(
                label: Text('$preset'),
                selected: state.targetPreset == preset,
                onSelected: (_) => _cubit.setTargetPreset(preset),
              );
            }),
            ActionChip(
              avatar: Icon(
                Icons.edit_outlined,
                size: 16,
                color: isCustomTarget ? AppColors.night : null,
              ),
              backgroundColor: isCustomTarget ? AppColors.lantern : null,
              label: Text(
                isCustomTarget
                    ? '${state.targetPreset}'
                    : l10n.tasbihCustomTargetTitle,
              ),
              onPressed: () => _openCustomTargetDialog(context, l10n),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // 3. Large Circular Tap Area with Progress Ring (scales safely at 200% text scale)
        Center(
          child: Semantics(
            button: true,
            liveRegion: true,
            label:
                '${l10n.tasbihTapPrompt}. ${state.sessionCount} / ${state.targetPreset}',
            child: InkWell(
              onTap: _cubit.increment,
              customBorder: const CircleBorder(),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 260,
                  minHeight: 260,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    KhatmahProgressRing(
                      progress: state.sessionProgressFraction,
                      size: 250,
                      label: '',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${state.sessionCount}',
                              style: theme.textTheme.displayLarge?.copyWith(
                                fontSize: 54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '/ ${state.targetPreset}',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 180,
                              child: Text(
                                l10n.tasbihTapPrompt,
                                style: theme.textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        Center(
          child: Text(
            l10n.tasbihCompletedRoundsLabel(
              state.completedRoundsInSession,
              todayTotal,
            ),
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),

        // 4. Undo, Reset Lap, Save Session Controls (Wrap-resilient for 200% text scale)
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: _cubit.undo,
              icon: const Icon(Icons.undo_rounded, size: 18),
              label: Text(l10n.tasbihUndoAction),
            ),
            OutlinedButton.icon(
              onPressed: _cubit.resetSessionCounter,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(l10n.tasbihResetAction),
            ),
            ElevatedButton.icon(
              onPressed: _cubit.saveAndFinishSessionLap,
              icon: const Icon(Icons.check_rounded, size: 18),
              label: Text(l10n.tasbihSaveSessionAction),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsTab(
    BuildContext context,
    AppLocalizations l10n,
    TasbihState state,
  ) {
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final summary = state.statsSummary;

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        // 1. Period Filter (Today | 7 Days | 30 Days | All Time)
        SegmentedButton<TasbihStatsPeriod>(
          segments: [
            ButtonSegment(
              value: TasbihStatsPeriod.today,
              label: Text(l10n.tasbihPeriodToday),
            ),
            ButtonSegment(
              value: TasbihStatsPeriod.sevenDays,
              label: Text(l10n.tasbihPeriodSevenDays),
            ),
            ButtonSegment(
              value: TasbihStatsPeriod.thirtyDays,
              label: Text(l10n.tasbihPeriodThirtyDays),
            ),
            ButtonSegment(
              value: TasbihStatsPeriod.allTime,
              label: Text(l10n.tasbihPeriodAllTime),
            ),
          ],
          selected: {state.selectedPeriod},
          onSelectionChanged: (sel) => _cubit.setStatsPeriod(sel.first),
        ),
        const SizedBox(height: 16),

        if (summary == null || summary.isEmpty) ...[
          Card(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.insights_rounded,
                    size: 48,
                    color: AppColors.lantern,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.tasbihEmptyStatsMessage,
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          // 2. Hero Metric Cards (Period Total, Current Streak, Best Streak)
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  label: l10n.tasbihCardTitle,
                  value: '${summary.periodTotal}',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  label: l10n.tasbihCurrentStreakLabel,
                  value: l10n.dayStreakCount(summary.currentStreakDays),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  label: l10n.tasbihBestStreakLabel,
                  value: l10n.dayStreakCount(summary.bestStreakDays),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 3. Bar Chart (`fl_chart`)
          Card(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 12),
              child: SizedBox(
                height: 190,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _computeChartMaxY(summary.dailyChartPoints),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 34,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final idx = value.toInt();
                            if (idx < 0 ||
                                idx >= summary.dailyChartPoints.length) {
                              return const SizedBox.shrink();
                            }
                            final dateStr =
                                summary.dailyChartPoints[idx].localDate;
                            final shortDay = dateStr.length >= 10
                                ? dateStr.substring(8, 10)
                                : dateStr;
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                shortDay,
                                style: theme.textTheme.labelSmall,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups: List<BarChartGroupData>.generate(
                      summary.dailyChartPoints.length,
                      (idx) {
                        final point = summary.dailyChartPoints[idx];
                        return BarChartGroupData(
                          x: idx,
                          barRods: [
                            BarChartRodData(
                              toY: point.totalCount.toDouble(),
                              color: AppColors.lantern,
                              width:
                                  summary.dailyChartPoints.length > 14 ? 6 : 14,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 4. Per-Dhikr Breakdown
          Text(
            l10n.tasbihPerDhikrBreakdownTitle,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          ...summary.perDhikrBreakdown.entries.map((entry) {
            final label = state.labelForDhikrId(entry.key);
            final count = entry.value;
            final fraction = summary.periodTotal > 0
                ? (count / summary.periodTotal).clamp(0.0, 1.0)
                : 0.0;

            return Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              label,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            '$count',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: fraction,
                        color: AppColors.lantern,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],

        const SizedBox(height: 16),

        // 5. Adaptive Goal Reminder Preview Card
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(14),
            child: Row(
              children: [
                const Icon(
                  Icons.notifications_active_outlined,
                  color: AppColors.lantern,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    TasbihStatsCalculator.buildAdaptiveReminderBody(
                      todayTotal: summary?.todayTotal ?? 0,
                      dailyGoal: state.targetPreset,
                      currentStreakDays: summary?.currentStreakDays ?? 0,
                      languageCode: lang,
                    ),
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 6. Export Stats as JSON via Share Sheet
        ElevatedButton.icon(
          onPressed: () => _exportJsonStats(context),
          icon: const Icon(Icons.ios_share_rounded),
          label: Text(l10n.tasbihExportJsonAction),
        ),
      ],
    );
  }

  double _computeChartMaxY(List<TasbihDailyPoint> points) {
    var maxVal = 10;
    for (final p in points) {
      if (p.totalCount > maxVal) maxVal = p.totalCount;
    }
    return (maxVal * 1.2).ceilToDouble();
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(12),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
