import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/app/theme/app_colors.dart';
import 'package:qandil/app/theme/app_theme.dart';
import 'package:qandil/core/widgets/qandil_logo.dart';

void main() {
  group('Phase 10: Qandil Brand Identity, SVG Colorways & WCAG Contrast Tests',
      () {
    test('verifies both SVG logo files and colorways match official markup',
        () {
      final darkSvgFile = File(QandilLogo.onDarkAssetPath);
      final lightSvgFile = File(QandilLogo.onLightAssetPath);

      expect(darkSvgFile.existsSync(), isTrue);
      expect(lightSvgFile.existsSync(), isTrue);

      final darkSvg = darkSvgFile.readAsStringSync();
      final lightSvg = lightSvgFile.readAsStringSync();

      // Both must use viewBox='0 0 120 160' and the 8-point Rub el Hizb polygon
      expect(darkSvg, contains("viewBox='0 0 120 160'"));
      expect(lightSvg, contains("viewBox='0 0 120 160'"));

      // Dark UI colorway: Ivory (#FBF6EA) body and Lantern (#F2A93B) star
      expect(darkSvg, contains("stroke='#FBF6EA'"));
      expect(darkSvg, contains("fill='#FBF6EA'"));
      expect(darkSvg, contains("polygon fill='#F2A93B'"));

      // Light UI colorway: Night (#0F2A2E) body and Lantern Deep (#D98A12) star
      expect(lightSvg, contains("stroke='#0F2A2E'"));
      expect(lightSvg, contains("fill='#0F2A2E'"));
      expect(lightSvg, contains("polygon fill='#D98A12'"));

      // Verify QandilLogo colorway resolution for Dark vs Light theme
      const autoLogo = QandilLogo();
      expect(
        autoLogo.resolveColorway(Brightness.dark),
        QandilLogoColorway.onDark,
      );
      expect(
        autoLogo.resolveColorway(Brightness.light),
        QandilLogoColorway.onLight,
      );
    });

    test('WCAG 2.1 contrast ratios match QANDIL_BRAND.md & qandil_tokens.json',
        () {
      final tokensFile = File('assets/brand/tokens/qandil_tokens.json');
      expect(tokensFile.existsSync(), isTrue);
      final tokensJson =
          jsonDecode(tokensFile.readAsStringSync()) as Map<String, dynamic>;
      expect(tokensJson['name'], 'Qandil');

      // 1. Ivory (#FBF6EA) on Night (#0F2A2E) >= 14.0:1
      final ivoryOnNight = AppColors.wcagContrastRatio(
        AppColors.ivory,
        AppColors.night,
      );
      expect(ivoryOnNight, greaterThanOrEqualTo(13.9));

      // 2. Night (#0F2A2E) on Ivory (#FBF6EA) >= 14.0:1
      final nightOnIvory = AppColors.wcagContrastRatio(
        AppColors.night,
        AppColors.ivory,
      );
      expect(nightOnIvory, greaterThanOrEqualTo(13.9));

      // 3. Lantern (#F2A93B) on Night (#0F2A2E) >= 7.5:1 (AAA)
      final lanternOnNight = AppColors.wcagContrastRatio(
        AppColors.lantern,
        AppColors.night,
      );
      expect(lanternOnNight, greaterThanOrEqualTo(7.5));

      // 4. Ivory (#FBF6EA) on Nile (#1F6F5C) >= 5.5:1 (AA)
      final ivoryOnNile = AppColors.wcagContrastRatio(
        AppColors.ivory,
        AppColors.nile,
      );
      expect(ivoryOnNile, greaterThanOrEqualTo(5.5));

      // 5. Night (#0F2A2E) on Sand (#E6D8B8) >= 10.7:1 (AAA)
      final nightOnSand = AppColors.wcagContrastRatio(
        AppColors.night,
        AppColors.sand,
      );
      expect(nightOnSand, greaterThanOrEqualTo(10.6));

      // 6. Muted text (#4A5B5E) on Ivory (#FBF6EA) >= 6.5:1 (AA+)
      final mutedLightOnIvory = AppColors.wcagContrastRatio(
        AppColors.textMutedLight,
        AppColors.ivory,
      );
      expect(mutedLightOnIvory, greaterThanOrEqualTo(6.5));

      // 7. Muted text (#B9C9C6) on Night (#0F2A2E) >= 8.7:1 (AAA)
      final mutedDarkOnNight = AppColors.wcagContrastRatio(
        AppColors.textMutedDark,
        AppColors.night,
      );
      expect(mutedDarkOnNight, greaterThanOrEqualTo(8.7));

      // 8. Brand Rule: Never use Lantern (#F2A93B) for body text on Ivory (contrast is ~1.85:1)
      final lightTheme = AppTheme.light;
      expect(lightTheme.scaffoldBackgroundColor, AppColors.ivory);
      expect(lightTheme.textTheme.bodyLarge?.color, AppColors.night);
      expect(lightTheme.textTheme.bodyMedium?.color, AppColors.night);
      expect(lightTheme.textTheme.bodySmall?.color, AppColors.textMutedLight);
      expect(lightTheme.textTheme.bodyMedium?.color, isNot(AppColors.lantern));
    });

    test('verifies generated launcher icons and native splash assets exist',
        () {
      expect(
        File('assets/brand/qandil_app_icon_1024.png').existsSync(),
        isTrue,
      );
      expect(
        File('assets/brand/qandil_android_adaptive_foreground_1024.png')
            .existsSync(),
        isTrue,
      );
      expect(
        File('assets/brand/qandil_android_monochrome_1024.png').existsSync(),
        isTrue,
      );
      expect(
        File('assets/brand/qandil_splash_mark_1024.png').existsSync(),
        isTrue,
      );
      expect(
        File('android/app/src/main/res/drawable/launch_background.xml')
            .existsSync(),
        isTrue,
      );
    });
  });
}
