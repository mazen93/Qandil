import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/result/result.dart';
import '../models/quran_api_models.dart';
import 'quran_local_repository_impl.dart';

/// Seeds the local Drift database with the bundled official Quran Foundation v4
/// pre-production dataset (Surah 1 Al-Fatihah Page 1 & Surah 2 Al-Baqarah Page 2,
/// Tafsir Al-Muyassar ID 16, and The Clear Quran ID 131) when the cache is empty.
///
/// Content Integrity Rule: The seed file is a direct, unaltered snapshot from
/// Quran Foundation Content API v4 (`api.quran.com/api/v4`).
abstract final class QuranBundledSeedLoader {
  static const String seedAssetPath = 'assets/data/quran_prelive_seed.json';

  static Future<void> seedIfEmpty(
    QuranLocalRepositoryImpl localRepository, {
    AssetBundle? bundle,
  }) async {
    final existingChapters = await localRepository.getChapters(
      languageCode: 'ar',
    );
    if (existingChapters is Success) {
      return;
    }

    try {
      final effectiveBundle = bundle ?? rootBundle;
      final jsonString = await effectiveBundle.loadString(seedAssetPath);
      final decoded = jsonDecode(jsonString);
      if (decoded is! Map<String, dynamic>) return;

      final rawChapters = decoded['chapters'];
      if (rawChapters is List) {
        final chapters = rawChapters
            .whereType<Map<String, dynamic>>()
            .map(QuranApiModels.parseChapter)
            .toList(growable: false);
        await localRepository.cacheChapters(chapters, languageCode: 'ar');
        await localRepository.cacheChapters(chapters, languageCode: 'en');
      }

      final rawVerses = decoded['verses'];
      if (rawVerses is List) {
        final verses = rawVerses
            .whereType<Map<String, dynamic>>()
            .map(QuranApiModels.parseVerse)
            .toList(growable: false);
        await localRepository.cacheVerses(verses);
      }

      final rawTafsirCatalog = decoded['tafsirs_catalog'];
      if (rawTafsirCatalog is List) {
        final catalog = rawTafsirCatalog
            .whereType<Map<String, dynamic>>()
            .map(QuranApiModels.parseTafsirResource)
            .toList(growable: false);
        await localRepository.cacheTafsirList(catalog, languageCode: 'ar');
        await localRepository.cacheTafsirList(catalog, languageCode: 'en');
      }

      final rawTranslationCatalog = decoded['translations_catalog'];
      if (rawTranslationCatalog is List) {
        final catalog = rawTranslationCatalog
            .whereType<Map<String, dynamic>>()
            .map(QuranApiModels.parseTranslationResource)
            .toList(growable: false);
        await localRepository.cacheTranslationList(catalog, languageCode: 'ar');
        await localRepository.cacheTranslationList(catalog, languageCode: 'en');
      }

      final rawRecitationsCatalog = decoded['recitations_catalog'];
      if (rawRecitationsCatalog is List) {
        final catalog = rawRecitationsCatalog
            .whereType<Map<String, dynamic>>()
            .map(QuranApiModels.parseRecitationResource)
            .toList(growable: false);
        await localRepository.cacheRecitationsList(catalog, languageCode: 'ar');
        await localRepository.cacheRecitationsList(catalog, languageCode: 'en');
      }

      final rawTafsirs = decoded['tafsirs'];
      if (rawTafsirs is List) {
        for (final item in rawTafsirs.whereType<Map<String, dynamic>>()) {
          final verseKey = item['verse_key'] as String? ?? '';
          final resourceId = (item['resource_id'] as num?)?.toInt() ?? 16;
          if (verseKey.isNotEmpty) {
            final parsed = QuranApiModels.parseVerseTafsir(
              item,
              tafsirId: resourceId,
              verseKey: verseKey,
            );
            await localRepository.cacheVerseTafsir(parsed);
          }
        }
      }
    } catch (_) {
      // Ignore asset loading errors in unit tests that do not load Flutter assets.
    }
  }
}
