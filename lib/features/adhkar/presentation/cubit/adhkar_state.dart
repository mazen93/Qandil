import 'package:flutter/foundation.dart';

import '../../domain/entities/adhkar_entities.dart';

/// Immutable state for [AdhkarCubit].
@immutable
class AdhkarState {
  const AdhkarState({
    this.isLoading = false,
    this.dataset,
    this.categoriesProgress = const {},
    this.activeCategory = AdhkarCategory.morning,
    this.activeCategoryItems = const [],
    this.itemsProgress = const {},
    this.currentReaderIndex = 0,
    this.readerFontSize = 24.0,
    this.autoAdvanceOnComplete = true,
    this.errorMessage,
  });

  final bool isLoading;
  final AdhkarDataset? dataset;
  final Map<AdhkarCategory, AdhkarCategoryProgress> categoriesProgress;
  final AdhkarCategory activeCategory;
  final List<AdhkarItem> activeCategoryItems;
  final Map<String, AdhkarItemProgress> itemsProgress;
  final int currentReaderIndex;
  final double readerFontSize;
  final bool autoAdvanceOnComplete;
  final String? errorMessage;

  AdhkarCategoryProgress? get activeCategoryProgress =>
      categoriesProgress[activeCategory];

  AdhkarItem? get currentItem {
    if (activeCategoryItems.isEmpty) return null;
    if (currentReaderIndex < 0 ||
        currentReaderIndex >= activeCategoryItems.length) {
      return activeCategoryItems.first;
    }
    return activeCategoryItems[currentReaderIndex];
  }

  AdhkarItemProgress? get currentItemProgress {
    final item = currentItem;
    if (item == null) return null;
    return itemsProgress[item.id];
  }

  AdhkarState copyWith({
    bool? isLoading,
    AdhkarDataset? dataset,
    Map<AdhkarCategory, AdhkarCategoryProgress>? categoriesProgress,
    AdhkarCategory? activeCategory,
    List<AdhkarItem>? activeCategoryItems,
    Map<String, AdhkarItemProgress>? itemsProgress,
    int? currentReaderIndex,
    double? readerFontSize,
    bool? autoAdvanceOnComplete,
    String? errorMessage,
  }) {
    return AdhkarState(
      isLoading: isLoading ?? this.isLoading,
      dataset: dataset ?? this.dataset,
      categoriesProgress: categoriesProgress ?? this.categoriesProgress,
      activeCategory: activeCategory ?? this.activeCategory,
      activeCategoryItems: activeCategoryItems ?? this.activeCategoryItems,
      itemsProgress: itemsProgress ?? this.itemsProgress,
      currentReaderIndex: currentReaderIndex ?? this.currentReaderIndex,
      readerFontSize: readerFontSize ?? this.readerFontSize,
      autoAdvanceOnComplete:
          autoAdvanceOnComplete ?? this.autoAdvanceOnComplete,
      errorMessage: errorMessage,
    );
  }
}
