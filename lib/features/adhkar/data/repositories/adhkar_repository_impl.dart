import 'dart:convert';
import 'package:flutter/services.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/adhkar_entities.dart';
import '../../domain/repositories/adhkar_repository.dart';

/// Implementation of [AdhkarRepository] backed by bundled `assets/data/adhkar.json`
/// and local Drift SQLite table `adhkar_daily_progress`.
class AdhkarRepositoryImpl implements AdhkarRepository {
  AdhkarRepositoryImpl({
    required AppDatabase database,
    String? jsonContentOverride,
  })  : _database = database,
        _jsonContentOverride = jsonContentOverride;

  final AppDatabase _database;
  final String? _jsonContentOverride;

  AdhkarDataset? _cachedDataset;

  @override
  Future<Result<AdhkarDataset>> loadDataset() async {
    if (_cachedDataset != null) {
      return Success(_cachedDataset!);
    }

    try {
      final rawJson = _jsonContentOverride ??
          await rootBundle.loadString('assets/data/adhkar.json');
      final Map<String, dynamic> decoded =
          jsonDecode(rawJson) as Map<String, dynamic>;
      final dataset = AdhkarDataset.fromJson(decoded);
      _cachedDataset = dataset;
      return Success(dataset);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure(
          'Failed to load verified adhkar dataset: $e',
        ),
      );
    }
  }

  @override
  Future<Result<List<AdhkarItem>>> getItemsForCategory(
    AdhkarCategory category,
  ) async {
    final datasetResult = await loadDataset();
    return switch (datasetResult) {
      Success(:final value) => Success(value.itemsForCategory(category)),
      FailureResult(:final failure) => FailureResult(failure),
    };
  }

  @override
  Future<Result<Map<String, AdhkarItemProgress>>> getProgressForCategory({
    required String localDate,
    required AdhkarCategory category,
  }) async {
    try {
      final itemsResult = await getItemsForCategory(category);
      if (itemsResult is FailureResult<List<AdhkarItem>>) {
        return FailureResult(itemsResult.failure);
      }
      final items = (itemsResult as Success<List<AdhkarItem>>).value;

      final records = await _database.getAdhkarDailyProgressForDate(localDate);
      final recordsByItem = {for (final r in records) r.itemId: r};

      final progressMap = <String, AdhkarItemProgress>{};
      for (final item in items) {
        final record = recordsByItem[item.id];
        if (record != null) {
          progressMap[item.id] = AdhkarItemProgress(
            itemId: item.id,
            category: category.key,
            currentCount: record.currentCount,
            targetCount: item.repeat,
            isCompleted: record.isCompleted,
          );
        } else {
          progressMap[item.id] = AdhkarItemProgress(
            itemId: item.id,
            category: category.key,
            currentCount: 0,
            targetCount: item.repeat,
            isCompleted: false,
          );
        }
      }

      return Success(progressMap);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to load adhkar progress: $e'),
      );
    }
  }

  @override
  Future<Result<Map<AdhkarCategory, AdhkarCategoryProgress>>>
      getAllCategoriesProgress({
    required String localDate,
  }) async {
    try {
      final datasetResult = await loadDataset();
      if (datasetResult is FailureResult<AdhkarDataset>) {
        return FailureResult(datasetResult.failure);
      }
      final dataset = (datasetResult as Success<AdhkarDataset>).value;

      final records = await _database.getAdhkarDailyProgressForDate(localDate);
      final recordsByItem = {for (final r in records) r.itemId: r};

      final resultMap = <AdhkarCategory, AdhkarCategoryProgress>{};

      for (final category in AdhkarCategory.values) {
        final items = dataset.itemsForCategory(category);
        var completedItems = 0;
        var totalRepsDone = 0;
        var totalRepsTarget = 0;

        for (final item in items) {
          totalRepsTarget += item.repeat;
          final rec = recordsByItem[item.id];
          if (rec != null) {
            totalRepsDone += rec.currentCount;
            if (rec.isCompleted) {
              completedItems++;
            }
          }
        }

        resultMap[category] = AdhkarCategoryProgress(
          category: category,
          totalItems: items.length,
          completedItems: completedItems,
          totalRepetitionsDone: totalRepsDone,
          totalRepetitionsTarget: totalRepsTarget,
        );
      }

      return Success(resultMap);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to load all categories progress: $e'),
      );
    }
  }

  @override
  Future<Result<AdhkarItemProgress>> incrementProgress({
    required String localDate,
    required AdhkarItem item,
    required AdhkarCategory category,
  }) async {
    try {
      final records = await _database.getAdhkarDailyProgressForDate(localDate);
      final existing = records.cast<AdhkarDailyProgressRecord?>().firstWhere(
            (r) => r?.itemId == item.id,
            orElse: () => null,
          );

      final nextCount = (existing?.currentCount ?? 0) + 1;
      final isNowCompleted = nextCount >= item.repeat;

      final saved = await _database.upsertAdhkarItemProgress(
        date: localDate,
        itemId: item.id,
        category: category.key,
        currentCount: nextCount,
        targetCount: item.repeat,
        isCompleted: isNowCompleted,
      );

      return Success(
        AdhkarItemProgress(
          itemId: saved.itemId,
          category: saved.category,
          currentCount: saved.currentCount,
          targetCount: saved.targetCount,
          isCompleted: saved.isCompleted,
        ),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to increment adhkar progress: $e'),
      );
    }
  }

  @override
  Future<Result<AdhkarItemProgress>> toggleItemComplete({
    required String localDate,
    required AdhkarItem item,
    required AdhkarCategory category,
  }) async {
    try {
      final records = await _database.getAdhkarDailyProgressForDate(localDate);
      final existing = records.cast<AdhkarDailyProgressRecord?>().firstWhere(
            (r) => r?.itemId == item.id,
            orElse: () => null,
          );

      final wasCompleted = existing?.isCompleted ?? false;
      final nextCompleted = !wasCompleted;
      final nextCount = nextCompleted ? item.repeat : 0;

      final saved = await _database.upsertAdhkarItemProgress(
        date: localDate,
        itemId: item.id,
        category: category.key,
        currentCount: nextCount,
        targetCount: item.repeat,
        isCompleted: nextCompleted,
      );

      return Success(
        AdhkarItemProgress(
          itemId: saved.itemId,
          category: saved.category,
          currentCount: saved.currentCount,
          targetCount: saved.targetCount,
          isCompleted: saved.isCompleted,
        ),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to toggle adhkar item complete: $e'),
      );
    }
  }

  @override
  Future<Result<void>> resetCategoryProgress({
    required String localDate,
    required AdhkarCategory category,
  }) async {
    try {
      await _database.resetAdhkarProgressForCategory(
        date: localDate,
        category: category.key,
      );
      return const Success(null);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to reset adhkar category: $e'),
      );
    }
  }
}
