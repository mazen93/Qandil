import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/di/register_dependencies.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/result/result.dart';
import '../../../../core/widgets/qandil_empty_state.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../audio/presentation/cubit/audio_cubit.dart';
import '../../../quran/domain/entities/quran_entities.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/hifz_entities.dart';
import '../../domain/services/hifz_display_masker.dart';
import '../cubit/hifz_cubit.dart';
import '../cubit/hifz_state.dart';

/// Phase 12 Memorization (Hifz) Hub Screen:
/// 1. Plan & Queue Tab:
///    - Daily goals (`newVersesPerDay`, `reviewRangesPerDayCap`) + Catch-Up Mode toggle
///    - Add Memorized Verse Range form
///    - Today's SM-2 Due Review Queue (with quick self-grade or Test launcher)
///    - Audio Loop Helper with configurable pause gap (`0s`, `3s`, `5s`, `10s`) to repeat after the reciter
/// 2. Test & Recite Tab:
///    - Resumable session (survives app kill via Drift `hifz_active_session`)
///    - Mode 1: Recite by Verse Number
///    - Mode 2: What is the Next Verse?
///    - Mode 3: Review My Mistakes
///    - Interactive word tap on revealed verse to record exact word position of a mistake
///    - Self-grade buttons (`Perfect / متقن`, `Hesitated / تردّد`, `Forgot / نسيت`)
/// 3. Weak Spots & Mutashabihat Tab:
///    - Aggregated weak spots sorted by mistake count + one-tap "Review My Mistakes" session
///    - Clearly marked Mutashabihat (Similar Verses) extension point
/// 4. Stats & Teacher Export Tab:
///    - Total memorized (`verses`, `pages`, `juz`), review streak, 7-day weekly accuracy %, projected completion date
///    - Export Teacher Progress Report as JSON via `share_plus` (no accounts needed).
class HifzHubPage extends StatefulWidget {
  const HifzHubPage({
    super.key,
    this.availableVersesByKey = const {},
    this.audioCubit,
    this.initialSurahNumber = 1,
    this.initialSurahName = 'الفاتحة',
    this.initialSurahVersesCount = 7,
  });

  final Map<String, QuranVerse> availableVersesByKey;
  final AudioCubit? audioCubit;
  final int initialSurahNumber;
  final String initialSurahName;
  final int initialSurahVersesCount;

  @override
  State<HifzHubPage> createState() => _HifzHubPageState();
}

class _HifzHubPageState extends State<HifzHubPage>
    with SingleTickerProviderStateMixin {
  late final HifzCubit _cubit;
  late final TabController _tabController;

  late int _selectedSurah;
  late int _startAyah;
  late int _endAyah;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<HifzCubit>();
    _tabController = TabController(length: 4, vsync: this);
    _selectedSurah = widget.initialSurahNumber;
    _startAyah = 1;
    _endAyah = widget.initialSurahVersesCount.clamp(1, 7);

    int newGoal = 5;
    int reviewCap = 5;
    bool catchUp = false;
    int catchUpDays = 3;
    try {
      final s = context.read<SettingsCubit>().state.settings;
      newGoal = s.hifzNewVersesPerDayGoal;
      reviewCap = s.hifzReviewRangesPerDayCap;
      catchUp = s.hifzCatchUpModeEnabled;
      catchUpDays = s.hifzCatchUpDays;
    } catch (_) {}

    _cubit.initialize(
      newVersesPerDayGoal: newGoal,
      reviewRangesPerDayCap: reviewCap,
      catchUpModeEnabled: catchUp,
      catchUpSpreadDays: catchUpDays,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cubit.close();
    super.dispose();
  }

  Future<void> _exportTeacherJson() async {
    final result = await _cubit.buildTeacherExportJson();
    if (!mounted) return;
    if (result case Success(:final value)) {
      final bytes = Uint8List.fromList(utf8.encode(value));
      await SharePlus.instance.share(
        ShareParams(
          text: value,
          files: [
            XFile.fromData(
              bytes,
              name: 'qandil_hifz_teacher_report.json',
              mimeType: 'application/json',
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider<HifzCubit>.value(
      value: _cubit,
      child: BlocBuilder<HifzCubit, HifzState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.hifzTitle),
              actions: [
                IconButton(
                  tooltip: l10n.hifzTeacherExportAction,
                  icon: const Icon(Icons.ios_share_rounded),
                  onPressed: _exportTeacherJson,
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: AppColors.lantern,
                tabs: [
                  Tab(text: l10n.hifzTabPlan),
                  Tab(text: l10n.hifzTabTest),
                  Tab(text: l10n.hifzTabMistakes),
                  Tab(text: l10n.hifzTabStats),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildPlanAndQueueTab(context, state, l10n),
                _buildTestAndReciteTab(context, state, l10n),
                _buildWeakSpotsAndMutashabihatTab(context, state, l10n),
                _buildStatsAndTeacherTab(context, state, l10n),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlanAndQueueTab(
    BuildContext context,
    HifzState state,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        // 1. Daily Goals & Catch-Up Mode Card
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.hifzDailyGoalsTitle,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.hifzNewVersesPerDayLabel),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 3, label: Text('3')),
                        ButtonSegment(value: 5, label: Text('5')),
                        ButtonSegment(value: 10, label: Text('10')),
                      ],
                      selected: {
                        const {3, 5, 10}.contains(state.newVersesPerDayGoal)
                            ? state.newVersesPerDayGoal
                            : 5,
                      },
                      onSelectionChanged: (sel) {
                        _cubit.setGoals(newVersesPerDayGoal: sel.first);
                        try {
                          context.read<SettingsCubit>().updateHifzGoals(
                                newVersesPerDayGoal: sel.first,
                              );
                        } catch (_) {}
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.hifzReviewsPerDayCapLabel),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 3, label: Text('3')),
                        ButtonSegment(value: 5, label: Text('5')),
                        ButtonSegment(value: 10, label: Text('10')),
                      ],
                      selected: {
                        const {3, 5, 10}.contains(state.reviewRangesPerDayCap)
                            ? state.reviewRangesPerDayCap
                            : 5,
                      },
                      onSelectionChanged: (sel) {
                        _cubit.setGoals(reviewRangesPerDayCap: sel.first);
                        try {
                          context.read<SettingsCubit>().updateHifzGoals(
                                reviewRangesPerDayCap: sel.first,
                              );
                        } catch (_) {}
                      },
                    ),
                  ],
                ),
                const Divider(height: 20),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.hifzCatchUpModeLabel),
                  value: state.catchUpModeEnabled,
                  onChanged: (enabled) {
                    _cubit.setGoals(catchUpModeEnabled: enabled);
                    try {
                      context.read<SettingsCubit>().updateHifzGoals(
                            catchUpModeEnabled: enabled,
                          );
                    } catch (_) {}
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 2. Add Memorized Range Card
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.hifzAddRangeTitle,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        initialValue: _selectedSurah.clamp(1, 2),
                        decoration: InputDecoration(
                          labelText: l10n.readerNavSurah,
                        ),
                        items: const [
                          DropdownMenuItem(value: 1, child: Text('1. الفاتحة')),
                          DropdownMenuItem(value: 2, child: Text('2. البقرة')),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedSurah = val;
                              _startAyah = 1;
                              _endAyah = val == 1 ? 7 : 5;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: '$_startAyah',
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'من آية'),
                        onChanged: (v) {
                          final parsed = int.tryParse(v);
                          if (parsed != null) _startAyah = parsed;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: '$_endAyah',
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'إلى آية'),
                        onChanged: (v) {
                          final parsed = int.tryParse(v);
                          if (parsed != null) _endAyah = parsed;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    _cubit.addMemorizedRange(
                      surahNumber: _selectedSurah,
                      startAyah: _startAyah,
                      endAyah: _endAyah,
                      startPage: _selectedSurah == 1 ? 1 : 2,
                      endPage: _selectedSurah == 1 ? 1 : 2,
                      juzNumber: 1,
                    );
                  },
                  icon: const Icon(Icons.add_task_rounded),
                  label: Text(l10n.hifzAddRangeAction),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 3. Audio Loop Helper with Pause Gap
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.hifzAudioHelperTitle,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.hifzAudioPauseGapLabel,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 0, label: Text('0s')),
                    ButtonSegment(value: 3, label: Text('3s')),
                    ButtonSegment(value: 5, label: Text('5s')),
                    ButtonSegment(value: 10, label: Text('10s')),
                  ],
                  selected: {state.audioLoopPauseGapSeconds},
                  onSelectionChanged: (sel) {
                    _cubit.setAudioLoopPauseGapSeconds(sel.first);
                    widget.audioCubit?.setHifzPauseGapSeconds(sel.first);
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    widget.audioCubit?.startHifzRangeLoop(
                      surahNumber: _selectedSurah,
                      surahName: _selectedSurah == 1 ? 'الفاتحة' : 'البقرة',
                      versesCount: _selectedSurah == 1 ? 7 : 286,
                      startAyah: _startAyah,
                      endAyah: _endAyah,
                      repeatCount: 3,
                      pauseGapSeconds: state.audioLoopPauseGapSeconds,
                    );
                    Navigator.of(context).maybePop();
                  },
                  icon: const Icon(Icons.repeat_rounded),
                  label: Text(l10n.hifzStartAudioLoopAction),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 4. Today's Due Review Queue
        Text(
          '${l10n.hifzDueQueueTitle} (${state.dueQueue.length})',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        if (state.dueQueue.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(16),
              child: Text(l10n.hifzDueQueueEmpty),
            ),
          )
        else
          for (final range in state.dueQueue) ...[
            Card(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'سورة ${range.surahNumber == 1 ? 'الفاتحة' : 'البقرة'} (${range.startAyah} - ${range.endAyah})',
                          style: theme.textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded,
                              size: 20),
                          onPressed: () =>
                              _cubit.deleteMemorizedRange(range.id),
                        ),
                      ],
                    ),
                    Text(
                      'EF: ${range.easinessFactor.toStringAsFixed(2)} • Interval: ${range.intervalDays}d • Due: ${range.nextDueDate}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.tonalIcon(
                          onPressed: () {
                            _cubit.startRangeTestSession(
                              mode: HifzTestMode.reciteByVerseNumber,
                              rangeId: range.id,
                              surahNumber: range.surahNumber,
                              startAyah: range.startAyah,
                              endAyah: range.endAyah,
                            );
                            _tabController.animateTo(1);
                          },
                          icon: const Icon(Icons.quiz_outlined, size: 18),
                          label: Text(l10n.hifzTabTest),
                        ),
                        OutlinedButton(
                          onPressed: () => _cubit.quickGradeRange(
                            range,
                            HifzSelfGrade.perfect,
                          ),
                          child: Text(l10n.hifzGradePerfect),
                        ),
                        OutlinedButton(
                          onPressed: () => _cubit.quickGradeRange(
                            range,
                            HifzSelfGrade.hesitated,
                          ),
                          child: Text(l10n.hifzGradeHesitated),
                        ),
                        OutlinedButton(
                          onPressed: () => _cubit.quickGradeRange(
                            range,
                            HifzSelfGrade.forgot,
                          ),
                          child: Text(l10n.hifzGradeForgot),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
      ],
    );
  }

  Widget _buildTestAndReciteTab(
    BuildContext context,
    HifzState state,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final session = state.activeSession;

    if (!session.isActive || session.verseKeys.isEmpty) {
      return ListView(
        padding: const EdgeInsetsDirectional.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.hifzTabTest,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      _cubit.startRangeTestSession(
                        mode: HifzTestMode.reciteByVerseNumber,
                        surahNumber: _selectedSurah,
                        startAyah: _startAyah,
                        endAyah: _endAyah,
                      );
                    },
                    icon: const Icon(Icons.numbers_rounded),
                    label: Text(l10n.hifzTestModeByNumber),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      _cubit.startRangeTestSession(
                        mode: HifzTestMode.whatIsNextVerse,
                        surahNumber: _selectedSurah,
                        startAyah: _startAyah,
                        endAyah: _endAyah < 2 ? 2 : _endAyah,
                      );
                    },
                    icon: const Icon(Icons.skip_next_rounded),
                    label: Text(l10n.hifzTestModeNextVerse),
                  ),
                  if (state.weakSpots.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      onPressed: _cubit.startReviewMyMistakesSession,
                      icon: const Icon(Icons.healing_rounded),
                      label: Text(l10n.hifzTestModeMistakes),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      );
    }

    final promptKey = session.currentVerseKey ?? '1:1';
    final targetKey = session.nextTargetVerseKey ?? promptKey;
    final promptVerse = widget.availableVersesByKey[promptKey];
    final targetVerse = widget.availableVersesByKey[targetKey];
    final targetWords = targetVerse != null
        ? HifzDisplayMasker.extractWords(targetVerse)
        : <String>[targetKey];

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      session.mode == HifzTestMode.whatIsNextVerse
                          ? l10n.hifzTestModeNextVerse
                          : (session.mode == HifzTestMode.reviewMyMistakes
                              ? l10n.hifzTestModeMistakes
                              : l10n.hifzTestModeByNumber),
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '${session.currentIndex + 1} / ${session.verseKeys.length}',
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
                const Divider(height: 24),

                // Mode 2 shows prompt verse k and asks for verse k+1
                if (session.mode == HifzTestMode.whatIsNextVerse) ...[
                  Text(
                    'الآية الحالية ($promptKey):',
                    style: theme.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    promptVerse?.textUthmani ?? '﴿آية $promptKey﴾',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: AppTypography.mushafVerseStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                Container(
                  padding: const EdgeInsetsDirectional.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lantern.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'سمّع الآية رقم ($targetKey)',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 20),

                if (!session.isRevealed)
                  ElevatedButton.icon(
                    onPressed: _cubit.revealCurrentSessionVerse,
                    icon: const Icon(Icons.visibility_outlined),
                    label: Text(l10n.hifzRevealVerseAction),
                  )
                else ...[
                  Text(
                    l10n.hifzTapMistakeWordHint,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: List.generate(targetWords.length, (i) {
                        final wordPos = i + 1;
                        final isSelected =
                            session.tappedMistakeWordPosition == wordPos;
                        return ChoiceChip(
                          label: Text(
                            targetWords[i],
                            style: AppTypography.mushafVerseStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 22,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor:
                              theme.colorScheme.error.withValues(alpha: 0.25),
                          onSelected: (sel) {
                            _cubit.selectMistakeWordPosition(
                              sel ? wordPos : null,
                            );
                          },
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.nile,
                            foregroundColor: AppColors.ivory,
                          ),
                          onPressed: () => _cubit.gradeCurrentSessionVerse(
                            HifzSelfGrade.perfect,
                          ),
                          child: Text(l10n.hifzGradePerfect),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.lantern,
                            foregroundColor: AppColors.night,
                          ),
                          onPressed: () => _cubit.gradeCurrentSessionVerse(
                            HifzSelfGrade.hesitated,
                          ),
                          child: Text(l10n.hifzGradeHesitated),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                            foregroundColor: theme.colorScheme.onError,
                          ),
                          onPressed: () => _cubit.gradeCurrentSessionVerse(
                            HifzSelfGrade.forgot,
                          ),
                          child: Text(l10n.hifzGradeForgot),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _cubit.cancelActiveSession,
                  child: const Text('إنهاء الجلسة'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeakSpotsAndMutashabihatTab(
    BuildContext context,
    HifzState state,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.hifzWeakSpotsTitle,
              style: theme.textTheme.titleMedium,
            ),
            if (state.weakSpots.isNotEmpty)
              FilledButton.tonalIcon(
                onPressed: () {
                  _cubit.startReviewMyMistakesSession();
                  _tabController.animateTo(1);
                },
                icon: const Icon(Icons.play_arrow_rounded, size: 18),
                label: Text(l10n.hifzTestModeMistakes),
              ),
          ],
        ),
        const SizedBox(height: 10),
        if (state.weakSpots.isEmpty)
          Card(
            child: QandilEmptyState(
              title: l10n.hifzWeakSpotsTitle,
              message: l10n.hifzWeakSpotsEmpty,
            ),
          )
        else
          for (final spot in state.weakSpots) ...[
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      theme.colorScheme.error.withValues(alpha: 0.18),
                  foregroundColor: theme.colorScheme.error,
                  child: Text('${spot.mistakeCount}'),
                ),
                title: Text('الآية ${spot.verseKey}'),
                subtitle: Text(
                  spot.frequentWordPositions.isEmpty
                      ? 'آخر خطأ: ${spot.lastMistakeDate}'
                      : 'مواضع الكلمات: ${spot.frequentWordPositions.join(", ")} • ${spot.lastMistakeDate}',
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        const SizedBox(height: 20),

        // Clearly Marked Mutashabihat Extension Point Card
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.compare_arrows_rounded,
                      color: AppColors.lantern,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.hifzMutashabihatTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (!state.mutashabihatAvailable)
                  Text(
                    l10n.hifzMutashabihatNotice,
                    style: theme.textTheme.bodyMedium,
                  )
                else
                  for (final pair in state.mutashabihatPairs)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        '${pair.firstVerseKey} ↔ ${pair.secondVerseKey}',
                      ),
                      subtitle: Text(pair.sourceAttribution),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsAndTeacherTab(
    BuildContext context,
    HifzState state,
    AppLocalizations l10n,
  ) {
    final stats = state.statsSummary;

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: l10n.hifzStatsMemorizedVerses,
                value: '${stats?.memorizedVersesCount ?? 0}',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _StatCard(
                label: l10n.hifzStatsMemorizedPages,
                value: '${stats?.memorizedPagesCount ?? 0}',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _StatCard(
                label: l10n.hifzStatsMemorizedJuz,
                value: '${stats?.memorizedJuzCount ?? 0}',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: l10n.hifzStatsReviewStreak,
                value: '${stats?.reviewStreakDays ?? 0}d',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _StatCard(
                label: l10n.hifzStatsWeeklyAccuracy,
                value: '${stats?.weeklyAccuracyPercent ?? 100}%',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.event_available_rounded,
              color: AppColors.lantern,
            ),
            title: Text(l10n.hifzStatsProjectedCompletion),
            subtitle: Text(stats?.projectedCompletionDate ?? '--'),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _exportTeacherJson,
          icon: const Icon(Icons.share_rounded),
          label: Text(l10n.hifzTeacherExportAction),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
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
        padding: const EdgeInsetsDirectional.all(14),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
