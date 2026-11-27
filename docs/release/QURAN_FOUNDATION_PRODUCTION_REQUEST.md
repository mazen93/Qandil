# Quran Foundation Production API Access Request Package

Use the information below when submitting the request to upgrade **Qandil (`قنديل`)** from the Quran Foundation Pre-Production environment (`apis-prelive.quran.foundation`, which serves Surahs 1 and 2) to **Production (`apis.quran.foundation`, all 114 Surahs)**.

---

## 1. Application Details

- **Application Name:** Qandil (`قنديل`) — Light for your day / نورٌ يرافق يومك
- **Platforms:** Android & iOS (Flutter)
- **Package Name / Bundle ID:** `com.mmazin.qandil`
- **Target Audience & Business Model:** Free, 100% ad-free daily Quran reading, listening, memorization (Hifz), and worship companion. No monetization, no paywalls, and no advertisements.

---

## 2. Application Description (For Quran Foundation Review Team)

> **Qandil (`قنديل`)** is a free, ad-free, offline-first mobile application for Android and iOS built to help Muslims read, listen to, reflect upon, and memorize the Holy Quran alongside their daily worship (prayer times, Qibla, verified adhkar, and tasbih).
>
> Qandil integrates the **Quran Foundation Content API v4** (`chapters`, `verses/by_chapter`, `verses/by_page`, `verses/by_juz`, `resources/tafsirs`, `tafsirs`, `resources/translations`, `resources/recitations`, `recitations`, and `search`) in strict compliance with all Quran Foundation API Terms of Use and content-integrity requirements.

---

## 3. Compliance with Quran Foundation API Terms & Security Rules

1. **Zero Client Secrets in the Mobile App (OAuth2 Token Proxy):**
   - `client_secret` is **never** bundled in the Flutter app or source repository.
   - Instead, Qandil uses a dedicated Cloudflare Workers serverless proxy (`serverless/token_proxy/src/index.js`) that stores `QF_CLIENT_ID` and `QF_CLIENT_SECRET` in encrypted environment secrets, requests OAuth2 `client_credentials` tokens from Quran Foundation, caches them in memory until 60 seconds before expiry, enforces per-IP rate limiting, and returns only short-lived access tokens to the app.
2. **7-Day Cache Expiry Policy:**
   - All API responses cached locally in Qandil's SQLite (`Drift`) database carry a `cachedAt` timestamp and an explicit `expiresAt = cachedAt + 7 days` TTL (`QuranLocalRepositoryImpl.cacheTtl = Duration(days: 7)`).
   - `purgeExpiredQuranCache()` automatically purges expired cache entries on app startup and refreshes content when online within the 7-day window.
3. **Strict Content Integrity (Zero Alteration, Zero AI Usage):**
   - Quranic text (`text_uthmani`) is rendered verbatim using the official **KFGQPC Uthmanic Script Hafs Ver 18** font (`UthmanicHafs1Ver18.ttf`).
   - Display-layer features (such as Arabic search query normalization or Hifz word masking) operate strictly in memory on ephemeral copies and **never** normalize, strip diacritics from, or alter stored or displayed Quranic text.
   - Qandil never machine-translates religious text and **never** uses Quran Foundation content to train, fine-tune, or prompt any AI/ML model.
4. **User-Initiated Offline Audio with Reciter Attribution:**
   - Audio recitations are downloaded only when explicitly initiated by the user per surah into app-private storage (`getApplicationSupportDirectory()/offline_audio`), with an explicit reciter credit banner and storage management screen (`AudioDownloadsStoragePage`).
5. **Complete Attribution on About / Credits Screen & Share Cards:**
   - The dedicated **About & Credits** screen (`lib/features/settings/presentation/pages/credits_page.dart`) explicitly credits **Quran Foundation (`quran.com`)**, King Fahd Glorious Quran Printing Complex (KFGQPC), every reciter, tafsir (*Al-Tafsir Al-Muyassar*, *Tafsir Ibn Kathir*), and translation (*Saheeh International*, *The Clear Quran*).
   - Every shared verse text or image automatically appends the attribution line:
     - English: `Source: King Fahd Glorious Quran Printing Complex via Quran Foundation (quran.com) — Shared via Qandil`
     - Arabic: `المصدر: مجمع الملك فهد لطباعة المصحف الشريف عبر مؤسسة القرآن (quran.com) — مشاركة من تطبيق قنديل`

---

## 4. Attachments to Include with Your Production Request

1. **Screenshot 1:** `About & Credits` screen in Arabic and English showing full attribution to Quran Foundation (`quran.com`), KFGQPC, reciters, tafsirs, and translations.
2. **Screenshot 2:** `Quran Reader` screen showing Surah Al-Fatihah and Surah Al-Baqarah rendered in KFGQPC Uthmanic Script Hafs from `apis-prelive.quran.foundation`.
3. **Screenshot 3:** `Verse Action Bottom Sheet` showing Tafsir, Translation, Word-by-Word breakdown, and Share credit line.
4. **Screenshot 4:** `Offline Audio & Storage` screen showing user-initiated download controls and the reciter credit banner.
5. **Cloudflare Worker Proxy Source:** `serverless/token_proxy/src/index.js` demonstrating that `client_secret` stays server-side.
