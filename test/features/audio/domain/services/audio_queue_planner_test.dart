import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/audio/domain/entities/audio_entities.dart';
import 'package:qandil/features/audio/domain/services/audio_queue_planner.dart';

void main() {
  final sampleQueue = List<AudioQueueTrack>.generate(7, (idx) {
    final ayah = idx + 1;
    return AudioQueueTrack(
      id: '6_1:$ayah',
      surahNumber: 1,
      surahName: 'الفاتحة',
      reciterId: 6,
      reciterName: 'Mahmoud Khalil Al-Husary',
      remoteUrl: 'https://verses.quran.com/Husary/00100$ayah.mp3',
      verseKey: '1:$ayah',
      ayahNumber: ayah,
    );
  });

  group('AudioQueuePlanner', () {
    test('advances sequentially verse-by-verse when repeat is disabled', () {
      final step1 = AudioQueuePlanner.computeNextStep(
        queue: sampleQueue,
        currentIndex: 0,
        repeatConfig: const AudioRepeatRangeConfig(enabled: false),
        continueToNextSurah: false,
        currentSurahNumber: 1,
      );

      expect(step1.nextTrackIndex, 1);
      expect(step1.shouldContinueToNextSurah, isFalse);
    });

    test(
        'repeats a single verse (e.g. Ayah 2) N times before advancing to Ayah 3',
        () {
      var repeat = const AudioRepeatRangeConfig(
        enabled: true,
        startAyah: 2,
        endAyah: 2,
        repeatCount: 3, // Play Ayah 2 three times total
      );

      // Cycle 1 completes at index 1 (Ayah 2) -> loops back to index 1
      final afterCycle1 = AudioQueuePlanner.computeNextStep(
        queue: sampleQueue,
        currentIndex: 1,
        repeatConfig: repeat,
        continueToNextSurah: false,
        currentSurahNumber: 1,
      );
      expect(afterCycle1.nextTrackIndex, 1);
      expect(afterCycle1.updatedRepeatConfig.completedCycles, 1);
      repeat = afterCycle1.updatedRepeatConfig;

      // Cycle 2 completes at index 1 (Ayah 2) -> loops back to index 1
      final afterCycle2 = AudioQueuePlanner.computeNextStep(
        queue: sampleQueue,
        currentIndex: 1,
        repeatConfig: repeat,
        continueToNextSurah: false,
        currentSurahNumber: 1,
      );
      expect(afterCycle2.nextTrackIndex, 1);
      expect(afterCycle2.updatedRepeatConfig.completedCycles, 2);
      repeat = afterCycle2.updatedRepeatConfig;

      // Cycle 3 completes at index 1 (Ayah 2) -> advances to index 2 (Ayah 3)
      final afterCycle3 = AudioQueuePlanner.computeNextStep(
        queue: sampleQueue,
        currentIndex: 1,
        repeatConfig: repeat,
        continueToNextSurah: false,
        currentSurahNumber: 1,
      );
      expect(afterCycle3.nextTrackIndex, 2);
      expect(afterCycle3.updatedRepeatConfig.completedCycles, 0);
    });

    test(
        'repeats a verse range (Ayah 2 to Ayah 4) N times before advancing to Ayah 5',
        () {
      var repeat = const AudioRepeatRangeConfig(
        enabled: true,
        startAyah: 2,
        endAyah: 4,
        repeatCount: 2,
      );

      // At Ayah 2 (index 1) -> moves to Ayah 3 (index 2)
      final s1 = AudioQueuePlanner.computeNextStep(
        queue: sampleQueue,
        currentIndex: 1,
        repeatConfig: repeat,
        continueToNextSurah: false,
        currentSurahNumber: 1,
      );
      expect(s1.nextTrackIndex, 2);

      // At Ayah 4 (index 3, end of range) -> loops back to Ayah 2 (index 1) for cycle 2
      final s2 = AudioQueuePlanner.computeNextStep(
        queue: sampleQueue,
        currentIndex: 3,
        repeatConfig: repeat,
        continueToNextSurah: false,
        currentSurahNumber: 1,
      );
      expect(s2.nextTrackIndex, 1);
      expect(s2.updatedRepeatConfig.completedCycles, 1);
      repeat = s2.updatedRepeatConfig;

      // After finishing cycle 2 at Ayah 4 (index 3) -> advances to Ayah 5 (index 4)
      final s3 = AudioQueuePlanner.computeNextStep(
        queue: sampleQueue,
        currentIndex: 3,
        repeatConfig: repeat,
        continueToNextSurah: false,
        currentSurahNumber: 1,
      );
      expect(s3.nextTrackIndex, 4);
      expect(s3.updatedRepeatConfig.completedCycles, 0);
    });

    test(
        'continues to next surah when last track finishes and continueToNextSurah is true',
        () {
      final decision = AudioQueuePlanner.computeNextStep(
        queue: sampleQueue,
        currentIndex: 6, // Last verse of Surah 1
        repeatConfig: const AudioRepeatRangeConfig(enabled: false),
        continueToNextSurah: true,
        currentSurahNumber: 1,
      );

      expect(decision.nextTrackIndex, isNull);
      expect(decision.shouldContinueToNextSurah, isTrue);
      expect(decision.nextSurahNumber, 2);
    });
  });
}
