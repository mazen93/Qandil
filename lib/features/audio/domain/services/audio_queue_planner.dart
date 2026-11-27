import 'package:flutter/foundation.dart';

import '../entities/audio_entities.dart';

/// Decision returned by [AudioQueuePlanner.computeNextStep] when a track finishes playing.
@immutable
class AudioQueueAdvanceDecision {
  const AudioQueueAdvanceDecision({
    required this.nextTrackIndex,
    required this.updatedRepeatConfig,
    required this.shouldContinueToNextSurah,
    this.nextSurahNumber,
  });

  /// Index in the current queue to play next, or `null` if the current queue has finished.
  final int? nextTrackIndex;
  final AudioRepeatRangeConfig updatedRepeatConfig;
  final bool shouldContinueToNextSurah;
  final int? nextSurahNumber;

  bool get shouldStop => nextTrackIndex == null && !shouldContinueToNextSurah;
}

/// Pure, deterministic Dart service governing Phase 4 audio queue advancement:
/// - Verse-by-verse and full-surah queue progression
/// - Repeating a single verse or verse range (`startAyah`..`endAyah`) $N$ times
/// - Continuing to the next surah (`1..114`) when the current surah completes
abstract final class AudioQueuePlanner {
  static const int totalSurahsInQuran = 114;

  /// Computes the next action when [currentIndex] in [queue] completes playback.
  static AudioQueueAdvanceDecision computeNextStep({
    required List<AudioQueueTrack> queue,
    required int currentIndex,
    required AudioRepeatRangeConfig repeatConfig,
    required bool continueToNextSurah,
    required int currentSurahNumber,
  }) {
    if (queue.isEmpty || currentIndex < 0 || currentIndex >= queue.length) {
      return AudioQueueAdvanceDecision(
        nextTrackIndex: null,
        updatedRepeatConfig: repeatConfig,
        shouldContinueToNextSurah: false,
      );
    }

    final currentTrack = queue[currentIndex];
    final currentAyah = currentTrack.ayahNumber;

    // 1. Check if a Verse or Verse-Range Repeat is active
    if (repeatConfig.enabled && repeatConfig.repeatCount > 1) {
      // Full-surah repeat case (when ayahNumber is null)
      if (currentAyah == null) {
        final nextCompletedCycles = repeatConfig.completedCycles + 1;
        if (nextCompletedCycles < repeatConfig.repeatCount) {
          return AudioQueueAdvanceDecision(
            nextTrackIndex: currentIndex,
            updatedRepeatConfig: repeatConfig.copyWith(
              completedCycles: nextCompletedCycles,
            ),
            shouldContinueToNextSurah: false,
          );
        }
      } else {
        // Verse-by-verse repeat range [startAyah .. endAyah]
        final startAyah = repeatConfig.startAyah <= repeatConfig.endAyah
            ? repeatConfig.startAyah
            : repeatConfig.endAyah;
        final endAyah = repeatConfig.endAyah >= repeatConfig.startAyah
            ? repeatConfig.endAyah
            : repeatConfig.startAyah;

        if (currentAyah >= startAyah && currentAyah < endAyah) {
          // Still inside the range before reaching endAyah -> advance to next verse in range
          if (currentIndex + 1 < queue.length) {
            return AudioQueueAdvanceDecision(
              nextTrackIndex: currentIndex + 1,
              updatedRepeatConfig: repeatConfig,
              shouldContinueToNextSurah: false,
            );
          }
        } else if (currentAyah == endAyah) {
          // Reached the end of the repeat range -> check if more cycles remain
          final nextCompletedCycles = repeatConfig.completedCycles + 1;
          if (nextCompletedCycles < repeatConfig.repeatCount) {
            final startIndex = _findIndexForAyah(queue, startAyah);
            return AudioQueueAdvanceDecision(
              nextTrackIndex: startIndex ?? 0,
              updatedRepeatConfig: repeatConfig.copyWith(
                completedCycles: nextCompletedCycles,
              ),
              shouldContinueToNextSurah: false,
            );
          } else {
            // Finished all N cycles of this range -> reset cycle counter and advance past endAyah
            final resetConfig = repeatConfig.copyWith(completedCycles: 0);
            if (currentIndex + 1 < queue.length) {
              return AudioQueueAdvanceDecision(
                nextTrackIndex: currentIndex + 1,
                updatedRepeatConfig: resetConfig,
                shouldContinueToNextSurah: false,
              );
            }
          }
        }
      }
    }

    // 2. Normal advance to the next track in the current surah queue
    if (currentIndex + 1 < queue.length) {
      return AudioQueueAdvanceDecision(
        nextTrackIndex: currentIndex + 1,
        updatedRepeatConfig: repeatConfig.copyWith(completedCycles: 0),
        shouldContinueToNextSurah: false,
      );
    }

    // 3. Reached the end of the surah queue -> check if continueToNextSurah is enabled
    if (continueToNextSurah && currentSurahNumber < totalSurahsInQuran) {
      return AudioQueueAdvanceDecision(
        nextTrackIndex: null,
        updatedRepeatConfig: repeatConfig.copyWith(completedCycles: 0),
        shouldContinueToNextSurah: true,
        nextSurahNumber: currentSurahNumber + 1,
      );
    }

    // 4. Stop at end of queue
    return AudioQueueAdvanceDecision(
      nextTrackIndex: null,
      updatedRepeatConfig: repeatConfig.copyWith(completedCycles: 0),
      shouldContinueToNextSurah: false,
    );
  }

  static int? _findIndexForAyah(List<AudioQueueTrack> queue, int ayahNumber) {
    for (var i = 0; i < queue.length; i++) {
      if (queue[i].ayahNumber == ayahNumber) {
        return i;
      }
    }
    return null;
  }
}
