import 'package:flutter/foundation.dart';

/// Time period filter on the Phase 7 Tasbih Statistics screen.
enum TasbihStatsPeriod {
  today,
  sevenDays,
  thirtyDays,
  allTime,
}

/// Option in the Tasbih Dhikr Picker (either loaded from Phase 8 `adhkar.json` or a custom label typed by the user).
@immutable
class TasbihDhikrOption {
  const TasbihDhikrOption({
    required this.id,
    required this.label,
    this.isCustom = false,
  });

  factory TasbihDhikrOption.fromJson(Map<String, dynamic> json) {
    return TasbihDhikrOption(
      id: json['id'] as String? ?? 'custom',
      label: json['label'] as String? ?? '',
      isCustom: json['isCustom'] as bool? ?? true,
    );
  }

  final String id;
  final String label;
  final bool isCustom;

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'isCustom': isCustom,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasbihDhikrOption &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          label == other.label &&
          isCustom == other.isCustom;

  @override
  int get hashCode => Object.hash(id, label, isCustom);
}

/// Aggregated daily total for a single local calendar date (`YYYY-MM-DD`).
@immutable
class TasbihDailyPoint {
  const TasbihDailyPoint({
    required this.localDate,
    required this.totalCount,
  });

  final String localDate;
  final int totalCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasbihDailyPoint &&
          runtimeType == other.runtimeType &&
          localDate == other.localDate &&
          totalCount == other.totalCount;

  @override
  int get hashCode => Object.hash(localDate, totalCount);
}

/// Complete statistics snapshot computed by [TasbihStatsCalculator].
@immutable
class TasbihStatsSummary {
  const TasbihStatsSummary({
    required this.period,
    required this.todayTotal,
    required this.sevenDaysTotal,
    required this.thirtyDaysTotal,
    required this.allTimeTotal,
    required this.periodTotal,
    required this.currentStreakDays,
    required this.bestStreakDays,
    required this.dailyChartPoints,
    required this.perDhikrBreakdown,
  });

  final TasbihStatsPeriod period;
  final int todayTotal;
  final int sevenDaysTotal;
  final int thirtyDaysTotal;
  final int allTimeTotal;
  final int periodTotal;
  final int currentStreakDays;
  final int bestStreakDays;
  final List<TasbihDailyPoint> dailyChartPoints;

  /// Maps `dhikrId` -> total count within the selected [period].
  final Map<String, int> perDhikrBreakdown;

  bool get isEmpty => allTimeTotal == 0;
}
