import '../../features/hifz/domain/services/hifz_sm2_scheduler.dart';
import '../../features/prayer/domain/entities/prayer_entities.dart';
import '../../features/prayer/domain/services/prayer_calculator_service.dart';
import '../../features/settings/domain/entities/app_settings.dart';
import '../../features/tasbih/domain/services/tasbih_stats_calculator.dart';
import 'notification_entities.dart';

/// Pure Dart scheduler planner for Phase 6 Notifications:
/// - Builds a rolling 7-day window of prayer notifications, daily wird reminders,
///   optional Friday reminders, and tasbih reminders.
/// - Explicitly budgets total pending notifications to at most [maxPendingBudget] (`56`),
///   staying safely below the iOS 64-notification system limit.
abstract final class NotificationWindowPlanner {
  /// Hard cap on pending scheduled notifications (iOS system cap is 64; 56 leaves an 8-item safety buffer).
  static const int maxPendingBudget = 56;
  static const int rollingWindowDays = 7;

  /// Plans all future notifications within the 7-day rolling window starting from [now].
  static List<PlannedNotificationItem> planRollingSevenDayWindow({
    required DateTime now,
    required AppSettings settings,
    Duration? utcOffset,
    int todayTasbihTotal = 0,
    int currentTasbihStreakDays = 0,
    int hifzDueQueueSize = 0,
    int hifzOverdueCount = 0,
  }) {
    if (!settings.notificationsEnabled) {
      return const [];
    }

    final startDay = DateTime(now.year, now.month, now.day);
    final sevenDaySchedules = PrayerCalculatorService.computeThirtyDaySchedules(
      startDate: startDay,
      latitude: settings.locationLatitude,
      longitude: settings.locationLongitude,
      method: settings.prayerCalculationMethod,
      asrMadhab: settings.asrMadhab,
      highLatitudeRule: settings.highLatitudeRule,
      adjustments: settings.prayerAdjustments,
      utcOffset: utcOffset,
      days: rollingWindowDays,
    );

    final isAr = settings.languageCode == 'ar';
    final candidates = <PlannedNotificationItem>[];

    const obligatorySlots = <PrayerSlot>[
      PrayerSlot.fajr,
      PrayerSlot.dhuhr,
      PrayerSlot.asr,
      PrayerSlot.maghrib,
      PrayerSlot.isha,
    ];

    for (var dayIdx = 0; dayIdx < sevenDaySchedules.length; dayIdx++) {
      final schedule = sevenDaySchedules[dayIdx];
      final calendarDate = schedule.date;

      // 1. Five Daily Prayers (up to 35 items over 7 days)
      for (var slotIdx = 0; slotIdx < obligatorySlots.length; slotIdx++) {
        final slot = obligatorySlots[slotIdx];
        final config = settings.prayerNotificationsConfig.forSlot(slot);
        if (!config.enabled) continue;

        final prayerTime = schedule.timeForSlot(slot);
        final triggerTime = prayerTime.subtract(
          Duration(minutes: config.minutesBefore),
        );

        if (!triggerTime.isAfter(now)) continue;

        final slotLabel = _localizedPrayerName(slot, isAr: isAr);
        final title = isAr ? 'موعد صلاة $slotLabel' : '$slotLabel Prayer Time';
        final body = config.minutesBefore > 0
            ? (isAr
                ? 'باقي ${config.minutesBefore} دقيقة على أذان $slotLabel (${settings.locationCityNameAr})'
                : '${config.minutesBefore} min until $slotLabel in ${settings.locationCityNameEn}')
            : (isAr
                ? 'حان الآن موعد صلاة $slotLabel حسب توقيت ${settings.locationCityNameAr}'
                : 'It is now time for $slotLabel prayer in ${settings.locationCityNameEn}');

        candidates.add(
          PlannedNotificationItem(
            id: 1000 + (dayIdx * 10) + slotIdx,
            channel: QandilNotificationChannel.prayer,
            title: title,
            body: body,
            scheduledAt: triggerTime,
            playSound: config.soundMode == PrayerNotificationSoundMode.adhan,
            payload: 'prayer:${slot.name}',
          ),
        );
      }

      // 2. Daily Wird Reminder (up to 7 items over 7 days)
      if (settings.wirdReminderEnabled) {
        final wirdTime = DateTime(
          calendarDate.year,
          calendarDate.month,
          calendarDate.day,
          settings.wirdReminderHour,
          settings.wirdReminderMinute,
        );
        if (wirdTime.isAfter(now)) {
          candidates.add(
            PlannedNotificationItem(
              id: 2000 + dayIdx,
              channel: QandilNotificationChannel.wird,
              title: isAr ? 'وِرد القرآن اليومي' : 'Daily Quran Wird',
              body: isAr
                  ? 'نورٌ يرافق يومك — حان موعد قراءة وردك اليومي من المصحف الشريف.'
                  : 'Light for your day — time to continue your daily Quran reading.',
              scheduledAt: wirdTime,
              playSound: true,
              payload: 'wird:daily',
            ),
          );
        }
      }

      // 3. Weekly Friday Reminder (up to 1 item in a 7-day window)
      if (settings.fridayReminderEnabled &&
          calendarDate.weekday == DateTime.friday) {
        final fridayTime = DateTime(
          calendarDate.year,
          calendarDate.month,
          calendarDate.day,
          settings.fridayReminderHour,
          settings.fridayReminderMinute,
        );
        if (fridayTime.isAfter(now)) {
          candidates.add(
            PlannedNotificationItem(
              id: 4000 + dayIdx,
              channel: QandilNotificationChannel.wird,
              title: isAr ? 'سنن يوم الجمعة' : 'Friday Sunnah Reminder',
              body: isAr
                  ? 'تذكير بقراءة سورة الكهف والإكثار من الصلاة على النبي ﷺ.'
                  : 'Reminder to read Surah Al-Kahf and send blessings upon the Prophet.',
              scheduledAt: fridayTime,
              playSound: true,
              payload: 'wird:friday',
            ),
          );
        }
      }

      // 4. Daily Tasbih Reminder (up to 7 items over 7 days; adapts text on Day 0 based on today's local goal)
      if (settings.tasbihReminderEnabled) {
        final tasbihTime = DateTime(
          calendarDate.year,
          calendarDate.month,
          calendarDate.day,
          settings.tasbihReminderHour,
          settings.tasbihReminderMinute,
        );
        if (tasbihTime.isAfter(now)) {
          final adaptiveBody = dayIdx == 0
              ? TasbihStatsCalculator.buildAdaptiveReminderBody(
                  todayTotal: todayTasbihTotal,
                  dailyGoal: settings.tasbihTargetPreset,
                  currentStreakDays: currentTasbihStreakDays,
                  languageCode: settings.languageCode,
                )
              : (isAr
                  ? 'حافظ على وردك اليومي من التسبيح والأذكار.'
                  : 'Keep up your daily tasbih and dhikr streak.');

          candidates.add(
            PlannedNotificationItem(
              id: 3000 + dayIdx,
              channel: QandilNotificationChannel.tasbih,
              title: isAr ? 'تذكير التسبيح والذكر' : 'Daily Tasbih Reminder',
              body: adaptiveBody,
              scheduledAt: tasbihTime,
              playSound: true,
              payload: 'tasbih:daily',
            ),
          );
        }
      }

      // 5. Daily Morning Adhkar Reminder
      if (settings.morningAdhkarReminderEnabled) {
        final morningTime = DateTime(
          calendarDate.year,
          calendarDate.month,
          calendarDate.day,
          settings.morningAdhkarReminderHour,
          settings.morningAdhkarReminderMinute,
        );
        if (morningTime.isAfter(now)) {
          candidates.add(
            PlannedNotificationItem(
              id: 5000 + dayIdx,
              channel: QandilNotificationChannel.tasbih,
              title: isAr ? 'أذكار الصباح' : 'Morning Adhkar',
              body: isAr
                  ? 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ — حان وقت قراءة أذكار الصباح.'
                  : 'Time to read your morning adhkar and begin your day with remembrance.',
              scheduledAt: morningTime,
              playSound: true,
              payload: 'adhkar:morning',
            ),
          );
        }
      }

      // 6. Daily Evening Adhkar Reminder
      if (settings.eveningAdhkarReminderEnabled) {
        final eveningTime = DateTime(
          calendarDate.year,
          calendarDate.month,
          calendarDate.day,
          settings.eveningAdhkarReminderHour,
          settings.eveningAdhkarReminderMinute,
        );
        if (eveningTime.isAfter(now)) {
          candidates.add(
            PlannedNotificationItem(
              id: 6000 + dayIdx,
              channel: QandilNotificationChannel.tasbih,
              title: isAr ? 'أذكار المساء' : 'Evening Adhkar',
              body: isAr
                  ? 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ — حان وقت قراءة أذكار المساء.'
                  : 'Time to read your evening adhkar for evening peace and protection.',
              scheduledAt: eveningTime,
              playSound: true,
              payload: 'adhkar:evening',
            ),
          );
        }
      }

      // 7. Phase 12: Daily Hifz Spaced-Review Reminder (adapts text to review queue size)
      if (settings.hifzReminderEnabled) {
        final hifzTime = DateTime(
          calendarDate.year,
          calendarDate.month,
          calendarDate.day,
          settings.hifzReminderHour,
          settings.hifzReminderMinute,
        );
        if (hifzTime.isAfter(now)) {
          final adaptiveHifzBody =
              HifzSm2Scheduler.buildAdaptiveReviewReminderBody(
            dueQueueSize: hifzDueQueueSize,
            overdueCount: hifzOverdueCount,
            languageCode: settings.languageCode,
          );
          candidates.add(
            PlannedNotificationItem(
              id: 7000 + dayIdx,
              channel: QandilNotificationChannel.wird,
              title: isAr ? 'مراجعة حفظ القرآن' : 'Daily Hifz Review',
              body: adaptiveHifzBody,
              scheduledAt: hifzTime,
              playSound: true,
              payload: 'hifz:review',
            ),
          );
        }
      }
    }

    // Sort strictly chronologically and enforce the iOS <64 budget (maxPendingBudget = 56)
    candidates.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    if (candidates.length > maxPendingBudget) {
      return candidates.sublist(0, maxPendingBudget);
    }
    return candidates;
  }

  static String _localizedPrayerName(PrayerSlot slot, {required bool isAr}) {
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
