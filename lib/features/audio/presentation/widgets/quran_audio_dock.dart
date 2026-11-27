import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../quran/domain/entities/quran_entities.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/audio_entities.dart';
import '../../domain/services/reciter_sorter.dart';
import '../cubit/audio_cubit.dart';
import '../cubit/audio_state.dart';
import '../pages/audio_downloads_storage_page.dart';

/// Docked audio playback controller bar inside the Quran Reader:
/// - Play/Pause, Previous/Next Verse
/// - Reciter picker (Egyptian reciters first, displaying style Murattal/Mujawwad)
/// - Mode toggle (Verse-by-Verse vs Full Surah)
/// - Speed selector (`0.75x`, `1.0x`, `1.25x`, `1.5x`)
/// - Repeat Verse/Range N times & Continue to Next Surah dialog
/// - Sleep Timer menu
/// - Offline Audio & Storage Usage screen shortcut
class QuranAudioDock extends StatelessWidget {
  const QuranAudioDock({
    required this.currentSurahNumber,
    required this.currentSurahName,
    required this.currentSurahVersesCount,
    required this.currentAyahNumber,
    required this.chapters,
    super.key,
  });

  final int currentSurahNumber;
  final String currentSurahName;
  final int currentSurahVersesCount;
  final int currentAyahNumber;
  final List<QuranChapter> chapters;

  void _openReciterSheet(BuildContext context, AudioState state) {
    final l10n = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final audioCubit = context.read<AudioCubit>();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.all(16),
                child: Text(
                  l10n.audioSelectReciterTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.reciters.length,
                  itemBuilder: (context, index) {
                    final reciter = state.reciters[index];
                    final isSelected = reciter.id == state.selectedReciterId;
                    final isEgyptian = ReciterSorter.isEgyptianReciter(reciter);
                    final label = ReciterSorter.formatDisplayName(
                      reciter,
                      languageCode: lang,
                    );

                    return ListTile(
                      leading: Icon(
                        isSelected
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_off_rounded,
                        color: isSelected ? AppColors.lantern : null,
                      ),
                      title: Text(label),
                      subtitle: isEgyptian
                          ? Text(
                              l10n.audioEgyptianReciterBadge,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppColors.lantern),
                            )
                          : null,
                      onTap: () {
                        audioCubit.selectReciter(
                          reciter.id,
                          currentSurahNumber: currentSurahNumber,
                          currentSurahName: currentSurahName,
                          versesCount: currentSurahVersesCount,
                        );
                        try {
                          context
                              .read<SettingsCubit>()
                              .updateDefaultReciterId(reciter.id);
                        } catch (_) {}
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
  }

  void _openRepeatAndOptionsDialog(BuildContext context, AudioState state) {
    final l10n = AppLocalizations.of(context);
    final audioCubit = context.read<AudioCubit>();

    var enabled = state.repeatConfig.enabled;
    var startAyah = state.repeatConfig.startAyah;
    var endAyah = state.repeatConfig.endAyah;
    var repeatCount =
        state.repeatConfig.repeatCount > 1 ? state.repeatConfig.repeatCount : 3;
    var continueNextSurah = state.continueToNextSurah;

    final startCtrl = TextEditingController(text: '$startAyah');
    final endCtrl = TextEditingController(text: '$endAyah');

    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(l10n.audioRepeatTitle),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.audioRepeatEnable),
                    value: enabled,
                    onChanged: (val) => setDialogState(() => enabled = val),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: startCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l10n.audioRepeatStartAyah,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: endCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l10n.audioRepeatEndAyah,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(l10n.audioRepeatCountLabel),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: [2, 3, 5, 10].map((cnt) {
                      return ChoiceChip(
                        label: Text('${cnt}x'),
                        selected: repeatCount == cnt,
                        onSelected: (_) =>
                            setDialogState(() => repeatCount = cnt),
                      );
                    }).toList(),
                  ),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.audioContinueNextSurah),
                    value: continueNextSurah,
                    onChanged: (val) =>
                        setDialogState(() => continueNextSurah = val),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  startAyah =
                      (int.tryParse(startCtrl.text.trim()) ?? 1).clamp(1, 286);
                  endAyah = (int.tryParse(endCtrl.text.trim()) ?? startAyah)
                      .clamp(startAyah, 286);
                  audioCubit
                    ..setRepeatConfig(
                      AudioRepeatRangeConfig(
                        enabled: enabled,
                        startAyah: startAyah,
                        endAyah: endAyah,
                        repeatCount: repeatCount,
                      ),
                    )
                    ..setContinueToNextSurah(continueNextSurah);
                  Navigator.of(dialogContext).pop();
                },
                child: Text(l10n.audioApplyAction),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openSleepTimerSheet(BuildContext context, AudioState state) {
    final l10n = AppLocalizations.of(context);
    final audioCubit = context.read<AudioCubit>();
    const options = <int?>[null, 15, 30, 45, 60];

    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.all(16),
              child: Text(
                l10n.audioSleepTimerTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            ...options.map((minutes) {
              final isSelected = state.sleepTimerRemainingMinutes == minutes;
              return ListTile(
                leading: Icon(
                  isSelected
                      ? Icons.check_circle_rounded
                      : Icons.timer_outlined,
                  color: isSelected ? AppColors.lantern : null,
                ),
                title: Text(
                  minutes == null
                      ? l10n.audioSleepTimerOff
                      : l10n.audioSleepTimerMinutes(minutes),
                ),
                onTap: () {
                  audioCubit.setSleepTimer(minutes);
                  Navigator.of(context).pop();
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _openDownloadsPage(BuildContext context) {
    final audioCubit = context.read<AudioCubit>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider<AudioCubit>.value(
          value: audioCubit,
          child: AudioDownloadsStoragePage(chapters: chapters),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;

    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        final audioCubit = context.read<AudioCubit>();
        final reciterLabel = ReciterSorter.formatDisplayName(
          state.selectedReciter,
          languageCode: lang,
        );

        return Container(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 10),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            border: Border(
              top: BorderSide(color: theme.colorScheme.outline),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top row: Reciter selector chip + Mode toggle + Downloads button
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _openReciterSheet(context, state),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.record_voice_over_outlined,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                reciterLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                            const Icon(Icons.expand_less_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final nextMode =
                          state.playbackMode == AudioPlaybackMode.verseByVerse
                              ? AudioPlaybackMode.fullSurah
                              : AudioPlaybackMode.verseByVerse;
                      audioCubit.setPlaybackMode(nextMode);
                    },
                    child: Text(
                      state.playbackMode == AudioPlaybackMode.verseByVerse
                          ? l10n.audioModeVerseByVerse
                          : l10n.audioModeFullSurah,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.audioDownloadsTitle,
                    icon: const Icon(Icons.download_for_offline_outlined),
                    onPressed: () => _openDownloadsPage(context),
                  ),
                ],
              ),

              // Bottom row: Transport controls + Speed + Repeat + Sleep Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Speed Cycle Button (0.75x .. 1.5x)
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(40, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      const speeds = AudioSpeedPresets.values;
                      final currentIdx = speeds.indexOf(state.playbackSpeed);
                      final nextSpeed =
                          speeds[(currentIdx + 1) % speeds.length];
                      audioCubit.setPlaybackSpeed(nextSpeed);
                    },
                    child: Text('${state.playbackSpeed}x'),
                  ),

                  // Previous Verse
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.skip_previous_rounded),
                    onPressed: state.currentQueueIndex > 0
                        ? audioCubit.skipToPreviousTrack
                        : null,
                  ),

                  // Play / Pause Button
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.lantern,
                      foregroundColor: AppColors.night,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () => audioCubit.togglePlayPause(
                      currentSurahNumber: currentSurahNumber,
                      currentSurahName: currentSurahName,
                      versesCount: currentSurahVersesCount,
                      startAyah: currentAyahNumber,
                    ),
                    child: Icon(
                      state.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 26,
                    ),
                  ),

                  // Next Verse
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.skip_next_rounded),
                    onPressed: state.currentQueueIndex + 1 < state.queue.length
                        ? audioCubit.skipToNextTrack
                        : null,
                  ),

                  // Repeat Verse/Range & Sleep Timer
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        tooltip: l10n.audioRepeatTitle,
                        icon: Icon(
                          Icons.repeat_rounded,
                          color: state.repeatConfig.enabled
                              ? AppColors.lantern
                              : null,
                        ),
                        onPressed: () =>
                            _openRepeatAndOptionsDialog(context, state),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        tooltip: l10n.audioSleepTimerTitle,
                        icon: Icon(
                          Icons.bedtime_outlined,
                          color: state.sleepTimerRemainingMinutes != null
                              ? AppColors.lantern
                              : null,
                        ),
                        onPressed: () => _openSleepTimerSheet(context, state),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
