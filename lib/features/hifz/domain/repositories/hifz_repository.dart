import '../../../../core/result/result.dart';
import '../entities/hifz_entities.dart';

/// Repository interface for Phase 12 Memorization (Hifz) Tools.
abstract interface class HifzRepository {
  /// Returns all memorized verse ranges ordered by `nextDueDate` ascending, then `id`.
  Future<Result<List<HifzMemorizedRange>>> getMemorizedRanges();

  /// Adds a new memorized verse range and schedules its first SM-2 review.
  Future<Result<HifzMemorizedRange>> addMemorizedRange({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
    required int startPage,
    required int endPage,
    required int juzNumber,
    DateTime? nowLocal,
  });

  /// Deletes a memorized verse range by [rangeId].
  Future<Result<void>> deleteMemorizedRange(int rangeId);

  /// Records a completed review for [range] with [grade] on [nowLocal]:
  /// updates the range's SM-2 fields (`easinessFactor`, `intervalDays`, `repetitions`, `lastReviewedDate`, `nextDueDate`)
  /// and inserts an event into `hifz_review_events` in the same SQLite transaction.
  Future<Result<HifzMemorizedRange>> recordRangeReview({
    required HifzMemorizedRange range,
    required HifzSelfGrade grade,
    DateTime? nowLocal,
  });

  /// Records a verse/word mistake in `hifz_mistake_logs` when graded `Hesitated` or `Forgot`.
  Future<Result<HifzMistakeEntry>> recordMistake({
    required String verseKey,
    required int surahNumber,
    required int ayahNumber,
    int? wordPosition,
    required HifzSelfGrade grade,
    DateTime? nowLocal,
  });

  /// Returns all raw mistake log entries ordered by most recent first.
  Future<Result<List<HifzMistakeEntry>>> getMistakeLogs();

  /// Returns aggregated weak spots sorted by mistake frequency descending.
  Future<Result<List<HifzWeakSpotSummary>>> getWeakSpots();

  /// Computes comprehensive Hifz statistics (`memorizedVerses`, `pages`, `juz`, `reviewStreak`, `weeklyAccuracy`, `projectedCompletionDate`).
  Future<Result<HifzStatsSummary>> getStatsSummary({
    required int newVersesPerDayGoal,
    DateTime? nowLocal,
  });

  /// Persists the active Hifz test/review session to Drift (`hifz_active_session`) so it survives app kill.
  Future<Result<void>> saveActiveSession(HifzSessionSnapshot session);

  /// Restores the active Hifz test/review session from Drift (`hifz_active_session`).
  Future<Result<HifzSessionSnapshot>> getActiveSession();

  /// Clears the active session in Drift when finished or cancelled.
  Future<Result<void>> clearActiveSession();

  /// Builds a Teacher Progress Report JSON string (memorized ranges, stats, review history, weak spots)
  /// for sharing via the system share sheet (no accounts needed).
  Future<Result<String>> buildTeacherExportJson({
    required int newVersesPerDayGoal,
    required int reviewRangesPerDayCap,
    DateTime? nowLocal,
  });
}
