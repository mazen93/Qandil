import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../../../core/notifications/adhan_player_service.dart';
import '../../domain/entities/audio_entities.dart';

/// Gateway interface abstracting platform audio hardware so [AudioCubit] is 100% unit-testable.
abstract interface class AudioPlayerGateway {
  Stream<void> get onTrackCompleted;

  Stream<bool> get onPlayingChanged;

  Future<void> playTrack(AudioQueueTrack track, {required double speed});

  Future<void> pause();

  Future<void> resume();

  Future<void> stop();

  Future<void> setSpeed(double speed);

  Future<void> dispose();
}

/// Production implementation of [AudioPlayerGateway] powered by `just_audio`,
/// `just_audio_background` (lock-screen/notification controls), and `audio_session`
/// (phone call and other-audio interruption handling + auto-resume).
class QuranAudioPlayerService implements AudioPlayerGateway {
  QuranAudioPlayerService({
    AudioPlayer? player,
    AdhanPlayerService? adhanPlayer,
  })  : _adhanPlayer = adhanPlayer,
        _ownsPlayer = player == null && adhanPlayer == null,
        _player = player ?? adhanPlayer?.sharedPlayer ?? AudioPlayer() {
    _initStreamsAndAudioSession();
  }

  final AudioPlayer _player;
  final AdhanPlayerService? _adhanPlayer;
  final bool _ownsPlayer;
  final StreamController<void> _completedController =
      StreamController<void>.broadcast();
  final StreamController<bool> _playingController =
      StreamController<bool>.broadcast();

  StreamSubscription<PlayerState>? _playerStateSub;
  StreamSubscription<AudioInterruptionEvent>? _interruptionSub;
  StreamSubscription<void>? _becomingNoisySub;
  bool _wasPlayingBeforeInterruption = false;

  @override
  Stream<void> get onTrackCompleted => _completedController.stream;

  @override
  Stream<bool> get onPlayingChanged => _playingController.stream;

  Future<void> _initStreamsAndAudioSession() async {
    _playerStateSub = _player.playerStateStream.listen((state) {
      if (_adhanPlayer?.isAdhanActive ?? false) {
        _playingController.add(false);
        return;
      }
      _playingController.add(state.playing);
      if (state.processingState == ProcessingState.completed) {
        _completedController.add(null);
      }
    });

    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());

      // Handle interruptions (incoming phone calls, alarms, other audio apps)
      _interruptionSub = session.interruptionEventStream.listen((event) async {
        if (event.begin) {
          _wasPlayingBeforeInterruption = _player.playing;
          if (_player.playing) {
            await _player.pause();
          }
        } else {
          // Interruption ended -> resume playback if we were playing before the call/interruption
          if (_wasPlayingBeforeInterruption &&
              (event.type == AudioInterruptionType.pause ||
                  event.type == AudioInterruptionType.duck)) {
            _wasPlayingBeforeInterruption = false;
            await _player.play();
          }
        }
      });

      // Pause automatically if headphones are unplugged
      _becomingNoisySub = session.becomingNoisyEventStream.listen((_) async {
        if (_player.playing) {
          await _player.pause();
        }
      });
    } catch (_) {
      // Safe fallback in test harnesses without native audio session channel.
    }
  }

  @override
  Future<void> playTrack(AudioQueueTrack track, {required double speed}) async {
    final mediaItem = MediaItem(
      id: track.id,
      album: track.surahName,
      title: track.verseKey != null
          ? '${track.surahName} (${track.verseKey})'
          : track.surahName,
      artist: track.reciterName,
    );

    final audioSource = track.isOfflineFile
        ? AudioSource.file(track.localFilePath!, tag: mediaItem)
        : AudioSource.uri(Uri.parse(track.remoteUrl), tag: mediaItem);

    try {
      await _adhanPlayer?.relinquishToQuran();
      await _player.setVolume(1.0);
      await _player.setAudioSource(audioSource);
      await _player.setSpeed(AudioSpeedPresets.clampSpeed(speed));
      await _player.play();
    } on PlayerInterruptedException {
      // Safe: user skipped to another track while the current source was loading.
    } catch (e) {
      if (e.toString().contains('Connection aborted') ||
          e.toString().contains('Loading interrupted')) {
        return;
      }
      rethrow;
    }
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> resume() async {
    await _adhanPlayer?.relinquishToQuran();
    await _player.setVolume(1.0);
    await _player.play();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(AudioSpeedPresets.clampSpeed(speed));
  }

  @override
  Future<void> dispose() async {
    await _playerStateSub?.cancel();
    await _interruptionSub?.cancel();
    await _becomingNoisySub?.cancel();
    await _completedController.close();
    await _playingController.close();
    if (_ownsPlayer) {
      await _player.dispose();
    }
  }
}
