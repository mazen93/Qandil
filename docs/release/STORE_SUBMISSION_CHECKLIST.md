# Qandil (`قنديل`) — Store Submission Checklist (Google Play & Apple App Store)

This document contains the exact answers, justifications, review notes, and bilingual listing text required to submit **Qandil v1.0.0** (`com.mmazin.qandil`) to **Google Play Console** and **Apple App Store Connect**.

---

## 1. Google Play Console Checklist

### A. Target API & Build Configuration
- **Application ID:** `com.mmazin.qandil`
- **Target SDK / Compile SDK:** Managed by Flutter (`targetSdk 35+` / Android 15 compliant).
- **R8 Code Shrinking & Obfuscation:** Enabled in `android/app/build.gradle.kts` (`isMinifyEnabled = true`, `isShrinkResources = true`, `proguard-rules.pro`).
- **Release AAB Command with Dart Obfuscation:**
  ```bash
  flutter build appbundle --release \
    --obfuscate \
    --split-debug-info=build/app/outputs/symbols \
    --dart-define-from-file=config/env.prod.json
  ```

### B. Google Play Data Safety Form Answers
- **Does your app collect or share any of the required user data types?** -> **No**
  - *Explanation:* Foreground location is processed strictly on-device (`adhan` library) and stored only in local SQLite/SharedPreferences. Personal notes, bookmarks, tasbih counts, and hifz schedules never leave the device. No analytics or crash-reporting SDK is bundled in v1.0.

### C. App Content Declarations (Android 14+ Permissions)
1. **Foreground Service Permission (`FOREGROUND_SERVICE_MEDIA_PLAYBACK`):**
   - *Declaration text:* "Qandil is a Quran recitation and audio player app. When the user starts playing a Quran surah recitation, the app runs a mediaPlayback foreground service with a visible MediaStyle notification so audio continues playing while the user locks their screen or switches apps."
2. **Exact Alarm Permission (`SCHEDULE_EXACT_ALARM`):**
   - *Note:* Qandil uses `SCHEDULE_EXACT_ALARM` (user-granted in system settings with a graceful fallback to inexact alarms), **NOT** `USE_EXACT_ALARM`, avoiding Google Play policy rejection risk for non-alarm-clock apps.
3. **Notification Policy Access (`ACCESS_NOTIFICATION_POLICY`):**
   - *Note:* Requested only when the user voluntarily enables the optional "Do Not Disturb while reading" toggle inside the Quran Reader, and always restored upon exiting Reading Mode or on next app launch.

---

## 2. Apple App Store Connect Checklist

### A. Build & Xcode Setup
- **Bundle Identifier:** `com.mmazin.qandil`
- **Widget Extension Target (Phase 11):** `com.mmazin.qandil.QandilWidgets`
- **App Group Identifier:** `group.com.mmazin.qandil` (follow `ios/QandilWidgets/README_XCODE_SETUP.md`).
- **Release IPA Command with Dart Obfuscation:**
  ```bash
  flutter build ipa --release \
    --obfuscate \
    --split-debug-info=build/ios/symbols \
    --dart-define-from-file=config/env.prod.json
  ```

### B. App Store Privacy Labels
- **Data Collection:** Select **"No, we do not collect data from this app"** ("Data Not Collected").

### C. Background Modes Justification (`UIBackgroundModes: audio`)
- *Justification for App Review:* "Qandil provides continuous audio recitation of the Holy Quran by renowned reciters. The `audio` background mode is used so recitation continues playing when the user locks the iPhone screen or switches applications, with full Lock Screen and Control Center media playback controls."

### D. Notes for App Review (Copy-Paste into App Store Connect)
```text
Thank you for reviewing Qandil (قنديل)!

1. No Account Required:
   All features of Qandil v1.0 are accessible immediately without sign-in.

2. Background Audio Testing (UIBackgroundModes: audio):
   - Open the "Quran" (القرآن) tab.
   - Tap the Play button in the bottom Audio Dock to start Quran recitation.
   - Lock the device screen: audio continues playing and can be controlled from the iOS Lock Screen and Control Center.

3. Location & Prayer Times (NSLocationWhenInUseUsageDescription):
   - Open the "Prayer" (الصلاة) tab.
   - Location is used only while the app is open to calculate prayer times and Qibla direction 100% on-device. If location permission is declined, you can pick any city manually (e.g., Cairo or Makkah) using the city picker button in the top bar.

4. Local Notifications:
   - Open "More" (المزيد) -> "Configure Prayer Alerts, Reminders & Health".
   - All notifications are scheduled locally on-device within a rolling 7-day window (strictly under iOS's 64-notification limit).

5. Home-Screen Widgets:
   - Long-press the iOS Home Screen -> tap "+" -> search for "Qandil" to add the Next Prayer, Five Prayers, Daily Tasbih, and Today's Wird widgets.
```

---

## 3. Bilingual Store Listing Copy (`ar` & `en`)

### Arabic Store Listing (`ar`)
- **App Name (الاسم):** قنديل — القرآن والورد اليومي
- **Subtitle / Short Description (الوصف القصير — 80 حرفاً):**
  مصحف المدينة، تلاوات خاشعة، مواقيت الصلاة والقبلة، الأذكار، التحفيظ، والمسبحة.
- **Full Description (الوصف الكامل):**
  **قنديل — نورٌ يرافق يومك.**
  رفيقك اليومي الهادئ للقرآن الكريم والعبادة، مصمّم بعناية ليعمل دون اتصال بالإنترنت، وبلا إعلانات، وبلا حسابات، مع احترام كامل لخصوصيتك.

  **أهم المميزات:**
  • **المصحف الشريف بالرسم العثماني الأصيل:** قراءة مريحة بوضع صفحات المصحف أو قائمة الآيات بخط مجمع الملك فهد (حفص عن عاصم)، مع البحث السريع، والعلامات المرجعية الملونة، والملاحظات التدبرية.
  • **التفسير والترجمة ومعاني الكلمات:** التفسير الميسر وتفسير ابن كثير، مع ترجمات معتمدة ومعاني الكلمات كلمةً بكلمة عبر واجهة مؤسسة القرآن (Quran Foundation).
  • **تلاوات صوتية لكبار القرّاء:** استماع متصل أو آيةً بآية مع إبراز قرّاء المدرسة المصرية الأصيلة (الحصري، عبد الباسط، المنشاوي) وكبار قرّاء العالم الإسلامي، مع التكرار، ومؤقت النوم، وتنزيل السور للاستماع دون إنترنت.
  • **أدوات التحفيظ والمراجعة (الحفظ):** أوضاع إخفاء ذكية للآيات، اختبار التسميع الذاتي، جدول مراجعة متباعدة (SM-2) مع وضع الاستدراك، سجل نقاط الضعف، ومساعد التكرار الصوتي مع وقفة الترديد.
  • **وضع القراءة والخشوع:** إبقاء الشاشة مضاءة، تهدئة عناصر الواجهة، وتأجيل التنبيهات الداخلية أثناء القراءة (مع خيار وضع عدم الإزعاج على أندرويد).
  • **مواقيت الصلاة والقبلة والتقويم الهجري:** حساب فلكي دقيق ١٠٠٪ داخل جهازك (الهيئة المصرية العامة للمساحة افتراضياً)، بوصلة قبلة حية، وتقويم أم القرى الهجري.
  • **الأذكار والمسبحة الإحصائية:** أذكار الصباح والمساء الموثّقة من حصن المسلم مع عدّاد تكرار، ومسبحة يومية تحفظ تتابعك وإحصاءاتك.
  • **ودجات الشاشة الرئيسية:** متابعة الصلاة القادمة، الصلوات الخمس، الورد اليومي، والمسبحة مباشرة من شاشتك الرئيسية.

### English Store Listing (`en-US`)
- **App Name:** Qandil: Quran, Prayer & Wird
- **Subtitle / Short Description (80 chars):**
  Authentic Mushaf, Reciters, Prayer Times, Qibla, Adhkar, Hifz & Tasbih. No Ads.
- **Full Description:**
  **Qandil (قنديل) — Light for your day.**
  A calm, Arabic-first Quran and daily-worship companion designed for reflection and consistency. Offline-first, 100% ad-free, no account required, and zero tracking.

  **Key Features:**
  • **Authentic Uthmani Quran Reader:** Read in Madani Mushaf Page View or Verse List View rendered in the KFGQPC Uthmanic Hafs script. Includes instant Arabic search, colored bookmarks, personal notes, and a Khatmah planner with missed-day catch-up.
  • **Scholarly Tafsir, Translations & Word-by-Word:** Access Al-Tafsir Al-Muyassar, Tafsir Ibn Kathir, Saheeh International, The Clear Quran, and word-by-word meanings powered by the Quran Foundation API.
  • **Renowned Quran Reciters & Offline Audio:** Stream or download surahs for offline listening with live verse highlighting, range repeat, playback speed (0.75x–1.5x), and sleep timer—featuring beloved Egyptian Qaris (Al-Husary, AbdulBaset, Al-Minshawi) and world reciters.
  • **Memorization (Hifz) Tools:** 5 non-destructive verse hide modes, self-graded recitation testing, an on-device SM-2 spaced-repetition review scheduler with Catch-Up Mode, word-level mistake logs, teacher progress export, and audio loop with recitation pause gaps.
  • **Distraction-Free Reading Mode:** Keeps your screen awake, dims UI chrome, queues in-app reminders, and offers crash-safe Android Do Not Disturb restoration.
  • **On-Device Prayer Times, Qibla & Hijri Calendar:** Computed 100% on your device with no background location tracking. Includes live Qibla compass and Umm al-Qura Hijri calendar.
  • **Verified Adhkar & Tasbih Analytics:** Authentic Hisn al-Muslim morning and evening adhkar, plus an interactive Tasbih counter with daily streaks and charts.
  • **Home-Screen Widgets:** Glanceable widgets for Next Prayer, Five Daily Prayers, Today's Wird, and Daily Tasbih.

---

## 4. Required Store Screenshots Matrix (Arabic & English)

Capture 6 screenshots in **Arabic (RTL, Dark Night & Light Ivory)** and 6 in **English (LTR)**:
1. **Home Screen & Widgets:** Greeting, Next Prayer countdown, Today's Wird ring, Dhikr quick counter, and Verse of the Day.
2. **Quran Reader & Tafsir Sheet:** Uthmanic Hafs script with verse highlighting and bottom sheet showing Al-Tafsir Al-Muyassar & translation.
3. **Audio Player & Reciters:** Audio dock with Egyptian Qaris list and offline surah downloads.
4. **Hifz Memorization & Hide Modes:** Reader with word masking + SM-2 review queue & stats.
5. **Prayer Times & Qibla Compass:** Five daily prayers + live Qibla compass aligned with Makkah.
6. **Adhkar & Tasbih Statistics:** Morning Adhkar reader + Tasbih counter & 7-day bar chart.
