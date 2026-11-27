import 'package:flutter/foundation.dart';
import 'package:hijri_core/hijri_core.dart';

/// Immutable representation of a converted Umm al-Qura Hijri date.
@immutable
class HijriDateInfo {
  const HijriDateInfo({
    required this.hYear,
    required this.hMonth,
    required this.hDay,
    required this.monthNameAr,
    required this.monthNameEn,
    required this.adjustmentDays,
  });

  final int hYear;
  final int hMonth;
  final int hDay;
  final String monthNameAr;
  final String monthNameEn;
  final int adjustmentDays;

  String format({required String languageCode}) {
    if (languageCode == 'ar') {
      return '${_toArabicDigits(hDay)} $monthNameAr ${_toArabicDigits(hYear)} هـ';
    }
    return '$hDay $monthNameEn $hYear AH';
  }

  static String _toArabicDigits(int number) {
    const western = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const eastern = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var result = number.toString();
    for (var i = 0; i < western.length; i++) {
      result = result.replaceAll(western[i], eastern[i]);
    }
    return result;
  }
}

/// Represents a major annual Islamic occasion on the Hijri calendar.
@immutable
class IslamicOccasion {
  const IslamicOccasion({
    required this.hMonth,
    required this.hDay,
    required this.titleAr,
    required this.titleEn,
  });

  final int hMonth;
  final int hDay;
  final String titleAr;
  final String titleEn;

  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;
}

/// On-device Umm al-Qura Hijri calendar service powered by `hijri_core`,
/// supporting a user adjustment of `-2` to `+2` days for local moon sighting.
abstract final class HijriCalendarService {
  static const List<String> arabicMonthNames = [
    'محرم',
    'صفر',
    'ربيع الأول',
    'ربيع الآخر',
    'جمادى الأولى',
    'جمادى الآخرة',
    'رجب',
    'شعبان',
    'رمضان',
    'شوال',
    'ذو القعدة',
    'ذو الحجة',
  ];

  static const List<String> englishMonthNames = [
    'Muharram',
    'Safar',
    'Rabi\' al-Awwal',
    'Rabi\' al-Thani',
    'Jumada al-Ula',
    'Jumada al-Akhirah',
    'Rajab',
    'Sha\'ban',
    'Ramadan',
    'Shawwal',
    'Dhu al-Qi\'dah',
    'Dhu al-Hijjah',
  ];

  static const List<IslamicOccasion> islamicOccasions = [
    IslamicOccasion(
      hMonth: 1,
      hDay: 1,
      titleAr: 'رأس السنة الهجرية',
      titleEn: 'Islamic New Year (1 Muharram)',
    ),
    IslamicOccasion(
      hMonth: 1,
      hDay: 10,
      titleAr: 'يوم عاشوراء',
      titleEn: 'Day of Ashura (10 Muharram)',
    ),
    IslamicOccasion(
      hMonth: 3,
      hDay: 12,
      titleAr: 'ذكرى المولد النبوي الشريف',
      titleEn: 'Mawlid al-Nabi (12 Rabi\' al-Awwal)',
    ),
    IslamicOccasion(
      hMonth: 7,
      hDay: 27,
      titleAr: 'ذكرى الإسراء والمعراج',
      titleEn: 'Isra and Mi\'raj (27 Rajab)',
    ),
    IslamicOccasion(
      hMonth: 9,
      hDay: 1,
      titleAr: 'أول أيام شهر رمضان المبارك',
      titleEn: 'First Day of Ramadan (1 Ramadan)',
    ),
    IslamicOccasion(
      hMonth: 9,
      hDay: 21,
      titleAr: 'بداية العشر الأواخر من رمضان',
      titleEn: 'Last Ten Nights of Ramadan (21 Ramadan)',
    ),
    IslamicOccasion(
      hMonth: 10,
      hDay: 1,
      titleAr: 'عيد الفطر المبارك',
      titleEn: 'Eid al-Fitr (1 Shawwal)',
    ),
    IslamicOccasion(
      hMonth: 12,
      hDay: 9,
      titleAr: 'يوم عرفة',
      titleEn: 'Day of Arafah (9 Dhu al-Hijjah)',
    ),
    IslamicOccasion(
      hMonth: 12,
      hDay: 10,
      titleAr: 'عيد الأضحى المبارك',
      titleEn: 'Eid al-Adha (10 Dhu al-Hijjah)',
    ),
  ];

  /// Converts a Gregorian [date] to an Umm al-Qura [HijriDateInfo] applying
  /// [adjustmentDays] clamped to `-2..+2`.
  static HijriDateInfo fromGregorian(
    DateTime date, {
    int adjustmentDays = 0,
  }) {
    final clampedAdj = adjustmentDays.clamp(-2, 2);
    final adjustedGregorian = DateTime.utc(
      date.year,
      date.month,
      date.day,
    ).add(Duration(days: clampedAdj));

    final hijri =
        toHijri(adjustedGregorian) ?? const HijriDate(hy: 1448, hm: 6, hd: 16);
    final monthIndex = (hijri.hm - 1).clamp(0, 11);

    return HijriDateInfo(
      hYear: hijri.hy,
      hMonth: hijri.hm,
      hDay: hijri.hd,
      monthNameAr: arabicMonthNames[monthIndex],
      monthNameEn: englishMonthNames[monthIndex],
      adjustmentDays: clampedAdj,
    );
  }

  /// Formats a Gregorian date alongside its Umm al-Qura Hijri date for the Home header.
  static String formatGregorianDate(
    DateTime date, {
    required String languageCode,
  }) {
    const enMonths = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    const arMonths = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    final mIdx = (date.month - 1).clamp(0, 11);
    if (languageCode == 'ar') {
      return '${HijriDateInfo._toArabicDigits(date.day)} ${arMonths[mIdx]} ${HijriDateInfo._toArabicDigits(date.year)} م';
    }
    return '${date.day} ${enMonths[mIdx]} ${date.year}';
  }

  /// Returns any Islamic occasion matching [hijriDate], or `null` if none.
  static IslamicOccasion? occasionForDate(HijriDateInfo hijriDate) {
    for (final occ in islamicOccasions) {
      if (occ.hMonth == hijriDate.hMonth && occ.hDay == hijriDate.hDay) {
        return occ;
      }
    }
    return null;
  }
}
