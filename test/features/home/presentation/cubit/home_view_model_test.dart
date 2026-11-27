import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/core/database/app_database.dart';
import 'package:qandil/features/adhkar/domain/entities/adhkar_entities.dart';
import 'package:qandil/features/home/domain/entities/home_entities.dart';
import 'package:qandil/features/home/domain/services/home_widget_sync_service.dart';
import 'package:qandil/features/home/presentation/cubit/home_view_model.dart';
import 'package:qandil/features/prayer/domain/entities/prayer_entities.dart';
import 'package:qandil/features/quran/data/repositories/quran_local_repository_impl.dart';
import 'package:qandil/features/quran/domain/entities/quran_entities.dart';
import 'package:qandil/features/settings/domain/entities/app_settings.dart';

class FakeHomeWidgetSyncGateway implements HomeWidgetSyncGateway {
  String? appGroupId;
  final Map<String, Object> savedData = {};
  final List<
          ({String androidName, String qualifiedAndroidName, String iOSName})>
      updatedWidgets = [];

  @override
  Future<void> setAppGroupId(String id) async {
    appGroupId = id;
  }

  @override
  Future<void> saveData(String key, Object value) async {
    savedData[key] = value;
  }

  @override
  Future<void> updateWidget({
    required String androidName,
    required String qualifiedAndroidName,
    required String iOSName,
  }) async {
    updatedWidgets.add((
      androidName: androidName,
      qualifiedAndroidName: qualifiedAndroidName,
      iOSName: iOSName,
    ));
  }
}

void main() {
  late AppDatabase db;
  late QuranLocalRepositoryImpl localQuranRepo;
  late FakeHomeWidgetSyncGateway fakeWidgetGateway;
  late HomeWidgetSyncService widgetSyncService;
  late DateTime fakeNow;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    fakeNow = DateTime(2026, 11, 27, 8, 30);
    localQuranRepo = QuranLocalRepositoryImpl(
      database: db,
      clock: () => fakeNow.toUtc(),
    );
    fakeWidgetGateway = FakeHomeWidgetSyncGateway();
    widgetSyncService = HomeWidgetSyncService(gateway: fakeWidgetGateway);

    // Seed local Quran chapters, verses, and tafsir in Drift (zero network)
    await localQuranRepo.cacheChapters(const [
      QuranChapter(
        id: 1,
        nameArabic: 'الفاتحة',
        nameSimple: 'Al-Fatihah',
        nameTranslated: 'The Opener',
        revelationPlace: 'makkah',
        revelationOrder: 5,
        bismillahPre: false,
        versesCount: 7,
        startPage: 1,
        endPage: 1,
      ),
      QuranChapter(
        id: 2,
        nameArabic: 'البقرة',
        nameSimple: 'Al-Baqarah',
        nameTranslated: 'The Cow',
        revelationPlace: 'madinah',
        revelationOrder: 87,
        bismillahPre: true,
        versesCount: 286,
        startPage: 2,
        endPage: 49,
      ),
    ]);

    await localQuranRepo.cacheVerses(const [
      QuranVerse(
        id: 1,
        verseKey: '1:1',
        chapterId: 1,
        verseNumber: 1,
        pageNumber: 1,
        juzNumber: 1,
        hizbNumber: 1,
        textUthmani: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
        textImlaeiSimple: 'بسم الله الرحمن الرحيم',
      ),
      QuranVerse(
        id: 2,
        verseKey: '1:2',
        chapterId: 1,
        verseNumber: 2,
        pageNumber: 1,
        juzNumber: 1,
        hizbNumber: 1,
        textUthmani: 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ',
        textImlaeiSimple: 'الحمد لله رب العالمين',
      ),
      QuranVerse(
        id: 255,
        verseKey: '2:255',
        chapterId: 2,
        verseNumber: 255,
        pageNumber: 42,
        juzNumber: 3,
        hizbNumber: 5,
        textUthmani: 'ٱللَّهُ لَآ إِلَـٰهَ إِلَّا هُوَ ٱلْحَىُّ ٱلْقَيُّومُ',
        textImlaeiSimple: 'الله لا إله إلا هو الحي القيوم',
      ),
    ]);

    await localQuranRepo.cacheVerseTafsir(
      const VerseTafsir(
        tafsirId: 16,
        verseKey: '1:1',
        text: 'التفسير الميسر للآية الأولى',
        resourceName: 'التفسير الميسر',
      ),
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('Phase 11: HomeViewModel Unit Tests', () {
    test(
        'computes time-of-day greeting, highlighted morning/evening adhkar, Gregorian & Hijri dates, and deterministic Verse of the Day',
        () async {
      // Morning at 08:30 AM
      fakeNow = DateTime(2026, 11, 27, 8, 30);
      final viewModel = HomeViewModel(
        database: db,
        localQuranRepository: localQuranRepo,
        widgetSyncService: widgetSyncService,
        clock: () => fakeNow,
        enableBundledSeed: false,
      );

      const settings = AppSettings(
        languageCode: 'ar',
        themeMode: ThemeMode.dark,
      );
      await viewModel.refresh(settings);

      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.timeOfDayPeriod, HomeTimeOfDayPeriod.morning);
      expect(
        viewModel.state.highlightedAdhkarCategory,
        AdhkarCategory.morning,
      );
      expect(viewModel.state.hasValidLocation, isTrue);
      expect(viewModel.state.cityDisplayName, 'القاهرة، مصر');
      expect(viewModel.state.hijriDateFormatted, isNotEmpty);
      expect(viewModel.state.gregorianDateFormatted, isNotEmpty);
      expect(viewModel.state.verseOfTheDay, isNotNull);

      // Same date always picks the exact same Verse of the Day deterministically
      final pickedVerseKeyMorning =
          viewModel.state.verseOfTheDay!.verse.verseKey;
      fakeNow = DateTime(2026, 11, 27, 19, 45); // Evening of same day
      await viewModel.refresh(settings);

      expect(viewModel.state.timeOfDayPeriod, HomeTimeOfDayPeriod.evening);
      expect(
        viewModel.state.highlightedAdhkarCategory,
        AdhkarCategory.evening,
      );
      expect(
        viewModel.state.verseOfTheDay!.verse.verseKey,
        pickedVerseKeyMorning,
      );

      await viewModel.close();
    });

    test(
        'after Isha shows tomorrow Fajr as Next Prayer, and handles missing location gracefully',
        () async {
      // Late night at 23:00 (after Isha in Cairo)
      fakeNow = DateTime(2026, 11, 27, 23, 0);
      final viewModel = HomeViewModel(
        database: db,
        localQuranRepository: localQuranRepo,
        widgetSyncService: widgetSyncService,
        clock: () => fakeNow,
        enableBundledSeed: false,
      );

      const cairoSettings = AppSettings(
        languageCode: 'ar',
        locationLatitude: 30.0444,
        locationLongitude: 31.2357,
        locationCityNameAr: 'القاهرة، مصر',
        locationCityNameEn: 'Cairo, Egypt',
      );
      await viewModel.refresh(cairoSettings);

      expect(viewModel.state.nextPrayer, isNotNull);
      expect(viewModel.state.nextPrayer!.slot, PrayerSlot.fajr);
      expect(
        viewModel.state.nextPrayer!.prayerTime.day,
        28, // Tomorrow (Nov 28) Fajr
      );

      // Missing location (0, 0 with empty city names)
      const missingLocationSettings = AppSettings(
        locationLatitude: 0.0,
        locationLongitude: 0.0,
        locationCityNameAr: '',
        locationCityNameEn: '',
      );
      await viewModel.refresh(missingLocationSettings);

      expect(viewModel.state.hasValidLocation, isFalse);
      expect(viewModel.state.nextPrayer, isNull);
      expect(
        viewModel.state.lastSyncedWidgetPayload?.hasLocation,
        isFalse,
      );

      await viewModel.close();
    });

    test(
        'quickIncrementTasbih increments today total & streak in Drift and updates synced widget payload',
        () async {
      fakeNow = DateTime(2026, 11, 27, 10, 0);
      final viewModel = HomeViewModel(
        database: db,
        localQuranRepository: localQuranRepo,
        widgetSyncService: widgetSyncService,
        clock: () => fakeNow,
        enableBundledSeed: false,
      );

      const settings = AppSettings();
      await viewModel.refresh(settings);
      expect(viewModel.state.todayTasbihTotal, 0);

      await viewModel.quickIncrementTasbih(settings);
      await viewModel.quickIncrementTasbih(settings);

      expect(viewModel.state.todayTasbihTotal, 2);
      expect(viewModel.state.currentTasbihStreakDays, 1);
      expect(fakeWidgetGateway.savedData['qandil_tasbih_today'], 2);
      expect(fakeWidgetGateway.savedData['qandil_tasbih_streak'], 1);

      await viewModel.close();
    });
  });
}
