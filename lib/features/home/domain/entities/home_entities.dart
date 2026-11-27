import 'package:flutter/foundation.dart';

import '../../../adhkar/domain/entities/adhkar_entities.dart';
import '../../../prayer/domain/entities/prayer_entities.dart';
import '../../../quran/domain/entities/quran_entities.dart';
import '../../../quran/domain/services/khatmah_calculator.dart';

/// Time-of-day periods used for localized Home greeting and Adhkar shortcut highlighting.
enum HomeTimeOfDayPeriod {
  morning,
  afternoon,
  evening;

  /// Resolves the period from a local [DateTime].
  /// - `04:00..11:59`: [morning]
  /// - `12:00..16:59`: [afternoon]
  /// - `17:00..03:59`: [evening]
  static HomeTimeOfDayPeriod fromDateTime(DateTime now) {
    final h = now.hour;
    if (h >= 4 && h < 12) {
      return HomeTimeOfDayPeriod.morning;
    } else if (h >= 12 && h < 17) {
      return HomeTimeOfDayPeriod.afternoon;
    }
    return HomeTimeOfDayPeriod.evening;
  }

  /// Resolves which Adhkar category (`morning` vs `evening`) should be highlighted on the Home Dhikr card.
  /// - `04:00..13:59`: [AdhkarCategory.morning]
  /// - `14:00..03:59`: [AdhkarCategory.evening]
  static AdhkarCategory highlightedAdhkarCategory(DateTime now) {
    final h = now.hour;
    return (h >= 4 && h < 14) ? AdhkarCategory.morning : AdhkarCategory.evening;
  }
}

/// Deterministic offline Verse of the Day entity.
@immutable
class HomeVerseOfTheDay {
  const HomeVerseOfTheDay({
    required this.verse,
    required this.surahNameArabic,
    required this.surahNameSimple,
    this.tafsirSnippet,
  });

  final QuranVerse verse;
  final String surahNameArabic;
  final String surahNameSimple;
  final String? tafsirSnippet;

  int get surahNumber {
    final parts = verse.verseKey.split(':');
    return int.tryParse(parts.first) ?? 1;
  }

  int get ayahNumber => verse.verseNumber;
  int get pageNumber => verse.pageNumber;
}

/// Complete, serializable snapshot shared between the Flutter app and native
/// Android App Widgets (`HomeWidgetPreferences`) / iOS WidgetKit (`group.com.mmazin.qandil`).
@immutable
class HomeWidgetPayload {
  const HomeWidgetPayload({
    required this.languageCode,
    required this.isRtl,
    required this.isDarkTheme,
    required this.hasLocation,
    required this.cityName,
    required this.gregorianDateText,
    required this.hijriDateText,
    required this.nextPrayerName,
    required this.nextPrayerTimeFormatted,
    required this.nextPrayerTargetEpochMs,
    required this.nextPrayerCountdownText,
    required this.fajrTimeFormatted,
    required this.sunriseTimeFormatted,
    required this.dhuhrTimeFormatted,
    required this.asrTimeFormatted,
    required this.maghribTimeFormatted,
    required this.ishaTimeFormatted,
    required this.prayerBoundaryEpochMsList,
    required this.todayTasbihTotal,
    required this.tasbihStreakDays,
    required this.tasbihTargetPreset,
    required this.wirdCurrentSurahName,
    required this.wirdCurrentPage,
    required this.wirdCurrentAyah,
    required this.wirdCurrentJuz,
    required this.wirdProgressPercent,
    required this.wirdCatchUpPagesPerDay,
    required this.updatedAtEpochMs,
  });

  final String languageCode;
  final bool isRtl;
  final bool isDarkTheme;
  final bool hasLocation;
  final String cityName;
  final String gregorianDateText;
  final String hijriDateText;

  // 1. Small Next Prayer Widget
  final String nextPrayerName;
  final String nextPrayerTimeFormatted;
  final int nextPrayerTargetEpochMs;
  final String nextPrayerCountdownText;

  // 2. Medium Five Prayer Times Widget
  final String fajrTimeFormatted;
  final String sunriseTimeFormatted;
  final String dhuhrTimeFormatted;
  final String asrTimeFormatted;
  final String maghribTimeFormatted;
  final String ishaTimeFormatted;

  /// Upcoming prayer boundary timestamps (epoch ms) over the next 24h so native Android alarms
  /// and iOS `TimelineProvider` automatically refresh widgets at every prayer boundary.
  final List<int> prayerBoundaryEpochMsList;

  // 3. Small Tasbih Counter Widget
  final int todayTasbihTotal;
  final int tasbihStreakDays;
  final int tasbihTargetPreset;

  // 4. Medium Today's Wird Progress Widget
  final String wirdCurrentSurahName;
  final int wirdCurrentPage;
  final int wirdCurrentAyah;
  final int wirdCurrentJuz;
  final int wirdProgressPercent;
  final int wirdCatchUpPagesPerDay;

  final int updatedAtEpochMs;

  Map<String, Object> toKeyValueMap() {
    return <String, Object>{
      'qandil_lang': languageCode,
      'qandil_is_rtl': isRtl,
      'qandil_is_dark': isDarkTheme,
      'qandil_has_location': hasLocation,
      'qandil_city_name': cityName,
      'qandil_gregorian_date': gregorianDateText,
      'qandil_hijri_date': hijriDateText,
      'qandil_next_prayer_name': nextPrayerName,
      'qandil_next_prayer_time': nextPrayerTimeFormatted,
      'qandil_next_prayer_epoch_ms': nextPrayerTargetEpochMs,
      'qandil_next_prayer_countdown': nextPrayerCountdownText,
      'qandil_fajr_time': fajrTimeFormatted,
      'qandil_sunrise_time': sunriseTimeFormatted,
      'qandil_dhuhr_time': dhuhrTimeFormatted,
      'qandil_asr_time': asrTimeFormatted,
      'qandil_maghrib_time': maghribTimeFormatted,
      'qandil_isha_time': ishaTimeFormatted,
      'qandil_prayer_boundaries_csv': prayerBoundaryEpochMsList.join(','),
      'qandil_tasbih_today': todayTasbihTotal,
      'qandil_tasbih_streak': tasbihStreakDays,
      'qandil_tasbih_target': tasbihTargetPreset,
      'qandil_wird_surah': wirdCurrentSurahName,
      'qandil_wird_page': wirdCurrentPage,
      'qandil_wird_ayah': wirdCurrentAyah,
      'qandil_wird_juz': wirdCurrentJuz,
      'qandil_wird_percent': wirdProgressPercent,
      'qandil_wird_daily_pages': wirdCatchUpPagesPerDay,
      'qandil_updated_at_ms': updatedAtEpochMs,
    };
  }
}

/// Immutable state for [HomeViewModel].
@immutable
class HomeViewState {
  const HomeViewState({
    this.isLoading = true,
    this.now,
    this.timeOfDayPeriod = HomeTimeOfDayPeriod.morning,
    this.highlightedAdhkarCategory = AdhkarCategory.morning,
    this.hasValidLocation = true,
    this.cityDisplayName = '',
    this.gregorianDateFormatted = '',
    this.hijriDateFormatted = '',
    this.todaySchedule,
    this.tomorrowSchedule,
    this.nextPrayer,
    this.savedSurahNumber = 1,
    this.savedSurahNameArabic = 'الفاتحة',
    this.savedSurahNameSimple = 'Al-Fatihah',
    this.savedAyahNumber = 1,
    this.savedPageNumber = 1,
    this.savedJuzNumber = 1,
    this.khatmahSummary,
    this.todayTasbihTotal = 0,
    this.currentTasbihStreakDays = 0,
    this.bestTasbihStreakDays = 0,
    this.tasbihTargetPreset = 33,
    this.verseOfTheDay,
    this.lastSyncedWidgetPayload,
  });

  final bool isLoading;
  final DateTime? now;
  final HomeTimeOfDayPeriod timeOfDayPeriod;
  final AdhkarCategory highlightedAdhkarCategory;
  final bool hasValidLocation;
  final String cityDisplayName;
  final String gregorianDateFormatted;
  final String hijriDateFormatted;
  final DailyPrayerSchedule? todaySchedule;
  final DailyPrayerSchedule? tomorrowSchedule;
  final NextPrayerCountdown? nextPrayer;
  final int savedSurahNumber;
  final String savedSurahNameArabic;
  final String savedSurahNameSimple;
  final int savedAyahNumber;
  final int savedPageNumber;
  final int savedJuzNumber;
  final KhatmahScheduleSummary? khatmahSummary;
  final int todayTasbihTotal;
  final int currentTasbihStreakDays;
  final int bestTasbihStreakDays;
  final int tasbihTargetPreset;
  final HomeVerseOfTheDay? verseOfTheDay;
  final HomeWidgetPayload? lastSyncedWidgetPayload;

  HomeViewState copyWith({
    bool? isLoading,
    DateTime? now,
    HomeTimeOfDayPeriod? timeOfDayPeriod,
    AdhkarCategory? highlightedAdhkarCategory,
    bool? hasValidLocation,
    String? cityDisplayName,
    String? gregorianDateFormatted,
    String? hijriDateFormatted,
    DailyPrayerSchedule? todaySchedule,
    DailyPrayerSchedule? tomorrowSchedule,
    NextPrayerCountdown? nextPrayer,
    int? savedSurahNumber,
    String? savedSurahNameArabic,
    String? savedSurahNameSimple,
    int? savedAyahNumber,
    int? savedPageNumber,
    int? savedJuzNumber,
    KhatmahScheduleSummary? khatmahSummary,
    int? todayTasbihTotal,
    int? currentTasbihStreakDays,
    int? bestTasbihStreakDays,
    int? tasbihTargetPreset,
    HomeVerseOfTheDay? verseOfTheDay,
    HomeWidgetPayload? lastSyncedWidgetPayload,
  }) {
    return HomeViewState(
      isLoading: isLoading ?? this.isLoading,
      now: now ?? this.now,
      timeOfDayPeriod: timeOfDayPeriod ?? this.timeOfDayPeriod,
      highlightedAdhkarCategory:
          highlightedAdhkarCategory ?? this.highlightedAdhkarCategory,
      hasValidLocation: hasValidLocation ?? this.hasValidLocation,
      cityDisplayName: cityDisplayName ?? this.cityDisplayName,
      gregorianDateFormatted:
          gregorianDateFormatted ?? this.gregorianDateFormatted,
      hijriDateFormatted: hijriDateFormatted ?? this.hijriDateFormatted,
      todaySchedule: todaySchedule ?? this.todaySchedule,
      tomorrowSchedule: tomorrowSchedule ?? this.tomorrowSchedule,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      savedSurahNumber: savedSurahNumber ?? this.savedSurahNumber,
      savedSurahNameArabic: savedSurahNameArabic ?? this.savedSurahNameArabic,
      savedSurahNameSimple: savedSurahNameSimple ?? this.savedSurahNameSimple,
      savedAyahNumber: savedAyahNumber ?? this.savedAyahNumber,
      savedPageNumber: savedPageNumber ?? this.savedPageNumber,
      savedJuzNumber: savedJuzNumber ?? this.savedJuzNumber,
      khatmahSummary: khatmahSummary ?? this.khatmahSummary,
      todayTasbihTotal: todayTasbihTotal ?? this.todayTasbihTotal,
      currentTasbihStreakDays:
          currentTasbihStreakDays ?? this.currentTasbihStreakDays,
      bestTasbihStreakDays: bestTasbihStreakDays ?? this.bestTasbihStreakDays,
      tasbihTargetPreset: tasbihTargetPreset ?? this.tasbihTargetPreset,
      verseOfTheDay: verseOfTheDay ?? this.verseOfTheDay,
      lastSyncedWidgetPayload:
          lastSyncedWidgetPayload ?? this.lastSyncedWidgetPayload,
    );
  }
}
