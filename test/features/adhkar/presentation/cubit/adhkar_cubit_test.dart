import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/core/database/app_database.dart';
import 'package:qandil/features/adhkar/data/repositories/adhkar_repository_impl.dart';
import 'package:qandil/features/adhkar/domain/entities/adhkar_entities.dart';
import 'package:qandil/features/adhkar/presentation/cubit/adhkar_cubit.dart';

void main() {
  late AppDatabase db;
  late AdhkarRepositoryImpl repository;
  late String adhkarJsonString;
  late DateTime fakeNow;

  setUpAll(() {
    adhkarJsonString = File('assets/data/adhkar.json').readAsStringSync();
  });

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = AdhkarRepositoryImpl(
      database: db,
      jsonContentOverride: adhkarJsonString,
    );
    fakeNow = DateTime(2026, 11, 27, 8, 30);
  });

  tearDown(() async {
    await db.close();
  });

  group('AdhkarCubit & AdhkarRepositoryImpl', () {
    test('initializes dataset and loads all 11 canonical categories', () async {
      final cubit = AdhkarCubit(
        repository: repository,
        clock: () => fakeNow,
      );

      await cubit.initialize();

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.dataset, isNotNull);
      expect(
          cubit.state.categoriesProgress.length, AdhkarCategory.values.length);

      final morningProgress =
          cubit.state.categoriesProgress[AdhkarCategory.morning];
      expect(morningProgress, isNotNull);
      expect(morningProgress!.totalItems, greaterThan(0));
      expect(morningProgress.completedItems, 0);

      await cubit.close();
    });

    test(
        'selects category, increments item repetitions, marks complete, and persists in Drift',
        () async {
      final cubit = AdhkarCubit(
        repository: repository,
        clock: () => fakeNow,
      );

      await cubit.initialize();
      await cubit.selectCategory(AdhkarCategory.morning);

      expect(cubit.state.activeCategoryItems, isNotEmpty);
      final firstItem = cubit.state.activeCategoryItems.first;
      expect(cubit.state.currentItem?.id, firstItem.id);

      // Increment repetitions until target is reached
      for (var r = 0; r < firstItem.repeat; r++) {
        await cubit.incrementCurrentItem();
      }

      final progress = cubit.state.currentItemProgress;
      expect(progress, isNotNull);
      expect(progress!.currentCount, firstItem.repeat);
      expect(progress.isCompleted, isTrue);

      // Verify Drift DB holds the row on today's date
      final dbRows = await db.getAdhkarDailyProgressForDate('2026-11-27');
      expect(dbRows.length, 1);
      expect(dbRows.first.itemId, firstItem.id);
      expect(dbRows.first.isCompleted, isTrue);

      // Toggle complete off
      await cubit.toggleCurrentItemComplete();
      expect(cubit.state.currentItemProgress?.isCompleted, isFalse);

      await cubit.close();
    });

    test('daily reset resets category progress for today', () async {
      final cubit = AdhkarCubit(
        repository: repository,
        clock: () => fakeNow,
      );

      await cubit.initialize();
      await cubit.selectCategory(AdhkarCategory.morning);
      await cubit.incrementCurrentItem();

      expect(cubit.state.currentItemProgress?.currentCount, 1);

      // Reset category for today
      await cubit.resetActiveCategoryToday();

      expect(cubit.state.currentItemProgress?.currentCount, 0);
      final dbRows = await db.getAdhkarDailyProgressForDate('2026-11-27');
      expect(dbRows, isEmpty);

      await cubit.close();
    });

    test(
        'date isolation: counts recorded on one day do not leak into next day (automatic midnight reset)',
        () async {
      // Day 1
      final day1Clock = DateTime(2026, 11, 27, 8, 0);
      final cubitDay1 = AdhkarCubit(
        repository: repository,
        clock: () => day1Clock,
      );
      await cubitDay1.initialize();
      await cubitDay1.selectCategory(AdhkarCategory.morning);
      await cubitDay1.incrementCurrentItem();
      expect(cubitDay1.state.currentItemProgress?.currentCount, 1);
      await cubitDay1.close();

      // Day 2 (new calendar day)
      final day2Clock = DateTime(2026, 11, 28, 8, 0);
      final cubitDay2 = AdhkarCubit(
        repository: repository,
        clock: () => day2Clock,
      );
      await cubitDay2.initialize();
      await cubitDay2.selectCategory(AdhkarCategory.morning);

      // Verify that on Day 2, the progress starts fresh at 0
      expect(cubitDay2.state.currentItemProgress?.currentCount, 0);
      expect(cubitDay2.state.currentItemProgress?.isCompleted, isFalse);

      await cubitDay2.close();
    });
  });
}
