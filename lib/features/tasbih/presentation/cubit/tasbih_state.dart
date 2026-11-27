import 'package:flutter/foundation.dart';

import '../../domain/entities/tasbih_entities.dart';

/// Immutable state for [TasbihCubit].
@immutable
class TasbihState {
  const TasbihState({
    this.isLoading = false,
    this.sessionCount = 0,
    this.completedRoundsInSession = 0,
    this.targetPreset = 33,
    this.hapticsEnabled = true,
    this.dhikrOptions = const [],
    this.selectedDhikrId = 'general_tasbih',
    this.selectedPeriod = TasbihStatsPeriod.sevenDays,
    this.statsSummary,
    this.errorMessage,
  });

  final bool isLoading;
  final int sessionCount;
  final int completedRoundsInSession;
  final int targetPreset;
  final bool hapticsEnabled;
  final List<TasbihDhikrOption> dhikrOptions;
  final String selectedDhikrId;
  final TasbihStatsPeriod selectedPeriod;
  final TasbihStatsSummary? statsSummary;
  final String? errorMessage;

  TasbihDhikrOption get selectedDhikr {
    for (final option in dhikrOptions) {
      if (option.id == selectedDhikrId) return option;
    }
    if (dhikrOptions.isNotEmpty) return dhikrOptions.first;
    return const TasbihDhikrOption(
      id: 'general_tasbih',
      label: 'تسبيح عام',
    );
  }

  double get sessionProgressFraction {
    if (targetPreset <= 0) return 0.0;
    final inCurrentRound = sessionCount % targetPreset;
    if (sessionCount > 0 && inCurrentRound == 0) return 1.0;
    return (inCurrentRound / targetPreset).clamp(0.0, 1.0);
  }

  String labelForDhikrId(String dhikrId) {
    for (final option in dhikrOptions) {
      if (option.id == dhikrId) return option.label;
    }
    return dhikrId;
  }

  TasbihState copyWith({
    bool? isLoading,
    int? sessionCount,
    int? completedRoundsInSession,
    int? targetPreset,
    bool? hapticsEnabled,
    List<TasbihDhikrOption>? dhikrOptions,
    String? selectedDhikrId,
    TasbihStatsPeriod? selectedPeriod,
    TasbihStatsSummary? statsSummary,
    String? errorMessage,
  }) {
    return TasbihState(
      isLoading: isLoading ?? this.isLoading,
      sessionCount: sessionCount ?? this.sessionCount,
      completedRoundsInSession:
          completedRoundsInSession ?? this.completedRoundsInSession,
      targetPreset: targetPreset ?? this.targetPreset,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      dhikrOptions: dhikrOptions ?? this.dhikrOptions,
      selectedDhikrId: selectedDhikrId ?? this.selectedDhikrId,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      statsSummary: statsSummary ?? this.statsSummary,
      errorMessage: errorMessage,
    );
  }
}
