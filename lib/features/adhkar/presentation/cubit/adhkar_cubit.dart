import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/result/result.dart';
import '../../domain/entities/adhkar_entities.dart';
import '../../domain/repositories/adhkar_repository.dart';
import 'adhkar_state.dart';

/// Cubit for managing Phase 8 Adhkar & Duas:
/// - Category overview with daily completion progress
/// - Swipe reader with item-level repeat counting and haptic feedback
/// - Daily reset and category reset
/// - Adjustable text size
class AdhkarCubit extends Cubit<AdhkarState> {
  AdhkarCubit({
    required AdhkarRepository repository,
    DateTime Function()? clock,
  })  : _repository = repository,
        _clock = clock ?? DateTime.now,
        super(const AdhkarState());

  final AdhkarRepository _repository;
  final DateTime Function() _clock;

  String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Initializes the adhkar module, loading the verified dataset and daily progress.
  Future<void> initialize() async {
    emit(state.copyWith(isLoading: true));

    final datasetResult = await _repository.loadDataset();
    if (datasetResult is FailureResult<AdhkarDataset>) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: datasetResult.failure.message,
        ),
      );
      return;
    }

    final dataset = (datasetResult as Success<AdhkarDataset>).value;
    final todayKey = _formatDate(_clock());

    final progressResult = await _repository.getAllCategoriesProgress(
      localDate: todayKey,
    );
    final catProgress = switch (progressResult) {
      Success(:final value) => value,
      FailureResult() => <AdhkarCategory, AdhkarCategoryProgress>{},
    };

    emit(
      state.copyWith(
        isLoading: false,
        dataset: dataset,
        categoriesProgress: catProgress,
      ),
    );
  }

  /// Selects and loads items for [category] to display in the Adhkar Reader.
  Future<void> selectCategory(
    AdhkarCategory category, {
    int initialIndex = 0,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        activeCategory: category,
        currentReaderIndex: initialIndex,
      ),
    );

    final itemsResult = await _repository.getItemsForCategory(category);
    final items = switch (itemsResult) {
      Success(:final value) => value,
      FailureResult() => <AdhkarItem>[],
    };

    final todayKey = _formatDate(_clock());
    final progressResult = await _repository.getProgressForCategory(
      localDate: todayKey,
      category: category,
    );
    final itemsProgress = switch (progressResult) {
      Success(:final value) => value,
      FailureResult() => <String, AdhkarItemProgress>{},
    };

    emit(
      state.copyWith(
        isLoading: false,
        activeCategoryItems: items,
        itemsProgress: itemsProgress,
        currentReaderIndex: initialIndex.clamp(
          0,
          items.isNotEmpty ? items.length - 1 : 0,
        ),
      ),
    );

    await _refreshCategoriesProgress();
  }

  void setReaderIndex(int index) {
    if (state.activeCategoryItems.isEmpty) return;
    final clamped = index.clamp(0, state.activeCategoryItems.length - 1);
    emit(state.copyWith(currentReaderIndex: clamped));
  }

  /// Increments repetition count for the current item.
  /// Fires haptics, updates Drift database, and returns true if completed.
  Future<bool> incrementCurrentItem() async {
    final item = state.currentItem;
    if (item == null) return false;

    try {
      await HapticFeedback.lightImpact();
    } catch (_) {}

    final todayKey = _formatDate(_clock());
    final result = await _repository.incrementProgress(
      localDate: todayKey,
      item: item,
      category: state.activeCategory,
    );

    if (result is Success<AdhkarItemProgress>) {
      final updatedProgress = result.value;
      final updatedMap =
          Map<String, AdhkarItemProgress>.from(state.itemsProgress)
            ..[item.id] = updatedProgress;

      if (updatedProgress.isCompleted) {
        try {
          await HapticFeedback.mediumImpact();
        } catch (_) {}
      }

      emit(state.copyWith(itemsProgress: updatedMap));
      await _refreshCategoriesProgress();
      return updatedProgress.isCompleted;
    }

    return false;
  }

  /// Toggles completion status for current item.
  Future<void> toggleCurrentItemComplete() async {
    final item = state.currentItem;
    if (item == null) return;

    try {
      await HapticFeedback.selectionClick();
    } catch (_) {}

    final todayKey = _formatDate(_clock());
    final result = await _repository.toggleItemComplete(
      localDate: todayKey,
      item: item,
      category: state.activeCategory,
    );

    if (result is Success<AdhkarItemProgress>) {
      final updatedProgress = result.value;
      final updatedMap =
          Map<String, AdhkarItemProgress>.from(state.itemsProgress)
            ..[item.id] = updatedProgress;

      emit(state.copyWith(itemsProgress: updatedMap));
      await _refreshCategoriesProgress();
    }
  }

  /// Resets daily progress for all items in the active category for today.
  Future<void> resetActiveCategoryToday() async {
    final todayKey = _formatDate(_clock());
    await _repository.resetCategoryProgress(
      localDate: todayKey,
      category: state.activeCategory,
    );

    await selectCategory(
      state.activeCategory,
      initialIndex: state.currentReaderIndex,
    );
  }

  void setReaderFontSize(double fontSize) {
    emit(state.copyWith(readerFontSize: fontSize.clamp(18.0, 38.0)));
  }

  void toggleAutoAdvance(bool enabled) {
    emit(state.copyWith(autoAdvanceOnComplete: enabled));
  }

  Future<void> _refreshCategoriesProgress() async {
    final todayKey = _formatDate(_clock());
    final progressResult = await _repository.getAllCategoriesProgress(
      localDate: todayKey,
    );
    if (progressResult
        is Success<Map<AdhkarCategory, AdhkarCategoryProgress>>) {
      emit(state.copyWith(categoriesProgress: progressResult.value));
    }
  }
}
