import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// Supported colorways for the official Qandil SVG lantern mark (`QANDIL_BRAND.md` Section 2).
enum QandilLogoColorway {
  /// Automatically selects [onDark] when `Theme.of(context).brightness == Brightness.dark`
  /// and [onLight] when `Brightness.light`.
  auto,

  /// Dark UI colorway (`assets/brand/logo/qandil_mark_on_dark.svg`):
  /// Ivory `#FBF6EA` lantern body + Lantern `#F2A93B` eight-point Rub el Hizb flame.
  onDark,

  /// Light UI colorway (`assets/brand/logo/qandil_mark_on_light.svg`):
  /// Night `#0F2A2E` lantern body + Lantern Deep `#D98A12` eight-point Rub el Hizb flame.
  onLight,

  /// Monochrome white (`assets/brand/logo/qandil_mark_mono_white.svg`).
  monoWhite,

  /// Monochrome black (`assets/brand/logo/qandil_mark_mono_black.svg`).
  monoBlack,
}

/// Official Qandil SVG Logo widget (`viewBox='0 0 120 160'`) with two primary colorways:
/// - Dark UI (`onDark`): Ivory `#FBF6EA` body + Lantern `#F2A93B` star
/// - Light UI (`onLight`): Night `#0F2A2E` body + Lantern Deep `#D98A12` star
///
/// Brand Identity Rules (`QANDIL_BRAND.md` Section 2):
/// - Minimum mark height in UI: `24 px`.
/// - Clear space around the mark: at least `1/4` of the mark's width on every side when `includeClearSpace` is true.
class QandilLogo extends StatelessWidget {
  const QandilLogo({
    super.key,
    this.height = 36,
    this.colorway = QandilLogoColorway.auto,
    this.includeClearSpace = false,
    this.showWordmark = false,
    this.showTagline = false,
    this.semanticLabel,
  });

  /// Canonical SVG markup for Dark UI (`Ivory #FBF6EA` body + `Lantern #F2A93B` star).
  static const String darkColorwaySvgMarkup = "<svg viewBox='0 0 120 160'>"
      "<circle cx='60' cy='18' r='6' fill='none' stroke='#FBF6EA' stroke-width='4'/>"
      "<path d='M24 46Q60 8 96 46Z' fill='#FBF6EA'/>"
      "<path d='M28 52H92V100Q92 128 60 146Q28 128 28 100Z' fill='none' stroke='#FBF6EA' stroke-width='5' stroke-linejoin='round'/>"
      "<g transform='translate(0 4)'>"
      "<polygon fill='#F2A93B' points='60,66 66.4,72.4 75.6,72.4 75.6,81.6 82,88 75.6,94.4 75.6,103.6 66.4,103.6 60,110 53.6,103.6 44.4,103.6 44.4,94.4 38,88 44.4,81.6 44.4,72.4 53.6,72.4'/>"
      '</g>'
      "<circle cx='60' cy='153' r='3.5' fill='#FBF6EA'/>"
      '</svg>';

  /// Canonical SVG markup for Light UI (`Night #0F2A2E` body + `Lantern Deep #D98A12` star).
  static const String lightColorwaySvgMarkup = "<svg viewBox='0 0 120 160'>"
      "<circle cx='60' cy='18' r='6' fill='none' stroke='#0F2A2E' stroke-width='4'/>"
      "<path d='M24 46Q60 8 96 46Z' fill='#0F2A2E'/>"
      "<path d='M28 52H92V100Q92 128 60 146Q28 128 28 100Z' fill='none' stroke='#0F2A2E' stroke-width='5' stroke-linejoin='round'/>"
      "<g transform='translate(0 4)'>"
      "<polygon fill='#D98A12' points='60,66 66.4,72.4 75.6,72.4 75.6,81.6 82,88 75.6,94.4 75.6,103.6 66.4,103.6 60,110 53.6,103.6 44.4,103.6 44.4,94.4 38,88 44.4,81.6 44.4,72.4 53.6,72.4'/>"
      '</g>'
      "<circle cx='60' cy='153' r='3.5' fill='#0F2A2E'/>"
      '</svg>';

  static const String onDarkAssetPath =
      'assets/brand/logo/qandil_mark_on_dark.svg';
  static const String onLightAssetPath =
      'assets/brand/logo/qandil_mark_on_light.svg';
  static const String monoWhiteAssetPath =
      'assets/brand/logo/qandil_mark_mono_white.svg';
  static const String monoBlackAssetPath =
      'assets/brand/logo/qandil_mark_mono_black.svg';

  final double height;
  final QandilLogoColorway colorway;
  final bool includeClearSpace;
  final bool showWordmark;
  final bool showTagline;
  final String? semanticLabel;

  /// Resolves the effective colorway based on [colorway] and the ambient theme [brightness].
  QandilLogoColorway resolveColorway(Brightness brightness) {
    if (colorway != QandilLogoColorway.auto) {
      return colorway;
    }
    return brightness == Brightness.dark
        ? QandilLogoColorway.onDark
        : QandilLogoColorway.onLight;
  }

  /// Returns the bundled SVG asset path for [resolved].
  static String assetPathFor(QandilLogoColorway resolved) {
    return switch (resolved) {
      QandilLogoColorway.onDark || QandilLogoColorway.auto => onDarkAssetPath,
      QandilLogoColorway.onLight => onLightAssetPath,
      QandilLogoColorway.monoWhite => monoWhiteAssetPath,
      QandilLogoColorway.monoBlack => monoBlackAssetPath,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolved = resolveColorway(theme.brightness);
    // Enforce minimum 24px height rule from QANDIL_BRAND.md Section 2
    final effectiveHeight = height < 24.0 ? 24.0 : height;
    final effectiveWidth = effectiveHeight * (120.0 / 160.0);
    final clearSpace = includeClearSpace ? (effectiveWidth * 0.25) : 0.0;

    final isDarkColorway = resolved == QandilLogoColorway.onDark ||
        resolved == QandilLogoColorway.monoWhite;
    final textColor = isDarkColorway ? AppColors.ivory : AppColors.night;
    final mutedColor =
        isDarkColorway ? AppColors.textMutedDark : AppColors.textMutedLight;

    final markWidget = Padding(
      padding: EdgeInsets.all(clearSpace),
      child: SvgPicture.asset(
        assetPathFor(resolved),
        width: effectiveWidth,
        height: effectiveHeight,
        semanticsLabel: semanticLabel ?? 'Qandil — قنديل',
      ),
    );

    if (!showWordmark && !showTagline) {
      return markWidget;
    }

    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final wordmarkText = isAr ? 'قنديل' : 'Qandil';
    final taglineText = isAr ? 'نورٌ يرافق يومك.' : 'Light for your day.';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        markWidget,
        if (showWordmark) ...[
          const SizedBox(height: 10),
          Text(
            wordmarkText,
            style: TextStyle(
              fontFamily: 'ReemKufi',
              fontWeight: FontWeight.w700,
              fontSize: 28,
              color: textColor,
              height: 1.3,
            ),
          ),
        ],
        if (showTagline) ...[
          const SizedBox(height: 4),
          Text(
            taglineText,
            style: TextStyle(
              fontFamily: AppTypography.uiFontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: mutedColor,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

/// Decorative eight-point star (Rub el Hizb ornament) from the Qandil lantern flame.
///
/// Brand Identity Rule (`QANDIL_BRAND.md` Section 5):
/// "The eight-point star is the only ornament. Use it sparingly: section dividers,
/// the 'verse end' marker in lists, empty states. Never as a pattern wallpaper behind Quran text."
class QandilRubElHizbOrnament extends StatelessWidget {
  const QandilRubElHizbOrnament({
    super.key,
    this.size = 24,
    this.color,
  });

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final starColor =
        color ?? (isDark ? AppColors.lantern : AppColors.lanternDeep);

    return ExcludeSemantics(
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _RubElHizbStarPainter(color: starColor),
        ),
      ),
    );
  }
}

class _RubElHizbStarPainter extends CustomPainter {
  const _RubElHizbStarPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // Original star coordinates span x: 38..82 (44 units), y: 66..110 (44 units), centered at (60, 88).
    final scale = size.width / 44.0;
    canvas.save();
    canvas.scale(scale, scale);
    canvas.translate(-38.0, -66.0);

    const points = <Offset>[
      Offset(60, 66),
      Offset(66.4, 72.4),
      Offset(75.6, 72.4),
      Offset(75.6, 81.6),
      Offset(82, 88),
      Offset(75.6, 94.4),
      Offset(75.6, 103.6),
      Offset(66.4, 103.6),
      Offset(60, 110),
      Offset(53.6, 103.6),
      Offset(44.4, 103.6),
      Offset(44.4, 94.4),
      Offset(38, 88),
      Offset(44.4, 81.6),
      Offset(44.4, 72.4),
      Offset(53.6, 72.4),
    ];

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(Path()..addPolygon(points, true), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _RubElHizbStarPainter oldDelegate) =>
      oldDelegate.color != color;
}
