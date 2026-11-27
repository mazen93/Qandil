import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/result/result.dart';
import '../../domain/entities/tasbih_entities.dart';
import '../../domain/repositories/tasbih_repository.dart';
import 'tasbih_state.dart';

/// Cubit managing Phase 7 Tasbih Counter & Statistics:
/// - Large tap area increments immediately persisted to Drift `tasbih_events` & `tasbih_daily` in the same transaction
/// - Haptics toggle
/// - Target presets (`33`, `99`, `100`, `custom`)
/// - Dhikr picker (Phase 8 data + custom user-typed labels)
/// - Undo last tap, Reset session counter, Save session lap
/// - Statistics period switching (`today`, `7 days`, `30 days`, `all time`), streaks, and JSON export
class TasbihCubit extends Cubit<TasbihState> {
  TasbihCubit({
    required TasbihRepository repository,
    DateTime Function()? clock,
  })  : _repository = repository,
        _clock = clock ?? DateTime.now,
        super(const TasbihState());

  final TasbihRepository _repository;
  final DateTime Function() _clock;

  /// Loads dhikr options and initial statistics summary.
  Future<void> initialize({
    String languageCode = 'ar',
    int initialTargetPreset = 33,
    bool initialHapticsEnabled = true,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        targetPreset: initialTargetPreset,
        hapticsEnabled: initialHapticsEnabled,
      ),
    );

    final optionsResult = await _repository.getDhikrOptions(
      languageCode: languageCode,
    );
    final options = switch (optionsResult) {
      Success(:final value) => value,
      FailureResult() => const <TasbihDhikrOption>[
          TasbihDhikrOption(id: 'general_tasbih', label: 'تسبيح عام'),
        ],
    };

    final selectedId = options.any((o) => o.id == state.selectedDhikrId)
        ? state.selectedDhikrId
        : (options.isNotEmpty ? options.first.id : 'general_tasbih');

    final statsResult = await _repository.getStatsSummary(
      period: state.selectedPeriod,
      nowLocal: _clock(),
    );
    final stats = switch (statsResult) {
      Success(:final value) => value,
      FailureResult() => null,
    };

    emit(
      state.copyWith(
        isLoading: false,
        dhikrOptions: options,
        selectedDhikrId: selectedId,
        statsSummary: stats,
      ),
    );
  }

  /// Records a single tap immediately in Drift `tasbih_events` & `tasbih_daily` in the same transaction,
  /// so counts are NEVER lost if the app is killed at any moment.
  Future<void> increment({int step = 1}) async {
    final safeStep = step <= 0 ? 1 : step;
    final nextSessionCount = state.sessionCount + safeStep;
    final completedRounds =
        state.targetPreset > 0 ? (nextSessionCount ~/ state.targetPreset) : 0;
    final hitTargetBoundary =
        state.targetPreset > 0 && (nextSessionCount % state.targetPreset == 0);

    if (state.hapticsEnabled) {
      try {
        if (hitTargetBoundary) {
          await HapticFeedback.mediumImpact();
        } else {
          await HapticFeedback.lightImpact();
        }
      } catch (_) {}
    }

    emit(
      state.copyWith(
        sessionCount: nextSessionCount,
        completedRoundsInSession: completedRounds,
      ),
    );

    await _repository.recordIncrement(
      dhikrId: state.selectedDhikrId,
      count: safeStep,
      nowLocal: _clock(),
    );

    await refreshStats();
  }

  /// Undoes the most recent tap for the active dhikr in both the session counter and Drift database.
  Future<void> undo() async {
    final result = await _repository.undoLastIncrement(
      dhikrId: state.selectedDhikrId,
      nowLocal: _clock(),
    );

    if (result case Success(:final value) when value > 0) {
      final nextSessionCount = (state.sessionCount - value).clamp(0, 9999999);
      final completedRounds =
          state.targetPreset > 0 ? (nextSessionCount ~/ state.targetPreset) : 0;
      emit(
        state.copyWith(
          sessionCount: nextSessionCount,
          completedRoundsInSession: completedRounds,
        ),
      );
      await refreshStats();
    }
  }

  /// Resets the on-screen session lap counter to 0 (historical counts remain safely saved in Drift).
  void resetSessionCounter() {
    emit(
      state.copyWith(
        sessionCount: 0,
        completedRoundsInSession: 0,
      ),
    );
  }

  /// Completes/saves the current session lap and resets the session dial for a fresh lap.
  Future<void> saveAndFinishSessionLap() async {
    resetSessionCounter();
    await refreshStats();
  }

  void setTargetPreset(int target) {
    final clamped = target.clamp(1, 100000);
    final completedRounds = state.sessionCount ~/ clamped;
    emit(
      state.copyWith(
        targetPreset: clamped,
        completedRoundsInSession: completedRounds,
      ),
    );
  }

  void toggleHaptics(bool enabled) {
    emit(state.copyWith(hapticsEnabled: enabled));
  }

  void selectDhikr(String dhikrId) {
    emit(
      state.copyWith(
        selectedDhikrId: dhikrId,
        sessionCount: 0,
        completedRoundsInSession: 0,
      ),
    );
  }

  /// Adds a custom user-typed dhikr label and selects it immediately.
  Future<void> addCustomDhikr({
    required String label,
    required String languageCode,
  }) async {
    final trimmed = label.trim();
    if (trimmed.isEmpty) return;

    final result = await _repository.addCustomDhikrLabel(
      label: trimmed,
      languageCode: languageCode,
    );
    if (result case Success(:final value) when value.isNotEmpty) {
      emit(
        state.copyWith(
          dhikrOptions: value,
          selectedDhikrId: value.last.id,
          sessionCount: 0,
          completedRoundsInSession: 0,
        ),
      );
    }
  }

  Future<void> setStatsPeriod(TasbihStatsPeriod period) async {
    emit(state.copyWith(selectedPeriod: period));
    await refreshStats();
  }

  Future<void> refreshStats() async {
    final result = await _repository.getStatsSummary(
      period: state.selectedPeriod,
      nowLocal: _clock(),
    );
    if (result case Success(:final value)) {
      emit(state.copyWith(statsSummary: value));
    }
  }

  Future<Result<String>> buildExportJson() {
    return _repository.buildExportJson(nowLocal: _clock());
  }
}
