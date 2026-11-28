# Privacy Policy for Qandil (قنديل)

**Last Updated:** November 28, 2026  
**Effective Date:** November 28, 2026  
**Application Name:** Qandil (قنديل - رفيق المسلم)  
**Package / Bundle ID:** `com.mmazin.qandil`  
**Developer:** Mohamed Mazen  
**Contact Email:** [mohamed_mazin10@hotmail.com](mailto:mohamed_mazin10@hotmail.com)  
**Project Repository:** [https://github.com/mazen93/Qandil](https://github.com/mazen93/Qandil)

---

## Language / اللغة
- [English Privacy Policy](#english)
- [سياسة الخصوصية باللغة العربية](#arabic)

---

<a name="english"></a>
## English Version

### 1. Introduction & Core Philosophy
Qandil ("we", "our", or "the App") is developed as a privacy-first, offline-capable Muslim companion and Quran reading application. We respect your personal privacy above all else. 

**Our commitment is absolute: We do not collect, store, transmit, monetize, sell, or share your personal data with any third party, advertising network, or analytics provider.**

The App is designed so that all spiritual practices—reading the Holy Quran, listening to recitations, calculating prayer times, finding the Qibla, counting Tasbih, and reading Adhkar—function locally on your device with complete confidentiality.

---

### 2. Information We Access and How It Is Used

#### A. Location Data (Precise and Approximate)
- **What We Access:** When granted permission, Qandil accesses your device's geographical coordinates (latitude and longitude).
- **Why We Need It:** Location coordinates are used **strictly on-device** to:
  1. Calculate accurate astronomical Islamic prayer times (Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha) based on your selected calculation convention (e.g., Egyptian General Authority of Survey, Umm al-Qura, Muslim World League, ISNA, or Karachi).
  2. Compute the exact trigonometric direction (bearing) towards the Holy Kaaba in Makkah for the Qibla compass.
- **Data Handling:** 
  - Your location data is **never transmitted** over the internet to any external server, cloud service, or third party.
  - Location coordinates are only stored locally in your device's secure SQLite database so prayer times can be computed without requesting GPS permissions repeatedly.
  - You can decline location permissions at any time through your operating system settings. The app provides manual location selection and will function properly with manual settings.

#### B. Storage & Local Device Data
- **What We Access:** Local app-specific storage directory provided by your operating system.
- **Why We Need It:**
  - To store downloaded Quran text pages, translations, and tafsir for offline reading.
  - To store downloaded Quran recitation audio files chosen by the user for offline listening.
  - To maintain your local SQLite database containing reading bookmarks, last-read positions, personal Khatmah plans, custom Adhkar, and Tasbih counter tallies.
- **Data Handling:** All this data stays on your local device. It is not synchronized with any remote server and is completely erased if you uninstall the application or clear app data in system settings.

#### C. Audio & Background Playback
- **What We Access:** Media playback service and foreground service permissions (`FOREGROUND_SERVICE_MEDIA_PLAYBACK` on Android, Background Audio capability on iOS).
- **Why We Need It:** To allow continuous, seamless playback of Quranic recitations and Adhan alerts when your screen is locked or while multitasking with other applications.
- **Data Handling:** No audio recording or microphone access is ever requested or used by Qandil.

#### D. Local Notifications
- **What We Access:** Notification permissions (`POST_NOTIFICATIONS` on Android 13+, User Notifications on iOS).
- **Why We Need It:** To deliver scheduled prayer time alerts, full Adhan audio notifications, and voluntary daily morning/evening dhikr reminders.
- **Data Handling:** All notifications are scheduled **locally on your device** via system alarms. No push notification servers (such as Firebase Cloud Messaging, APNs, or third-party notification delivery services) are used, meaning your device tokens are never sent to any server.

---

### 3. Third-Party Services, SDKs & Trackers

- **Zero Advertising SDKs:** Qandil contains no advertisements, banner ads, interstitial ads, or reward video ads.
- **Zero Analytics / Tracking SDKs:** We do not integrate Google Analytics, Firebase Analytics, Meta Pixel, Adjust, AppsFlyer, or any user profiling libraries.
- **Content Delivery Networks (CDNs):** When you choose to download or stream Quran recitations or translations, requests are made directly to well-known, public Islamic open-source repositories and CDNs (such as Quran.com, QuranicAudio.com, EveryAyah.com). These network requests contain only standard technical HTTP request headers necessary to stream or retrieve the requested media file and do not transmit personal identifiers.

---

### 4. Children’s Privacy (COPPA & GDPR Compliance)
Qandil does not collect any personal information from any user, including children under the age of 13 (or under 16 in the European Union). Because no personal information is collected, stored, or processed, Qandil is safe for users of all ages and is fully compliant with the Children's Online Privacy Protection Act (COPPA) and the General Data Protection Regulation (GDPR).

---

### 5. Data Retention, Control & Deletion
- **User Control:** You retain full control over your data. All reading history, bookmarks, and counters are stored strictly within the app's local sandbox.
- **Deletion:** You can reset your data at any time from the app's Settings menu, or delete all app data and cached recitations permanently by uninstalling Qandil from your device.

---

### 6. Changes to This Privacy Policy
We may periodically update our Privacy Policy to reflect app updates or regulatory standards. Any modifications will be posted to this page with an updated "Last Updated" date. We encourage you to review this page periodically.

---

### 7. Contact Us
If you have any questions, suggestions, or concerns regarding this Privacy Policy or your data privacy while using Qandil, please feel free to reach out to us:

- **Developer:** Mohamed Mazen
- **Email:** [mohamed_mazin10@hotmail.com](mailto:mohamed_mazin10@hotmail.com)
- **GitHub Repository:** [https://github.com/mazen93/Qandil](https://github.com/mazen93/Qandil)

---

<br/>

<a name="arabic"></a>
## النسخة العربية (Arabic Version)

### سياسة الخصوصية لتطبيق قنديل (Qandil)

**تاريخ آخر تحديث:** 28 نوفمبر 2026  
**تاريخ السريان:** 28 نوفمبر 2026  
**اسم التطبيق:** قنديل - رفيق المسلم (Qandil)  
**معرّف الحزمة (Package ID):** `com.mmazin.qandil`  
**المطوّر:** محمد مازن (Mohamed Mazen)  
**البريد الإلكتروني للتواصل:** [mohamed_mazin10@hotmail.com](mailto:mohamed_mazin10@hotmail.com)  
**مستودع المشروع:** [https://github.com/mazen93/Qandil](https://github.com/mazen93/Qandil)

---

### 1. المقدمة وفلسفة التطبيق الأساسية
تم تصميم وتطوير تطبيق "قنديل" ليكون رفيقاً إسلامياً شاملاً يعتمد مبدأ "الخصوصية أولاً" والعمل دون اتصال بالإنترنت (Offline-First). نحن نقدّر خصوصيتك تقديراً تاماً ونلتزم بحمايتها بأعلى المعايير.

**تعهّدنا راسخ ومطلق: نحن لا نجمع، ولا نخزن على خوادم خارجية، ولا ننقل، ولا نبيع، ولا نشارك أي بيانات شخصية تخص المستخدم مع أي طرف ثالث أو شبكات إعلانية أو منصات تتبع إحصائي.**

يعمل التطبيق بالكامل داخل بيئة جهازك الآمنة، حيث تُحسب مواقيت الصلاة واتجاه القبلة وتُدار الختمات وقراءة القرآن الكريم والاستماع للتلاوات والأذكار والسبحة محلياً دون الحاجة إلى إنشاء حساب أو إرسال بياناتك لخوادم بعيدة.

---

### 2. الصلاحيات والبيانات التي يتم الوصول إليها وكيفية استخدامها

#### أ. بيانات الموقع الجغرافي (الدقيق والتقريبي)
- **ما نصل إليه:** عند منح الإذن للتطبيق، يصل قنديل إلى إحداثيات موقعك الجغرافي (خط الطول ودائرة العرض).
- **سبب الحاجة إلى الموقع:** تُستخدم الإحداثيات **محلياً داخل هاتفك فقط** للغرضين التاليين:
  1. حساب المواقيت الفلكية الدقيقة للصلوات الخمس والشروق اعتماداً على الهيئة أو المنهج الحسابي المختار (مثل الهيئة المصرية العامة للمساحة، أم القرى، رابطة العالم الإسلامي، جامعة العلوم الإسلامية بكراتشي، أو الاتحاد الإسلامي لأمريكا الشمالية).
  2. تحديد زاوية واتجاه القبلة الدقيق نحو الكعبة المشرفة بمكة المكرمة عبر بوصلة القبلة.
- **كيفية التعامل مع بيانات الموقع:**
  - **لا يتم أبداً إرسال إحداثياتك** عبر شبكة الإنترنت إلى أي خادم خارجي أو طرف ثالث.
  - تُحفظ الإحداثيات محلياً فقط في قاعدة بيانات الهاتف المشفرة حتى لا يطلب التطبيق إذن الموقع باستمرار.
  - يمكنك إلغاء صلاحية الموقع في أي وقت عبر إعدادات نظام التشغيل بهاتفك، كما يتيح التطبيق تحديد المدينة يدوياً دون الحاجة لتشغيل الـ GPS.

#### ب. التخزين وبيانات الجهاز المحلية
- **ما نصل إليه:** مجلد التخزين الخاص بالتطبيق والمعزول على جهازك (App Sandboxed Storage).
- **سبب الحاجة إليه:**
  - حفظ صفحات المصحف الشريف والتفاسير والترجمات لقراءتها بدون إنترنت.
  - حفظ ملفات التلاوات الصوتية للسور والآيات التي يختار المستخدم تحميلها للاستماع في وضع عدم الاتصال.
  - إدارة قاعدة البيانات المحلية (SQLite) لتخزين العلامات المرجعية، آخر موضع قراءة، جدول الختمة القرآنية، الأذكار، وسجلات السبحة الإلكترونية.
- **كيفية التعامل:** تبقى كل هذه البيانات محفوظة حصرياً على جهازك، وتُحذف نهائياً وتلقائياً بمجرد إلغاء تثبيت التطبيق من الهاتف.

#### ج. الصوت والتشغيل في الخلفية
- **ما نصل إليه:** خدمات تشغيل الوسائط الصوتية في الخلفية (`FOREGROUND_SERVICE_MEDIA_PLAYBACK` في أندرويد وإمكانية الخلفية الصوتية في iOS).
- **سبب الحاجة إليه:** لتمكين الاستماع المتواصل لتلاوات القرآن الكريم وسماع الأذان كاملاً عند إغلاق الشاشة أو أثناء استخدام تطبيقات أخرى.
- **كيفية التعامل:** لا يطلب التطبيق ولا يستخدم إذن الميكروفون ولا يقوم بتسجيل أي صوت على الإطلاق.

#### د. الإشعارات والتنبيهات المحلية
- **ما نصل إليه:** إذن إرسال الإشعارات (`POST_NOTIFICATIONS` في أندرويد 13+ وإذن التنبيهات في iOS).
- **سبب الحاجة إليه:** لجدولة تنبيهات مواقيت الصلاة، وإطلاق صوت الأذان الشريف، والتذكير بأذكار الصباح والمساء.
- **كيفية التعامل:** تُجدول جميع التنبيهات **محلياً على هاتفك** عبر منبهات النظام، دون استخدام أي خوادم إشعارات خارجية (مثل Firebase أو OneSignal)، مما يضمن عدم تداول معرّف جهازك على الإطلاق.

---

### 3. الخدمات الخارجية، حزم البرمجيات وأدوات التتبع
- **خالٍ تماماً من الإعلانات:** لا يحتوي تطبيق قنديل على أي إعلانات تجارية، أو نوافذ منبثقة، أو بنرات.
- **خالٍ من حزم التتبع والتحليلات:** لا نستخدم Google Analytics، أو Firebase Analytics، أو Facebook Pixel، أو أي مكتبة تهدف إلى تتبع سلوك المستخدمين وبناء ملفات تعريفية.
- **شبكات توفير المحتوى (CDNs):** عند قيامك بتشغيل أو تنزيل التلاوات الصوتية، يتصل التطبيق مباشرة بشبكات التوزيع الإسلامية المفتوحة المعتمدة (مثل Quran.com، QuranicAudio.com، EveryAyah.com). تقتصر هذه الطلبات على تحميل الملف الصوتي المطلوب فقط دون إرسال أي معرفات شخصية.

---

### 4. حماية خصوصية الأطفال (توافق COPPA و GDPR)
لا يقوم تطبيق قنديل بجمع أي بيانات شخصية من أي مستخدم، بما في ذلك الأطفال دون سن 13 عاماً (أو دون سن 16 عاماً في الاتحاد الأوروبي). ولعدم وجود أي جمع أو معالجة للبيانات الشخصية، فإن التطبيق آمن ومناسب لجميع الفئات العمرية ومتوافق مع القوانين الدولية لحماية خصوصية الأطفال.

---

### 5. الاحتفاظ بالبيانات والتحكم بها وحذفها
- يملك المستخدم كامل الحرية والتحكم في بياناته المخزنة محلياً.
- يمكنك إعادة ضبط أو حذف أي سجلات أو علامات مرجعية في أي وقت من خلال قائمة إعدادات التطبيق، كما يؤدي حذف التطبيق من هاتفك إلى مسح كافة البيانات بشكل كامل وفوري.

---

### 6. التعديلات على سياسة الخصوصية
قد نقوم بتحديث سياسة الخصوصية هذه من حين لآخر لمواكبة التحديثات التقنية أو المتطلبات التنظيمية. سيتم نشر أي تعديل على هذه الصفحة مع تحديث تاريخ "آخر تحديث".

---

### 7. التواصل معنا
إذا كانت لديك أي استفسارات أو ملاحظات أو أسئلة تتعلق بسياسة الخصوصية لتطبيق قنديل، يُرجى التواصل معنا عبر:

- **المطوّر:** محمد مازن (Mohamed Mazen)
- **البريد الإلكتروني:** [mohamed_mazin10@hotmail.com](mailto:mohamed_mazin10@hotmail.com)
- **مستودع المشروع على GitHub:** [https://github.com/mazen93/Qandil](https://github.com/mazen93/Qandil)
