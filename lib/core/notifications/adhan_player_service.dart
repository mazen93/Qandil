import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

/// Plays the full bundled `assets/audio/adhan.mp3` (2m13s) using `just_audio`
/// when the user taps an Adhan notification or triggers full Adhan playback.
///
/// Why this exists alongside the OS notification sound:
/// iOS strictly caps notification sounds (`UNNotificationSound`) at 30 seconds
/// and stops them as soon as the user unlocks or taps the notification.
/// Playing the asset via `just_audio` + `audio_session` delivers the complete Adhan.
class AdhanPlayerService {
  AdhanPlayerService({AudioPlayer? player}) : _injectedPlayer = player;

  static const String assetPath = 'assets/audio/adhan.mp3';

  final AudioPlayer? _injectedPlayer;
  AudioPlayer? _player;
  StreamSubscription<PlayerState>? _stateSub;
  final StreamController<bool> _playingController =
      StreamController<bool>.broadcast();
  bool _isPlaying = false;

  Stream<bool> get isPlayingStream => _playingController.stream;
  bool get isPlaying => _isPlaying;

  AudioPlayer _ensurePlayer() {
    final existing = _player;
    if (existing != null) return existing;

    final created = _injectedPlayer ?? AudioPlayer();
    _player = created;
    _stateSub = created.playerStateStream.listen((state) {
      final playingNow =
          state.playing && state.processingState != ProcessingState.completed;
      if (_isPlaying != playingNow) {
        _isPlaying = playingNow;
        _playingController.add(playingNow);
      }
      if (state.processingState == ProcessingState.completed) {
        unawaited(created.stop());
      }
    });
    return created;
  }

  /// Plays the full Adhan audio from `assets/audio/adhan.mp3`.
  Future<void> playFullAdhan({String title = 'Qandil — Adhan'}) async {
    final player = _ensurePlayer();

    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
      await session.setActive(true);
    } catch (_) {
      // Safe fallback in test harnesses without native audio session channel.
    }

    try {
      await player.stop();
      try {
        await player.setAudioSource(
          AudioSource.asset(
            assetPath,
            tag: MediaItem(
              id: 'qandil_adhan',
              album: 'Qandil',
              title: title,
              artist: 'Adhan',
            ),
          ),
        );
      } catch (_) {
        // Fallback if JustAudioBackground was not initialized.
        await player.setAsset(assetPath);
      }
      await player.play();
    } catch (_) {
      // Safe fallback if asset or audio hardware is unavailable.
    }
  }

  /// Stops any currently playing Adhan audio.
  Future<void> stop() async {
    try {
      await _player?.stop();
    } catch (_) {}
  }

  Future<void> dispose() async {
    await _stateSub?.cancel();
    await _playingController.close();
    await _player?.dispose();
  }
}
