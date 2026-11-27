import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/result/result.dart';
import '../../../quran/domain/entities/quran_entities.dart';
import '../../data/services/audio_offline_download_manager.dart';
import '../../data/services/quran_audio_player_service.dart';
import '../../domain/entities/audio_entities.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../domain/services/audio_queue_planner.dart';
import 'audio_state.dart';

/// Cubit managing Phase 4 Quran Audio playback:
/// - Verse-by-verse and full-surah playback modes
/// - Active verse key broadcasting for reader highlighting & auto-scroll
/// - Repeat verse or verse range $N$ times
/// - Playback speed (`0.75x` to `1.5x`)
/// - Sleep timer
/// - Continue to next surah
/// - Egyptian-first reciters list & default reciter selection
/// - User-initiated offline surah downloads with pause/resume/storage/delete
class AudioCubit extends Cubit<AudioState> {
  AudioCubit({
    required AudioRepository repository,
    required AudioPlayerGateway playerGateway,
    required AudioOfflineDownloadManager downloadManager,
  })  : _repository = repository,
        _player = playerGateway,
        _downloadManager = downloadManager,
        super(const AudioState()) {
    _completedSub = _player.onTrackCompleted.listen((_) {
      _handleTrackCompleted();
    });
    _playingSub = _player.onPlayingChanged.listen((playing) {
      if (!isClosed && state.isPlaying != playing) {
        emit(state.copyWith(isPlaying: playing));
      }
    });
  }

  final AudioRepository _repository;
  final AudioPlayerGateway _player;
  final AudioOfflineDownloadManager _downloadManager;

  StreamSubscription<void>? _completedSub;
  StreamSubscription<bool>? _playingSub;
  StreamSubscription<void>? _downloadSub;
  Timer? _sleepTimer;

  /// Loads the Egyptian-first reciter catalog and offline download items.
  Future<void> initialize({
    int defaultReciterId = 6,
    List<QuranChapter> chapters = const [],
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        selectedReciterId: defaultReciterId,
      ),
    );

    final recitersResult = await _repository.getReciters();
    final reciters = switch (recitersResult) {
      Success(:final value) => value,
      FailureResult() => const <RecitationResource>[],
    };

    var effectiveReciterId = defaultReciterId;
    if (reciters.isNotEmpty &&
        !reciters.any((r) => r.id == effectiveReciterId)) {
      effectiveReciterId = reciters.first.id;
    }

    final downloads = await _downloadManager.getDownloadedItems(
      chapters: chapters,
      reciters: reciters,
    );
    final totalBytes = await _downloadManager.calculateTotalStorageUsedBytes();

    emit(
      state.copyWith(
        isLoading: false,
        reciters: reciters,
        selectedReciterId: effectiveReciterId,
        downloads: downloads,
        totalStorageUsedBytes: totalBytes,
      ),
    );
  }

  /// Selects a new default reciter and restarts playback if currently playing.
  Future<void> selectReciter(int reciterId) async {
    emit(state.copyWith(selectedReciterId: reciterId));
    if (state.isPlaying) {
      await startSurahPlayback(
        surahNumber: state.currentSurahNumber,
        surahName: state.currentSurahName,
        startAyah: state.currentTrack?.ayahNumber ?? 1,
      );
    }
  }

  /// Toggles between `verseByVerse` and `fullSurah` playback modes.
  Future<void> setPlaybackMode(AudioPlaybackMode mode) async {
    if (state.playbackMode == mode) return;
    emit(state.copyWith(playbackMode: mode));
    if (state.isPlaying) {
      await startSurahPlayback(
        surahNumber: state.currentSurahNumber,
        surahName: state.currentSurahName,
      );
    }
  }

  /// Starts playing [surahNumber] from [startAyah] in the active [playbackMode].
  Future<void> startSurahPlayback({
    required int surahNumber,
    required String surahName,
    int versesCount = 7,
    int startAyah = 1,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        currentSurahNumber: surahNumber,
        currentSurahName: surahName,
      ),
    );

    final reciter = state.selectedReciter;
    final Result<List<AudioQueueTrack>> queueResult;

    if (state.playbackMode == AudioPlaybackMode.verseByVerse) {
      queueResult = await _repository.getVerseByVerseQueue(
        surahNumber: surahNumber,
        surahName: surahName,
        versesCount: versesCount,
        reciter: reciter,
      );
    } else {
      queueResult = await _repository.getFullSurahQueue(
        surahNumber: surahNumber,
        surahName: surahName,
        reciter: reciter,
      );
    }

    switch (queueResult) {
      case FailureResult(:final failure):
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      case Success(:final value):
        if (value.isEmpty) {
          emit(state.copyWith(isLoading: false));
          return;
        }
        var targetIndex = 0;
        if (state.playbackMode == AudioPlaybackMode.verseByVerse) {
          for (var i = 0; i < value.length; i++) {
            if (value[i].ayahNumber == startAyah) {
              targetIndex = i;
              break;
            }
          }
        }
        final track = value[targetIndex];
        emit(
          state.copyWith(
            isLoading: false,
            isPlaying: true,
            queue: value,
            currentQueueIndex: targetIndex,
            activeVerseKey: track.verseKey,
            clearActiveVerseKey: track.verseKey == null,
          ),
        );
        try {
          await _player.playTrack(track, speed: state.playbackSpeed);
        } catch (e) {
          if (isClosed) return;
          emit(
            state.copyWith(
              isPlaying: false,
              errorMessage: 'تعذّر تشغيل المقطع الصوتي: $e',
            ),
          );
        }
    }
  }

  Future<void> togglePlayPause({
    required int currentSurahNumber,
    required String currentSurahName,
    int versesCount = 7,
    int startAyah = 1,
  }) async {
    if (state.isPlaying) {
      await _player.pause();
      emit(state.copyWith(isPlaying: false));
      return;
    }

    if (state.queue.isNotEmpty &&
        state.currentSurahNumber == currentSurahNumber) {
      await _player.resume();
      emit(state.copyWith(isPlaying: true));
      return;
    }

    await startSurahPlayback(
      surahNumber: currentSurahNumber,
      surahName: currentSurahName,
      versesCount: versesCount,
      startAyah: startAyah,
    );
  }

  Future<void> skipToNextTrack() async {
    if (state.currentQueueIndex + 1 < state.queue.length) {
      await _playIndex(state.currentQueueIndex + 1);
    }
  }

  Future<void> skipToPreviousTrack() async {
    if (state.currentQueueIndex > 0) {
      await _playIndex(state.currentQueueIndex - 1);
    }
  }

  Future<void> setPlaybackSpeed(double speed) async {
    final clamped = AudioSpeedPresets.clampSpeed(speed);
    emit(state.copyWith(playbackSpeed: clamped));
    await _player.setSpeed(clamped);
  }

  void setRepeatConfig(AudioRepeatRangeConfig config) {
    emit(state.copyWith(repeatConfig: config.copyWith(completedCycles: 0)));
  }

  /// Sets an optional pause gap in seconds (`0..30`) between verse tracks during Hifz range loops
  /// so the learner can recite after the Qari.
  void setHifzPauseGapSeconds(int seconds) {
    emit(state.copyWith(hifzPauseGapSeconds: seconds.clamp(0, 30)));
  }

  /// Convenience helper for Phase 12 Hifz Audio Loop: loops [startAyah]..[endAyah]
  /// for [repeatCount] times with an optional [pauseGapSeconds] pause between verses.
  Future<void> startHifzRangeLoop({
    required int surahNumber,
    required String surahName,
    required int versesCount,
    required int startAyah,
    required int endAyah,
    int repeatCount = 3,
    int pauseGapSeconds = 3,
  }) async {
    final safeStart = startAyah.clamp(1, versesCount);
    final safeEnd = endAyah.clamp(safeStart, versesCount);
    emit(
      state.copyWith(
        playbackMode: AudioPlaybackMode.verseByVerse,
        hifzPauseGapSeconds: pauseGapSeconds.clamp(0, 30),
        repeatConfig: AudioRepeatRangeConfig(
          enabled: true,
          startAyah: safeStart,
          endAyah: safeEnd,
          repeatCount: repeatCount.clamp(1, 99),
          completedCycles: 0,
        ),
      ),
    );
    await startSurahPlayback(
      surahNumber: surahNumber,
      surahName: surahName,
      versesCount: versesCount,
      startAyah: safeStart,
    );
  }

  void setContinueToNextSurah(bool enabled) {
    emit(state.copyWith(continueToNextSurah: enabled));
  }

  /// Sets a sleep timer in [minutes] (or `null` to cancel).
  void setSleepTimer(int? minutes) {
    _sleepTimer?.cancel();
    if (minutes == null || minutes <= 0) {
      emit(state.copyWith(clearSleepTimer: true));
      return;
    }

    emit(state.copyWith(sleepTimerRemainingMinutes: minutes));
    _sleepTimer = Timer(Duration(minutes: minutes), () async {
      await _player.pause();
      if (!isClosed) {
        emit(
          state.copyWith(
            isPlaying: false,
            clearSleepTimer: true,
          ),
        );
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Offline Downloads Management
  // ---------------------------------------------------------------------------

  Future<void> startOrResumeOfflineDownload({
    required int surahNumber,
    required String surahName,
  }) async {
    await _downloadSub?.cancel();
    final completer = Completer<void>();
    _downloadSub = _downloadManager
        .startOrResumeDownload(
      reciter: state.selectedReciter,
      surahNumber: surahNumber,
      surahName: surahName,
    )
        .asyncMap((result) async {
      if (isClosed) return;
      switch (result) {
        case Success(:final value):
          final updatedList = _upsertDownloadItemInList(state.downloads, value);
          final totalBytes =
              await _downloadManager.calculateTotalStorageUsedBytes();
          if (!isClosed) {
            emit(
              state.copyWith(
                downloads: updatedList,
                totalStorageUsedBytes: totalBytes,
              ),
            );
          }
        case FailureResult(:final failure):
          if (!isClosed) {
            emit(state.copyWith(errorMessage: failure.message));
          }
      }
    }).listen(
      (_) {},
      onDone: () {
        if (!completer.isCompleted) completer.complete();
      },
      onError: (_) {
        if (!completer.isCompleted) completer.complete();
      },
    );
    await completer.future;
  }

  Future<void> pauseOfflineDownload({required int surahNumber}) async {
    await _downloadManager.pauseDownload(
      reciterId: state.selectedReciterId,
      surahNumber: surahNumber,
    );
  }

  Future<void> deleteOfflineDownload({
    required int reciterId,
    required int surahNumber,
  }) async {
    await _downloadManager.deleteDownload(
      reciterId: reciterId,
      surahNumber: surahNumber,
    );
    final filtered = state.downloads
        .where(
          (d) => !(d.reciterId == reciterId && d.surahNumber == surahNumber),
        )
        .toList(growable: false);
    final totalBytes = await _downloadManager.calculateTotalStorageUsedBytes();
    emit(
      state.copyWith(
        downloads: filtered,
        totalStorageUsedBytes: totalBytes,
      ),
    );
  }

  Future<void> _handleTrackCompleted() async {
    final decision = AudioQueuePlanner.computeNextStep(
      queue: state.queue,
      currentIndex: state.currentQueueIndex,
      repeatConfig: state.repeatConfig,
      continueToNextSurah: state.continueToNextSurah,
      currentSurahNumber: state.currentSurahNumber,
    );

    emit(state.copyWith(repeatConfig: decision.updatedRepeatConfig));

    if (decision.nextTrackIndex != null) {
      if (state.hifzPauseGapSeconds > 0) {
        await Future<void>.delayed(
          Duration(seconds: state.hifzPauseGapSeconds),
        );
        if (isClosed) return;
      }
      await _playIndex(decision.nextTrackIndex!);
      return;
    }

    if (decision.shouldContinueToNextSurah &&
        decision.nextSurahNumber != null) {
      final nextSurah = decision.nextSurahNumber!;
      await startSurahPlayback(
        surahNumber: nextSurah,
        surahName: 'سورة $nextSurah',
      );
      return;
    }

    await _player.stop();
    emit(
      state.copyWith(
        isPlaying: false,
        clearActiveVerseKey: true,
      ),
    );
  }

  Future<void> _playIndex(int index) async {
    if (index < 0 || index >= state.queue.length) return;
    final track = state.queue[index];
    emit(
      state.copyWith(
        currentQueueIndex: index,
        isPlaying: true,
        activeVerseKey: track.verseKey,
        clearActiveVerseKey: track.verseKey == null,
      ),
    );
    try {
      await _player.playTrack(track, speed: state.playbackSpeed);
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isPlaying: false,
          errorMessage: 'تعذّر تشغيل المقطع الصوتي: $e',
        ),
      );
    }
  }

  List<SurahAudioDownloadItem> _upsertDownloadItemInList(
    List<SurahAudioDownloadItem> current,
    SurahAudioDownloadItem updated,
  ) {
    final result = <SurahAudioDownloadItem>[];
    var replaced = false;
    for (final item in current) {
      if (item.reciterId == updated.reciterId &&
          item.surahNumber == updated.surahNumber) {
        result.add(updated);
        replaced = true;
      } else {
        result.add(item);
      }
    }
    if (!replaced) {
      result.insert(0, updated);
    }
    return result;
  }

  @override
  Future<void> close() async {
    _sleepTimer?.cancel();
    await _completedSub?.cancel();
    await _playingSub?.cancel();
    await _downloadSub?.cancel();
    await _player.dispose();
    return super.close();
  }
}
