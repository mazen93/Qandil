# Qandil (`قنديل`) — Privacy Policy / سياسة الخصوصية

**Effective Date / تاريخ السريان:** 27 November 2026
**App Name / اسم التطبيق:** Qandil (`قنديل`)
**Package / Bundle ID:** `com.mmazin.qandil`

---

## English Version

### 1. Our Commitment to Your Privacy
**Qandil (`قنديل`)** is built as a calm, offline-first Quran and daily-worship companion.
- **No user account required** for v1.0.
- **Zero advertisements** (`No Ads`).
- **Zero analytics, zero tracking SDKs, and zero behavioral profiling.**

### 2. Location Information (100% On-Device)
- If you grant foreground ("When-In-Use") location permission, Qandil reads your device's latitude and longitude **solely on your device** to calculate daily prayer times and the Qibla direction using the on-device `adhan` astronomical calculation library.
- You may also select your city manually without granting GPS permission.
- **No Background Location:** Qandil never requests background location access (`ACCESS_BACKGROUND_LOCATION` / `NSLocationAlwaysUsageDescription`).
- **Never Transmitted:** Your coordinates and city name are stored exclusively in your device's local SQLite database (`Drift`) and local App Group / SharedPreferences (for updating your home-screen widgets) and are **never** sent to our servers or any third party.

### 3. Personal Worship & Reading Data (100% On-Device)
All of your personal worship records are stored locally on your device in an app-private SQLite database:
- Quran reading position, Khatmah plans, colored bookmarks, and personal reflection notes.
- Hifz (memorization) ranges, SM-2 review schedules, and word-level mistake logs.
- Tasbih daily counts, streaks, and Adhkar completion progress.
- If you choose to export your Tasbih statistics or Hifz teacher progress report as a JSON file, the file is shared directly by you via your operating system's native Share Sheet.

### 4. Network Requests & Quran Content Sources
Qandil works offline-first. Network requests are made **only** when fetching Quranic text packs, tafsir, translations, or streaming/downloading audio recitations:
1. **Qandil OAuth2 Token Proxy (Cloudflare Workers):** Exchanges server-held credentials for a short-lived anonymous Quran Foundation OAuth2 access token so that API secrets are never embedded in the mobile app. The proxy does not log or store personal user data.
2. **Quran Foundation Content & Audio APIs (`*.quran.foundation` / `*.quran.com`):** Serves verified Uthmani Quran script, tafsirs, translations, and audio recitations.

### 5. Device Permissions Explained
- **Location (`When-In-Use`):** On-device prayer time and Qibla calculations.
- **Notifications (`POST_NOTIFICATIONS`) & Exact Alarms (`SCHEDULE_EXACT_ALARM` on Android 14+):** Firing local prayer alerts, Daily Wird reminders, Morning/Evening Adhkar reminders, Tasbih reminders, and Hifz review reminders on time.
- **Foreground Service Media Playback (`FOREGROUND_SERVICE_MEDIA_PLAYBACK` / `UIBackgroundModes: audio`):** Continuing Quran recitation playback when the screen is locked.
- **Notification Policy Access (`ACCESS_NOTIFICATION_POLICY` on Android — Optional):** Only requested if you explicitly enable the optional "Do Not Disturb while reading" toggle inside Reading Mode. Qandil saves your previous interruption filter before reading and always restores it on exit or next launch.

### 6. Contact
For privacy questions or data inquiries, please contact the Qandil team via the support contact listed on the App Store and Google Play Store listing.

---

## النسخة العربية (Arabic Version)

### ١. التزامنا بخصوصيتك
صُمّم تطبيق **قنديل (`Qandil`)** ليكون رفيقك الهادئ للقرآن الكريم والورد اليومي مع العمل دون اتصال بالإنترنت:
- **لا يتطلب إنشاء حساب** في الإصدار الأول (`v1.0`).
- **خالٍ تماماً من الإعلانات.**
- **خالٍ تماماً من أدوات التتبّع أو التحليلات السلوكية.**

### ٢. بيانات الموقع الجغرافي (محلياً على جهازك فقط)
- عند منح إذن الموقع الجغرافي أثناء استخدام التطبيق (`When-In-Use`), يستخدم التطبيق إحداثيات موقعك **داخل جهازك فقط** لحساب مواقيت الصلاة واتجاه القبلة فلكياً عبر مكتبة (`adhan`).
- يمكنك دائماً اختيار مدينتك يدوياً دون منح إذن GPS.
- **لا يتم طلب الموقع في الخلفية أبداً، ولا يتم إرسال إحداثيات موقعك إلى أي خادم خارجي أو طرف ثالث.**

### ٣. بيانات العبادة والورد اليومي (محلياً على جهازك فقط)
تُحفظ جميع بياناتك الشخصية في قاعدة بيانات محلية خاصة بالتطبيق (`SQLite / Drift`) داخل جهازك فقط، وتشمل:
- موضع القراءة، خطة الختمة، العلامات المرجعية، والملاحظات التدبرية.
- مقاطع الحفظ وجدول المراجعة المتباعدة (`SM-2`) وسجل أخطاء التسميع.
- عدّاد التسبيح اليومي وإحصاءات التتابع وتقدّم الأذكار.
- عند تصدير إحصاءات التسبيح أو تقرير الحفظ للمعلّم بصيغة `JSON`، تتم المشاركة يدوياً بأمرك عبر نافذة المشاركة الخاصة بنظام التشغيل.

### ٤. الاتصالات الشبكية ومصادر المحتوى القرآني
تقتصر الاتصالات الشبكية في التطبيق على جلب النصوص القرآنية والتفاسير والترجمات والتلاوات الصوتية من:
١. **خادم الرموز المؤقتة (`Qandil OAuth2 Token Proxy`):** لإصدار رمز وصول مؤقت مجهول الهوية لواجهة مؤسسة القرآن دون تخزين أي بيانات شخصية.
٢. **واجهات مؤسسة القرآن (`Quran Foundation API`):** لتحميل النص القرآني بالرسم العثماني والتفاسير والترجمات والتلاوات الصوتية الموثّقة.
