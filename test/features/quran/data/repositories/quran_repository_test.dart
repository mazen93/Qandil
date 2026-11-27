import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:qandil/core/database/app_database.dart';
import 'package:qandil/core/network/quran_api_client.dart';
import 'package:qandil/core/network/quran_auth_token_provider.dart';
import 'package:qandil/core/result/result.dart';
import 'package:qandil/features/quran/data/repositories/offline_first_quran_repository_impl.dart';
import 'package:qandil/features/quran/data/repositories/quran_local_repository_impl.dart';
import 'package:qandil/features/quran/data/repositories/quran_remote_repository_impl.dart';
import 'package:qandil/features/quran/data/repositories/quran_text_pack_download_manager.dart';
import 'package:qandil/features/quran/domain/entities/quran_entities.dart';

void main() {
  const preliveBaseUrl = 'https://apis-prelive.quran.foundation/content/api/v4';
  const proxyUrl = 'https://proxy.example.workers.dev/api/v1/token';

  late AppDatabase db;
  late DateTime fakeNow;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    fakeNow = DateTime.utc(2026, 11, 26, 12, 0, 0);
  });

  tearDown(() async {
    await db.close();
  });

  Map<String, dynamic> buildChaptersPayload() {
    return {
      'chapters': List.generate(114, (index) {
        final id = index + 1;
        if (id == 1) {
          return {
            'id': 1,
            'revelation_place': 'makkah',
            'revelation_order': 5,
            'bismillah_pre': false,
            'name_simple': 'Al-Fatihah',
            'name_arabic': 'الفاتحة',
            'verses_count': 7,
            'pages': [1, 1],
            'translated_name': {'language_name': 'arabic', 'name': 'الفاتحة'},
          };
        }
        if (id == 2) {
          return {
            'id': 2,
            'revelation_place': 'madinah',
            'revelation_order': 87,
            'bismillah_pre': true,
            'name_simple': 'Al-Baqarah',
            'name_arabic': 'البقرة',
            'verses_count': 286,
            'pages': [2, 49],
            'translated_name': {'language_name': 'arabic', 'name': 'البقرة'},
          };
        }
        return {
          'id': id,
          'revelation_place': 'makkah',
          'revelation_order': id,
          'bismillah_pre': true,
          'name_simple': 'Surah $id',
          'name_arabic': 'سورة $id',
          'verses_count': 10,
          'pages': [50, 51],
          'translated_name': {'language_name': 'arabic', 'name': 'سورة $id'},
        };
      }),
    };
  }

  Map<String, dynamic> buildSurah1VersesPayload() {
    return {
      'verses': [
        {
          'id': 1,
          'verse_number': 1,
          'verse_key': '1:1',
          'chapter_id': 1,
          'page_number': 1,
          'juz_number': 1,
          'hizb_number': 1,
          'text_uthmani': 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
          'text_imlaei_simple': 'بسم الله الرحمن الرحيم',
          'words': [
            {
              'id': 1,
              'position': 1,
              'text_uthmani': 'بِسْمِ',
              'char_type_name': 'word',
              'code_v2': '&#xfb51;',
              'v2_page': 1,
              'line_number': 2,
              'translation': {'text': 'In (the) name'},
              'transliteration': {'text': 'bis\'mi'},
            },
          ],
          'translations': [
            {
              'resource_id': 131,
              'text':
                  'In the Name of Allah—the Most Compassionate, Most Merciful.',
              'resource_name': 'Dr. Mustafa Khattab, The Clear Quran',
            },
          ],
        },
      ],
    };
  }

  Map<String, dynamic> buildSurah2VersesPayload() {
    return {
      'verses': [
        {
          'id': 8,
          'verse_number': 1,
          'verse_key': '2:1',
          'chapter_id': 2,
          'page_number': 2,
          'juz_number': 1,
          'hizb_number': 1,
          'text_uthmani': 'الٓمٓ',
          'text_imlaei_simple': 'الم',
          'words': [
            {
              'id': 1,
              'position': 1,
              'text_uthmani': 'الٓمٓ',
              'char_type_name': 'word',
              'code_v2': '&#xfb52;',
              'v2_page': 2,
              'line_number': 3,
              'translation': {'text': 'Alif Laam Meem'},
              'transliteration': {'text': 'alif-lam-meem'},
            },
          ],
        },
      ],
    };
  }

  http.Response jsonUtf8Response(Map<String, dynamic> body,
      {int status = 200, Map<String, String>? headers}) {
    return http.Response.bytes(
      utf8.encode(jsonEncode(body)),
      status,
      headers: {
        'content-type': 'application/json; charset=utf-8',
        ...?headers,
      },
    );
  }

  group('Phase 2: Quran Content Layer & Token Proxy Unit Tests', () {
    test(
        'Surahs 1 and 2 load from pre-production with x-auth-token & x-client-id headers and preserve exact Uthmani text',
        () async {
      var tokenRequests = 0;
      final recordedHeaders = <Map<String, String>>[];

      final mockClient = MockClient((request) async {
        if (request.url.toString() == proxyUrl) {
          tokenRequests++;
          return jsonUtf8Response({
            'accessToken': 'short-lived-token-123',
            'clientId': 'qf-client-id-abc',
            'expiresIn': 3600,
          });
        }

        recordedHeaders.add(request.headers);

        if (request.url.path.endsWith('/chapters')) {
          return jsonUtf8Response(buildChaptersPayload());
        }
        if (request.url.path.endsWith('/verses/by_chapter/1')) {
          return jsonUtf8Response(buildSurah1VersesPayload());
        }
        if (request.url.path.endsWith('/verses/by_chapter/2')) {
          return jsonUtf8Response(buildSurah2VersesPayload());
        }
        return jsonUtf8Response({'error': 'not found'}, status: 404);
      });

      final tokenProvider = ProxyQuranAuthTokenProvider(
        httpClient: mockClient,
        tokenProxyUrl: proxyUrl,
        clock: () => fakeNow,
      );
      final apiClient = QuranApiClient(
        httpClient: mockClient,
        tokenProvider: tokenProvider,
        baseUrl: preliveBaseUrl,
      );
      final remoteRepo = QuranRemoteRepositoryImpl(apiClient: apiClient);
      final localRepo = QuranLocalRepositoryImpl(
        database: db,
        clock: () => fakeNow,
      );
      final repo = OfflineFirstQuranRepositoryImpl(
        remoteRepository: remoteRepo,
        localRepository: localRepo,
      );

      // 1. Fetch Chapters
      final chaptersResult = await repo.getChapters();
      expect(chaptersResult, isA<Success<List<QuranChapter>>>());
      final chapters = (chaptersResult as Success<List<QuranChapter>>).value;
      expect(chapters.length, 114);
      expect(chapters[0].id, 1);
      expect(chapters[0].nameArabic, 'الفاتحة');
      expect(chapters[1].id, 2);
      expect(chapters[1].nameArabic, 'البقرة');

      // 2. Fetch Surah 1 (Al-Fatihah)
      final surah1Result = await repo.getVersesByChapter(
        1,
        translationIds: const [131],
      );
      expect(surah1Result, isA<Success<List<QuranVerse>>>());
      final surah1Verses = (surah1Result as Success<List<QuranVerse>>).value;
      expect(surah1Verses.length, 1);
      expect(
        surah1Verses.first.textUthmani,
        'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
      );
      expect(surah1Verses.first.words.first.textUthmani, 'بِسْمِ');
      expect(surah1Verses.first.translations.first.translationId, 131);

      // 3. Fetch Surah 2 (Al-Baqarah)
      final surah2Result = await repo.getVersesByChapter(2);
      expect(surah2Result, isA<Success<List<QuranVerse>>>());
      final surah2Verses = (surah2Result as Success<List<QuranVerse>>).value;
      expect(surah2Verses.first.verseKey, '2:1');
      expect(surah2Verses.first.textUthmani, 'الٓمٓ');

      // Token should have been fetched once and cached for all 3 API calls
      expect(tokenRequests, 1);
      for (final headers in recordedHeaders) {
        expect(headers['x-auth-token'], 'short-lived-token-123');
        expect(headers['x-client-id'], 'qf-client-id-abc');
      }
    });

    test(
        'fetches tafsirs, translations, recitations, page/juz verses, and search results',
        () async {
      final mockClient = MockClient((request) async {
        if (request.url.toString() == proxyUrl) {
          return jsonUtf8Response({
            'accessToken': 'token-xyz',
            'clientId': 'client-xyz',
            'expiresIn': 3600,
          });
        }
        final path = request.url.path;
        if (path.endsWith('/resources/tafsirs')) {
          return jsonUtf8Response({
            'tafsirs': [
              {
                'id': 16,
                'name': 'التفسير الميسر',
                'author_name': 'مجمع الملك فهد',
                'language_name': 'arabic',
                'slug': 'ar-tafsir-muyassar',
              },
            ],
          });
        }
        if (path.endsWith('/tafsirs/16/by_ayah/1:1')) {
          return jsonUtf8Response({
            'tafsir': {
              'resource_id': 16,
              'verse_key': '1:1',
              'text': 'أبدأ قراءتي مستعينًا بالله تعالى.',
              'resource_name': 'التفسير الميسر',
            },
          });
        }
        if (path.endsWith('/resources/translations')) {
          return jsonUtf8Response({
            'translations': [
              {
                'id': 131,
                'name': 'The Clear Quran',
                'author_name': 'Dr. Mustafa Khattab',
                'language_name': 'english',
                'slug': 'clear-quran',
              },
            ],
          });
        }
        if (path.endsWith('/translations/131/by_ayah/1:1')) {
          return jsonUtf8Response({
            'translation': {
              'resource_id': 131,
              'verse_key': '1:1',
              'text':
                  'In the Name of Allah—the Most Compassionate, Most Merciful.',
              'resource_name': 'The Clear Quran',
            },
          });
        }
        if (path.endsWith('/resources/recitations')) {
          return jsonUtf8Response({
            'recitations': [
              {
                'id': 7,
                'reciter_name': 'Mahmoud Khalil Al-Husary',
                'style': 'Murattal',
                'translated_name': {'name': 'محمود خليل الحصري'},
              },
            ],
          });
        }
        if (path.endsWith('/verses/by_page/1') ||
            path.endsWith('/verses/by_juz/1')) {
          return jsonUtf8Response(buildSurah1VersesPayload());
        }
        if (path.endsWith('/search')) {
          return jsonUtf8Response({
            'search': {
              'results': [
                {
                  'verse_key': '1:1',
                  'text': 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
                },
              ],
            },
          });
        }
        return jsonUtf8Response({}, status: 404);
      });

      final tokenProvider = ProxyQuranAuthTokenProvider(
        httpClient: mockClient,
        tokenProxyUrl: proxyUrl,
      );
      final apiClient = QuranApiClient(
        httpClient: mockClient,
        tokenProvider: tokenProvider,
        baseUrl: preliveBaseUrl,
      );
      final remoteRepo = QuranRemoteRepositoryImpl(apiClient: apiClient);
      final localRepo = QuranLocalRepositoryImpl(database: db);
      final repo = OfflineFirstQuranRepositoryImpl(
        remoteRepository: remoteRepo,
        localRepository: localRepo,
      );

      final tafsirs = await repo.getTafsirList();
      expect((tafsirs as Success<List<TafsirResource>>).value.first.name,
          'التفسير الميسر');

      final verseTafsir =
          await repo.getTafsirForVerse(tafsirId: 16, verseKey: '1:1');
      expect((verseTafsir as Success<VerseTafsir>).value.text,
          contains('أبدأ قراءتي'));

      final translations = await repo.getTranslationList(languageCode: 'en');
      expect(
          (translations as Success<List<TranslationResource>>).value.first.id,
          131);

      final verseTrans = await repo.getTranslationForVerse(
          translationId: 131, verseKey: '1:1');
      expect((verseTrans as Success<VerseTranslation>).value.text,
          contains('Most Compassionate'));

      final recitations = await repo.getRecitationsList();
      expect(
          (recitations as Success<List<RecitationResource>>)
              .value
              .first
              .reciterName,
          'Mahmoud Khalil Al-Husary');

      final pageVerses = await repo.getVersesByPage(1);
      expect((pageVerses as Success<List<QuranVerse>>).value.first.verseKey,
          '1:1');

      final juzVerses = await repo.getVersesByJuz(1);
      expect(
          (juzVerses as Success<List<QuranVerse>>).value.first.verseKey, '1:1');

      final searchHits = await repo.search(query: 'الرحمن');
      expect((searchHits as Success<List<QuranSearchHit>>).value.first.verseKey,
          '1:1');
    });

    test(
        'enforces 7-day Drift cache expiry: serves cache within 7 days, refreshes after 7 days',
        () async {
      var remoteChapterCalls = 0;

      final mockClient = MockClient((request) async {
        if (request.url.toString() == proxyUrl) {
          return jsonUtf8Response({
            'accessToken': 'token-cache-test',
            'clientId': 'client-cache-test',
            'expiresIn': 3600,
          });
        }
        remoteChapterCalls++;
        return jsonUtf8Response(buildChaptersPayload());
      });

      final tokenProvider = ProxyQuranAuthTokenProvider(
        httpClient: mockClient,
        tokenProxyUrl: proxyUrl,
        clock: () => fakeNow,
      );
      final apiClient = QuranApiClient(
        httpClient: mockClient,
        tokenProvider: tokenProvider,
        baseUrl: preliveBaseUrl,
      );
      final remoteRepo = QuranRemoteRepositoryImpl(apiClient: apiClient);
      final localRepo = QuranLocalRepositoryImpl(
        database: db,
        clock: () => fakeNow,
      );
      final repo = OfflineFirstQuranRepositoryImpl(
        remoteRepository: remoteRepo,
        localRepository: localRepo,
      );

      // Call 1: Cache miss -> hits remote
      await repo.getChapters();
      expect(remoteChapterCalls, 1);

      // Call 2 (6 days later): Cache hit (< 7 days) -> does NOT hit remote
      fakeNow = fakeNow.add(const Duration(days: 6));
      await repo.getChapters();
      expect(remoteChapterCalls, 1);

      // Call 3 (8 days after initial cache): Cache expired (> 7 days) -> hits remote again
      fakeNow = fakeNow.add(const Duration(days: 2));
      await repo.getChapters();
      expect(remoteChapterCalls, 2);

      // Verify purgeExpiredQuranCache removes rows older than 7 days
      fakeNow = fakeNow.add(const Duration(days: 8));
      final purged = await db.purgeExpiredQuranCache(now: fakeNow);
      expect(purged, greaterThan(0));
    });

    test(
        'handles expired token (HTTP 401) by refreshing token from proxy and retrying request',
        () async {
      var tokenCalls = 0;
      var apiCalls = 0;

      final mockClient = MockClient((request) async {
        if (request.url.toString() == proxyUrl) {
          tokenCalls++;
          return jsonUtf8Response({
            'accessToken': 'token-v$tokenCalls',
            'clientId': 'client-1',
            'expiresIn': 3600,
          });
        }
        apiCalls++;
        // First API call fails with 401 Expired Token
        if (apiCalls == 1) {
          return jsonUtf8Response({'error': 'token expired'}, status: 401);
        }
        return jsonUtf8Response(buildChaptersPayload());
      });

      final tokenProvider = ProxyQuranAuthTokenProvider(
        httpClient: mockClient,
        tokenProxyUrl: proxyUrl,
      );
      final apiClient = QuranApiClient(
        httpClient: mockClient,
        tokenProvider: tokenProvider,
        baseUrl: preliveBaseUrl,
      );
      final remoteRepo = QuranRemoteRepositoryImpl(apiClient: apiClient);

      final result = await remoteRepo.getChapters();
      expect(result, isA<Success<List<QuranChapter>>>());
      expect(tokenCalls, 2);
      expect(apiCalls, 2);
    });

    test(
        'retries on HTTP 429 with backoff and returns RateLimitFailure when exhausted, and maps SocketException to NetworkFailure',
        () async {
      var rateLimitedAttempts = 0;
      final recordedDelays = <Duration>[];

      final rateLimitClient = MockClient((request) async {
        if (request.url.toString() == proxyUrl) {
          return jsonUtf8Response({
            'accessToken': 'token-429',
            'clientId': 'client-1',
            'expiresIn': 3600,
          });
        }
        rateLimitedAttempts++;
        return jsonUtf8Response(
          {'error': 'too many requests'},
          status: 429,
          headers: {'retry-after': '2'},
        );
      });

      final tokenProvider = ProxyQuranAuthTokenProvider(
        httpClient: rateLimitClient,
        tokenProxyUrl: proxyUrl,
      );
      final apiClient = QuranApiClient(
        httpClient: rateLimitClient,
        tokenProvider: tokenProvider,
        baseUrl: preliveBaseUrl,
        maxRetries: 2,
        delayFn: (d) async => recordedDelays.add(d),
      );
      final remoteRepo = QuranRemoteRepositoryImpl(apiClient: apiClient);

      final rateLimitResult = await remoteRepo.getChapters();
      expect(rateLimitResult, isA<FailureResult<List<QuranChapter>>>());
      final failure =
          (rateLimitResult as FailureResult<List<QuranChapter>>).failure;
      expect(failure, isA<RateLimitFailure>());
      expect((failure as RateLimitFailure).retryAfterSeconds, 2);
      expect(rateLimitedAttempts, 3); // 1 initial + 2 retries
      expect(recordedDelays.length, 2);

      // Offline SocketException test
      final offlineClient = MockClient((request) async {
        throw const SocketException('Network unreachable');
      });
      final offlineApi = QuranApiClient(
        httpClient: offlineClient,
        tokenProvider: ProxyQuranAuthTokenProvider(
          httpClient: offlineClient,
          tokenProxyUrl: proxyUrl,
        ),
        baseUrl: preliveBaseUrl,
      );
      final offlineRepo = QuranRemoteRepositoryImpl(apiClient: offlineApi);
      final offlineResult = await offlineRepo.getChapters();
      expect(offlineResult, isA<FailureResult<List<QuranChapter>>>());
      expect(
        (offlineResult as FailureResult<List<QuranChapter>>).failure,
        isA<NetworkFailure>(),
      );
    });

    test(
        'QuranTextPackDownloadManager downloads Surahs 1 and 2 with progress updates persisted in Drift downloads table',
        () async {
      final mockClient = MockClient((request) async {
        if (request.url.toString() == proxyUrl) {
          return jsonUtf8Response({
            'accessToken': 'token-dl',
            'clientId': 'client-dl',
            'expiresIn': 3600,
          });
        }
        if (request.url.path.endsWith('/chapters')) {
          return jsonUtf8Response(buildChaptersPayload());
        }
        if (request.url.path.endsWith('/verses/by_chapter/1')) {
          return jsonUtf8Response(buildSurah1VersesPayload());
        }
        if (request.url.path.endsWith('/verses/by_chapter/2')) {
          return jsonUtf8Response(buildSurah2VersesPayload());
        }
        return jsonUtf8Response({}, status: 404);
      });

      final tokenProvider = ProxyQuranAuthTokenProvider(
        httpClient: mockClient,
        tokenProxyUrl: proxyUrl,
      );
      final apiClient = QuranApiClient(
        httpClient: mockClient,
        tokenProvider: tokenProvider,
        baseUrl: preliveBaseUrl,
      );
      final remoteRepo = QuranRemoteRepositoryImpl(apiClient: apiClient);
      final localRepo = QuranLocalRepositoryImpl(database: db);
      final downloadManager = QuranTextPackDownloadManager(
        database: db,
        remoteRepository: remoteRepo,
        localRepository: localRepo,
      );

      final events = await downloadManager.downloadTextPack(
        packId: 'prelive_surahs_1_2',
        chapterNumbers: const [1, 2],
      ).toList();

      expect(events.length, 4); // 0/3 -> 1/3 -> 2/3 -> 3/3 completed
      final lastProgress =
          (events.last as Success<TextPackDownloadProgress>).value;
      expect(lastProgress.status, 'completed');
      expect(lastProgress.fraction, 1.0);

      final dbDownloads = await db.select(db.downloads).get();
      expect(dbDownloads.length, 1);
      expect(dbDownloads.first.packId, 'prelive_surahs_1_2');
      expect(dbDownloads.first.status, 'completed');
      expect(dbDownloads.first.progress, 1.0);
    });

    test('Security check: no client_secret exists anywhere in lib/ or config/',
        () async {
      final directoriesToScan = [
        Directory('lib'),
        Directory('config'),
      ];

      for (final dir in directoriesToScan) {
        if (!dir.existsSync()) continue;
        for (final entity in dir.listSync(recursive: true)) {
          if (entity is File) {
            final content = await entity.readAsString();
            expect(
              content.toLowerCase().contains('client_secret'),
              isFalse,
              reason:
                  'Found forbidden client_secret reference in ${entity.path}',
            );
            expect(
              content.contains('QF_CLIENT_SECRET'),
              isFalse,
              reason:
                  'Found forbidden QF_CLIENT_SECRET reference in ${entity.path}',
            );
          }
        }
      }
    });
  });
}
