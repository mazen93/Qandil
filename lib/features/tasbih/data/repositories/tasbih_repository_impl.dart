import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/tasbih_entities.dart';
import '../../domain/repositories/tasbih_repository.dart';
import '../../domain/services/tasbih_stats_calculator.dart';

/// Concrete Drift-backed implementation of [TasbihRepository].
class TasbihRepositoryImpl implements TasbihRepository {
  TasbihRepositoryImpl({
    required AppDatabase database,
    DateTime Function()? clock,
    AssetBundle? assetBundle,
  })  : _database = database,
        _clock = clock ?? DateTime.now,
        _assetBundle = assetBundle;

  final AppDatabase _database;
  final DateTime Function() _clock;
  final AssetBundle? _assetBundle;

  static const String _phase8AdhkarAssetPath = 'assets/data/adhkar.json';

  @override
  Future<Result<void>> recordIncrement({
    required String dhikrId,
    required int count,
    DateTime? nowLocal,
  }) async {
    try {
      final now = nowLocal ?? _clock();
      final localDate = TasbihStatsCalculator.formatLocalDate(now);
      await _database.recordTasbihIncrement(
        dhikrId: dhikrId,
        count: count,
        localDate: localDate,
        timestamp: now.toUtc(),
      );
      return const Success(null);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to record tasbih increment: $e'),
      );
    }
  }

  @override
  Future<Result<int>> undoLastIncrement({
    required String dhikrId,
    DateTime? nowLocal,
  }) async {
    try {
      final now = nowLocal ?? _clock();
      final localDate = TasbihStatsCalculator.formatLocalDate(now);
      final undoneCount = await _database.undoLastTasbihIncrement(
        dhikrId: dhikrId,
        localDate: localDate,
      );
      return Success(undoneCount);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to undo tasbih increment: $e'),
      );
    }
  }

  @override
  Future<Result<TasbihStatsSummary>> getStatsSummary({
    required TasbihStatsPeriod period,
    DateTime? nowLocal,
  }) async {
    try {
      final now = nowLocal ?? _clock();
      final rows = await _database.getAllTasbihDaily();
      final entries = rows
          .map(
            (r) => TasbihDailyEntry(
              date: r.date,
              dhikrId: r.dhikrId,
              total: r.total,
            ),
          )
          .toList(growable: false);

      final summary = TasbihStatsCalculator.computeSummary(
        entries: entries,
        nowLocal: now,
        period: period,
      );
      return Success(summary);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to compute tasbih statistics: $e'),
      );
    }
  }

  @override
  Future<Result<List<TasbihDhikrOption>>> getDhikrOptions({
    required String languageCode,
  }) async {
    try {
      final options = <TasbihDhikrOption>[
        // Structural default counter slot (zero memory-generated religious text)
        TasbihDhikrOption(
          id: 'general_tasbih',
          label: languageCode == 'ar' ? 'تسبيح عام' : 'General Tasbih',
          isCustom: false,
        ),
      ];

      // 1. Load any verified items from Phase 8 assets/data/adhkar.json if present
      try {
        final bundle = _assetBundle ?? rootBundle;
        final rawJson = await bundle.loadString(_phase8AdhkarAssetPath);
        final decoded = jsonDecode(rawJson);
        final list = decoded is List
            ? decoded
            : (decoded is Map<String, dynamic> ? decoded['items'] : null);
        if (list is List) {
          for (final item in list.whereType<Map<String, dynamic>>()) {
            final id = '${item['id'] ?? ''}';
            final arabic = (item['arabic'] as String?)?.trim() ?? '';
            if (id.isNotEmpty && arabic.isNotEmpty) {
              options.add(
                TasbihDhikrOption(
                  id: 'adhkar_$id',
                  label: arabic,
                  isCustom: false,
                ),
              );
            }
          }
        }
      } catch (_) {
        // Phase 8 adhkar.json not yet supplied; continue cleanly with general + user custom labels.
      }

      // 2. Load custom user-typed labels from Drift settings
      final settingsRow = await _database.getOrCreateSettings();
      final customList = _parseCustomLabels(
        settingsRow.tasbihCustomLabelsJson,
      );
      options.addAll(customList);

      return Success(options);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to load dhikr options: $e'),
      );
    }
  }

  @override
  Future<Result<List<TasbihDhikrOption>>> addCustomDhikrLabel({
    required String label,
    required String languageCode,
  }) async {
    final trimmed = label.trim();
    if (trimmed.isEmpty) {
      return getDhikrOptions(languageCode: languageCode);
    }

    try {
      final settingsRow = await _database.getOrCreateSettings();
      final customList = _parseCustomLabels(
        settingsRow.tasbihCustomLabelsJson,
      ).toList();

      final customId =
          'custom_${DateTime.now().millisecondsSinceEpoch}_${customList.length + 1}';
      customList.add(
        TasbihDhikrOption(
          id: customId,
          label: trimmed,
          isCustom: true,
        ),
      );

      final encoded = jsonEncode(
        customList.map((c) => c.toJson()).toList(growable: false),
      );
      await _database.updateSettings(
        SettingsCompanion(
          tasbihCustomLabelsJson: Value(encoded),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

      return getDhikrOptions(languageCode: languageCode);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to save custom dhikr label: $e'),
      );
    }
  }

  @override
  Future<Result<String>> buildExportJson({DateTime? nowLocal}) async {
    try {
      final now = nowLocal ?? _clock();
      final dailyRows = await _database.getAllTasbihDaily();
      final eventRows = await _database.getAllTasbihEvents();

      final entries = dailyRows
          .map(
            (r) => TasbihDailyEntry(
              date: r.date,
              dhikrId: r.dhikrId,
              total: r.total,
            ),
          )
          .toList(growable: false);

      final summary = TasbihStatsCalculator.computeSummary(
        entries: entries,
        nowLocal: now,
        period: TasbihStatsPeriod.allTime,
      );

      final payload = <String, dynamic>{
        'app': 'Qandil',
        'exportedAt': now.toUtc().toIso8601String(),
        'summary': {
          'todayTotal': summary.todayTotal,
          'sevenDaysTotal': summary.sevenDaysTotal,
          'thirtyDaysTotal': summary.thirtyDaysTotal,
          'allTimeTotal': summary.allTimeTotal,
          'currentStreakDays': summary.currentStreakDays,
          'bestStreakDays': summary.bestStreakDays,
          'perDhikrBreakdown': summary.perDhikrBreakdown,
        },
        'tasbih_daily': dailyRows
            .map(
              (r) => {
                'date': r.date,
                'dhikrId': r.dhikrId,
                'total': r.total,
              },
            )
            .toList(growable: false),
        'tasbih_events': eventRows
            .map(
              (e) => {
                'id': e.id,
                'dhikrId': e.dhikrId,
                'count': e.count,
                'timestamp': e.timestamp.toUtc().toIso8601String(),
              },
            )
            .toList(growable: false),
      };

      const encoder = JsonEncoder.withIndent('  ');
      return Success(encoder.convert(payload));
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Failed to build tasbih export JSON: $e'),
      );
    }
  }

  List<TasbihDhikrOption> _parseCustomLabels(String rawJson) {
    if (rawJson.trim().isEmpty || rawJson.trim() == '[]') {
      return const [];
    }
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! List) return const [];
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(TasbihDhikrOption.fromJson)
          .where((o) => o.label.trim().isNotEmpty)
          .toList(growable: false);
    } catch (_) {
      return const [];
    }
  }
}
