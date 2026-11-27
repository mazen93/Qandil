import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Official Qandil brand color tokens from `QANDIL_BRAND.md` & `qandil_tokens.json`.
///
/// Rules from Brand Identity:
/// - Night (`#0F2A2E`): Dark theme background, text on light, icon background.
/// - Lantern (`#F2A93B`): Accent on dark, highlights, progress, the flame.
///   Never use Lantern amber for body text on Ivory (contrast 1.85:1).
/// - Lantern Deep (`#D98A12`): Flame on light backgrounds.
/// - Ivory (`#FBF6EA`): Light theme background, text on dark.
/// - Nile (`#1F6F5C`): Primary on light theme, buttons, links.
/// - Sand (`#E6D8B8`): Cards and separators on light theme.
/// - Surface Dark (`#163A3F`): Cards on dark theme.
/// - Outline Dark (`#2D5358`): Dividers on dark theme.
/// - Muted text (light) (`#4A5B5E`): Secondary text on Ivory (6.6:1 contrast).
/// - Muted text (dark) (`#B9C9C6`): Secondary text on Night (8.79:1 contrast).
abstract final class AppColors {
  static const Color night = Color(0xFF0F2A2E);
  static const Color surfaceDark = Color(0xFF163A3F);
  static const Color outlineDark = Color(0xFF2D5358);

  // Legacy aliases preserved for backward compatibility across existing features
  static const Color nightElevated = surfaceDark;
  static const Color nightContainer = outlineDark;

  static const Color lantern = Color(0xFFF2A93B);
  static const Color lanternDeep = Color(0xFFD98A12);
  static const Color lanternOnLight = lanternDeep;

  static const Color ivory = Color(0xFFFBF6EA);
  static const Color textMutedLight = Color(0xFF4A5B5E);
  static const Color textMutedDark = Color(0xFFB9C9C6);
  static const Color ivoryMuted = textMutedDark;

  static const Color nile = Color(0xFF1F6F5C);
  static const Color nileLight = Color(0xFF2B8C75);

  static const Color sand = Color(0xFFE6D8B8);
  static const Color sandBorder = Color(0xFFD4C39D);

  static const Color errorLight = Color(0xFFB3261E);
  static const Color errorDark = Color(0xFFF2B8B5);

  /// Computes the WCAG 2.1 relative luminance (`0.0..1.0`) of [color].
  static double relativeLuminance(Color color) {
    double channelLuminance(double c) {
      return c <= 0.03928
          ? c / 12.92
          : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
    }

    final r = channelLuminance(color.r);
    final g = channelLuminance(color.g);
    final b = channelLuminance(color.b);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// Computes the WCAG 2.1 contrast ratio (`1.0..21.0`) between [foreground] and [background].
  static double wcagContrastRatio(Color foreground, Color background) {
    final l1 = relativeLuminance(foreground);
    final l2 = relativeLuminance(background);
    final lighter = math.max(l1, l2);
    final darker = math.min(l1, l2);
    return (lighter + 0.05) / (darker + 0.05);
  }
}
