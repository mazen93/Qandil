import 'package:flutter/material.dart';

/// Qandil typography rules:
/// - ReemKufi: headings and brand display text.
/// - IBMPlexSansArabic: UI text (titles, body, labels, buttons).
/// - Note: Quranic text in Phase 3 will use the Mushaf font from the content source, never these UI fonts.
abstract final class AppTypography {
  static const String displayFontFamily = 'ReemKufi';
  static const String uiFontFamily = 'IBMPlexSansArabic';
  static const String mushafFontFamily = 'UthmanicHafs';

  /// Authentic Madani Mushaf text style using KFGQPC Uthmanic Script Hafs (`UthmanicHafs`).
  /// Never substitutes UI fonts for Quranic text.
  static TextStyle mushafVerseStyle({
    required Color color,
    double fontSize = 26.0,
    double height = 1.9,
  }) {
    return TextStyle(
      fontFamily: mushafFontFamily,
      fontSize: fontSize,
      height: height,
      color: color,
      fontWeight: FontWeight.w400,
    );
  }

  static TextTheme buildTextTheme(
    Color primaryTextColor,
    Color mutedTextColor,
  ) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 44,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        height: 1.25,
      ),
      displayMedium: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        height: 1.25,
      ),
      displaySmall: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        height: 1.3,
      ),
      headlineLarge: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        height: 1.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 1.35,
      ),
      headlineSmall: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 1.35,
      ),
      titleLarge: TextStyle(
        fontFamily: uiFontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 1.4,
      ),
      titleMedium: TextStyle(
        fontFamily: uiFontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontFamily: uiFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 1.4,
      ),
      bodyLarge: TextStyle(
        fontFamily: uiFontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: uiFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: uiFontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: mutedTextColor,
        height: 1.45,
      ),
      labelLarge: TextStyle(
        fontFamily: uiFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 1.35,
      ),
      labelMedium: TextStyle(
        fontFamily: uiFontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        height: 1.35,
      ),
      labelSmall: TextStyle(
        fontFamily: uiFontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: mutedTextColor,
        height: 1.35,
      ),
    );
  }
}
