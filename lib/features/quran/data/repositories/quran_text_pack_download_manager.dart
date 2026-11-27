import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/quran_entities.dart';
import 'quran_local_repository_impl.dart';
import 'quran_remote_repository_impl.dart';

/// Manages downloading and syncing offline text packs (chapters, verses, translations)
/// into the local Drift database with progress tracking in the `downloads` table.
class QuranTextPackDownloadManager {
  const QuranTextPackDownloadManager({
    required AppDatabase database,
    required QuranRemoteRepositoryImpl remoteRepository,
    required QuranLocalRepositoryImpl localRepository,
  })  : _database = database,
        _remote = remoteRepository,
        _local = localRepository;

  final AppDatabase _database;
  final QuranRemoteRepositoryImpl _remote;
  final QuranLocalRepositoryImpl _local;

  /// Downloads or refreshes a text pack for [chapterNumbers] (e.g., `[1, 2]` in pre-production)
  /// and optional [translationIds], emitting progress updates and recording status in `downloads`.
  Stream<Result<TextPackDownloadProgress>> downloadTextPack({
    required String packId,
    required List<int> chapterNumbers,
    String languageCode = 'ar',
    List<int> translationIds = const [],
  }) async* {
    final totalSteps = chapterNumbers.length + 1; // +1 for chapter catalog
    var completedSteps = 0;

    final downloadRowId = await _database.into(_database.downloads).insert(
          DownloadsCompanion.insert(
            itemType: 'text_pack',
            packId: Value(packId),
            localPath: 'drift://cached_verses/$packId',
            status: const Value('active'),
            progress: const Value(0.0),
          ),
        );

    yield Success(
      TextPackDownloadProgress(
        packId: packId,
        completedSteps: 0,
        totalSteps: totalSteps,
        status: 'active',
      ),
    );

    // Step 1: Fetch and cache chapters catalog
    final chaptersResult =
        await _remote.getChapters(languageCode: languageCode);
    switch (chaptersResult) {
      case FailureResult(:final failure):
        await _updateDownloadStatus(
          downloadRowId,
          status: 'failed',
          progress: 0.0,
        );
        yield FailureResult(failure);
        return;
      case Success(:final value):
        await _local.cacheChapters(value, languageCode: languageCode);
        completedSteps++;
        final fraction = completedSteps / totalSteps;
        await _updateDownloadStatus(
          downloadRowId,
          status: 'active',
          progress: fraction,
        );
        yield Success(
          TextPackDownloadProgress(
            packId: packId,
            completedSteps: completedSteps,
            totalSteps: totalSteps,
            status: 'active',
          ),
        );
    }

    // Step 2..N: Fetch and cache each requested chapter's verses
    for (final chapterNum in chapterNumbers) {
      final versesResult = await _remote.getVersesByChapter(
        chapterNum,
        languageCode: languageCode,
        includeWords: true,
        translationIds: translationIds,
        perPage: 300,
      );

      switch (versesResult) {
        case FailureResult(:final failure):
          await _updateDownloadStatus(
            downloadRowId,
            status: 'failed',
            progress: completedSteps / totalSteps,
          );
          yield FailureResult(failure);
          return;
        case Success(:final value):
          await _local.cacheVerses(value);
          completedSteps++;
          final isDone = completedSteps >= totalSteps;
          final status = isDone ? 'completed' : 'active';
          final fraction = (completedSteps / totalSteps).clamp(0.0, 1.0);
          await _updateDownloadStatus(
            downloadRowId,
            status: status,
            progress: fraction,
          );
          yield Success(
            TextPackDownloadProgress(
              packId: packId,
              completedSteps: completedSteps,
              totalSteps: totalSteps,
              status: status,
            ),
          );
      }
    }
  }

  Future<void> _updateDownloadStatus(
    int id, {
    required String status,
    required double progress,
  }) async {
    await (_database.update(_database.downloads)..where((t) => t.id.equals(id)))
        .write(
      DownloadsCompanion(
        status: Value(status),
        progress: Value(progress),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }
}
