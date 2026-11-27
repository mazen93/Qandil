import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../calendar/domain/services/hijri_calendar_service.dart';
import '../../../prayer/domain/entities/prayer_entities.dart';
import '../../../prayer/domain/services/prayer_calculator_service.dart';
import '../../../quran/data/repositories/quran_bundled_seed_loader.dart';
import '../../../quran/data/repositories/quran_local_repository_impl.dart';
import '../../../quran/domain/entities/quran_entities.dart';
import '../../../quran/domain/services/khatmah_calculator.dart';
import '../../../settings/domain/entities/app_settings.dart';
import '../../../tasbih/domain/services/tasbih_stats_calculator.dart';
import '../../domain/entities/home_entities.dart';
import '../../domain/services/home_widget_sync_service.dart';

/// Phase 11 Unified Home ViewModel (`HomeViewModel`):
/// - All data comes strictly from the local Drift database, bundled verified Quran data, and stored settings.
/// - Zero network calls and zero AI-generated text.
/// - Computes:
///   1. Header: localized time-of-day greeting, Gregorian & Hijri dates, current city (with missing-location handling).
///   2. Next Prayer: prayer name, time, live countdown; after Isha shows tomorrow's Fajr.
///   3. Today's Wird: Khatmah progress for today and saved reading position for Continue Reading.
///   4. Dhikr card: today's tasbih total & streak, quick-start counter (`+1`), and time-highlighted Morning/Evening Adhkar shortcut.
///   5. Verse of the Day: picked deterministically by calendar date from local Quran data, with local tafsir snippet.
/// - Synchronizes [HomeWidgetPayload] to Android App Widgets and iOS WidgetKit via [HomeWidgetSyncService].
class HomeViewModel extends Cubit<HomeViewState> {
  HomeViewModel({
    required AppDatabase database,
    required QuranLocalRepositoryImpl localQuranRepository,
    required HomeWidgetSyncService widgetSyncService,
    DateTime Function()? clock,
    this.enableBundledSeed = true,
  })  : _database = database,
        _localQuranRepository = localQuranRepository,
        _widgetSyncService = widgetSyncService,
        _clock = clock ?? DateTime.now,
        super(const HomeViewState());

  final AppDatabase _database;
  final QuranLocalRepositoryImpl _localQuranRepository;
  final HomeWidgetSyncService _widgetSyncService;
  final DateTime Function() _clock;
  final bool enableBundledSeed;

  /// Deterministically picks a verse index for a given local calendar [date] out of [totalVerses].
  static int deterministicVerseIndexForDate(DateTime date, int totalVerses) {
    if (totalVerses <= 0) return 0;
    final utcDay = DateTime.utc(date.year, date.month, date.day);
    final epoch = DateTime.utc(2026, 1, 1);
    final daysSinceEpoch = utcDay.difference(epoch).inDays;
    // Multiply by a prime coprime step (37) so consecutive days rotate across varied verses
    final hash = (daysSinceEpoch.abs() * 37) + date.day;
    return hash % totalVerses;
  }

  /// Checks whether [settings] carries a valid configured location.
  static bool hasValidConfiguredLocation(AppSettings settings) {
    final cityAr = settings.locationCityNameAr.trim();
    final cityEn = settings.locationCityNameEn.trim();
    if (cityAr.isEmpty && cityEn.isEmpty) return false;
    final lat = settings.locationLatitude;
    final lng = settings.locationLongitude;
    if (lat.isNaN || lng.isNaN) return false;
    if (lat < -90.0 || lat > 90.0 || lng < -180.0 || lng > 180.0) {
      return false;
    }
    if (lat == 0.0 && lng == 0.0) return false;
    return true;
  }

  /// Loads or refreshes all Home screen sections from local Drift database and [settings],
  /// and synchronizes the shared Home-screen widget payload.
  Future<void> refresh(
    AppSettings settings, {
    bool? isDarkThemeOverride,
  }) async {
    if (enableBundledSeed) {
      await QuranBundledSeedLoader.seedIfEmpty(_localQuranRepository);
    }

    final now = _clock();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final lang = settings.languageCode;
    final isAr = lang == 'ar';

    // 1. Header: Time-of-day period, Highlighted Adhkar Category, Hijri & Gregorian dates, City
    final period = HomeTimeOfDayPeriod.fromDateTime(now);
    final highlightedAdhkar = HomeTimeOfDayPeriod.highlightedAdhkarCategory(
      now,
    );
    final hijriDate = HijriCalendarService.fromGregorian(
      today,
      adjustmentDays: settings.hijriAdjustmentDays,
    );
    final hijriFormatted = hijriDate.format(languageCode: lang);
    final gregorianFormatted = HijriCalendarService.formatGregorianDate(
      today,
      languageCode: lang,
    );
    final validLocation = hasValidConfiguredLocation(settings);
    final cityDisplay =
        validLocation ? settings.currentCityDisplayName.trim() : '';

    // 2. Next Prayer & Today/Tomorrow Schedules (computed 100% on-device)
    DailyPrayerSchedule? todaySchedule;
    DailyPrayerSchedule? tomorrowSchedule;
    NextPrayerCountdown? nextPrayer;
    final boundaryEpochMs = <int>[];

    if (validLocation) {
      todaySchedule = PrayerCalculatorService.computeScheduleForDate(
        date: today,
        latitude: settings.locationLatitude,
        longitude: settings.locationLongitude,
        method: settings.prayerCalculationMethod,
        asrMadhab: settings.asrMadhab,
        highLatitudeRule: settings.highLatitudeRule,
        adjustments: settings.prayerAdjustments,
      );
      tomorrowSchedule = PrayerCalculatorService.computeScheduleForDate(
        date: tomorrow,
        latitude: settings.locationLatitude,
        longitude: settings.locationLongitude,
        method: settings.prayerCalculationMethod,
        asrMadhab: settings.asrMadhab,
        highLatitudeRule: settings.highLatitudeRule,
        adjustments: settings.prayerAdjustments,
      );
      nextPrayer = PrayerCalculatorService.computeNextPrayer(
        todaySchedule: todaySchedule,
        tomorrowSchedule: tomorrowSchedule,
        now: now,
      );

      for (final slot in PrayerSlot.values) {
        final t1 = todaySchedule.timeForSlot(slot);
        if (t1.isAfter(now)) {
          boundaryEpochMs.add(t1.millisecondsSinceEpoch);
        }
      }
      for (final slot in PrayerSlot.values) {
        final t2 = tomorrowSchedule.timeForSlot(slot);
        if (t2.isAfter(now)) {
          boundaryEpochMs.add(t2.millisecondsSinceEpoch);
        }
      }
      boundaryEpochMs.sort();
    }

    // 3. Today's Wird & Khatmah Progress from Drift `reading_progress`
    final progressRow = await _database.getOrCreateReadingProgress();
    final khatmah = KhatmahCalculator.calculate(
      targetDays: progressRow.khatmahTargetDays,
      currentPage: progressRow.pageNumber,
      startDate: progressRow.khatmahStartDate,
      now: now,
    );

    final chaptersRows = await (_database.select(_database.cachedChapters)
          ..orderBy([(t) => OrderingTerm.asc(t.chapterId)]))
        .get();
    final chaptersById = {for (final c in chaptersRows) c.chapterId: c};
    final savedChapter = chaptersById[progressRow.surahNumber];
    final savedSurahAr = savedChapter?.nameArabic ??
        (progressRow.surahNumber == 1
            ? 'الفاتحة'
            : (progressRow.surahNumber == 2
                ? 'البقرة'
                : '${progressRow.surahNumber}'));
    final savedSurahEn = savedChapter?.nameSimple ??
        (progressRow.surahNumber == 1
            ? 'Al-Fatihah'
            : (progressRow.surahNumber == 2
                ? 'Al-Baqarah'
                : 'Surah ${progressRow.surahNumber}'));

    // 4. Tasbih Today Total & Streak from Drift `tasbih_daily`
    final tasbihRows = await _database.getAllTasbihDaily();
    final tasbihEntries = tasbihRows
        .map(
          (r) => TasbihDailyEntry(
            date: r.date,
            dhikrId: r.dhikrId,
            total: r.total,
          ),
        )
        .toList(growable: false);
    final tasbihSummary = TasbihStatsCalculator.computeSummary(
      entries: tasbihEntries,
      nowLocal: now,
    );

    // 5. Deterministic Offline Verse of the Day from local `cached_verses`
    final verseOfTheDay = await _selectDeterministicVerseOfTheDay(
      today: today,
      chaptersById: chaptersById,
    );

    // 6. Build and sync Home-Screen Widget Payload
    final isDarkTheme =
        isDarkThemeOverride ?? (settings.themeMode == ThemeMode.dark);
    final nextPrayerNameText = nextPrayer != null
        ? _localizedSlotName(nextPrayer.slot, isAr: isAr)
        : (isAr ? 'حدد الموقع' : 'Set Location');
    final nextPrayerTimeText = nextPrayer != null
        ? formatClock12Hour(nextPrayer.prayerTime, isAr: isAr)
        : '--:--';
    final nextPrayerCountdownText =
        nextPrayer != null ? formatCountdown(nextPrayer.remaining) : '--';

    final widgetPayload = HomeWidgetPayload(
      languageCode: lang,
      isRtl: isAr,
      isDarkTheme: isDarkTheme,
      hasLocation: validLocation,
      cityName: cityDisplay,
      gregorianDateText: gregorianFormatted,
      hijriDateText: hijriFormatted,
      nextPrayerName: nextPrayerNameText,
      nextPrayerTimeFormatted: nextPrayerTimeText,
      nextPrayerTargetEpochMs:
          nextPrayer?.prayerTime.millisecondsSinceEpoch ?? 0,
      nextPrayerCountdownText: nextPrayerCountdownText,
      fajrTimeFormatted: todaySchedule != null
          ? formatClock12Hour(todaySchedule.fajr, isAr: isAr)
          : '--:--',
      sunriseTimeFormatted: todaySchedule != null
          ? formatClock12Hour(todaySchedule.sunrise, isAr: isAr)
          : '--:--',
      dhuhrTimeFormatted: todaySchedule != null
          ? formatClock12Hour(todaySchedule.dhuhr, isAr: isAr)
          : '--:--',
      asrTimeFormatted: todaySchedule != null
          ? formatClock12Hour(todaySchedule.asr, isAr: isAr)
          : '--:--',
      maghribTimeFormatted: todaySchedule != null
          ? formatClock12Hour(todaySchedule.maghrib, isAr: isAr)
          : '--:--',
      ishaTimeFormatted: todaySchedule != null
          ? formatClock12Hour(todaySchedule.isha, isAr: isAr)
          : '--:--',
      prayerBoundaryEpochMsList:
          boundaryEpochMs.take(10).toList(growable: false),
      todayTasbihTotal: tasbihSummary.todayTotal,
      tasbihStreakDays: tasbihSummary.currentStreakDays,
      tasbihTargetPreset: settings.tasbihTargetPreset,
      wirdCurrentSurahName: isAr ? savedSurahAr : savedSurahEn,
      wirdCurrentPage: progressRow.pageNumber,
      wirdCurrentAyah: progressRow.ayahNumber,
      wirdCurrentJuz: progressRow.juzNumber,
      wirdProgressPercent: (khatmah.progressFraction * 100).round(),
      wirdCatchUpPagesPerDay: khatmah.catchUpPagesPerDay,
      updatedAtEpochMs: now.millisecondsSinceEpoch,
    );

    await _widgetSyncService.syncPayload(widgetPayload);

    emit(
      HomeViewState(
        isLoading: false,
        now: now,
        timeOfDayPeriod: period,
        highlightedAdhkarCategory: highlightedAdhkar,
        hasValidLocation: validLocation,
        cityDisplayName: cityDisplay,
        gregorianDateFormatted: gregorianFormatted,
        hijriDateFormatted: hijriFormatted,
        todaySchedule: todaySchedule,
        tomorrowSchedule: tomorrowSchedule,
        nextPrayer: nextPrayer,
        savedSurahNumber: progressRow.surahNumber,
        savedSurahNameArabic: savedSurahAr,
        savedSurahNameSimple: savedSurahEn,
        savedAyahNumber: progressRow.ayahNumber,
        savedPageNumber: progressRow.pageNumber,
        savedJuzNumber: progressRow.juzNumber,
        khatmahSummary: khatmah,
        todayTasbihTotal: tasbihSummary.todayTotal,
        currentTasbihStreakDays: tasbihSummary.currentStreakDays,
        bestTasbihStreakDays: tasbihSummary.bestStreakDays,
        tasbihTargetPreset: settings.tasbihTargetPreset,
        verseOfTheDay: verseOfTheDay,
        lastSyncedWidgetPayload: widgetPayload,
      ),
    );
  }

  /// Quick-start Tasbih counter increment directly from the Home screen Dhikr card.
  /// Persists to `tasbih_events` and `tasbih_daily` in the same Drift transaction and updates Home widgets.
  Future<void> quickIncrementTasbih(
    AppSettings settings, {
    String dhikrId = 'general_tasbih',
    int step = 1,
  }) async {
    final now = _clock();
    final localDate = TasbihStatsCalculator.formatLocalDate(now);
    await _database.recordTasbihIncrement(
      dhikrId: dhikrId,
      count: step <= 0 ? 1 : step,
      localDate: localDate,
      timestamp: now.toUtc(),
    );
    await refresh(settings);
  }

  Future<HomeVerseOfTheDay?> _selectDeterministicVerseOfTheDay({
    required DateTime today,
    required Map<int, CachedChapterRecord> chaptersById,
  }) async {
    final verseRows = await (_database.select(_database.cachedVerses)
          ..orderBy([
            (t) => OrderingTerm.asc(t.chapterId),
            (t) => OrderingTerm.asc(t.verseNumber),
          ]))
        .get();

    if (verseRows.isEmpty) {
      return null;
    }

    final index = deterministicVerseIndexForDate(today, verseRows.length);
    final chosenRow = verseRows[index];
    final chapter = chaptersById[chosenRow.chapterId];

    // Load local translations and tafsir for this verse if cached
    final annotations = await (_database.select(
      _database.cachedVerseAnnotations,
    )..where((t) => t.verseKey.equals(chosenRow.verseKey)))
        .get();

    final translations = annotations
        .where((a) => a.resourceType == 'translation')
        .map(
          (a) => VerseTranslation(
            translationId: a.resourceId,
            verseKey: a.verseKey,
            text: a.textContent,
            resourceName: a.resourceName,
          ),
        )
        .toList(growable: false);

    final tafsirRow =
        annotations.where((a) => a.resourceType == 'tafsir').firstOrNull;

    final verse = QuranVerse(
      id: chosenRow.verseNumber,
      verseKey: chosenRow.verseKey,
      chapterId: chosenRow.chapterId,
      verseNumber: chosenRow.verseNumber,
      pageNumber: chosenRow.pageNumber,
      juzNumber: chosenRow.juzNumber,
      hizbNumber: chosenRow.hizbNumber,
      textUthmani: chosenRow.textUthmani,
      textImlaeiSimple: chosenRow.textImlaeiSimple,
      translations: translations,
    );

    return HomeVerseOfTheDay(
      verse: verse,
      surahNameArabic: chapter?.nameArabic ??
          (chosenRow.chapterId == 1 ? 'الفاتحة' : 'البقرة'),
      surahNameSimple: chapter?.nameSimple ??
          (chosenRow.chapterId == 1 ? 'Al-Fatihah' : 'Al-Baqarah'),
      tafsirSnippet: tafsirRow?.textContent,
    );
  }

  static String formatCountdown(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    return '${hours}h ${minutes}m';
  }

  /// Locale-safe 12-hour formatter (`05:00 ص` / `05:00 AM`) that never throws `LocaleDataException` in headless background isolates.
  static String formatClock12Hour(DateTime dt, {required bool isAr}) {
    final h24 = dt.hour;
    final isPm = h24 >= 12;
    final h12 = h24 % 12 == 0 ? 12 : h24 % 12;
    final hh = h12.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    final period = isAr ? (isPm ? 'م' : 'ص') : (isPm ? 'PM' : 'AM');
    return '$hh:$mm $period';
  }

  static String _localizedSlotName(PrayerSlot slot, {required bool isAr}) {
    if (isAr) {
      return switch (slot) {
        PrayerSlot.fajr => 'الفجر',
        PrayerSlot.sunrise => 'الشروق',
        PrayerSlot.dhuhr => 'الظهر',
        PrayerSlot.asr => 'العصر',
        PrayerSlot.maghrib => 'المغرب',
        PrayerSlot.isha => 'العشاء',
      };
    }
    return switch (slot) {
      PrayerSlot.fajr => 'Fajr',
      PrayerSlot.sunrise => 'Sunrise',
      PrayerSlot.dhuhr => 'Dhuhr',
      PrayerSlot.asr => 'Asr',
      PrayerSlot.maghrib => 'Maghrib',
      PrayerSlot.isha => 'Isha',
    };
  }
}
