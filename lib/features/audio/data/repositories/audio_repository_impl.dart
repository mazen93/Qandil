import 'dart:io';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/network/quran_api_client.dart';
import '../../../../core/result/result.dart';
import '../../../quran/domain/entities/quran_entities.dart';
import '../../../quran/domain/repositories/quran_repository.dart';
import '../../domain/entities/audio_entities.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../domain/services/reciter_sorter.dart';

/// Concrete implementation of [AudioRepository] backed by Quran Foundation Content API v4
/// and local Drift offline download records.
class AudioRepositoryImpl implements AudioRepository {
  const AudioRepositoryImpl({
    required QuranRepository quranRepository,
    required QuranApiClient apiClient,
    required AppDatabase database,
  })  : _quranRepository = quranRepository,
        _apiClient = apiClient,
        _database = database;

  final QuranRepository _quranRepository;
  final QuranApiClient _apiClient;
  final AppDatabase _database;

  static const String _verseAudioCdnBase = 'https://verses.quran.com/';

  /// Fallback CDN map for common reciter IDs when offline or when pre-production
  /// returns relative paths. Uses standard 3-digit padded MP3 filenames on download.quranicaudio.com.
  static String fallbackChapterAudioUrl(int reciterId, int surahNumber) {
    final s = surahNumber.toString().padLeft(3, '0');
    final folder = switch (reciterId) {
      6 || 12 => 'mahmood_khaleel_al-husaree',
      8 || 9 => 'muhammad_siddeeq_al-minshaawee',
      1 || 2 => 'abdulbaset_mujawwad',
      3 => 'abdurrahmaan_as-sudais',
      _ => 'mishaari_raashid_al_3afaasee',
    };
    return 'https://download.quranicaudio.com/quran/$folder/$s.mp3';
  }

  static String fallbackVerseAudioUrl(
    int reciterId,
    int surahNumber,
    int ayahNumber,
  ) {
    final s = surahNumber.toString().padLeft(3, '0');
    final a = ayahNumber.toString().padLeft(3, '0');
    final prefix = switch (reciterId) {
      6 || 12 => 'Husary_128kbps',
      8 || 9 => 'Minshawy_Murattal_128kbps',
      1 || 2 => 'Abdul_Basit_Murattal_192kbps',
      _ => 'Alafasy_128kbps',
    };
    return 'https://everyayah.com/data/$prefix/$s$a.mp3';
  }

  @override
  Future<Result<List<RecitationResource>>> getReciters({
    String languageCode = 'ar',
  }) async {
    final result =
        await _quranRepository.getRecitationsList(languageCode: languageCode);
    return switch (result) {
      FailureResult(:final failure) => FailureResult(failure),
      Success(:final value) => Success(
          ReciterSorter.sortEgyptianFirst(value),
        ),
    };
  }

  @override
  Future<Result<List<AudioQueueTrack>>> getVerseByVerseQueue({
    required int surahNumber,
    required String surahName,
    required int versesCount,
    required RecitationResource reciter,
  }) async {
    final apiResult = await _apiClient.getJson(
      '/recitations/${reciter.id}/by_chapter/$surahNumber',
      queryParameters: {'per_page': '300'},
    );

    if (apiResult case Success(:final value)) {
      final rawFiles = value['audio_files'];
      if (rawFiles is List && rawFiles.isNotEmpty) {
        final tracks = <AudioQueueTrack>[];
        for (final item in rawFiles.whereType<Map<String, dynamic>>()) {
          final verseKey = item['verse_key'] as String? ?? '';
          final rawUrl = item['url'] as String? ?? '';
          if (verseKey.isEmpty || rawUrl.isEmpty) continue;

          final parts = verseKey.split(':');
          final ayahNum = parts.length > 1 ? (int.tryParse(parts[1]) ?? 1) : 1;
          final resolvedUrl = rawUrl.startsWith('http')
              ? rawUrl
              : '$_verseAudioCdnBase${rawUrl.replaceFirst(RegExp(r'^/+'), '')}';

          tracks.add(
            AudioQueueTrack(
              id: '${reciter.id}_$verseKey',
              surahNumber: surahNumber,
              surahName: surahName,
              reciterId: reciter.id,
              reciterName: reciter.reciterName,
              remoteUrl: resolvedUrl,
              verseKey: verseKey,
              ayahNumber: ayahNum,
            ),
          );
        }
        if (tracks.isNotEmpty) {
          return Success(tracks);
        }
      }
    }

    // Deterministic fallback verse-by-verse URLs when pre-production proxy is offline
    final safeCount = versesCount > 0 ? versesCount : 7;
    final fallbackTracks = List<AudioQueueTrack>.generate(safeCount, (idx) {
      final ayah = idx + 1;
      final verseKey = '$surahNumber:$ayah';
      return AudioQueueTrack(
        id: '${reciter.id}_$verseKey',
        surahNumber: surahNumber,
        surahName: surahName,
        reciterId: reciter.id,
        reciterName: reciter.reciterName,
        remoteUrl: fallbackVerseAudioUrl(reciter.id, surahNumber, ayah),
        verseKey: verseKey,
        ayahNumber: ayah,
      );
    });
    return Success(fallbackTracks);
  }

  @override
  Future<Result<List<AudioQueueTrack>>> getFullSurahQueue({
    required int surahNumber,
    required String surahName,
    required RecitationResource reciter,
  }) async {
    // 1. Check if this surah is already downloaded for offline playback in app-private storage
    final downloadedRow = await (_database.select(_database.downloads)
          ..where(
            (t) =>
                t.itemType.equals('audio') &
                t.reciterId.equals(reciter.id) &
                t.surahNumber.equals(surahNumber) &
                t.status.equals('completed'),
          ))
        .getSingleOrNull();

    String? verifiedLocalPath;
    if (downloadedRow != null && downloadedRow.localPath.isNotEmpty) {
      final file = File(downloadedRow.localPath);
      if (file.existsSync()) {
        verifiedLocalPath = downloadedRow.localPath;
      }
    }

    // 2. Query remote chapter_recitations endpoint if not available offline
    var remoteUrl = fallbackChapterAudioUrl(reciter.id, surahNumber);
    if (verifiedLocalPath == null) {
      final apiResult = await _apiClient.getJson(
        '/chapter_recitations/${reciter.id}/$surahNumber',
      );
      if (apiResult case Success(:final value)) {
        final audioFileObj = value['audio_file'];
        if (audioFileObj is Map<String, dynamic>) {
          final parsedUrl = audioFileObj['audio_url'] as String? ?? '';
          if (parsedUrl.isNotEmpty) {
            remoteUrl = parsedUrl;
          }
        }
      }
    }

    return Success([
      AudioQueueTrack(
        id: '${reciter.id}_surah_$surahNumber',
        surahNumber: surahNumber,
        surahName: surahName,
        reciterId: reciter.id,
        reciterName: reciter.reciterName,
        remoteUrl: remoteUrl,
        localFilePath: verifiedLocalPath,
      ),
    ]);
  }
}
