import '../../../../core/result/result.dart';
import '../../../quran/domain/entities/quran_entities.dart';
import '../entities/audio_entities.dart';

/// Domain contract for fetching Quran audio tracks (verse-by-verse & full-surah)
/// and managing user-initiated offline surah downloads.
abstract interface class AudioRepository {
  /// Fetches the list of available reciters sorted with Egyptian reciters first.
  Future<Result<List<RecitationResource>>> getReciters({
    String languageCode = 'ar',
  });

  /// Builds a verse-by-verse playback queue for [surahNumber] and [reciter].
  Future<Result<List<AudioQueueTrack>>> getVerseByVerseQueue({
    required int surahNumber,
    required String surahName,
    required int versesCount,
    required RecitationResource reciter,
  });

  /// Builds a single full-surah playback queue track for [surahNumber] and [reciter],
  /// using the downloaded local file in app-private storage if available.
  Future<Result<List<AudioQueueTrack>>> getFullSurahQueue({
    required int surahNumber,
    required String surahName,
    required RecitationResource reciter,
  });
}
