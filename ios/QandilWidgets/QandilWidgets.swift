import WidgetKit
import SwiftUI

private let qandilAppGroupId = "group.com.mmazin.qandil"

struct QandilWidgetSnapshot: TimelineEntry {
    let date: Date
    let isAr: Bool
    let isDark: Bool
    let hasLocation: Bool
    let cityName: String
    let hijriDate: String
    let nextPrayerName: String
    let nextPrayerTime: String
    let nextPrayerCountdown: String
    let fajr: String
    let dhuhr: String
    let asr: String
    let maghrib: String
    let isha: String
    let tasbihToday: Int
    let tasbihStreak: Int
    let wirdSurah: String
    let wirdPage: Int
    let wirdJuz: Int
    let wirdPercent: Int

    static func loadFromAppGroup(at entryDate: Date = Date()) -> QandilWidgetSnapshot {
        let defaults = UserDefaults(suiteName: qandilAppGroupId)
        let lang = defaults?.string(forKey: "qandil_lang") ?? "ar"
        let isAr = (lang == "ar")
        let isDark = defaults?.object(forKey: "qandil_is_dark") as? Bool ?? true
        let hasLocation = defaults?.bool(forKey: "qandil_has_location") ?? false
        let city = defaults?.string(forKey: "qandil_city_name") ?? ""
        let hijri = defaults?.string(forKey: "qandil_hijri_date") ?? ""
        let nextName = defaults?.string(forKey: "qandil_next_prayer_name") ?? (isAr ? "الصلاة القادمة" : "Next Prayer")
        let nextTime = defaults?.string(forKey: "qandil_next_prayer_time") ?? "--:--"
        let countdown = defaults?.string(forKey: "qandil_next_prayer_countdown") ?? "--"
        let fajr = defaults?.string(forKey: "qandil_fajr_time") ?? "--:--"
        let dhuhr = defaults?.string(forKey: "qandil_dhuhr_time") ?? "--:--"
        let asr = defaults?.string(forKey: "qandil_asr_time") ?? "--:--"
        let maghrib = defaults?.string(forKey: "qandil_maghrib_time") ?? "--:--"
        let isha = defaults?.string(forKey: "qandil_isha_time") ?? "--:--"
        let tasbihToday = defaults?.integer(forKey: "qandil_tasbih_today") ?? 0
        let tasbihStreak = defaults?.integer(forKey: "qandil_tasbih_streak") ?? 0
        let wirdSurah = defaults?.string(forKey: "qandil_wird_surah") ?? (isAr ? "الفاتحة" : "Al-Fatihah")
        let wirdPage = max(1, defaults?.integer(forKey: "qandil_wird_page") ?? 1)
        let wirdJuz = max(1, defaults?.integer(forKey: "qandil_wird_juz") ?? 1)
        let wirdPercent = defaults?.integer(forKey: "qandil_wird_percent") ?? 0

        return QandilWidgetSnapshot(
            date: entryDate,
            isAr: isAr,
            isDark: isDark,
            hasLocation: hasLocation,
            cityName: city,
            hijriDate: hijri,
            nextPrayerName: nextName,
            nextPrayerTime: nextTime,
            nextPrayerCountdown: countdown,
            fajr: fajr,
            dhuhr: dhuhr,
            asr: asr,
            maghrib: maghrib,
            isha: isha,
            tasbihToday: tasbihToday,
            tasbihStreak: tasbihStreak,
            wirdSurah: wirdSurah,
            wirdPage: wirdPage,
            wirdJuz: wirdJuz,
            wirdPercent: wirdPercent
        )
    }
}

struct QandilTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> QandilWidgetSnapshot {
        QandilWidgetSnapshot.loadFromAppGroup()
    }

    func getSnapshot(in context: Context, completion: @escaping (QandilWidgetSnapshot) -> Void) {
        completion(QandilWidgetSnapshot.loadFromAppGroup())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<QandilWidgetSnapshot>) -> Void) {
        let now = Date()
        var entries: [QandilWidgetSnapshot] = [QandilWidgetSnapshot.loadFromAppGroup(at: now)]

        // Generate timeline entries at each upcoming prayer boundary so iOS refreshes widgets at prayer times
        let defaults = UserDefaults(suiteName: qandilAppGroupId)
        let csv = defaults?.string(forKey: "qandil_prayer_boundaries_csv") ?? ""
        let boundaryDates = csv.split(separator: ",")
            .compactMap { Double($0.trimmingCharacters(in: .whitespaces)) }
            .map { Date(timeIntervalSince1970: $0 / 1000.0) }
            .filter { $0 > now }

        for boundary in boundaryDates.prefix(6) {
            entries.append(QandilWidgetSnapshot.loadFromAppGroup(at: boundary))
        }

        let nextReload = boundaryDates.first ?? Calendar.current.date(byAdding: .minute, value: 30, to: now)!
        completion(Timeline(entries: entries, policy: .after(nextReload)))
    }
}

// Brand colors: Night #0F2A2E, Ivory #FBF6EA, Lantern #F2A93B, Nile #1F6F5C
extension Color {
    static let qandilNight = Color(red: 15.0 / 255.0, green: 42.0 / 255.0, blue: 46.0 / 255.0)
    static let qandilIvory = Color(red: 251.0 / 255.0, green: 246.0 / 255.0, blue: 234.0 / 255.0)
    static let qandilLantern = Color(red: 242.0 / 255.0, green: 169.0 / 255.0, blue: 59.0 / 255.0)
    static let qandilNile = Color(red: 31.0 / 255.0, green: 111.0 / 255.0, blue: 92.0 / 255.0)
}

// 1. Small: Next Prayer with Countdown
struct QandilNextPrayerWidgetView: View {
    let entry: QandilWidgetSnapshot

    var body: some View {
        let bg = entry.isDark ? Color.qandilNight : Color.qandilIvory
        let fg = entry.isDark ? Color.qandilIvory : Color.qandilNight
        let accent = entry.isDark ? Color.qandilLantern : Color.qandilNile

        VStack(alignment: .leading, spacing: 6) {
            Text(entry.hasLocation ? entry.nextPrayerName : (entry.isAr ? "مواقيت الصلاة" : "Prayer Times"))
                .font(.caption.bold())
                .foregroundColor(accent)
            Text(entry.hasLocation ? entry.nextPrayerTime : "--:--")
                .font(.title2.bold())
                .foregroundColor(fg)
            Text(entry.hasLocation ? "\(entry.nextPrayerCountdown) • \(entry.cityName)" : (entry.isAr ? "حدد موقعك في قنديل" : "Set location in Qandil"))
                .font(.caption2)
                .foregroundColor(fg.opacity(0.8))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(12)
        .background(bg)
        .environment(\.layoutDirection, entry.isAr ? .rightToLeft : .leftToRight)
    }
}

// 2. Medium: Five Prayer Times
struct QandilFivePrayersWidgetView: View {
    let entry: QandilWidgetSnapshot

    var body: some View {
        let bg = entry.isDark ? Color.qandilNight : Color.qandilIvory
        let fg = entry.isDark ? Color.qandilIvory : Color.qandilNight
        let accent = entry.isDark ? Color.qandilLantern : Color.qandilNile

        VStack(alignment: .leading, spacing: 8) {
            Text("\(entry.cityName) • \(entry.hijriDate)")
                .font(.caption.bold())
                .foregroundColor(accent)
            HStack {
                prayerColumn(name: entry.isAr ? "الفجر" : "Fajr", time: entry.fajr, fg: fg)
                Spacer()
                prayerColumn(name: entry.isAr ? "الظهر" : "Dhuhr", time: entry.dhuhr, fg: fg)
                Spacer()
                prayerColumn(name: entry.isAr ? "العصر" : "Asr", time: entry.asr, fg: fg)
                Spacer()
                prayerColumn(name: entry.isAr ? "المغرب" : "Maghrib", time: entry.maghrib, fg: fg)
                Spacer()
                prayerColumn(name: entry.isAr ? "العشاء" : "Isha", time: entry.isha, fg: fg)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(14)
        .background(bg)
        .environment(\.layoutDirection, entry.isAr ? .rightToLeft : .leftToRight)
    }

    private func prayerColumn(name: String, time: String, fg: Color) -> some View {
        VStack(spacing: 4) {
            Text(name).font(.caption2.bold()).foregroundColor(fg.opacity(0.85))
            Text(time).font(.caption2).foregroundColor(fg)
        }
    }
}

// 3. Small: Tasbih Counter with Today's Total
struct QandilTasbihWidgetView: View {
    let entry: QandilWidgetSnapshot

    var body: some View {
        let bg = entry.isDark ? Color.qandilNight : Color.qandilIvory
        let fg = entry.isDark ? Color.qandilIvory : Color.qandilNight
        let accent = entry.isDark ? Color.qandilLantern : Color.qandilNile

        VStack(spacing: 6) {
            Text(entry.isAr ? "تسبيح اليوم" : "Today's Tasbih")
                .font(.caption.bold())
                .foregroundColor(accent)
            Text("\(entry.tasbihToday)")
                .font(.title.bold())
                .foregroundColor(fg)
            Text(entry.isAr ? "التتابع: \(entry.tasbihStreak) يوم" : "Streak: \(entry.tasbihStreak)d")
                .font(.caption2)
                .foregroundColor(fg.opacity(0.8))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(12)
        .background(bg)
        .environment(\.layoutDirection, entry.isAr ? .rightToLeft : .leftToRight)
    }
}

// 4. Medium: Today's Wird Progress & Continue Reading
struct QandilWirdWidgetView: View {
    let entry: QandilWidgetSnapshot

    var body: some View {
        let bg = entry.isDark ? Color.qandilNight : Color.qandilIvory
        let fg = entry.isDark ? Color.qandilIvory : Color.qandilNight
        let accent = entry.isDark ? Color.qandilLantern : Color.qandilNile

        VStack(alignment: .leading, spacing: 6) {
            Text(entry.isAr ? "وِرد القرآن اليومي • \(entry.wirdPercent)%" : "Today's Wird • \(entry.wirdPercent)%")
                .font(.caption.bold())
                .foregroundColor(accent)
            Text(entry.isAr ? "سورة \(entry.wirdSurah) — صفحة \(entry.wirdPage) (جزء \(entry.wirdJuz))" : "\(entry.wirdSurah) — Page \(entry.wirdPage) (Juz \(entry.wirdJuz))")
                .font(.subheadline.bold())
                .foregroundColor(fg)
            Text(entry.isAr ? "اضغط لمتابعة القراءة" : "Tap to Continue Reading")
                .font(.caption2)
                .foregroundColor(fg.opacity(0.8))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(14)
        .background(bg)
        .environment(\.layoutDirection, entry.isAr ? .rightToLeft : .leftToRight)
    }
}

struct QandilNextPrayerWidget: Widget {
    let kind = "QandilNextPrayerWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QandilTimelineProvider()) { entry in
            QandilNextPrayerWidgetView(entry: entry)
        }
        .configurationDisplayName("Qandil — Next Prayer")
        .description("Next prayer time and live countdown.")
        .supportedFamilies([.systemSmall])
    }
}

struct QandilFivePrayersWidget: Widget {
    let kind = "QandilFivePrayersWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QandilTimelineProvider()) { entry in
            QandilFivePrayersWidgetView(entry: entry)
        }
        .configurationDisplayName("Qandil — Five Prayers")
        .description("Today's five daily prayer times.")
        .supportedFamilies([.systemMedium])
    }
}

struct QandilTasbihWidget: Widget {
    let kind = "QandilTasbihWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QandilTimelineProvider()) { entry in
            QandilTasbihWidgetView(entry: entry)
        }
        .configurationDisplayName("Qandil — Daily Tasbih")
        .description("Today's tasbih total and daily streak.")
        .supportedFamilies([.systemSmall])
    }
}

struct QandilWirdWidget: Widget {
    let kind = "QandilWirdWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QandilTimelineProvider()) { entry in
            QandilWirdWidgetView(entry: entry)
        }
        .configurationDisplayName("Qandil — Today's Wird")
        .description("Khatmah progress and Continue Reading shortcut.")
        .supportedFamilies([.systemMedium])
    }
}

@main
struct QandilWidgetsBundle: WidgetBundle {
    var body: some Widget {
        QandilNextPrayerWidget()
        QandilFivePrayersWidget()
        QandilTasbihWidget()
        QandilWirdWidget()
    }
}
