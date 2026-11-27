package com.mmazin.qandil.widgets

import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.view.View
import android.widget.RemoteViews
import com.mmazin.qandil.MainActivity
import com.mmazin.qandil.R
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Base class for Qandil Phase 11 Android Home-Screen App Widgets:
 * - Reads shared data from `HomeWidgetPreferences` via `HomeWidgetPlugin.getData(context)`
 * - Applies Qandil Night (#0F2A2E) or Ivory (#FBF6EA) theme and RTL/LTR layout direction
 * - Automatically schedules an alarm at the next prayer boundary and refreshes after device reboot
 *   (`ACTION_BOOT_COMPLETED`, `ACTION_TIMEZONE_CHANGED`, `ACTION_TIME_CHANGED`).
 */
abstract class BaseQandilWidgetProvider : AppWidgetProvider() {

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        val action = intent.action ?: return
        if (action == Intent.ACTION_BOOT_COMPLETED ||
            action == Intent.ACTION_TIMEZONE_CHANGED ||
            action == Intent.ACTION_TIME_CHANGED ||
            action == ACTION_PRAYER_BOUNDARY_REFRESH
        ) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(ComponentName(context, this::class.java))
            if (ids.isNotEmpty()) {
                onUpdate(context, manager, ids)
            }
        }
    }

    protected fun scheduleNextPrayerBoundaryAlarm(context: Context) {
        val prefs = HomeWidgetPlugin.getData(context)
        val csv = prefs.getString("qandil_prayer_boundaries_csv", "") ?: ""
        val now = System.currentTimeMillis()
        val nextBoundaryMs = csv.split(",")
            .mapNotNull { it.trim().toLongOrNull() }
            .firstOrNull { it > now + 1000L } ?: return

        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as? AlarmManager ?: return
        val intent = Intent(context, this::class.java).apply {
            action = ACTION_PRAYER_BOUNDARY_REFRESH
        }
        val flags = PendingIntent.FLAG_UPDATE_CURRENT or
            (if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) PendingIntent.FLAG_IMMUTABLE else 0)
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            this::class.java.simpleName.hashCode(),
            intent,
            flags
        )
        try {
            alarmManager.setAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                nextBoundaryMs,
                pendingIntent
            )
        } catch (_: SecurityException) {
            alarmManager.set(AlarmManager.RTC_WAKEUP, nextBoundaryMs, pendingIntent)
        }
    }

    protected fun createLaunchMainActivityPendingIntent(context: Context, requestCode: Int): PendingIntent {
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }
        val flags = PendingIntent.FLAG_UPDATE_CURRENT or
            (if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) PendingIntent.FLAG_IMMUTABLE else 0)
        return PendingIntent.getActivity(context, requestCode, intent, flags)
    }

    companion object {
        const val ACTION_PRAYER_BOUNDARY_REFRESH = "com.mmazin.qandil.ACTION_PRAYER_BOUNDARY_REFRESH"
        val COLOR_NIGHT = Color.parseColor("#0F2A2E")
        val COLOR_IVORY = Color.parseColor("#FBF6EA")
        val COLOR_LANTERN = Color.parseColor("#F2A93B")
        val COLOR_NILE = Color.parseColor("#1F6F5C")
    }
}

/** 1. Small Widget: Next Prayer with Countdown */
class QandilNextPrayerWidgetProvider : BaseQandilWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        val prefs = HomeWidgetPlugin.getData(context)
        val isDark = prefs.getBoolean("qandil_is_dark", true)
        val isAr = prefs.getString("qandil_lang", "ar") == "ar"
        val hasLocation = prefs.getBoolean("qandil_has_location", false)
        val nextName = prefs.getString("qandil_next_prayer_name", if (isAr) "الصلاة القادمة" else "Next Prayer")
        val nextTime = prefs.getString("qandil_next_prayer_time", "--:--")
        val countdown = prefs.getString("qandil_next_prayer_countdown", "--")
        val city = prefs.getString("qandil_city_name", "")

        val bgColor = if (isDark) COLOR_NIGHT else COLOR_IVORY
        val primaryText = if (isDark) COLOR_IVORY else COLOR_NIGHT
        val accentText = if (isDark) COLOR_LANTERN else COLOR_NILE

        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_next_prayer)
            views.setInt(R.id.widget_root, "setBackgroundColor", bgColor)
            views.setTextColor(R.id.widget_title, accentText)
            views.setTextColor(R.id.widget_primary_value, primaryText)
            views.setTextColor(R.id.widget_subtitle, primaryText)

            if (hasLocation) {
                views.setTextViewText(R.id.widget_title, nextName)
                views.setTextViewText(R.id.widget_primary_value, nextTime)
                views.setTextViewText(R.id.widget_subtitle, "$countdown • $city")
            } else {
                views.setTextViewText(R.id.widget_title, if (isAr) "مواقيت الصلاة" else "Prayer Times")
                views.setTextViewText(R.id.widget_primary_value, "--:--")
                views.setTextViewText(
                    R.id.widget_subtitle,
                    if (isAr) "افتح قنديل لتحديد موقعك" else "Open Qandil to set location"
                )
            }

            views.setOnClickPendingIntent(R.id.widget_root, createLaunchMainActivityPendingIntent(context, 101))
            appWidgetManager.updateAppWidget(widgetId, views)
        }
        scheduleNextPrayerBoundaryAlarm(context)
    }
}

/** 2. Medium Widget: The Five Prayer Times */
class QandilFivePrayersWidgetProvider : BaseQandilWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        val prefs = HomeWidgetPlugin.getData(context)
        val isDark = prefs.getBoolean("qandil_is_dark", true)
        val isAr = prefs.getString("qandil_lang", "ar") == "ar"
        val city = prefs.getString("qandil_city_name", if (isAr) "قنديل" else "Qandil")
        val hijri = prefs.getString("qandil_hijri_date", "")
        val fajr = prefs.getString("qandil_fajr_time", "--:--")
        val dhuhr = prefs.getString("qandil_dhuhr_time", "--:--")
        val asr = prefs.getString("qandil_asr_time", "--:--")
        val maghrib = prefs.getString("qandil_maghrib_time", "--:--")
        val isha = prefs.getString("qandil_isha_time", "--:--")

        val bgColor = if (isDark) COLOR_NIGHT else COLOR_IVORY
        val primaryText = if (isDark) COLOR_IVORY else COLOR_NIGHT
        val accentText = if (isDark) COLOR_LANTERN else COLOR_NILE

        val summaryLine = if (isAr) {
            "الفجر $fajr  |  الظهر $dhuhr  |  العصر $asr\nالمغرب $maghrib  |  العشاء $isha"
        } else {
            "Fajr $fajr  |  Dhuhr $dhuhr  |  Asr $asr\nMaghrib $maghrib  |  Isha $isha"
        }

        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_five_prayers)
            views.setInt(R.id.widget_root, "setBackgroundColor", bgColor)
            views.setTextColor(R.id.widget_title, accentText)
            views.setTextColor(R.id.widget_body, primaryText)
            views.setTextViewText(R.id.widget_title, "$city • $hijri")
            views.setTextViewText(R.id.widget_body, summaryLine)
            views.setOnClickPendingIntent(R.id.widget_root, createLaunchMainActivityPendingIntent(context, 102))
            appWidgetManager.updateAppWidget(widgetId, views)
        }
        scheduleNextPrayerBoundaryAlarm(context)
    }
}

/** 3. Small Widget: Tasbih Counter with Today's Total */
class QandilTasbihWidgetProvider : BaseQandilWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        val prefs = HomeWidgetPlugin.getData(context)
        val isDark = prefs.getBoolean("qandil_is_dark", true)
        val isAr = prefs.getString("qandil_lang", "ar") == "ar"
        val todayTotal = prefs.getInt("qandil_tasbih_today", 0)
        val streak = prefs.getInt("qandil_tasbih_streak", 0)

        val bgColor = if (isDark) COLOR_NIGHT else COLOR_IVORY
        val primaryText = if (isDark) COLOR_IVORY else COLOR_NIGHT
        val accentText = if (isDark) COLOR_LANTERN else COLOR_NILE

        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_tasbih)
            views.setInt(R.id.widget_root, "setBackgroundColor", bgColor)
            views.setTextColor(R.id.widget_title, accentText)
            views.setTextColor(R.id.widget_primary_value, primaryText)
            views.setTextColor(R.id.widget_subtitle, primaryText)

            views.setTextViewText(R.id.widget_title, if (isAr) "تسبيح اليوم" else "Today's Tasbih")
            views.setTextViewText(R.id.widget_primary_value, "$todayTotal")
            views.setTextViewText(
                R.id.widget_subtitle,
                if (isAr) "التتابع: $streak يوم" else "Streak: $streak d"
            )
            views.setOnClickPendingIntent(R.id.widget_root, createLaunchMainActivityPendingIntent(context, 103))
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}

/** 4. Medium Widget: Today's Wird Progress & Continue Reading */
class QandilWirdWidgetProvider : BaseQandilWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        val prefs = HomeWidgetPlugin.getData(context)
        val isDark = prefs.getBoolean("qandil_is_dark", true)
        val isAr = prefs.getString("qandil_lang", "ar") == "ar"
        val surah = prefs.getString("qandil_wird_surah", if (isAr) "الفاتحة" else "Al-Fatihah")
        val page = prefs.getInt("qandil_wird_page", 1)
        val juz = prefs.getInt("qandil_wird_juz", 1)
        val percent = prefs.getInt("qandil_wird_percent", 0)

        val bgColor = if (isDark) COLOR_NIGHT else COLOR_IVORY
        val primaryText = if (isDark) COLOR_IVORY else COLOR_NIGHT
        val accentText = if (isDark) COLOR_LANTERN else COLOR_NILE

        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_wird)
            views.setInt(R.id.widget_root, "setBackgroundColor", bgColor)
            views.setTextColor(R.id.widget_title, accentText)
            views.setTextColor(R.id.widget_primary_value, primaryText)
            views.setTextColor(R.id.widget_subtitle, primaryText)

            views.setTextViewText(
                R.id.widget_title,
                if (isAr) "وِرد القرآن • $percent%" else "Today's Wird • $percent%"
            )
            views.setTextViewText(
                R.id.widget_primary_value,
                if (isAr) "سورة $surah — ص $page (جزء $juz)" else "$surah — Page $page (Juz $juz)"
            )
            views.setTextViewText(
                R.id.widget_subtitle,
                if (isAr) "اضغط لمتابعة القراءة" else "Tap to Continue Reading"
            )
            views.setOnClickPendingIntent(R.id.widget_root, createLaunchMainActivityPendingIntent(context, 104))
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
