import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/adhkar/domain/entities/adhkar_entities.dart';

void main() {
  group('Phase 8 Adhkar JSON Schema & Content Integrity Tests', () {
    late Map<String, dynamic> rawJson;
    late AdhkarDataset dataset;

    setUpAll(() {
      final file = File('assets/data/adhkar.json');
      expect(file.existsSync(), isTrue,
          reason: 'assets/data/adhkar.json must exist in project assets');
      final content = file.readAsStringSync();
      rawJson = jsonDecode(content) as Map<String, dynamic>;
      dataset = AdhkarDataset.fromJson(rawJson);
    });

    test('metadata: schema_version, sources, and categories exist', () {
      expect(dataset.schemaVersion, greaterThanOrEqualTo(1));
      expect(dataset.sources, isNotEmpty);
      expect(dataset.categories, isNotEmpty);
      expect(dataset.items, isNotEmpty);

      // Verify that source attribution contains credit text
      final firstSource = dataset.sources.first;
      expect(firstSource.creditText, isNotEmpty);
    });

    test('all 11 canonical categories are defined in schema', () {
      final definedCategoryIds = dataset.categories.map((c) => c.id).toSet();
      for (final canonical in AdhkarCategory.values) {
        expect(
          definedCategoryIds.contains(canonical.key),
          isTrue,
          reason:
              'Category ${canonical.key} must be defined in categories list',
        );
      }
    });

    test(
        'STRICT CONTENT INTEGRITY: no item has empty Arabic text, and every item has valid id and repeat count',
        () {
      final missingFieldsReport = <String>[];

      for (var i = 0; i < dataset.items.length; i++) {
        final item = dataset.items[i];

        // 1. Mandatory ID
        expect(item.id.trim(), isNotEmpty,
            reason: 'Item at index $i must have a non-empty id');

        // 2. CRITICAL MASTER RULE: Fail build if any item has empty Arabic text
        expect(item.arabic.trim(), isNotEmpty,
            reason: 'Item ${item.id} at index $i has empty Arabic text!');

        // 3. Repeat count must be positive integer
        expect(item.repeat, greaterThanOrEqualTo(1),
            reason: 'Item ${item.id} must have repeat >= 1');

        // 4. Must belong to at least one valid category
        expect(item.categories, isNotEmpty,
            reason: 'Item ${item.id} must belong to at least one category');
        for (final catKey in item.categories) {
          expect(
            AdhkarCategory.tryFromKey(catKey),
            isNotNull,
            reason: 'Item ${item.id} references unknown category $catKey',
          );
        }

        // 5. Check optional fields and report if missing
        if (item.sourceRef == null || item.sourceRef!.trim().isEmpty) {
          missingFieldsReport.add('Item ${item.id}: missing sourceRef');
        }
        if (item.fadl == null || item.fadl!.trim().isEmpty) {
          missingFieldsReport.add('Item ${item.id}: missing fadl (optional)');
        }
        if (item.translations.isEmpty) {
          missingFieldsReport
              .add('Item ${item.id}: missing translations (optional)');
        }
      }

      // Output missing fields report for transparency (does not fail build for optional fields)
      if (missingFieldsReport.isNotEmpty) {
        // ignore: avoid_print
        print(
            'Adhkar Schema Integrity Report: ${missingFieldsReport.length} optional notices:');
        for (final notice in missingFieldsReport.take(10)) {
          // ignore: avoid_print
          print(' - $notice');
        }
        if (missingFieldsReport.length > 10) {
          // ignore: avoid_print
          print(' ... and ${missingFieldsReport.length - 10} more.');
        }
      }
    });

    test('morning and evening categories contain items', () {
      final morningItems = dataset.itemsForCategory(AdhkarCategory.morning);
      final eveningItems = dataset.itemsForCategory(AdhkarCategory.evening);

      expect(morningItems, isNotEmpty);
      expect(eveningItems, isNotEmpty);
    });
  });
}
