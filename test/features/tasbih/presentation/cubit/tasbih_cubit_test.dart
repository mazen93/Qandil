import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/core/database/app_database.dart';
import 'package:qandil/core/result/result.dart';
import 'package:qandil/features/tasbih/data/repositories/tasbih_repository_impl.dart';
import 'package:qandil/features/tasbih/domain/entities/tasbih_entities.dart';
import 'package:qandil/features/tasbih/presentation/cubit/tasbih_cubit.dart';

void main() {
  late AppDatabase db;
  late TasbihRepositoryImpl repository;
  late DateTime fakeNow;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = TasbihRepositoryImpl(database: db);
    fakeNow = DateTime(2026, 7, 20, 19, 15);
  });

  tearDown(() async {
    await db.close();
  });

  group('TasbihCubit & TasbihRepositoryImpl — Immediate Persistence & Controls',
      () {
    test(
        'every tap writes to tasbih_events and updates tasbih_daily in the same transaction and survives app kill',
        () async {
      final cubit1 = TasbihCubit(
        repository: repository,
        clock: () => fakeNow,
      );
      await cubit1.initialize(languageCode: 'ar', initialTargetPreset: 33);

      // Tap 3 times
      await cubit1.increment();
      await cubit1.increment();
      await cubit1.increment();

      expect(cubit1.state.sessionCount, 3);
      expect(cubit1.state.statsSummary?.todayTotal, 3);
      expect(cubit1.state.statsSummary?.currentStreakDays, 1);

      // Simulate sudden app kill by closing cubit1 immediately without calling save/reset
      await cubit1.close();

      // Verify underlying Drift tables persisted both events and daily summary
      final events = await db.getAllTasbihEvents();
      expect(events.length, 3);
      final dailyRows = await db.getAllTasbihDaily();
      expect(dailyRows.length, 1);
      expect(dailyRows.first.total, 3);
      expect(dailyRows.first.date, '2026-07-20');

      // Re-open app with a brand new TasbihCubit instance on the same database
      final cubit2 = TasbihCubit(
        repository: repository,
        clock: () => fakeNow,
      );
      await cubit2.initialize(languageCode: 'ar', initialTargetPreset: 33);

      // Verify zero count loss after app restart
      expect(cubit2.state.statsSummary?.todayTotal, 3);
      expect(cubit2.state.statsSummary?.allTimeTotal, 3);
      expect(cubit2.state.statsSummary?.currentStreakDays, 1);

      await cubit2.close();
    });

    test(
        'undo removes the most recent increment event and decrements daily total',
        () async {
      final cubit = TasbihCubit(
        repository: repository,
        clock: () => fakeNow,
      );
      await cubit.initialize(languageCode: 'en');

      await cubit.increment();
      await cubit.increment();
      expect(cubit.state.sessionCount, 2);
      expect(cubit.state.statsSummary?.todayTotal, 2);

      await cubit.undo();
      expect(cubit.state.sessionCount, 1);
      expect(cubit.state.statsSummary?.todayTotal, 1);

      final events = await db.getAllTasbihEvents();
      expect(events.length, 1);

      await cubit.close();
    });

    test(
        'supports target presets (33, 99, 100, custom), custom dhikr labels, and JSON export',
        () async {
      final cubit = TasbihCubit(
        repository: repository,
        clock: () => fakeNow,
      );
      await cubit.initialize(languageCode: 'ar', initialTargetPreset: 33);

      // Add a custom user-typed dhikr label
      await cubit.addCustomDhikr(
        label: 'ذكر مخصص للاختبار',
        languageCode: 'ar',
      );
      expect(cubit.state.selectedDhikr.label, 'ذكر مخصص للاختبار');
      expect(cubit.state.selectedDhikr.isCustom, isTrue);

      // Change target preset to 99 and tap
      cubit.setTargetPreset(99);
      expect(cubit.state.targetPreset, 99);
      await cubit.increment(step: 99);
      expect(cubit.state.completedRoundsInSession, 1);

      // Switch period to All Time
      await cubit.setStatsPeriod(TasbihStatsPeriod.allTime);
      expect(cubit.state.selectedPeriod, TasbihStatsPeriod.allTime);
      expect(cubit.state.statsSummary?.allTimeTotal, 99);

      // Export JSON
      final exportResult = await cubit.buildExportJson();
      expect(exportResult, isA<Success<String>>());
      final jsonMap = jsonDecode((exportResult as Success<String>).value)
          as Map<String, dynamic>;
      expect(jsonMap['app'], 'Qandil');
      expect((jsonMap['tasbih_daily'] as List).length, 1);
      expect((jsonMap['tasbih_events'] as List).length, 1);

      await cubit.close();
    });
  });
}
