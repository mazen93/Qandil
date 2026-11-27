import 'package:flutter/material.dart';

/// The 11 canonical categories of Adhkar and Duas in Qandil.
enum AdhkarCategory {
  morning('morning'),
  evening('evening'),
  afterPrayer('after_prayer'),
  sleep('sleep'),
  waking('waking'),
  travel('travel'),
  food('food'),
  mosque('mosque'),
  generalDuas('general_duas'),
  quranicDuas('quranic_duas'),
  khatmDua('khatm_dua'),
  home('home'),
  wudu('wudu');

  const AdhkarCategory(this.key);
  final String key;

  static AdhkarCategory fromKey(String key) {
    for (final cat in values) {
      if (cat.key == key) return cat;
    }
    return AdhkarCategory.morning;
  }

  static AdhkarCategory? tryFromKey(String key) {
    for (final cat in values) {
      if (cat.key == key) return cat;
    }
    return null;
  }

  String titleAr() {
    return switch (this) {
      morning => 'أذكار الصباح',
      evening => 'أذكار المساء',
      afterPrayer => 'أذكار بعد الصلاة',
      sleep => 'أذكار النوم',
      waking => 'دعاء الاستيقاظ',
      travel => 'أدعية السفر',
      food => 'أدعية الطعام',
      mosque => 'أدعية المسجد',
      generalDuas => 'أدعية عامة',
      quranicDuas => 'أدعية قرآنية',
      khatmDua => 'دعاء ختم القرآن',
      home => 'دخول المنزل والخروج منه',
      wudu => 'أدعية الوضوء',
    };
  }

  String titleEn() {
    return switch (this) {
      morning => 'Morning Adhkar',
      evening => 'Evening Adhkar',
      afterPrayer => 'After Prayer',
      sleep => 'Sleep Adhkar',
      waking => 'Waking Up',
      travel => 'Travel Duas',
      food => 'Food Duas',
      mosque => 'Mosque Duas',
      generalDuas => 'General Duas',
      quranicDuas => 'Quranic Duas',
      khatmDua => 'Khatm al-Quran Dua',
      home => 'Home Duas',
      wudu => 'Wudu Duas',
    };
  }

  IconData icon() {
    return switch (this) {
      morning => Icons.wb_sunny_outlined,
      evening => Icons.nightlight_round_outlined,
      afterPrayer => Icons.access_time_rounded,
      sleep => Icons.bedtime_outlined,
      waking => Icons.alarm_on_outlined,
      travel => Icons.flight_takeoff_rounded,
      food => Icons.restaurant_rounded,
      mosque => Icons.mosque_outlined,
      generalDuas => Icons.favorite_border_rounded,
      quranicDuas => Icons.menu_book_rounded,
      khatmDua => Icons.bookmark_added_outlined,
      home => Icons.home_outlined,
      wudu => Icons.water_drop_outlined,
    };
  }
}

/// A single verified dhikr or dua item from `assets/data/adhkar.json`.
@immutable
class AdhkarItem {
  const AdhkarItem({
    required this.id,
    required this.categories,
    required this.arabic,
    required this.repeat,
    this.repeatTextAr,
    this.fadl,
    this.sourceRef,
    this.dataset,
    this.translations = const {},
  });

  final String id;
  final List<String> categories;
  final String arabic;
  final int repeat;
  final String? repeatTextAr;
  final String? fadl;
  final String? sourceRef;
  final String? dataset;
  final Map<String, String> translations;

  bool belongsTo(AdhkarCategory category) {
    return categories.contains(category.key);
  }

  String? translationFor(String languageCode) {
    return translations[languageCode];
  }

  factory AdhkarItem.fromJson(Map<String, dynamic> json) {
    final rawCats = json['categories'];
    final cats = <String>[];
    if (rawCats is List) {
      for (final c in rawCats) {
        if (c is String) cats.add(c);
      }
    } else if (json['category'] is String) {
      cats.add(json['category'] as String);
    }

    final rawTrans = json['translations'];
    final translationsMap = <String, String>{};
    if (rawTrans is Map) {
      for (final entry in rawTrans.entries) {
        if (entry.key is String && entry.value is String) {
          translationsMap[entry.key as String] = entry.value as String;
        }
      }
    }

    final rawDataset = json['dataset'];
    final datasetStr = rawDataset is String
        ? rawDataset
        : (rawDataset is Map ? rawDataset['source_id']?.toString() : null);

    return AdhkarItem(
      id: (json['id'] ?? '').toString(),
      categories: cats,
      arabic: (json['arabic'] ?? '').toString(),
      repeat: (json['repeat'] as num?)?.toInt() ?? 1,
      repeatTextAr: json['repeat_text_ar']?.toString(),
      fadl: json['fadl']?.toString(),
      sourceRef: (json['source_ref'] ?? json['source'])?.toString(),
      dataset: datasetStr,
      translations: translationsMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categories': categories,
      'arabic': arabic,
      'repeat': repeat,
      if (repeatTextAr != null) 'repeat_text_ar': repeatTextAr,
      if (fadl != null) 'fadl': fadl,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (dataset != null) 'dataset': dataset,
      if (translations.isNotEmpty) 'translations': translations,
    };
  }
}

/// Daily completion state of an item for a given calendar date (`YYYY-MM-DD`).
@immutable
class AdhkarItemProgress {
  const AdhkarItemProgress({
    required this.itemId,
    required this.category,
    required this.currentCount,
    required this.targetCount,
    required this.isCompleted,
  });

  final String itemId;
  final String category;
  final int currentCount;
  final int targetCount;
  final bool isCompleted;

  double get progressFraction {
    if (targetCount <= 0) return 0.0;
    return (currentCount / targetCount).clamp(0.0, 1.0);
  }

  AdhkarItemProgress copyWith({
    int? currentCount,
    int? targetCount,
    bool? isCompleted,
  }) {
    return AdhkarItemProgress(
      itemId: itemId,
      category: category,
      currentCount: currentCount ?? this.currentCount,
      targetCount: targetCount ?? this.targetCount,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// Overall daily progress summary for an entire category.
@immutable
class AdhkarCategoryProgress {
  const AdhkarCategoryProgress({
    required this.category,
    required this.totalItems,
    required this.completedItems,
    required this.totalRepetitionsDone,
    required this.totalRepetitionsTarget,
  });

  final AdhkarCategory category;
  final int totalItems;
  final int completedItems;
  final int totalRepetitionsDone;
  final int totalRepetitionsTarget;

  double get progressFraction {
    if (totalItems <= 0) return 0.0;
    return (completedItems / totalItems).clamp(0.0, 1.0);
  }

  bool get isAllCompleted => totalItems > 0 && completedItems >= totalItems;
}

/// Source attribution metadata for credits screen.
@immutable
class AdhkarSourceAttribution {
  const AdhkarSourceAttribution({
    required this.id,
    required this.name,
    this.url,
    this.license,
    this.basedOn,
    required this.creditText,
  });

  final String id;
  final String name;
  final String? url;
  final String? license;
  final String? basedOn;
  final String creditText;

  factory AdhkarSourceAttribution.fromJson(Map<String, dynamic> json) {
    return AdhkarSourceAttribution(
      id: (json['id'] ?? '') as String,
      name: (json['name'] ?? '') as String,
      url: json['url'] as String?,
      license: json['license'] as String?,
      basedOn: json['based_on'] as String?,
      creditText: (json['credit_text'] ?? '') as String,
    );
  }
}

/// Category metadata inside `adhkar.json`.
@immutable
class AdhkarCategoryMeta {
  const AdhkarCategoryMeta({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.status,
    required this.itemCount,
  });

  final String id;
  final String nameAr;
  final String nameEn;
  final String status; // 'complete_from_source' | 'pending_import'
  final int itemCount;

  bool get isPendingImport => status == 'pending_import';

  factory AdhkarCategoryMeta.fromJson(Map<String, dynamic> json) {
    return AdhkarCategoryMeta(
      id: (json['id'] ?? '') as String,
      nameAr: (json['name_ar'] ?? '') as String,
      nameEn: (json['name_en'] ?? '') as String,
      status: (json['status'] ?? 'complete_from_source') as String,
      itemCount: (json['item_count'] as num?)?.toInt() ?? 0,
    );
  }
}

/// Full parsed verified adhkar dataset.
@immutable
class AdhkarDataset {
  const AdhkarDataset({
    required this.schemaVersion,
    required this.generated,
    required this.readme,
    required this.sources,
    required this.categories,
    required this.items,
  });

  final int schemaVersion;
  final String generated;
  final String readme;
  final List<AdhkarSourceAttribution> sources;
  final List<AdhkarCategoryMeta> categories;
  final List<AdhkarItem> items;

  List<AdhkarItem> itemsForCategory(AdhkarCategory category) {
    return items.where((it) => it.belongsTo(category)).toList(growable: false);
  }

  factory AdhkarDataset.fromJson(Map<String, dynamic> json) {
    final rawSources = json['sources'];
    final sourcesList = <AdhkarSourceAttribution>[];
    if (rawSources is List) {
      for (final s in rawSources) {
        if (s is Map<String, dynamic>) {
          sourcesList.add(AdhkarSourceAttribution.fromJson(s));
        }
      }
    }

    final rawCats = json['categories'];
    final catsList = <AdhkarCategoryMeta>[];
    if (rawCats is List) {
      for (final c in rawCats) {
        if (c is Map<String, dynamic>) {
          catsList.add(AdhkarCategoryMeta.fromJson(c));
        }
      }
    }

    final rawItems = json['items'];
    final itemsList = <AdhkarItem>[];
    if (rawItems is List) {
      for (final it in rawItems) {
        if (it is Map<String, dynamic>) {
          itemsList.add(AdhkarItem.fromJson(it));
        }
      }
    }

    return AdhkarDataset(
      schemaVersion: (json['schema_version'] as num?)?.toInt() ?? 1,
      generated: (json['generated'] ?? '') as String,
      readme: (json['readme'] ?? '') as String,
      sources: sourcesList,
      categories: catsList,
      items: itemsList,
    );
  }
}
