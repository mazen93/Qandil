import '../../../../core/result/result.dart';
import '../entities/tasbih_entities.dart';

/// Domain contract for Phase 7 Tasbih counter, statistics, custom dhikr labels, and JSON export.
abstract interface class TasbihRepository {
  /// Records a tasbih increment and updates `tasbih_daily` in the same SQLite transaction.
  Future<Result<void>> recordIncrement({
    required String dhikrId,
    required int count,
    DateTime? nowLocal,
  });

  /// Undoes the last increment for [dhikrId] and decrements `tasbih_daily` in the same transaction.
  Future<Result<int>> undoLastIncrement({
    required String dhikrId,
    DateTime? nowLocal,
  });

  /// Computes the complete [TasbihStatsSummary] for [period] (Today, 7 Days, 30 Days, All Time).
  Future<Result<TasbihStatsSummary>> getStatsSummary({
    required TasbihStatsPeriod period,
    DateTime? nowLocal,
  });

  /// Loads available Dhikr picker options from Phase 8 `assets/data/adhkar.json` (if present)
  /// combined with custom user-saved labels in Drift `settings`.
  Future<Result<List<TasbihDhikrOption>>> getDhikrOptions({
    required String languageCode,
  });

  /// Saves a new custom user-typed dhikr label into Drift `settings`.
  Future<Result<List<TasbihDhikrOption>>> addCustomDhikrLabel({
    required String label,
    required String languageCode,
  });

  /// Generates a complete JSON export string of all `tasbih_daily`, `tasbih_events`, and streak metrics.
  Future<Result<String>> buildExportJson({DateTime? nowLocal});
}
