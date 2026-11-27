import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/result/result.dart';
import '../../domain/entities/hifz_entities.dart';
import '../../domain/repositories/hifz_repository.dart';
import '../../domain/services/hifz_sm2_scheduler.dart';
import '../../domain/services/mutashabihat_extension_point.dart';
import 'hifz_state.dart';

/// Cubit managing Phase 12 Memorization (Hifz) Tools:
/// - Memorized verse ranges & daily goals (`newVersesPerDayGoal`, `reviewRangesPerDayCap`)
/// - SM-2 daily review queue with overdue ordering and Catch-Up Mode
/// - Crash-safe resumable test sessions (`Recite by Verse Number`, `What is the Next Verse?`, `Review My Mistakes`)
/// - Mistake logging with tapped word position & weak-spots aggregation
/// - Mutashabihat extension point loader
/// - Teacher Progress Report JSON export
class HifzCubit extends Cubit<HifzState> {
  HifzCubit({
    required HifzRepository repository,
    HifzSm2Scheduler? scheduler,
    MutashabihatExtensionPoint? mutashabihatExtension,
    DateTime Function()? clock,
  })  : _repository = repository,
        _scheduler = scheduler ?? const HifzSm2Scheduler(),
        _mutashabihatExtension =
            mutashabihatExtension ?? const MutashabihatExtensionPoint(),
        _clock = clock ?? DateTime.now,
        super(const HifzState());

  final HifzRepository _repository;
  final HifzSm2Scheduler _scheduler;
  final MutashabihatExtensionPoint _mutashabihatExtension;
  final DateTime Function() _clock;

  /// Loads memorized ranges, builds today's SM-2 queue, restores any active session
  /// that was interrupted by an app kill, loads weak spots & stats, and checks the Mutashabihat extension point.
  Future<void> initialize({
    int newVersesPerDayGoal = 5,
    int reviewRangesPerDayCap = 5,
    bool catchUpModeEnabled = false,
    int catchUpSpreadDays = 3,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        newVersesPerDayGoal: newVersesPerDayGoal,
        reviewRangesPerDayCap: reviewRangesPerDayCap,
        catchUpModeEnabled: catchUpModeEnabled,
        catchUpSpreadDays: catchUpSpreadDays,
      ),
    );

    final restoredSession = switch (await _repository.getActiveSession()) {
      Success(:final value) => value,
      FailureResult() => const HifzSessionSnapshot(isActive: false),
    };

    final mutashabihat =
        await _mutashabihatExtension.loadVerifiedDatasetIfSupplied();

    emit(
      state.copyWith(
        activeSession: restoredSession,
        mutashabihatAvailable: mutashabihat.isAvailable,
        mutashabihatPairs: mutashabihat.pairs,
      ),
    );

    await refreshAll();
  }

  Future<void> refreshAll() async {
    final now = _clock();
    final todayKey = HifzSm2Scheduler.formatLocalDate(now);

    final ranges = switch (await _repository.getMemorizedRanges()) {
      Success(:final value) => value,
      FailureResult() => const <HifzMemorizedRange>[],
    };

    final queueResult = _scheduler.buildDailyQueue(
      allRanges: ranges,
      todayDate: todayKey,
      dailyCap: state.reviewRangesPerDayCap,
      catchUpMode: state.catchUpModeEnabled,
      catchUpSpreadDays: state.catchUpSpreadDays,
    );

    final weakSpots = switch (await _repository.getWeakSpots()) {
      Success(:final value) => value,
      FailureResult() => const <HifzWeakSpotSummary>[],
    };

    final mistakes = switch (await _repository.getMistakeLogs()) {
      Success(:final value) => value,
      FailureResult() => const <HifzMistakeEntry>[],
    };

    final stats = switch (await _repository.getStatsSummary(
      newVersesPerDayGoal: state.newVersesPerDayGoal,
      nowLocal: now,
    )) {
      Success(:final value) => value,
      FailureResult() => null,
    };

    emit(
      state.copyWith(
        isLoading: false,
        memorizedRanges: ranges,
        dailyQueueResult: queueResult,
        weakSpots: weakSpots,
        mistakeLogs: mistakes,
        statsSummary: stats,
      ),
    );
  }

  Future<void> addMemorizedRange({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
    int startPage = 1,
    int endPage = 1,
    int juzNumber = 1,
  }) async {
    await _repository.addMemorizedRange(
      surahNumber: surahNumber,
      startAyah: startAyah,
      endAyah: endAyah,
      startPage: startPage,
      endPage: endPage,
      juzNumber: juzNumber,
      nowLocal: _clock(),
    );
    await refreshAll();
  }

  Future<void> deleteMemorizedRange(int rangeId) async {
    await _repository.deleteMemorizedRange(rangeId);
    await refreshAll();
  }

  Future<void> setGoals({
    int? newVersesPerDayGoal,
    int? reviewRangesPerDayCap,
    bool? catchUpModeEnabled,
    int? catchUpSpreadDays,
  }) async {
    emit(
      state.copyWith(
        newVersesPerDayGoal: newVersesPerDayGoal,
        reviewRangesPerDayCap: reviewRangesPerDayCap,
        catchUpModeEnabled: catchUpModeEnabled,
        catchUpSpreadDays: catchUpSpreadDays,
      ),
    );
    await refreshAll();
  }

  void setAudioLoopPauseGapSeconds(int seconds) {
    emit(state.copyWith(audioLoopPauseGapSeconds: seconds.clamp(0, 60)));
  }

  /// Starts a Hifz test/review session for a verse range and immediately persists it to Drift
  /// so it survives the app being killed at any point.
  Future<void> startRangeTestSession({
    required HifzTestMode mode,
    int? rangeId,
    required int surahNumber,
    required int startAyah,
    required int endAyah,
  }) async {
    final safeStart = startAyah.clamp(1, 286);
    final safeEnd = endAyah.clamp(safeStart, 286);
    final keys = <String>[
      for (var ayah = safeStart; ayah <= safeEnd; ayah++) '$surahNumber:$ayah',
    ];

    final session = HifzSessionSnapshot(
      isActive: true,
      mode: mode,
      rangeId: rangeId,
      surahNumber: surahNumber,
      startAyah: safeStart,
      endAyah: safeEnd,
      currentIndex: 0,
      isRevealed: false,
      verseKeys: keys,
      gradesByVerseKey: const {},
    );

    emit(state.copyWith(activeSession: session));
    await _repository.saveActiveSession(session);
  }

  /// Starts a "Review My Mistakes" session over all weak-spot verses recorded in `hifz_mistake_logs`.
  Future<void> startReviewMyMistakesSession() async {
    final keys = state.weakSpots.map((w) => w.verseKey).toList(growable: false);
    if (keys.isEmpty) return;

    final firstParts = keys.first.split(':');
    final surahNum = int.tryParse(firstParts.first) ?? 1;
    final ayahNum =
        firstParts.length > 1 ? (int.tryParse(firstParts[1]) ?? 1) : 1;

    final session = HifzSessionSnapshot(
      isActive: true,
      mode: HifzTestMode.reviewMyMistakes,
      surahNumber: surahNum,
      startAyah: ayahNum,
      endAyah: ayahNum,
      currentIndex: 0,
      isRevealed: false,
      verseKeys: keys,
      gradesByVerseKey: const {},
    );

    emit(state.copyWith(activeSession: session));
    await _repository.saveActiveSession(session);
  }

  /// Reveals the current hidden verse in the active test session and persists state.
  Future<void> revealCurrentSessionVerse() async {
    if (!state.activeSession.isActive) return;
    final updated = state.activeSession.copyWith(isRevealed: true);
    emit(state.copyWith(activeSession: updated));
    await _repository.saveActiveSession(updated);
  }

  /// Records a tapped word position on the revealed verse before grading `Hesitated` or `Forgot`.
  Future<void> selectMistakeWordPosition(int? wordPosition) async {
    if (!state.activeSession.isActive) return;
    final updated = state.activeSession.copyWith(
      tappedMistakeWordPosition: wordPosition,
      clearTappedWord: wordPosition == null,
    );
    emit(state.copyWith(activeSession: updated));
    await _repository.saveActiveSession(updated);
  }

  /// Grades the current verse in the active session (`Perfect`, `Hesitated`, or `Forgot`):
  /// - On `Hesitated` or `Forgot`, logs the verse, tapped word position (if any), and date to `hifz_mistake_logs`.
  /// - Advances to the next verse in the session and persists to `hifz_active_session`.
  /// - When the last verse of the session is graded, updates the range's SM-2 schedule and completes the session.
  Future<void> gradeCurrentSessionVerse(HifzSelfGrade grade) async {
    final session = state.activeSession;
    if (!session.isActive || session.verseKeys.isEmpty) return;

    final targetKey =
        session.nextTargetVerseKey ?? session.verseKeys[session.currentIndex];
    final parts = targetKey.split(':');
    final surahNum = int.tryParse(parts.first) ?? session.surahNumber;
    final ayahNum = parts.length > 1 ? (int.tryParse(parts[1]) ?? 1) : 1;

    // 1. Log mistake on Hesitated or Forgot
    if (grade == HifzSelfGrade.hesitated || grade == HifzSelfGrade.forgot) {
      await _repository.recordMistake(
        verseKey: targetKey,
        surahNumber: surahNum,
        ayahNumber: ayahNum,
        wordPosition: session.tappedMistakeWordPosition,
        grade: grade,
        nowLocal: _clock(),
      );
    }

    final updatedGrades = Map<String, HifzSelfGrade>.from(
      session.gradesByVerseKey,
    )..[targetKey] = grade;

    final lastStepIndex = session.mode == HifzTestMode.whatIsNextVerse &&
            session.verseKeys.length > 1
        ? session.verseKeys.length - 2
        : session.verseKeys.length - 1;

    if (session.currentIndex < lastStepIndex) {
      final nextSession = session.copyWith(
        currentIndex: session.currentIndex + 1,
        isRevealed: false,
        clearTappedWord: true,
        gradesByVerseKey: updatedGrades,
      );
      emit(state.copyWith(activeSession: nextSession));
      await _repository.saveActiveSession(nextSession);
      await refreshAll();
      return;
    }

    // Session completed: compute overall range grade (worst grade in session determines SM-2 interval)
    var overallGrade = HifzSelfGrade.perfect;
    for (final g in updatedGrades.values) {
      if (g == HifzSelfGrade.forgot) {
        overallGrade = HifzSelfGrade.forgot;
        break;
      } else if (g == HifzSelfGrade.hesitated) {
        overallGrade = HifzSelfGrade.hesitated;
      }
    }

    if (session.rangeId != null) {
      final matchingRange = state.memorizedRanges
          .where((r) => r.id == session.rangeId)
          .firstOrNull;
      if (matchingRange != null) {
        await _repository.recordRangeReview(
          range: matchingRange,
          grade: overallGrade,
          nowLocal: _clock(),
        );
      }
    }

    const cleared = HifzSessionSnapshot(isActive: false);
    emit(state.copyWith(activeSession: cleared));
    await _repository.clearActiveSession();
    await refreshAll();
  }

  /// Directly grades a due range from the daily review queue without stepping verse-by-verse.
  Future<void> quickGradeRange(
    HifzMemorizedRange range,
    HifzSelfGrade grade,
  ) async {
    if (grade == HifzSelfGrade.hesitated || grade == HifzSelfGrade.forgot) {
      await _repository.recordMistake(
        verseKey: '${range.surahNumber}:${range.startAyah}',
        surahNumber: range.surahNumber,
        ayahNumber: range.startAyah,
        grade: grade,
        nowLocal: _clock(),
      );
    }
    await _repository.recordRangeReview(
      range: range,
      grade: grade,
      nowLocal: _clock(),
    );
    await refreshAll();
  }

  Future<void> cancelActiveSession() async {
    const cleared = HifzSessionSnapshot(isActive: false);
    emit(state.copyWith(activeSession: cleared));
    await _repository.clearActiveSession();
  }

  Future<Result<String>> buildTeacherExportJson() {
    return _repository.buildTeacherExportJson(
      newVersesPerDayGoal: state.newVersesPerDayGoal,
      reviewRangesPerDayCap: state.reviewRangesPerDayCap,
      nowLocal: _clock(),
    );
  }
}
