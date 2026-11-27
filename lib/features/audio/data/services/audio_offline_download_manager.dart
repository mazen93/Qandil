import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/result/result.dart';
import '../../../quran/domain/entities/quran_entities.dart';
import '../../domain/entities/audio_entities.dart';
import '../repositories/audio_repository_impl.dart';

/// Manages user-initiated per-surah offline audio downloads into app-private storage:
/// - Progress tracking (`0.0`..`1.0`)
/// - Pause and Resume (HTTP `Range: bytes=<offset>-` appending to `.part` file)
/// - Storage usage computation & file deletion
/// - Reciter credit persisted in Drift `downloads` table (`packId` stores reciter attribution)
class AudioOfflineDownloadManager {
  AudioOfflineDownloadManager({
    required AppDatabase database,
    required http.Client httpClient,
    Future<Directory> Function()? storageDirProvider,
  })  : _database = database,
        _httpClient = httpClient,
        _storageDirProvider =
            storageDirProvider ?? getApplicationSupportDirectory;

  final AppDatabase _database;
  final http.Client _httpClient;
  final Future<Directory> Function() _storageDirProvider;

  /// Active pause flags keyed by `${reciterId}_$surahNumber`.
  final Map<String, bool> _pausedJobs = {};

  String _jobKey(int reciterId, int surahNumber) => '${reciterId}_$surahNumber';

  /// Lists all recorded offline audio downloads from Drift.
  Future<List<SurahAudioDownloadItem>> getDownloadedItems({
    required List<QuranChapter> chapters,
    required List<RecitationResource> reciters,
  }) async {
    final rows = await (_database.select(_database.downloads)
          ..where((t) => t.itemType.equals('audio'))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();

    final items = <SurahAudioDownloadItem>[];
    for (final row in rows) {
      final recId = row.reciterId ?? 6;
      final surahNum = row.surahNumber ?? 1;
      final surahName = _findSurahName(chapters, surahNum);
      final reciterName = row.packId ?? _findReciterName(reciters, recId);

      var actualBytes = row.totalBytes;
      if (row.localPath.isNotEmpty) {
        final f = File(row.localPath);
        if (f.existsSync()) {
          actualBytes = f.lengthSync();
        }
      }

      items.add(
        SurahAudioDownloadItem(
          reciterId: recId,
          reciterName: reciterName,
          surahNumber: surahNum,
          surahName: surahName,
          status: _parseStatus(row.status),
          progress: row.progress,
          downloadedBytes: (actualBytes * row.progress).round(),
          totalBytes: actualBytes,
          localPath: row.localPath,
        ),
      );
    }
    return items;
  }

  /// Calculates total bytes used on disk by all downloaded offline audio files.
  Future<int> calculateTotalStorageUsedBytes() async {
    final rows = await (_database.select(_database.downloads)
          ..where((t) => t.itemType.equals('audio')))
        .get();

    var total = 0;
    for (final row in rows) {
      if (row.localPath.isEmpty) continue;
      final file = File(row.localPath);
      if (file.existsSync()) {
        total += file.lengthSync();
      } else {
        final partFile = File('${row.localPath}.part');
        if (partFile.existsSync()) {
          total += partFile.lengthSync();
        } else {
          total += row.totalBytes;
        }
      }
    }
    return total;
  }

  /// Requests pausing an active download for [reciterId] and [surahNumber].
  Future<void> pauseDownload({
    required int reciterId,
    required int surahNumber,
  }) async {
    _pausedJobs[_jobKey(reciterId, surahNumber)] = true;
    await (_database.update(_database.downloads)
          ..where(
            (t) =>
                t.itemType.equals('audio') &
                t.reciterId.equals(reciterId) &
                t.surahNumber.equals(surahNumber),
          ))
        .write(
      DownloadsCompanion(
        status: const Value('paused'),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  /// Deletes a downloaded (or partially downloaded) surah audio file and removes its Drift record.
  Future<void> deleteDownload({
    required int reciterId,
    required int surahNumber,
  }) async {
    _pausedJobs[_jobKey(reciterId, surahNumber)] = true;

    final existing = await (_database.select(_database.downloads)
          ..where(
            (t) =>
                t.itemType.equals('audio') &
                t.reciterId.equals(reciterId) &
                t.surahNumber.equals(surahNumber),
          ))
        .getSingleOrNull();

    if (existing != null && existing.localPath.isNotEmpty) {
      final file = File(existing.localPath);
      if (file.existsSync()) {
        await file.delete();
      }
      final partFile = File('${existing.localPath}.part');
      if (partFile.existsSync()) {
        await partFile.delete();
      }
    }

    await (_database.delete(_database.downloads)
          ..where(
            (t) =>
                t.itemType.equals('audio') &
                t.reciterId.equals(reciterId) &
                t.surahNumber.equals(surahNumber),
          ))
        .go();
  }

  /// Starts or resumes downloading a surah audio file into app-private storage,
  /// emitting [SurahAudioDownloadItem] snapshots as chunks arrive.
  Stream<Result<SurahAudioDownloadItem>> startOrResumeDownload({
    required RecitationResource reciter,
    required int surahNumber,
    required String surahName,
    String? remoteAudioUrl,
  }) async* {
    final key = _jobKey(reciter.id, surahNumber);
    _pausedJobs[key] = false;

    final baseDir = await _storageDirProvider();
    final audioDir = Directory(
      p.join(baseDir.path, 'offline_audio', '${reciter.id}'),
    );
    if (!audioDir.existsSync()) {
      await audioDir.create(recursive: true);
    }

    final targetPath = p.join(
      audioDir.path,
      '${surahNumber.toString().padLeft(3, '0')}.mp3',
    );
    final partFile = File('$targetPath.part');
    final finalFile = File(targetPath);

    var existingBytes = 0;
    if (partFile.existsSync()) {
      existingBytes = partFile.lengthSync();
    } else if (finalFile.existsSync()) {
      final completedSize = finalFile.lengthSync();
      await _upsertDownloadRow(
        reciter: reciter,
        surahNumber: surahNumber,
        localPath: targetPath,
        status: 'completed',
        progress: 1.0,
        totalBytes: completedSize,
      );
      yield Success(
        SurahAudioDownloadItem(
          reciterId: reciter.id,
          reciterName: reciter.reciterName,
          surahNumber: surahNumber,
          surahName: surahName,
          status: AudioDownloadStatus.completed,
          progress: 1.0,
          downloadedBytes: completedSize,
          totalBytes: completedSize,
          localPath: targetPath,
        ),
      );
      return;
    }

    final url = remoteAudioUrl ??
        AudioRepositoryImpl.fallbackChapterAudioUrl(reciter.id, surahNumber);

    try {
      final request = http.Request('GET', Uri.parse(url));
      if (existingBytes > 0) {
        request.headers['Range'] = 'bytes=$existingBytes-';
      }

      final streamedResponse = await _httpClient.send(request);
      if (streamedResponse.statusCode < 200 ||
          streamedResponse.statusCode >= 300) {
        await _upsertDownloadRow(
          reciter: reciter,
          surahNumber: surahNumber,
          localPath: targetPath,
          status: 'failed',
          progress: 0.0,
          totalBytes: existingBytes,
        );
        yield FailureResult(
          ServerFailure(
            'Audio download failed with HTTP ${streamedResponse.statusCode}.',
          ),
        );
        return;
      }

      final contentLength = streamedResponse.contentLength ?? 0;
      final totalBytes =
          contentLength > 0 ? existingBytes + contentLength : existingBytes;

      final sink = partFile.openWrite(
        mode: existingBytes > 0 ? FileMode.append : FileMode.write,
      );

      var downloadedBytes = existingBytes;

      await for (final chunk in streamedResponse.stream) {
        if (_pausedJobs[key] == true) {
          await sink.flush();
          await sink.close();
          final pausedProgress = totalBytes > 0
              ? (downloadedBytes / totalBytes).clamp(0.0, 1.0)
              : 0.0;
          await _upsertDownloadRow(
            reciter: reciter,
            surahNumber: surahNumber,
            localPath: targetPath,
            status: 'paused',
            progress: pausedProgress,
            totalBytes: totalBytes,
          );
          yield Success(
            SurahAudioDownloadItem(
              reciterId: reciter.id,
              reciterName: reciter.reciterName,
              surahNumber: surahNumber,
              surahName: surahName,
              status: AudioDownloadStatus.paused,
              progress: pausedProgress,
              downloadedBytes: downloadedBytes,
              totalBytes: totalBytes,
              localPath: targetPath,
            ),
          );
          return;
        }

        sink.add(chunk);
        downloadedBytes += chunk.length;
        final progress = totalBytes > 0
            ? (downloadedBytes / totalBytes).clamp(0.0, 0.99)
            : 0.5;

        await _upsertDownloadRow(
          reciter: reciter,
          surahNumber: surahNumber,
          localPath: targetPath,
          status: 'active',
          progress: progress,
          totalBytes: totalBytes > 0 ? totalBytes : downloadedBytes,
        );

        yield Success(
          SurahAudioDownloadItem(
            reciterId: reciter.id,
            reciterName: reciter.reciterName,
            surahNumber: surahNumber,
            surahName: surahName,
            status: AudioDownloadStatus.downloading,
            progress: progress,
            downloadedBytes: downloadedBytes,
            totalBytes: totalBytes > 0 ? totalBytes : downloadedBytes,
            localPath: targetPath,
          ),
        );
      }

      await sink.flush();
      await sink.close();

      if (partFile.existsSync()) {
        await partFile.rename(targetPath);
      }

      final finalBytes =
          finalFile.existsSync() ? finalFile.lengthSync() : downloadedBytes;

      await _upsertDownloadRow(
        reciter: reciter,
        surahNumber: surahNumber,
        localPath: targetPath,
        status: 'completed',
        progress: 1.0,
        totalBytes: finalBytes,
      );

      yield Success(
        SurahAudioDownloadItem(
          reciterId: reciter.id,
          reciterName: reciter.reciterName,
          surahNumber: surahNumber,
          surahName: surahName,
          status: AudioDownloadStatus.completed,
          progress: 1.0,
          downloadedBytes: finalBytes,
          totalBytes: finalBytes,
          localPath: targetPath,
        ),
      );
    } catch (e) {
      await _upsertDownloadRow(
        reciter: reciter,
        surahNumber: surahNumber,
        localPath: targetPath,
        status: 'failed',
        progress: 0.0,
        totalBytes: existingBytes,
      );
      yield FailureResult(
        NetworkFailure('Failed to download surah audio: $e'),
      );
    }
  }

  Future<void> _upsertDownloadRow({
    required RecitationResource reciter,
    required int surahNumber,
    required String localPath,
    required String status,
    required double progress,
    required int totalBytes,
  }) async {
    final existing = await (_database.select(_database.downloads)
          ..where(
            (t) =>
                t.itemType.equals('audio') &
                t.reciterId.equals(reciter.id) &
                t.surahNumber.equals(surahNumber),
          ))
        .getSingleOrNull();

    final creditLabel = reciter.style.isNotEmpty
        ? '${reciter.reciterName} (${reciter.style})'
        : reciter.reciterName;

    final now = DateTime.now().toUtc();
    if (existing == null) {
      await _database.into(_database.downloads).insert(
            DownloadsCompanion.insert(
              itemType: 'audio',
              reciterId: Value(reciter.id),
              surahNumber: Value(surahNumber),
              packId: Value(creditLabel),
              localPath: localPath,
              status: Value(status),
              progress: Value(progress),
              totalBytes: Value(totalBytes),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
    } else {
      await (_database.update(_database.downloads)
            ..where((t) => t.id.equals(existing.id)))
          .write(
        DownloadsCompanion(
          packId: Value(creditLabel),
          localPath: Value(localPath),
          status: Value(status),
          progress: Value(progress),
          totalBytes: Value(totalBytes),
          updatedAt: Value(now),
        ),
      );
    }
  }

  AudioDownloadStatus _parseStatus(String raw) {
    return switch (raw) {
      'active' || 'downloading' => AudioDownloadStatus.downloading,
      'paused' => AudioDownloadStatus.paused,
      'completed' => AudioDownloadStatus.completed,
      'failed' => AudioDownloadStatus.failed,
      _ => AudioDownloadStatus.notDownloaded,
    };
  }

  String _findSurahName(List<QuranChapter> chapters, int surahNumber) {
    for (final c in chapters) {
      if (c.id == surahNumber) return c.nameArabic;
    }
    return surahNumber == 1
        ? 'الفاتحة'
        : (surahNumber == 2 ? 'البقرة' : 'سورة $surahNumber');
  }

  String _findReciterName(List<RecitationResource> reciters, int reciterId) {
    for (final r in reciters) {
      if (r.id == reciterId) return r.reciterName;
    }
    return 'Mahmoud Khalil Al-Husary';
  }
}
