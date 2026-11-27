import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/home/domain/entities/home_entities.dart';
import 'package:qandil/features/home/domain/services/home_widget_sync_service.dart';

import '../../presentation/cubit/home_view_model_test.dart';

void main() {
  group('Phase 11: HomeWidgetSyncService & Data-Sharing Layer Tests', () {
    test(
        'serializes all 4 widget families (Next Prayer, Five Prayers, Tasbih, Today Wird), prayer boundaries, RTL & theme, and triggers reload on all 4 widgets',
        () async {
      final fakeGateway = FakeHomeWidgetSyncGateway();
      final syncService = HomeWidgetSyncService(gateway: fakeGateway);

      const payload = HomeWidgetPayload(
        languageCode: 'ar',
        isRtl: true,
        isDarkTheme: true,
        hasLocation: true,
        cityName: 'القاهرة، مصر',
        gregorianDateText: '27 نوفمبر 2026',
        hijriDateText: '17 جمادى الآخرة 1448 هـ',
        nextPrayerName: 'الظهر',
        nextPrayerTimeFormatted: '11:46 ص',
        nextPrayerTargetEpochMs: 1795772760000,
        nextPrayerCountdownText: '01h 16m',
        fajrTimeFormatted: '05:00 ص',
        sunriseTimeFormatted: '06:28 ص',
        dhuhrTimeFormatted: '11:46 ص',
        asrTimeFormatted: '02:39 م',
        maghribTimeFormatted: '04:56 م',
        ishaTimeFormatted: '06:17 م',
        prayerBoundaryEpochMsList: [
          1795772760000,
          1795783140000,
          1795791360000,
        ],
        todayTasbihTotal: 99,
        tasbihStreakDays: 7,
        tasbihTargetPreset: 33,
        wirdCurrentSurahName: 'البقرة',
        wirdCurrentPage: 42,
        wirdCurrentAyah: 255,
        wirdCurrentJuz: 3,
        wirdProgressPercent: 7,
        wirdCatchUpPagesPerDay: 20,
        updatedAtEpochMs: 1795768000000,
      );

      await syncService.syncPayload(payload);

      // 1. Verify iOS App Group initialized
      expect(fakeGateway.appGroupId, 'group.com.mmazin.qandil');

      // 2. Verify shared key-value data for RTL, theme, prayer boundaries, tasbih, and wird
      expect(fakeGateway.savedData['qandil_lang'], 'ar');
      expect(fakeGateway.savedData['qandil_is_rtl'], isTrue);
      expect(fakeGateway.savedData['qandil_is_dark'], isTrue);
      expect(fakeGateway.savedData['qandil_next_prayer_name'], 'الظهر');
      expect(
        fakeGateway.savedData['qandil_prayer_boundaries_csv'],
        '1795772760000,1795783140000,1795791360000',
      );
      expect(fakeGateway.savedData['qandil_tasbih_today'], 99);
      expect(fakeGateway.savedData['qandil_wird_surah'], 'البقرة');
      expect(fakeGateway.savedData['qandil_wird_page'], 42);

      // 3. Verify atomic JSON blob
      final jsonStr = fakeGateway.savedData['qandil_payload_json'] as String;
      final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
      expect(decoded['qandil_city_name'], 'القاهرة، مصر');

      // 4. Verify all 4 widget providers were notified to reload
      expect(fakeGateway.updatedWidgets.length, 4);
      final iosKinds = fakeGateway.updatedWidgets.map((w) => w.iOSName).toSet();
      expect(
        iosKinds,
        containsAll([
          'QandilNextPrayerWidget',
          'QandilFivePrayersWidget',
          'QandilTasbihWidget',
          'QandilWirdWidget',
        ]),
      );
    });
  });
}
