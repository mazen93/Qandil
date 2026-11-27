import 'package:flutter/foundation.dart';

import '../../../quran/domain/entities/quran_entities.dart';
import '../../domain/entities/audio_entities.dart';

/// Immutable state for [AudioCubit].
@immutable
class AudioState {
  const AudioState({
    this.isLoading = false,
    this.isPlaying = false,
    this.playbackMode = AudioPlaybackMode.verseByVerse,
    this.reciters = const [],
    this.selectedReciterId = 6,
    this.queue = const [],
    this.currentQueueIndex = 0,
    this.currentSurahNumber = 1,
    this.currentSurahName = 'الفاتحة',
    this.activeVerseKey,
    this.playbackSpeed = 1.0,
    this.repeatConfig = const AudioRepeatRangeConfig(),
    this.hifzPauseGapSeconds = 0,
    this.continueToNextSurah = true,
    this.sleepTimerRemainingMinutes,
    this.downloads = const [],
    this.totalStorageUsedBytes = 0,
    this.errorMessage,
  });

  final bool isLoading;
  final bool isPlaying;
  final AudioPlaybackMode playbackMode;
  final List<RecitationResource> reciters;
  final int selectedReciterId;
  final List<AudioQueueTrack> queue;
  final int currentQueueIndex;
  final int currentSurahNumber;
  final String currentSurahName;
  final String? activeVerseKey;
  final double playbackSpeed;
  final AudioRepeatRangeConfig repeatConfig;
  final int hifzPauseGapSeconds;
  final bool continueToNextSurah;
  final int? sleepTimerRemainingMinutes;
  final List<SurahAudioDownloadItem> downloads;
  final int totalStorageUsedBytes;
  final String? errorMessage;

  RecitationResource get selectedReciter {
    for (final r in reciters) {
      if (r.id == selectedReciterId) return r;
    }
    if (reciters.isNotEmpty) return reciters.first;
    return const RecitationResource(
      id: 6,
      reciterName: 'Mahmoud Khalil Al-Husary',
      style: 'Murattal',
      translatedName: 'محمود خليل الحصري',
    );
  }

  AudioQueueTrack? get currentTrack {
    if (queue.isEmpty ||
        currentQueueIndex < 0 ||
        currentQueueIndex >= queue.length) {
      return null;
    }
    return queue[currentQueueIndex];
  }

  AudioState copyWith({
    bool? isLoading,
    bool? isPlaying,
    AudioPlaybackMode? playbackMode,
    List<RecitationResource>? reciters,
    int? selectedReciterId,
    List<AudioQueueTrack>? queue,
    int? currentQueueIndex,
    int? currentSurahNumber,
    String? currentSurahName,
    String? activeVerseKey,
    bool clearActiveVerseKey = false,
    double? playbackSpeed,
    AudioRepeatRangeConfig? repeatConfig,
    int? hifzPauseGapSeconds,
    bool? continueToNextSurah,
    int? sleepTimerRemainingMinutes,
    bool clearSleepTimer = false,
    List<SurahAudioDownloadItem>? downloads,
    int? totalStorageUsedBytes,
    String? errorMessage,
  }) {
    return AudioState(
      isLoading: isLoading ?? this.isLoading,
      isPlaying: isPlaying ?? this.isPlaying,
      playbackMode: playbackMode ?? this.playbackMode,
      reciters: reciters ?? this.reciters,
      selectedReciterId: selectedReciterId ?? this.selectedReciterId,
      queue: queue ?? this.queue,
      currentQueueIndex: currentQueueIndex ?? this.currentQueueIndex,
      currentSurahNumber: currentSurahNumber ?? this.currentSurahNumber,
      currentSurahName: currentSurahName ?? this.currentSurahName,
      activeVerseKey:
          clearActiveVerseKey ? null : (activeVerseKey ?? this.activeVerseKey),
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      repeatConfig: repeatConfig ?? this.repeatConfig,
      hifzPauseGapSeconds: hifzPauseGapSeconds ?? this.hifzPauseGapSeconds,
      continueToNextSurah: continueToNextSurah ?? this.continueToNextSurah,
      sleepTimerRemainingMinutes: clearSleepTimer
          ? null
          : (sleepTimerRemainingMinutes ?? this.sleepTimerRemainingMinutes),
      downloads: downloads ?? this.downloads,
      totalStorageUsedBytes:
          totalStorageUsedBytes ?? this.totalStorageUsedBytes,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          isPlaying == other.isPlaying &&
          playbackMode == other.playbackMode &&
          listEquals(reciters, other.reciters) &&
          selectedReciterId == other.selectedReciterId &&
          listEquals(queue, other.queue) &&
          currentQueueIndex == other.currentQueueIndex &&
          currentSurahNumber == other.currentSurahNumber &&
          currentSurahName == other.currentSurahName &&
          activeVerseKey == other.activeVerseKey &&
          playbackSpeed == other.playbackSpeed &&
          repeatConfig == other.repeatConfig &&
          hifzPauseGapSeconds == other.hifzPauseGapSeconds &&
          continueToNextSurah == other.continueToNextSurah &&
          sleepTimerRemainingMinutes == other.sleepTimerRemainingMinutes &&
          listEquals(downloads, other.downloads) &&
          totalStorageUsedBytes == other.totalStorageUsedBytes &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hashAll([
        isLoading,
        isPlaying,
        playbackMode,
        Object.hashAll(reciters),
        selectedReciterId,
        Object.hashAll(queue),
        currentQueueIndex,
        currentSurahNumber,
        currentSurahName,
        activeVerseKey,
        playbackSpeed,
        repeatConfig,
        hifzPauseGapSeconds,
        continueToNextSurah,
        sleepTimerRemainingMinutes,
        Object.hashAll(downloads),
        totalStorageUsedBytes,
        errorMessage,
      ]);
}
