import 'dart:async';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:qandil/core/database/app_database.dart';
import 'package:qandil/core/result/result.dart';
import 'package:qandil/features/audio/data/services/audio_offline_download_manager.dart';
import 'package:qandil/features/audio/data/services/quran_audio_player_service.dart';
import 'package:qandil/features/audio/domain/entities/audio_entities.dart';
import 'package:qandil/features/audio/domain/repositories/audio_repository.dart';
import 'package:qandil/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:qandil/features/quran/domain/entities/quran_entities.dart';

class FakeAudioPlayerGateway implements AudioPlayerGateway {
  final StreamController<void> completedController =
      StreamController<void>.broadcast();
  final StreamController<bool> playingController =
      StreamController<bool>.broadcast();

  final List<AudioQueueTrack> playedTracks = [];
  double lastSpeed = 1.0;
  bool isPaused = false;

  @override
  Stream<void> get onTrackCompleted => completedController.stream;

  @override
  Stream<bool> get onPlayingChanged => playingController.stream;

  @override
  Future<void> playTrack(AudioQueueTrack track, {required double speed}) async {
    playedTracks.add(track);
    lastSpeed = speed;
    isPaused = false;
    playingController.add(true);
  }

  @override
  Future<void> pause() async {
    isPaused = true;
    playingController.add(false);
  }

  @override
  Future<void> resume() async {
    isPaused = false;
    playingController.add(true);
  }

  @override
  Future<void> setSpeed(double speed) async {
    lastSpeed = speed;
  }

  @override
  Future<void> stop() async {
    isPaused = true;
    playingController.add(false);
  }

  @override
  Future<void> dispose() async {
    await completedController.close();
    await playingController.close();
  }
}

class FakeAudioRepository implements AudioRepository {
  @override
  Future<Result<List<RecitationResource>>> getReciters({
    String languageCode = 'ar',
  }) async {
    return const Success([
      RecitationResource(
        id: 6,
        reciterName: 'Mahmoud Khalil Al-Husary',
        style: 'Murattal',
        translatedName: 'محمود خليل الحصري',
      ),
    ]);
  }

  @override
  Future<Result<List<AudioQueueTrack>>> getVerseByVerseQueue({
    required int surahNumber,
    required String surahName,
    required int versesCount,
    required RecitationResource reciter,
  }) async {
    return Success([
      AudioQueueTrack(
        id: '6_$surahNumber:1',
        surahNumber: surahNumber,
        surahName: surahName,
        reciterId: reciter.id,
        reciterName: reciter.reciterName,
        remoteUrl: 'https://verses.quran.com/Husary/00${surahNumber}001.mp3',
        verseKey: '$surahNumber:1',
        ayahNumber: 1,
      ),
      AudioQueueTrack(
        id: '6_$surahNumber:2',
        surahNumber: surahNumber,
        surahName: surahName,
        reciterId: reciter.id,
        reciterName: reciter.reciterName,
        remoteUrl: 'https://verses.quran.com/Husary/00${surahNumber}002.mp3',
        verseKey: '$surahNumber:2',
        ayahNumber: 2,
      ),
    ]);
  }

  @override
  Future<Result<List<AudioQueueTrack>>> getFullSurahQueue({
    required int surahNumber,
    required String surahName,
    required RecitationResource reciter,
  }) async {
    return Success([
      AudioQueueTrack(
        id: '6_surah_$surahNumber',
        surahNumber: surahNumber,
        surahName: surahName,
        reciterId: reciter.id,
        reciterName: reciter.reciterName,
        remoteUrl: 'https://download.quranicaudio.com/Husary/$surahNumber.mp3',
      ),
    ]);
  }
}

void main() {
  late AppDatabase db;
  late Directory tempDir;
  late FakeAudioPlayerGateway fakePlayer;
  late AudioOfflineDownloadManager downloadManager;
  late AudioCubit cubit;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    tempDir = await Directory.systemTemp.createTemp('qandil_audio_test_');
    fakePlayer = FakeAudioPlayerGateway();

    final mockHttpClient = MockClient.streaming((request, bodyStream) async {
      final bytes = List<int>.filled(1024, 42);
      return http.StreamedResponse(
        Stream<List<int>>.value(bytes),
        200,
        contentLength: bytes.length,
      );
    });

    downloadManager = AudioOfflineDownloadManager(
      database: db,
      httpClient: mockHttpClient,
      storageDirProvider: () async => tempDir,
    );

    cubit = AudioCubit(
      repository: FakeAudioRepository(),
      playerGateway: fakePlayer,
      downloadManager: downloadManager,
    );
  });

  tearDown(() async {
    await cubit.close();
    await db.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('AudioCubit & Offline Downloads', () {
    test(
        'plays verse-by-verse, highlights activeVerseKey, auto-advances on track completion, and continues to next surah',
        () async {
      await cubit.initialize(defaultReciterId: 6);
      await cubit.startSurahPlayback(
        surahNumber: 1,
        surahName: 'الفاتحة',
        versesCount: 2,
      );

      expect(cubit.state.isPlaying, isTrue);
      expect(cubit.state.activeVerseKey, '1:1');
      expect(fakePlayer.playedTracks.last.verseKey, '1:1');

      // Simulate track 1:1 completing -> advances to 1:2
      fakePlayer.completedController.add(null);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(cubit.state.activeVerseKey, '1:2');

      // Simulate track 1:2 completing -> continues to Surah 2 (2:1)
      fakePlayer.completedController.add(null);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(cubit.state.currentSurahNumber, 2);
      expect(cubit.state.activeVerseKey, '2:1');
    });

    test(
        'adjusts playback speed (0.75x .. 1.5x) and downloads/deletes offline surah audio with reciter credit',
        () async {
      await cubit.initialize(defaultReciterId: 6);

      await cubit.setPlaybackSpeed(1.25);
      expect(cubit.state.playbackSpeed, 1.25);
      expect(fakePlayer.lastSpeed, 1.25);

      // Start offline download for Surah 1
      await cubit.startOrResumeOfflineDownload(
        surahNumber: 1,
        surahName: 'الفاتحة',
      );
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(cubit.state.downloads.length, 1);
      expect(cubit.state.downloads.first.status, AudioDownloadStatus.completed);
      expect(cubit.state.totalStorageUsedBytes, 1024);

      // Verify reciter credit is recorded in Drift downloads table
      final dbRows = await db.select(db.downloads).get();
      expect(dbRows.first.packId, contains('Mahmoud Khalil Al-Husary'));

      // Delete download
      await cubit.deleteOfflineDownload(reciterId: 6, surahNumber: 1);
      expect(cubit.state.downloads, isEmpty);
      expect(cubit.state.totalStorageUsedBytes, 0);
    });
  });
}
