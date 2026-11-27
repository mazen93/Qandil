import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

/// Plays the full bundled `assets/audio/adhan.mp3` (2m13s) using `just_audio`
/// when the user taps an Adhan notification or triggers full Adhan playback.
///
/// Shares a single [AudioPlayer] instance with [QuranAudioPlayerService] because
/// `just_audio_background` strictly enforces a single [AudioPlayer] instance
/// across the entire application.
class AdhanPlayerService {
  AdhanPlayerService({AudioPlayer? player}) : _injectedPlayer = player;

  static const String assetPath = 'assets/audio/adhan.mp3';

  final AudioPlayer? _injectedPlayer;
  AudioPlayer? _player;
  Timer? _scheduledTimer;
  Timer? _keepAliveTimer;
  StreamSubscription<PlayerState>? _stateSub;
  final StreamController<bool> _playingController =
      StreamController<bool>.broadcast();
  bool _isPlaying = false;
  bool _isAdhanActive = false;

  Stream<bool> get isPlayingStream => _playingController.stream;
  bool get isPlaying => _isPlaying;
  bool get isAdhanActive => _isAdhanActive;

  /// Returns the shared [AudioPlayer] instance so [QuranAudioPlayerService]
  /// and [AdhanPlayerService] never create conflicting `just_audio_background` players.
  AudioPlayer get sharedPlayer => _ensurePlayer();

  void _cancelTimers() {
    _scheduledTimer?.cancel();
    _scheduledTimer = null;
    _keepAliveTimer?.cancel();
    _keepAliveTimer = null;
  }

  AudioPlayer _ensurePlayer() {
    final existing = _player;
    if (existing != null) return existing;

    final created = _injectedPlayer ?? AudioPlayer();
    _player = created;
    _stateSub = created.playerStateStream.listen((state) {
      if (!_isAdhanActive) {
        if (_isPlaying) {
          _isPlaying = false;
          _playingController.add(false);
        }
        return;
      }
      final isWaitingForDelay = _scheduledTimer != null;
      final playingNow = !isWaitingForDelay &&
          state.playing &&
          state.processingState != ProcessingState.completed;
      if (_isPlaying != playingNow) {
        _isPlaying = playingNow;
        _playingController.add(playingNow);
      }
      if (!isWaitingForDelay &&
          state.processingState == ProcessingState.completed) {
        _isAdhanActive = false;
        unawaited(created.stop());
      }
    });
    return created;
  }

  /// Plays the full Adhan audio from `assets/audio/adhan.mp3`.
  Future<void> playFullAdhan({String title = 'Qandil — Adhan'}) async {
    _cancelTimers();
    _isAdhanActive = true;
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
      await player.setLoopMode(LoopMode.off);
      await player.setSpeed(1.0);
      await player.setVolume(1.0);
      await _loadAdhanSource(player, title: title);
      // Note: Do NOT await player.play() in just_audio because play()'s Future
      // only completes when the entire 2m13s track finishes or pauses.
      unawaited(player.play());
    } catch (_) {
      // Safe fallback if asset or audio hardware is unavailable.
    }
  }

  /// Keeps the iOS background audio session alive at volume 0 during [delay]
  /// (so locking the device does not suspend the app), then seeks to 0:00 and
  /// plays the full 2m13s Adhan at full volume when [delay] elapses.
  Future<void> scheduleFullAdhan({
    required Duration delay,
    String title = 'Qandil — Adhan',
  }) async {
    if (delay <= Duration.zero) {
      await playFullAdhan(title: title);
      return;
    }

    _cancelTimers();
    _isAdhanActive = true;
    final player = _ensurePlayer();

    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
      await session.setActive(true);
    } catch (_) {}

    try {
      await player.stop();
      await player.setLoopMode(LoopMode.one);
      await player.setSpeed(1.0);
      await _loadAdhanSource(player, title: title);
      await player.setVolume(0.0);

      // Schedule the unmute + restart timer BEFORE calling play() because
      // just_audio's play() Future does not complete until playback ends.
      _scheduledTimer = Timer(delay, () async {
        _scheduledTimer = null;
        _keepAliveTimer?.cancel();
        _keepAliveTimer = null;
        if (!_isAdhanActive) return;
        try {
          final session = await AudioSession.instance;
          await session.setActive(true);
        } catch (_) {}
        try {
          await player.setLoopMode(LoopMode.off);
          await player.seek(Duration.zero);
          await player.setVolume(1.0);
          if (!player.playing) {
            unawaited(player.play());
          }
          if (!_isPlaying) {
            _isPlaying = true;
            _playingController.add(true);
          }
        } catch (_) {}
      });

      // Keep-alive heartbeat during the countdown: if locking the iPhone screen
      // briefly pauses AVAudioSession, immediately resume muted playback so iOS
      // keeps the background audio session alive until _scheduledTimer fires.
      _keepAliveTimer = Timer.periodic(
        const Duration(milliseconds: 500),
        (_) {
          if (!_isAdhanActive || _scheduledTimer == null) {
            _keepAliveTimer?.cancel();
            _keepAliveTimer = null;
            return;
          }
          if (!player.playing) {
            unawaited(player.play());
          }
        },
      );

      unawaited(player.play());
    } catch (_) {}
  }

  Future<void> _loadAdhanSource(
    AudioPlayer player, {
    required String title,
  }) async {
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
  }

  /// Called by [QuranAudioPlayerService] before loading a Quran track so
  /// any scheduled/active Adhan cleanly yields the shared [AudioPlayer].
  Future<void> relinquishToQuran() async {
    _cancelTimers();
    _isAdhanActive = false;
    if (_isPlaying) {
      _isPlaying = false;
      _playingController.add(false);
    }
    try {
      await _player?.setLoopMode(LoopMode.off);
      await _player?.setVolume(1.0);
    } catch (_) {}
  }

  /// Stops any currently playing Adhan audio.
  Future<void> stop() async {
    _cancelTimers();
    final wasAdhan = _isAdhanActive;
    _isAdhanActive = false;
    if (_isPlaying) {
      _isPlaying = false;
      _playingController.add(false);
    }
    try {
      await _player?.setLoopMode(LoopMode.off);
      await _player?.setVolume(1.0);
      if (wasAdhan) {
        await _player?.stop();
      }
    } catch (_) {}
  }

  Future<void> dispose() async {
    _cancelTimers();
    _isAdhanActive = false;
    await _stateSub?.cancel();
    await _playingController.close();
    await _player?.dispose();
  }
}
