import 'package:flutter/foundation.dart';

/// Playback mode in the Phase 4 Quran Audio player.
enum AudioPlaybackMode {
  verseByVerse,
  fullSurah,
}

/// Supported playback speed presets (`0.75x` to `1.5x`).
abstract final class AudioSpeedPresets {
  static const List<double> values = [0.75, 1.0, 1.25, 1.5];

  static double clampSpeed(double speed) {
    return speed.clamp(0.75, 1.5);
  }
}

/// Represents a single playable item in the audio queue (either a single verse or a full surah).
@immutable
class AudioQueueTrack {
  const AudioQueueTrack({
    required this.id,
    required this.surahNumber,
    required this.surahName,
    required this.reciterId,
    required this.reciterName,
    required this.remoteUrl,
    this.verseKey,
    this.ayahNumber,
    this.localFilePath,
  });

  final String id;
  final int surahNumber;
  final String surahName;
  final int reciterId;
  final String reciterName;
  final String remoteUrl;
  final String? verseKey; // Null when playing a continuous full-surah stream
  final int? ayahNumber;
  final String? localFilePath;

  bool get isOfflineFile =>
      localFilePath != null && localFilePath!.trim().isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioQueueTrack &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          surahNumber == other.surahNumber &&
          surahName == other.surahName &&
          reciterId == other.reciterId &&
          reciterName == other.reciterName &&
          remoteUrl == other.remoteUrl &&
          verseKey == other.verseKey &&
          ayahNumber == other.ayahNumber &&
          localFilePath == other.localFilePath;

  @override
  int get hashCode => Object.hash(
        id,
        surahNumber,
        surahName,
        reciterId,
        reciterName,
        remoteUrl,
        verseKey,
        ayahNumber,
        localFilePath,
      );
}

/// Configuration for repeating a single verse or a range of verses (`startAyah`..`endAyah`) `repeatCount` times.
@immutable
class AudioRepeatRangeConfig {
  const AudioRepeatRangeConfig({
    this.enabled = false,
    this.startAyah = 1,
    this.endAyah = 1,
    this.repeatCount = 1,
    this.completedCycles = 0,
  });

  final bool enabled;
  final int startAyah;
  final int endAyah;

  /// Number of times to play the range (e.g. 2 means play twice total).
  final int repeatCount;
  final int completedCycles;

  AudioRepeatRangeConfig copyWith({
    bool? enabled,
    int? startAyah,
    int? endAyah,
    int? repeatCount,
    int? completedCycles,
  }) {
    return AudioRepeatRangeConfig(
      enabled: enabled ?? this.enabled,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      repeatCount: repeatCount ?? this.repeatCount,
      completedCycles: completedCycles ?? this.completedCycles,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioRepeatRangeConfig &&
          runtimeType == other.runtimeType &&
          enabled == other.enabled &&
          startAyah == other.startAyah &&
          endAyah == other.endAyah &&
          repeatCount == other.repeatCount &&
          completedCycles == other.completedCycles;

  @override
  int get hashCode => Object.hash(
        enabled,
        startAyah,
        endAyah,
        repeatCount,
        completedCycles,
      );
}

/// Status of a user-initiated offline surah audio download in app-private storage.
enum AudioDownloadStatus {
  notDownloaded,
  downloading,
  paused,
  completed,
  failed,
}

/// Domain model representing a per-surah offline audio download with reciter credit and byte size.
@immutable
class SurahAudioDownloadItem {
  const SurahAudioDownloadItem({
    required this.reciterId,
    required this.reciterName,
    required this.surahNumber,
    required this.surahName,
    required this.status,
    required this.progress,
    required this.downloadedBytes,
    required this.totalBytes,
    required this.localPath,
  });

  final int reciterId;
  final String reciterName;
  final int surahNumber;
  final String surahName;
  final AudioDownloadStatus status;
  final double progress;
  final int downloadedBytes;
  final int totalBytes;
  final String localPath;

  SurahAudioDownloadItem copyWith({
    AudioDownloadStatus? status,
    double? progress,
    int? downloadedBytes,
    int? totalBytes,
    String? localPath,
  }) {
    return SurahAudioDownloadItem(
      reciterId: reciterId,
      reciterName: reciterName,
      surahNumber: surahNumber,
      surahName: surahName,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      downloadedBytes: downloadedBytes ?? this.downloadedBytes,
      totalBytes: totalBytes ?? this.totalBytes,
      localPath: localPath ?? this.localPath,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahAudioDownloadItem &&
          runtimeType == other.runtimeType &&
          reciterId == other.reciterId &&
          reciterName == other.reciterName &&
          surahNumber == other.surahNumber &&
          surahName == other.surahName &&
          status == other.status &&
          progress == other.progress &&
          downloadedBytes == other.downloadedBytes &&
          totalBytes == other.totalBytes &&
          localPath == other.localPath;

  @override
  int get hashCode => Object.hash(
        reciterId,
        reciterName,
        surahNumber,
        surahName,
        status,
        progress,
        downloadedBytes,
        totalBytes,
        localPath,
      );
}
