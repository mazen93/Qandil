import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/core/database/app_database.dart';
import 'package:qandil/core/result/result.dart';
import 'package:qandil/features/hifz/data/repositories/hifz_repository_impl.dart';
import 'package:qandil/features/hifz/domain/entities/hifz_entities.dart';
import 'package:qandil/features/hifz/presentation/cubit/hifz_cubit.dart';

void main() {
  late AppDatabase db;
  late HifzRepositoryImpl repository;
  late DateTime fakeNow;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    fakeNow = DateTime(2026, 11, 27, 9, 0);
    repository = HifzRepositoryImpl(
      database: db,
      clock: () => fakeNow,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('Phase 12: HifzCubit Crash-Safe Session Persistence & Mistake Logging',
      () {
    test(
        'an active Hifz test session survives the app being killed mid-session and records word-level mistakes and teacher JSON export',
        () async {
      final cubit1 = HifzCubit(
        repository: repository,
        clock: () => fakeNow,
      );
      await cubit1.initialize();

      // Add a memorized verse range (Surah 1, Ayahs 1..3)
      await cubit1.addMemorizedRange(
        surahNumber: 1,
        startAyah: 1,
        endAyah: 3,
      );
      expect(cubit1.state.memorizedRanges.length, 1);
      final rangeId = cubit1.state.memorizedRanges.first.id;

      // Start a test session over 1:1..1:3
      await cubit1.startRangeTestSession(
        mode: HifzTestMode.reciteByVerseNumber,
        rangeId: rangeId,
        surahNumber: 1,
        startAyah: 1,
        endAyah: 3,
      );
      expect(cubit1.state.activeSession.isActive, isTrue);
      expect(cubit1.state.activeSession.currentVerseKey, '1:1');

      // Reveal 1:1, tap word position 3 as a mistake, and grade Hesitated
      await cubit1.revealCurrentSessionVerse();
      await cubit1.selectMistakeWordPosition(3);
      await cubit1.gradeCurrentSessionVerse(HifzSelfGrade.hesitated);

      // Session advanced to index 1 ('1:2'); reveal '1:2'
      expect(cubit1.state.activeSession.currentIndex, 1);
      expect(cubit1.state.activeSession.currentVerseKey, '1:2');
      await cubit1.revealCurrentSessionVerse();
      expect(cubit1.state.activeSession.isRevealed, isTrue);

      // SIMULATE APP KILL MID-SESSION: close cubit1 without finishing
      await cubit1.close();

      // Relaunch app with a brand-new HifzCubit instance on the same Drift database
      final cubit2 = HifzCubit(
        repository: repository,
        clock: () => fakeNow,
      );
      await cubit2.initialize();

      // Verify the exact session state survived the app kill!
      expect(cubit2.state.activeSession.isActive, isTrue);
      expect(cubit2.state.activeSession.currentIndex, 1);
      expect(cubit2.state.activeSession.currentVerseKey, '1:2');
      expect(cubit2.state.activeSession.isRevealed, isTrue);
      expect(
        cubit2.state.activeSession.gradesByVerseKey['1:1'],
        HifzSelfGrade.hesitated,
      );

      // Verify the word-level mistake on '1:1' (word 3) was persisted in weak spots
      expect(cubit2.state.weakSpots.length, 1);
      expect(cubit2.state.weakSpots.first.verseKey, '1:1');
      expect(cubit2.state.weakSpots.first.frequentWordPositions, [3]);

      // Finish grading '1:2' and '1:3' as Perfect -> session completes and updates SM-2 range
      await cubit2.gradeCurrentSessionVerse(HifzSelfGrade.perfect);
      await cubit2.revealCurrentSessionVerse();
      await cubit2.gradeCurrentSessionVerse(HifzSelfGrade.perfect);

      expect(cubit2.state.activeSession.isActive, isFalse);

      // Verify Teacher Progress Report JSON export works without accounts
      final exportResult = await cubit2.buildTeacherExportJson();
      expect(exportResult, isA<Success<String>>());
      final reportJson = jsonDecode(
        (exportResult as Success<String>).value,
      ) as Map<String, dynamic>;
      expect(reportJson['report_type'], 'hifz_teacher_progress_report');
      expect((reportJson['memorized_ranges'] as List).length, 1);
      expect((reportJson['weak_spots'] as List).length, 1);

      await cubit2.close();
    });
  });
}
