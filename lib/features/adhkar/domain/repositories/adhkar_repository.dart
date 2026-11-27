import '../../../../core/result/result.dart';
import '../entities/adhkar_entities.dart';

/// Repository interface for Adhkar and Duas feature.
abstract class AdhkarRepository {
  /// Loads and parses the verified `assets/data/adhkar.json` dataset.
  Future<Result<AdhkarDataset>> loadDataset();

  /// Returns items for [category].
  Future<Result<List<AdhkarItem>>> getItemsForCategory(AdhkarCategory category);

  /// Returns all progress records for items in [category] on [localDate] (`YYYY-MM-DD`).
  Future<Result<Map<String, AdhkarItemProgress>>> getProgressForCategory({
    required String localDate,
    required AdhkarCategory category,
  });

  /// Computes overall completion progress for all 11 categories on [localDate].
  Future<Result<Map<AdhkarCategory, AdhkarCategoryProgress>>>
      getAllCategoriesProgress({
    required String localDate,
  });

  /// Increments repetition count for [item] on [localDate].
  /// When count reaches [item.repeat], marks [isCompleted] true.
  Future<Result<AdhkarItemProgress>> incrementProgress({
    required String localDate,
    required AdhkarItem item,
    required AdhkarCategory category,
  });

  /// Toggles [isCompleted] for [item] on [localDate].
  Future<Result<AdhkarItemProgress>> toggleItemComplete({
    required String localDate,
    required AdhkarItem item,
    required AdhkarCategory category,
  });

  /// Resets daily progress for all items in [category] on [localDate].
  Future<Result<void>> resetCategoryProgress({
    required String localDate,
    required AdhkarCategory category,
  });
}
