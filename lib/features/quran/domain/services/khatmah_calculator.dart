import 'dart:math' as math;

import 'package:flutter/foundation.dart';

/// Immutable snapshot of a user's Khatmah plan, daily target, progress ring fraction,
/// and missed-day catch-up calculation.
@immutable
class KhatmahScheduleSummary {
  const KhatmahScheduleSummary({
    required this.targetDays,
    required this.currentPage,
    required this.totalPages,
    required this.basePagesPerDay,
    required this.catchUpPagesPerDay,
    required this.elapsedDays,
    required this.remainingDays,
    required this.expectedPageToday,
    required this.behindByPages,
    required this.progressFraction,
  });

  final int targetDays;
  final int currentPage;
  final int totalPages;
  final int basePagesPerDay;
  final int catchUpPagesPerDay;
  final int elapsedDays;
  final int remainingDays;
  final int expectedPageToday;
  final int behindByPages;
  final double progressFraction;

  bool get isBehindSchedule => behindByPages > 0;
  bool get isCompleted => currentPage >= totalPages;
}

/// Pure Dart calculator for the Phase 3 Khatmah Planner.
///
/// Computes:
/// - Base pages per day (`ceil(604 / targetDays)`).
/// - Progress ring fraction (`0.0`..`1.0`).
/// - Missed-day catch-up: when the user falls behind the expected cumulative page
///   for the elapsed days, redistributes the remaining pages across the remaining days.
abstract final class KhatmahCalculator {
  static const int totalMushafPages = 604;

  static KhatmahScheduleSummary calculate({
    required int targetDays,
    required int currentPage,
    DateTime? startDate,
    DateTime? now,
    int totalPages = totalMushafPages,
  }) {
    final safeTargetDays = targetDays.clamp(1, 3650);
    final safeCurrentPage = currentPage.clamp(1, totalPages);

    final basePagesPerDay = (totalPages / safeTargetDays).ceil();

    // Pages completed so far: reading page 1 means 1/604 progress; page 604 means 100%
    final progressFraction = (safeCurrentPage / totalPages).clamp(0.0, 1.0);

    final currentMoment = now ?? DateTime.now();
    final startMoment = startDate ?? currentMoment;

    final startDay = DateTime(
      startMoment.year,
      startMoment.month,
      startMoment.day,
    );
    final today = DateTime(
      currentMoment.year,
      currentMoment.month,
      currentMoment.day,
    );

    final elapsedDays = math.max(0, today.difference(startDay).inDays);
    final remainingDays = math.max(1, safeTargetDays - elapsedDays);

    // Expected page by the start of today (after `elapsedDays` completed days)
    final expectedCompletedPages =
        math.min(totalPages, elapsedDays * basePagesPerDay);
    final expectedPageToday = math.max(1, expectedCompletedPages);

    // Pages completed before the current unread page
    final completedPages = safeCurrentPage - 1;
    final behindByPages = math.max(0, expectedCompletedPages - completedPages);

    final remainingPages = math.max(0, totalPages - completedPages);
    final catchUpPagesPerDay =
        remainingPages == 0 ? 0 : (remainingPages / remainingDays).ceil();

    return KhatmahScheduleSummary(
      targetDays: safeTargetDays,
      currentPage: safeCurrentPage,
      totalPages: totalPages,
      basePagesPerDay: basePagesPerDay,
      catchUpPagesPerDay: catchUpPagesPerDay,
      elapsedDays: elapsedDays,
      remainingDays: remainingDays,
      expectedPageToday: expectedPageToday,
      behindByPages: behindByPages,
      progressFraction: progressFraction,
    );
  }
}
