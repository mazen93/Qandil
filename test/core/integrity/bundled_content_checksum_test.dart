import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

/// Phase 13 Release Hardening: Content-Integrity Checksum & Source Release Verification Test.
///
/// Master Rule:
/// "Add a content-integrity test that compares a checksum of bundled Quran data
/// against the source release."
void main() {
  group('Phase 13 Bundled Content-Integrity SHA-256 Checksum Tests', () {
    /// Canonical SHA-256 digest of the verified `assets/data/quran_prelive_seed.json` release.
    const expectedQuranPreliveSeedSha256 =
        'a12fe4e9ed00da0282e5b0501fbd768d96f3ca4fc67a366547bec070bbf0f4c4';

    /// Canonical SHA-256 digest of the verified `assets/data/adhkar.json` release
    /// (`Seen-Arabic/Morning-And-Evening-Adhkar-DB` / Hisn al-Muslim + `islamic-library-data`).
    const expectedAdhkarJsonSha256 =
        'd80071c2d90cac38db74ba81a69671bcef7cc2e5d018cd91863a2bdd72a62961';

    test(
      'bundled Quran data (assets/data/quran_prelive_seed.json) matches exact source release SHA-256 checksum and Uthmani record integrity',
      () {
        final file = File('assets/data/quran_prelive_seed.json');
        expect(
          file.existsSync(),
          isTrue,
          reason: 'assets/data/quran_prelive_seed.json must exist in bundle',
        );

        final bytes = file.readAsBytesSync();
        final actualSha256 = sha256.convert(bytes).toString();

        expect(
          actualSha256,
          equals(expectedQuranPreliveSeedSha256),
          reason:
              'CRITICAL CONTENT INTEGRITY VIOLATION: assets/data/quran_prelive_seed.json '
              'SHA-256 checksum ($actualSha256) does not match the verified source release '
              '($expectedQuranPreliveSeedSha256). Quranic seed data must never be altered.',
        );

        // Also verify structural & verse-level integrity of the parsed JSON
        final decoded = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
        final chapters = decoded['chapters'] as List<dynamic>;
        final verses = decoded['verses'] as List<dynamic>;

        expect(chapters.length, greaterThanOrEqualTo(2));
        expect(verses, isNotEmpty);

        // Verify Surah Al-Fatihah (1:1 to 1:7) is intact with full Uthmani diacritics
        final fatihahVerses = verses
            .cast<Map<String, dynamic>>()
            .where((v) => v['chapter_id'] == 1)
            .toList();
        expect(fatihahVerses.length, 7);

        final ayah1 = fatihahVerses.firstWhere((v) => v['verse_key'] == '1:1');
        expect(
          ayah1['text_uthmani'],
          equals('بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ'),
        );
      },
    );

    test(
      'bundled Adhkar data (assets/data/adhkar.json) matches exact source release SHA-256 checksum',
      () {
        final file = File('assets/data/adhkar.json');
        expect(
          file.existsSync(),
          isTrue,
          reason: 'assets/data/adhkar.json must exist in bundle',
        );

        final bytes = file.readAsBytesSync();
        final actualSha256 = sha256.convert(bytes).toString();

        expect(
          actualSha256,
          equals(expectedAdhkarJsonSha256),
          reason:
              'CRITICAL CONTENT INTEGRITY VIOLATION: assets/data/adhkar.json '
              'SHA-256 checksum ($actualSha256) does not match the verified source release '
              '($expectedAdhkarJsonSha256). Adhkar data must never be altered.',
        );
      },
    );
  });
}
