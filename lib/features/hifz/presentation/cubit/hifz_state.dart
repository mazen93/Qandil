import 'package:flutter/foundation.dart';

import '../../domain/entities/hifz_entities.dart';

/// Immutable state for [HifzCubit].
@immutable
class HifzState {
  const HifzState({
    this.isLoading = false,
    this.memorizedRanges = const [],
    this.dailyQueueResult,
    this.weakSpots = const [],
    this.mistakeLogs = const [],
    this.statsSummary,
    this.activeSession = const HifzSessionSnapshot(),
    this.newVersesPerDayGoal = 5,
    this.reviewRangesPerDayCap = 5,
    this.catchUpModeEnabled = false,
    this.catchUpSpreadDays = 3,
    this.mutashabihatAvailable = false,
    this.mutashabihatPairs = const [],
    this.audioLoopPauseGapSeconds = 3,
    this.errorMessage,
  });

  final bool isLoading;
  final List<HifzMemorizedRange> memorizedRanges;
  final HifzDailyQueueResult? dailyQueueResult;
  final List<HifzWeakSpotSummary> weakSpots;
  final List<HifzMistakeEntry> mistakeLogs;
  final HifzStatsSummary? statsSummary;
  final HifzSessionSnapshot activeSession;
  final int newVersesPerDayGoal;
  final int reviewRangesPerDayCap;
  final bool catchUpModeEnabled;
  final int catchUpSpreadDays;
  final bool mutashabihatAvailable;
  final List<MutashabihatPair> mutashabihatPairs;
  final int audioLoopPauseGapSeconds;
  final String? errorMessage;

  List<HifzMemorizedRange> get dueQueue =>
      dailyQueueResult?.dueQueue ?? const [];

  HifzState copyWith({
    bool? isLoading,
    List<HifzMemorizedRange>? memorizedRanges,
    HifzDailyQueueResult? dailyQueueResult,
    List<HifzWeakSpotSummary>? weakSpots,
    List<HifzMistakeEntry>? mistakeLogs,
    HifzStatsSummary? statsSummary,
    HifzSessionSnapshot? activeSession,
    int? newVersesPerDayGoal,
    int? reviewRangesPerDayCap,
    bool? catchUpModeEnabled,
    int? catchUpSpreadDays,
    bool? mutashabihatAvailable,
    List<MutashabihatPair>? mutashabihatPairs,
    int? audioLoopPauseGapSeconds,
    String? errorMessage,
  }) {
    return HifzState(
      isLoading: isLoading ?? this.isLoading,
      memorizedRanges: memorizedRanges ?? this.memorizedRanges,
      dailyQueueResult: dailyQueueResult ?? this.dailyQueueResult,
      weakSpots: weakSpots ?? this.weakSpots,
      mistakeLogs: mistakeLogs ?? this.mistakeLogs,
      statsSummary: statsSummary ?? this.statsSummary,
      activeSession: activeSession ?? this.activeSession,
      newVersesPerDayGoal: newVersesPerDayGoal ?? this.newVersesPerDayGoal,
      reviewRangesPerDayCap:
          reviewRangesPerDayCap ?? this.reviewRangesPerDayCap,
      catchUpModeEnabled: catchUpModeEnabled ?? this.catchUpModeEnabled,
      catchUpSpreadDays: catchUpSpreadDays ?? this.catchUpSpreadDays,
      mutashabihatAvailable:
          mutashabihatAvailable ?? this.mutashabihatAvailable,
      mutashabihatPairs: mutashabihatPairs ?? this.mutashabihatPairs,
      audioLoopPauseGapSeconds:
          audioLoopPauseGapSeconds ?? this.audioLoopPauseGapSeconds,
      errorMessage: errorMessage,
    );
  }
}
