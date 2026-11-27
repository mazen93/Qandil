import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/result/result.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/tasbih_entities.dart';
import '../../domain/services/tasbih_stats_calculator.dart';
import '../cubit/tasbih_cubit.dart';
import '../cubit/tasbih_state.dart';

/// Phase 7 Tasbih Counter and Statistics Screen (Enhanced Tactile UI/UX):
/// 1. Counter Tab:
///    - Active Dhikr hero banner with streak & daily total pills + quick-switch dhikr chips
///    - Target presets (33, 99, 100, Custom) + Haptics toggle
///    - Tactile 3D Tasbih Bead Medallion with custom 33-bead progress ring & spring tap animation
///    - Undo, Reset lap, and Session save actions in an ergonomic dock
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

class _TasbihPageState extends State<TasbihPage>
    with SingleTickerProviderStateMixin {
  late final TasbihCubit _cubit;
  late final AnimationController _tapBounceController;
  late final Animation<double> _tapScaleAnimation;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<TasbihCubit>();
    _tapBounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 130),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _tapScaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(
        parent: _tapBounceController,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.elasticOut,
      ),
    );

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
    _tapBounceController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _handleMedallionTap() {
    _tapBounceController.forward(from: 0.0).then((_) {
      if (mounted) {
        _tapBounceController.reverse();
      }
    });
    _cubit.increment();
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

  void _openDhikrPickerSheet(
    BuildContext context,
    AppLocalizations l10n,
    TasbihState state,
  ) {
    final theme = Theme.of(context);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.65,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        l10n.tasbihSelectDhikrLabel,
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                        _openAddCustomDhikrDialog(context, l10n);
                      },
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: Text(l10n.tasbihAddCustomDhikrTitle),
                    ),
                  ],
                ),
                const Divider(),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.dhikrOptions.length,
                    itemBuilder: (context, index) {
                      final option = state.dhikrOptions[index];
                      final isSelected = option.id == state.selectedDhikrId;
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        selected: isSelected,
                        selectedTileColor:
                            AppColors.lantern.withValues(alpha: 0.14),
                        leading: Icon(
                          isSelected
                              ? Icons.check_circle_rounded
                              : Icons.circle_outlined,
                          color: isSelected ? AppColors.lantern : null,
                        ),
                        title: Text(
                          option.label,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          _cubit.selectDhikr(option.id);
                          Navigator.of(sheetContext).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
    final isDark = theme.brightness == Brightness.dark;
    final todayTotal = state.statsSummary?.todayTotal ?? 0;
    final currentStreak = state.statsSummary?.currentStreakDays ?? 0;
    const presetTargets = [33, 99, 100];
    final isCustomTarget = !presetTargets.contains(state.targetPreset);
    final target = state.targetPreset > 0 ? state.targetPreset : 33;
    final inCurrentRound = state.sessionCount == 0
        ? 0
        : (state.sessionCount % target == 0
            ? target
            : state.sessionCount % target);
    final isRoundJustCompleted =
        state.sessionCount > 0 && state.sessionCount % target == 0;
    final accentColor = isDark ? AppColors.lantern : AppColors.nile;

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 24),
      children: [
        // 1. Active Dhikr Hero Card + Quick Chips + Custom Dhikr Action
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: isDark
                  ? [
                      AppColors.nightElevated,
                      AppColors.nightContainer.withValues(alpha: 0.85),
                    ]
                  : [
                      AppColors.sand.withValues(alpha: 0.7),
                      AppColors.ivory,
                    ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? AppColors.lantern.withValues(alpha: 0.35)
                  : AppColors.sandBorder,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top metadata row: Label + Streak Badge + Add Custom button
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 6,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        size: 16,
                        color: AppColors.lantern,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        l10n.tasbihSelectDhikrLabel,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: isDark
                              ? AppColors.ivoryMuted
                              : AppColors.textMutedLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (currentStreak > 0)
                        Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lantern.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: AppColors.lantern.withValues(alpha: 0.45),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.local_fire_department_rounded,
                                size: 15,
                                color: AppColors.lantern,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                l10n.dayStreakCount(currentStreak),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? AppColors.ivory
                                      : AppColors.night,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: () => _openAddCustomDhikrDialog(context, l10n),
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_rounded,
                                size: 15,
                                color: accentColor,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                l10n.tasbihAddCustomDhikrTitle,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: accentColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Prominent Active Dhikr Title (tappable to open full sheet)
              InkWell(
                onTap: state.dhikrOptions.isNotEmpty
                    ? () => _openDhikrPickerSheet(context, l10n, state)
                    : null,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.night.withValues(alpha: 0.55)
                        : AppColors.ivory.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? AppColors.nightContainer
                          : AppColors.sandBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.selectedDhikr.label,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.unfold_more_rounded,
                        size: 20,
                        color: accentColor,
                      ),
                    ],
                  ),
                ),
              ),

              // Quick One-Tap Dhikr Pills
              if (state.dhikrOptions.length > 1) ...[
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.dhikrOptions.map((option) {
                      final isSelected = option.id == state.selectedDhikrId;
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: ChoiceChip(
                          label: Text(
                            option.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          selected: isSelected,
                          selectedColor:
                              AppColors.lantern.withValues(alpha: 0.25),
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.lantern
                                : (isDark
                                    ? AppColors.nightContainer
                                    : AppColors.sandBorder),
                          ),
                          onSelected: (_) => _cubit.selectDhikr(option.id),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // 2. Target Presets Bar (33, 99, 100, Custom)
        Center(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '${l10n.tasbihTargetPresetLabel}:',
                style: theme.textTheme.labelLarge?.copyWith(
                  color:
                      isDark ? AppColors.ivoryMuted : AppColors.textMutedLight,
                ),
              ),
              ...presetTargets.map((preset) {
                final selected = state.targetPreset == preset;
                return ChoiceChip(
                  label: Text(
                    '$preset',
                    style: TextStyle(
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  selected: selected,
                  selectedColor: AppColors.lantern.withValues(alpha: 0.25),
                  side: BorderSide(
                    color: selected
                        ? AppColors.lantern
                        : (isDark
                            ? AppColors.nightContainer
                            : AppColors.sandBorder),
                  ),
                  onSelected: (_) => _cubit.setTargetPreset(preset),
                );
              }),
              ActionChip(
                avatar: Icon(
                  Icons.tune_rounded,
                  size: 16,
                  color: isCustomTarget ? AppColors.night : accentColor,
                ),
                backgroundColor: isCustomTarget ? AppColors.lantern : null,
                side: BorderSide(
                  color: isCustomTarget
                      ? AppColors.lantern
                      : (isDark
                          ? AppColors.nightContainer
                          : AppColors.sandBorder),
                ),
                label: Text(
                  isCustomTarget
                      ? '${state.targetPreset}'
                      : l10n.tasbihCustomTargetTitle,
                  style: TextStyle(
                    color: isCustomTarget ? AppColors.night : null,
                    fontWeight:
                        isCustomTarget ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                onPressed: () => _openCustomTargetDialog(context, l10n),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 3. Tactile 3D Tasbih Medallion with Bead Ring (scales safely at 200% text scale)
        Center(
          child: Semantics(
            button: true,
            liveRegion: true,
            label:
                '${l10n.tasbihTapPrompt}. ${state.sessionCount} / ${state.targetPreset}',
            child: GestureDetector(
              onTap: _handleMedallionTap,
              behavior: HitTestBehavior.opaque,
              child: ScaleTransition(
                scale: _tapScaleAnimation,
                child: SizedBox(
                  width: 288,
                  height: 288,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Tasbih Bead Ring
                      CustomPaint(
                        size: const Size(288, 288),
                        painter: _TasbihBeadRingPainter(
                          progress: state.sessionProgressFraction,
                          totalBeads: target <= 33 ? target : 33,
                          activeBeadColor: AppColors.lantern,
                          inactiveBeadColor: isDark
                              ? AppColors.nightContainer
                              : AppColors.sandBorder,
                          trackColor: isDark
                              ? AppColors.nightElevated
                              : AppColors.sand.withValues(alpha: 0.7),
                          isRoundComplete: isRoundJustCompleted,
                        ),
                      ),

                      // Inner Tactile Medallion Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        width: 224,
                        height: 224,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            center: const Alignment(-0.2, -0.25),
                            radius: 0.95,
                            colors: isDark
                                ? [
                                    AppColors.nightContainer,
                                    AppColors.nightElevated,
                                    AppColors.night,
                                  ]
                                : [
                                    AppColors.ivory,
                                    AppColors.sand.withValues(alpha: 0.65),
                                    AppColors.sand,
                                  ],
                          ),
                          border: Border.all(
                            color: isRoundJustCompleted
                                ? AppColors.lantern
                                : (isDark
                                    ? AppColors.lantern.withValues(alpha: 0.35)
                                    : AppColors.nile.withValues(alpha: 0.3)),
                            width: isRoundJustCompleted ? 2.5 : 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isRoundJustCompleted
                                  ? AppColors.lantern.withValues(alpha: 0.35)
                                  : Colors.black.withValues(
                                      alpha: isDark ? 0.45 : 0.10,
                                    ),
                              blurRadius: isRoundJustCompleted ? 24 : 18,
                              spreadRadius: isRoundJustCompleted ? 2 : 0,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Lap / Round Pill inside dial
                                Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isRoundJustCompleted
                                        ? AppColors.lantern
                                        : accentColor.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    '$inCurrentRound / ${state.targetPreset}',
                                    style:
                                        theme.textTheme.labelMedium?.copyWith(
                                      color: isRoundJustCompleted
                                          ? AppColors.night
                                          : accentColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Primary Counter Display
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 120),
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                  child: Text(
                                    '${state.sessionCount}',
                                    key: ValueKey<int>(state.sessionCount),
                                    style:
                                        theme.textTheme.displayLarge?.copyWith(
                                      fontSize: 64,
                                      fontWeight: FontWeight.w800,
                                      color: isRoundJustCompleted
                                          ? AppColors.lantern
                                          : null,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),

                                // Subtle Touch Icon + Tap Prompt
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.touch_app_rounded,
                                      size: 15,
                                      color: AppColors.lantern,
                                    ),
                                    const SizedBox(width: 4),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 155,
                                      ),
                                      child: Text(
                                        l10n.tasbihTapPrompt,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 4. Completed Rounds & Today's Total Summary Pill
        Center(
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.nightElevated
                  : AppColors.sand.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isDark ? AppColors.nightContainer : AppColors.sandBorder,
              ),
            ),
            child: Text(
              l10n.tasbihCompletedRoundsLabel(
                state.completedRoundsInSession,
                todayTotal,
              ),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 18),

        // 5. Undo, Reset Lap, Save Session Controls Dock (Wrap-resilient for 200% text scale)
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: state.sessionCount > 0 ? _cubit.undo : null,
                  icon: const Icon(Icons.undo_rounded, size: 18),
                  label: Text(l10n.tasbihUndoAction),
                ),
                OutlinedButton.icon(
                  onPressed: state.sessionCount > 0
                      ? _cubit.resetSessionCounter
                      : null,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text(l10n.tasbihResetAction),
                ),
                ElevatedButton.icon(
                  onPressed: _cubit.saveAndFinishSessionLap,
                  icon:
                      const Icon(Icons.check_circle_outline_rounded, size: 18),
                  label: Text(l10n.tasbihSaveSessionAction),
                ),
              ],
            ),
          ),
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
                  icon: Icons.auto_awesome_rounded,
                  label: l10n.tasbihCardTitle,
                  value: '${summary.periodTotal}',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  icon: Icons.local_fire_department_rounded,
                  label: l10n.tasbihCurrentStreakLabel,
                  value: l10n.dayStreakCount(summary.currentStreakDays),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  icon: Icons.emoji_events_rounded,
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: fraction,
                          minHeight: 7,
                          color: AppColors.lantern,
                        ),
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

/// CustomPainter drawing a ring of physical Tasbih beads around the counter medallion
/// along with a smooth progress arc.
class _TasbihBeadRingPainter extends CustomPainter {
  const _TasbihBeadRingPainter({
    required this.progress,
    required this.totalBeads,
    required this.activeBeadColor,
    required this.inactiveBeadColor,
    required this.trackColor,
    required this.isRoundComplete,
  });

  final double progress;
  final int totalBeads;
  final Color activeBeadColor;
  final Color inactiveBeadColor;
  final Color trackColor;
  final bool isRoundComplete;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) / 2) - 14;
    final clampedProgress = progress.clamp(0.0, 1.0);

    // 1. Subtle connecting string/track circle
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(center, radius, trackPaint);

    // 2. Active progress arc along the bead string
    if (clampedProgress > 0) {
      final arcPaint = Paint()
        ..color = activeBeadColor.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * clampedProgress,
        false,
        arcPaint,
      );
    }

    // 3. Individual Tasbih beads around the perimeter
    final beadCount = totalBeads.clamp(10, 33);
    final litBeads =
        isRoundComplete ? beadCount : (clampedProgress * beadCount).floor();

    for (var i = 0; i < beadCount; i++) {
      final angle = -math.pi / 2 + (2 * math.pi * i / beadCount);
      final beadCenter = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      final isLit = i < litBeads;
      final isCurrentHead =
          (i == litBeads - 1 && litBeads > 0) || isRoundComplete;
      // Every 11th bead (standard 11-22-33 tasbih divider) is slightly larger
      final isDividerBead = ((i + 1) % 11 == 0);
      final baseRadius = isDividerBead ? 6.2 : 4.6;
      final beadRadius = isCurrentHead ? baseRadius + 1.4 : baseRadius;

      if (isCurrentHead) {
        final glowPaint = Paint()
          ..color = activeBeadColor.withValues(alpha: 0.32)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(beadCenter, beadRadius + 4.0, glowPaint);
      }

      final beadPaint = Paint()
        ..color = isLit ? activeBeadColor : inactiveBeadColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(beadCenter, beadRadius, beadPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TasbihBeadRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.totalBeads != totalBeads ||
        oldDelegate.activeBeadColor != activeBeadColor ||
        oldDelegate.inactiveBeadColor != inactiveBeadColor ||
        oldDelegate.isRoundComplete != isRoundComplete;
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
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
            Icon(
              icon,
              size: 20,
              color: AppColors.lantern,
            ),
            const SizedBox(height: 6),
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
