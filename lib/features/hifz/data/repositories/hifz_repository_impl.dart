import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/hifz_entities.dart';
import '../../domain/repositories/hifz_repository.dart';
import '../../domain/services/hifz_sm2_scheduler.dart';

/// Concrete Drift-backed implementation of [HifzRepository].
class HifzRepositoryImpl implements HifzRepository {
  HifzRepositoryImpl({
    required AppDatabase database,
    HifzSm2Scheduler? scheduler,
    DateTime Function()? clock,
  })  : _database = database,
        _scheduler = scheduler ?? const HifzSm2Scheduler(),
        _clock = clock ?? DateTime.now;

  final AppDatabase _database;
  final HifzSm2Scheduler _scheduler;
  final DateTime Function() _clock;

  @override
  Future<Result<List<HifzMemorizedRange>>> getMemorizedRanges() async {
    try {
      final rows = await (_database.select(_database.hifzMemorizedRanges)
            ..orderBy([
              (t) => OrderingTerm.asc(t.nextDueDate),
              (t) => OrderingTerm.asc(t.id),
            ]))
          .get();

      return Success(rows.map(_mapRangeRow).toList(growable: false));
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to load Hifz memorized ranges: $e'),
      );
    }
  }

  @override
  Future<Result<HifzMemorizedRange>> addMemorizedRange({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
    required int startPage,
    required int endPage,
    required int juzNumber,
    DateTime? nowLocal,
  }) async {
    try {
      final now = nowLocal ?? _clock();
      final todayKey = HifzSm2Scheduler.formatLocalDate(now);
      final safeStartAyah = startAyah.clamp(1, 286);
      final safeEndAyah = endAyah.clamp(safeStartAyah, 286);
      final safeStartPage = startPage.clamp(1, 604);
      final safeEndPage = endPage.clamp(safeStartPage, 604);
      final safeJuz = juzNumber.clamp(1, 30);

      final inserted =
          await _database.into(_database.hifzMemorizedRanges).insertReturning(
                HifzMemorizedRangesCompanion.insert(
                  surahNumber: surahNumber.clamp(1, 114),
                  startAyah: safeStartAyah,
                  endAyah: safeEndAyah,
                  startPage: Value(safeStartPage),
                  endPage: Value(safeEndPage),
                  juzNumber: Value(safeJuz),
                  easinessFactor: const Value(2.5),
                  intervalDays: const Value(1),
                  repetitions: const Value(0),
                  nextDueDate: todayKey,
                  lastGrade: const Value('perfect'),
                ),
              );

      return Success(_mapRangeRow(inserted));
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to add Hifz memorized range: $e'),
      );
    }
  }

  @override
  Future<Result<void>> deleteMemorizedRange(int rangeId) async {
    try {
      await (_database.delete(_database.hifzMemorizedRanges)
            ..where((t) => t.id.equals(rangeId)))
          .go();
      return const Success(null);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to delete Hifz memorized range: $e'),
      );
    }
  }

  @override
  Future<Result<HifzMemorizedRange>> recordRangeReview({
    required HifzMemorizedRange range,
    required HifzSelfGrade grade,
    DateTime? nowLocal,
  }) async {
    try {
      final now = nowLocal ?? _clock();
      final todayKey = HifzSm2Scheduler.formatLocalDate(now);
      final update = _scheduler.scheduleNext(
        range: range,
        grade: grade,
        reviewDate: todayKey,
      );

      final updatedRange = await _database.transaction(() async {
        await (_database.update(_database.hifzMemorizedRanges)
              ..where((t) => t.id.equals(range.id)))
            .write(
          HifzMemorizedRangesCompanion(
            easinessFactor: Value(update.easinessFactor),
            intervalDays: Value(update.intervalDays),
            repetitions: Value(update.repetitions),
            lastReviewedDate: Value(update.lastReviewedDate),
            nextDueDate: Value(update.nextDueDate),
            lastGrade: Value(update.grade.code),
          ),
        );

        await _database.into(_database.hifzReviewEvents).insert(
              HifzReviewEventsCompanion.insert(
                rangeId: range.id,
                surahNumber: range.surahNumber,
                startAyah: range.startAyah,
                endAyah: range.endAyah,
                grade: grade.code,
                localDate: todayKey,
                reviewedAt: Value(now.toUtc()),
              ),
            );

        return range.copyWith(
          easinessFactor: update.easinessFactor,
          intervalDays: update.intervalDays,
          repetitions: update.repetitions,
          lastReviewedDate: update.lastReviewedDate,
          nextDueDate: update.nextDueDate,
          lastGrade: update.grade,
        );
      });

      return Success(updatedRange);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to record Hifz review: $e'),
      );
    }
  }

  @override
  Future<Result<HifzMistakeEntry>> recordMistake({
    required String verseKey,
    required int surahNumber,
    required int ayahNumber,
    int? wordPosition,
    required HifzSelfGrade grade,
    DateTime? nowLocal,
  }) async {
    try {
      final now = nowLocal ?? _clock();
      final todayKey = HifzSm2Scheduler.formatLocalDate(now);

      final row =
          await _database.into(_database.hifzMistakeLogs).insertReturning(
                HifzMistakeLogsCompanion.insert(
                  verseKey: verseKey,
                  surahNumber: surahNumber,
                  ayahNumber: ayahNumber,
                  wordPosition: Value(wordPosition),
                  grade: grade.code,
                  localDate: todayKey,
                  recordedAt: Value(now.toUtc()),
                ),
              );

      return Success(
        HifzMistakeEntry(
          id: row.id,
          verseKey: row.verseKey,
          surahNumber: row.surahNumber,
          ayahNumber: row.ayahNumber,
          wordPosition: row.wordPosition,
          grade: HifzSelfGrade.fromCode(row.grade),
          localDate: row.localDate,
        ),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to record Hifz mistake: $e'),
      );
    }
  }

  @override
  Future<Result<List<HifzMistakeEntry>>> getMistakeLogs() async {
    try {
      final rows = await (_database.select(_database.hifzMistakeLogs)
            ..orderBy([
              (t) => OrderingTerm.desc(t.recordedAt),
              (t) => OrderingTerm.desc(t.id),
            ]))
          .get();

      return Success(
        rows
            .map(
              (r) => HifzMistakeEntry(
                id: r.id,
                verseKey: r.verseKey,
                surahNumber: r.surahNumber,
                ayahNumber: r.ayahNumber,
                wordPosition: r.wordPosition,
                grade: HifzSelfGrade.fromCode(r.grade),
                localDate: r.localDate,
              ),
            )
            .toList(growable: false),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to load Hifz mistake logs: $e'),
      );
    }
  }

  @override
  Future<Result<List<HifzWeakSpotSummary>>> getWeakSpots() async {
    final mistakesResult = await getMistakeLogs();
    if (mistakesResult is FailureResult<List<HifzMistakeEntry>>) {
      return FailureResult(mistakesResult.failure);
    }
    final mistakes = (mistakesResult as Success<List<HifzMistakeEntry>>).value;

    final grouped = <String, List<HifzMistakeEntry>>{};
    for (final m in mistakes) {
      grouped.putIfAbsent(m.verseKey, () => []).add(m);
    }

    final summaries = <HifzWeakSpotSummary>[];
    for (final entry in grouped.entries) {
      final list = entry.value;
      final first = list.first;
      final wordPositions = list
          .map((e) => e.wordPosition)
          .whereType<int>()
          .toSet()
          .toList()
        ..sort();

      summaries.add(
        HifzWeakSpotSummary(
          verseKey: entry.key,
          surahNumber: first.surahNumber,
          ayahNumber: first.ayahNumber,
          mistakeCount: list.length,
          lastMistakeDate: first.localDate,
          frequentWordPositions: wordPositions,
        ),
      );
    }

    summaries.sort((a, b) => b.mistakeCount.compareTo(a.mistakeCount));
    return Success(summaries);
  }

  @override
  Future<Result<HifzStatsSummary>> getStatsSummary({
    required int newVersesPerDayGoal,
    DateTime? nowLocal,
  }) async {
    try {
      final now = nowLocal ?? _clock();
      final todayKey = HifzSm2Scheduler.formatLocalDate(now);
      final rangesResult = await getMemorizedRanges();
      final ranges = switch (rangesResult) {
        Success(:final value) => value,
        FailureResult() => const <HifzMemorizedRange>[],
      };

      final eventRows = await (_database.select(_database.hifzReviewEvents)
            ..orderBy([(t) => OrderingTerm.asc(t.localDate)]))
          .get();
      final reviewEvents = eventRows
          .map(
            (e) => (
              localDate: e.localDate,
              grade: HifzSelfGrade.fromCode(e.grade),
            ),
          )
          .toList(growable: false);

      final stats = HifzSm2Scheduler.computeStats(
        ranges: ranges,
        reviewEvents: reviewEvents,
        todayDate: todayKey,
        newVersesPerDayGoal: newVersesPerDayGoal,
      );
      return Success(stats);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to compute Hifz statistics: $e'),
      );
    }
  }

  @override
  Future<Result<void>> saveActiveSession(HifzSessionSnapshot session) async {
    try {
      final gradesMap = <String, String>{
        for (final entry in session.gradesByVerseKey.entries)
          entry.key: entry.value.code,
      };
      await _database.into(_database.hifzActiveSessions).insertOnConflictUpdate(
            HifzActiveSessionsCompanion(
              id: const Value(1),
              isActive: Value(session.isActive),
              sessionMode: Value(session.mode.code),
              rangeId: Value(session.rangeId),
              surahNumber: Value(session.surahNumber),
              startAyah: Value(session.startAyah),
              endAyah: Value(session.endAyah),
              currentIndex: Value(session.currentIndex),
              isRevealed: Value(session.isRevealed),
              tappedMistakeWordPosition:
                  Value(session.tappedMistakeWordPosition),
              verseKeysJson: Value(jsonEncode(session.verseKeys)),
              gradesJson: Value(jsonEncode(gradesMap)),
              updatedAt: Value(_clock().toUtc()),
            ),
          );
      return const Success(null);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to persist active Hifz session: $e'),
      );
    }
  }

  @override
  Future<Result<HifzSessionSnapshot>> getActiveSession() async {
    try {
      final row = await (_database.select(_database.hifzActiveSessions)
            ..where((t) => t.id.equals(1)))
          .getSingleOrNull();
      if (row == null || !row.isActive) {
        return const Success(HifzSessionSnapshot(isActive: false));
      }

      final rawKeys = jsonDecode(row.verseKeysJson);
      final verseKeys = rawKeys is List
          ? rawKeys.map((e) => e.toString()).toList(growable: false)
          : const <String>[];

      final rawGrades = jsonDecode(row.gradesJson);
      final gradesMap = <String, HifzSelfGrade>{};
      if (rawGrades is Map) {
        for (final entry in rawGrades.entries) {
          gradesMap[entry.key.toString()] =
              HifzSelfGrade.fromCode(entry.value.toString());
        }
      }

      return Success(
        HifzSessionSnapshot(
          isActive: row.isActive,
          mode: HifzTestMode.fromCode(row.sessionMode),
          rangeId: row.rangeId,
          surahNumber: row.surahNumber,
          startAyah: row.startAyah,
          endAyah: row.endAyah,
          currentIndex: row.currentIndex,
          isRevealed: row.isRevealed,
          tappedMistakeWordPosition: row.tappedMistakeWordPosition,
          verseKeys: verseKeys,
          gradesByVerseKey: gradesMap,
        ),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to restore active Hifz session: $e'),
      );
    }
  }

  @override
  Future<Result<void>> clearActiveSession() async {
    return saveActiveSession(const HifzSessionSnapshot(isActive: false));
  }

  @override
  Future<Result<String>> buildTeacherExportJson({
    required int newVersesPerDayGoal,
    required int reviewRangesPerDayCap,
    DateTime? nowLocal,
  }) async {
    try {
      final now = nowLocal ?? _clock();
      final ranges = switch (await getMemorizedRanges()) {
        Success(:final value) => value,
        FailureResult() => const <HifzMemorizedRange>[],
      };
      final stats = switch (await getStatsSummary(
        newVersesPerDayGoal: newVersesPerDayGoal,
        nowLocal: now,
      )) {
        Success(:final value) => value,
        FailureResult() => null,
      };
      final weakSpots = switch (await getWeakSpots()) {
        Success(:final value) => value,
        FailureResult() => const <HifzWeakSpotSummary>[],
      };

      final payload = <String, dynamic>{
        'app': 'Qandil (قنديل)',
        'report_type': 'hifz_teacher_progress_report',
        'exported_at_utc': now.toUtc().toIso8601String(),
        'goals': {
          'new_verses_per_day': newVersesPerDayGoal,
          'review_ranges_per_day_cap': reviewRangesPerDayCap,
        },
        if (stats != null)
          'summary': {
            'memorized_verses_total': stats.memorizedVersesCount,
            'memorized_pages_total': stats.memorizedPagesCount,
            'memorized_juz_total': stats.memorizedJuzCount,
            'review_streak_days': stats.reviewStreakDays,
            'weekly_accuracy_percent': stats.weeklyAccuracyPercent,
            'projected_completion_date': stats.projectedCompletionDate,
          },
        'memorized_ranges': ranges
            .map(
              (r) => {
                'surah_number': r.surahNumber,
                'start_ayah': r.startAyah,
                'end_ayah': r.endAyah,
                'start_page': r.startPage,
                'end_page': r.endPage,
                'juz_number': r.juzNumber,
                'easiness_factor': r.easinessFactor,
                'interval_days': r.intervalDays,
                'repetitions': r.repetitions,
                'last_reviewed_date': r.lastReviewedDate,
                'next_due_date': r.nextDueDate,
                'last_grade': r.lastGrade.code,
              },
            )
            .toList(),
        'weak_spots': weakSpots
            .map(
              (w) => {
                'verse_key': w.verseKey,
                'mistake_count': w.mistakeCount,
                'last_mistake_date': w.lastMistakeDate,
                'word_positions': w.frequentWordPositions,
              },
            )
            .toList(),
      };

      return Success(const JsonEncoder.withIndent('  ').convert(payload));
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to build Teacher Export JSON: $e'),
      );
    }
  }

  HifzMemorizedRange _mapRangeRow(HifzMemorizedRangeRecord r) {
    return HifzMemorizedRange(
      id: r.id,
      surahNumber: r.surahNumber,
      startAyah: r.startAyah,
      endAyah: r.endAyah,
      startPage: r.startPage,
      endPage: r.endPage,
      juzNumber: r.juzNumber,
      easinessFactor: r.easinessFactor,
      intervalDays: r.intervalDays,
      repetitions: r.repetitions,
      lastReviewedDate: r.lastReviewedDate,
      nextDueDate: r.nextDueDate,
      lastGrade: HifzSelfGrade.fromCode(r.lastGrade),
    );
  }
}
