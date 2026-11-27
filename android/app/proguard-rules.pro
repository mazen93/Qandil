# Qandil (قنديل) — Android R8 / ProGuard Keep Rules

# 1. Flutter Engine & Embedding
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# 2. Background Audio (just_audio / just_audio_background / audio_service)
-keep class com.ryanheise.audioservice.** { *; }
-keep class com.ryanheise.just_audio.** { *; }
-dontwarn com.google.android.exoplayer2.**
-keep class androidx.media.** { *; }

# 3. Local Notifications (flutter_local_notifications / Gson serialization)
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }

# 4. Qandil Native Home-Screen App Widgets
-keep class com.mmazin.qandil.widgets.** { *; }
-keep class es.antonborri.home_widget.** { *; }

# 5. Drift / SQLite3 Native FFI
-keep class org.sqlite.** { *; }
-keep class com.simolus3.sqlite3.** { *; }

# 6. Flutter Play Store Deferred Components (optional, unused in standard APK/AAB)
-dontwarn com.google.android.play.core.**
