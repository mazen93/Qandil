import 'dart:convert';

import 'package:flutter/services.dart';

import '../entities/hifz_entities.dart';

/// Clearly marked extension point for Phase 12 Similar Verses (Mutashabihat).
///
/// Master Rule #1 & Phase 12 Prompt Constraint:
/// "Similar verses (mutashabihat): include only if I supply a verified dataset.
/// Otherwise leave a clearly marked extension point. Do not generate the pairs."
class MutashabihatExtensionPoint {
  const MutashabihatExtensionPoint({
    AssetBundle? assetBundle,
    this.assetPath = defaultAssetPath,
  }) : _assetBundle = assetBundle;

  static const String defaultAssetPath = 'assets/data/mutashabihat.json';

  final AssetBundle? _assetBundle;
  final String assetPath;

  /// Attempts to load verified mutashabihat pairs from [assetPath].
  /// If the user has not supplied `assets/data/mutashabihat.json`, returns
  /// `(isAvailable: false, pairs: const [])` without generating any pairs.
  Future<({bool isAvailable, List<MutashabihatPair> pairs})>
      loadVerifiedDatasetIfSupplied() async {
    try {
      final bundle = _assetBundle ?? rootBundle;
      final rawJson = await bundle.loadString(assetPath);
      if (rawJson.trim().isEmpty) {
        return (isAvailable: false, pairs: const <MutashabihatPair>[]);
      }
      final decoded = jsonDecode(rawJson);
      final rawList = decoded is Map<String, dynamic>
          ? decoded['pairs']
          : (decoded is List ? decoded : null);
      if (rawList is! List) {
        return (isAvailable: false, pairs: const <MutashabihatPair>[]);
      }

      final pairs = rawList
          .whereType<Map<String, dynamic>>()
          .map(MutashabihatPair.fromJson)
          .where(
            (p) =>
                p.firstVerseKey.trim().isNotEmpty &&
                p.secondVerseKey.trim().isNotEmpty &&
                p.sourceAttribution.trim().isNotEmpty,
          )
          .toList(growable: false);

      return (isAvailable: pairs.isNotEmpty, pairs: pairs);
    } catch (_) {
      // Verified dataset not supplied yet — return clean empty extension state.
      return (isAvailable: false, pairs: const <MutashabihatPair>[]);
    }
  }
}
