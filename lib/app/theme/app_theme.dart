import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Material 3 Light and Dark theme definitions for Qandil.
///
/// - Light: Ivory (#FBF6EA) background, Night (#0F2A2E) text, Nile (#1F6F5C) accents,
///   Sand (#E6D8B8) card containers. Lantern (#F2A93B) is strictly for decorative shapes
///   and highlights, never for body text on Ivory.
/// - Dark: Night (#0F2A2E) background, Ivory (#FBF6EA) text, Lantern (#F2A93B) accents.
abstract final class AppTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.nile,
      onPrimary: AppColors.ivory,
      primaryContainer: AppColors.sand,
      onPrimaryContainer: AppColors.night,
      secondary: AppColors.nile,
      onSecondary: AppColors.ivory,
      secondaryContainer: AppColors.sand,
      onSecondaryContainer: AppColors.night,
      // Tertiary holds Lantern for non-text shapes/highlights with Night foreground
      tertiary: AppColors.lantern,
      onTertiary: AppColors.night,
      tertiaryContainer: AppColors.sand,
      onTertiaryContainer: AppColors.night,
      error: AppColors.errorLight,
      onError: AppColors.ivory,
      surface: AppColors.ivory,
      onSurface: AppColors.night,
      surfaceContainerHighest: AppColors.sand,
      onSurfaceVariant: AppColors.textMutedLight,
      outline: AppColors.textMutedLight,
      outlineVariant: AppColors.sand,
    );

    final textTheme = AppTypography.buildTextTheme(
      AppColors.night,
      AppColors.textMutedLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.ivory,
      fontFamily: AppTypography.uiFontFamily,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.night,
        titleTextStyle: textTheme.headlineMedium,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.sand.withValues(alpha: 0.55),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.sandBorder, width: 1),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.ivory,
        indicatorColor: AppColors.nile.withValues(alpha: 0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.nile);
          }
          return IconThemeData(color: AppColors.night.withValues(alpha: 0.7));
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelMedium?.copyWith(
              color: AppColors.nile,
              fontWeight: FontWeight.w700,
            );
          }
          return textTheme.labelMedium?.copyWith(
            color: AppColors.night.withValues(alpha: 0.75),
          );
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.nile,
          foregroundColor: AppColors.ivory,
          elevation: 0,
          minimumSize: const Size(48, 48),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.sandBorder,
        thickness: 1,
      ),
    );
  }

  static ThemeData get dark {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.lantern,
      onPrimary: AppColors.night,
      primaryContainer: AppColors.nightContainer,
      onPrimaryContainer: AppColors.ivory,
      secondary: AppColors.nileLight,
      onSecondary: AppColors.ivory,
      secondaryContainer: AppColors.nightElevated,
      onSecondaryContainer: AppColors.ivory,
      tertiary: AppColors.lantern,
      onTertiary: AppColors.night,
      tertiaryContainer: AppColors.nightContainer,
      onTertiaryContainer: AppColors.ivory,
      error: AppColors.errorDark,
      onError: AppColors.night,
      surface: AppColors.night,
      onSurface: AppColors.ivory,
      surfaceContainerHighest: AppColors.nightElevated,
      onSurfaceVariant: AppColors.ivoryMuted,
      outline: AppColors.nightContainer,
      outlineVariant: AppColors.nightElevated,
    );

    final textTheme = AppTypography.buildTextTheme(
      AppColors.ivory,
      AppColors.ivoryMuted,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.night,
      fontFamily: AppTypography.uiFontFamily,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.night,
        foregroundColor: AppColors.ivory,
        titleTextStyle: textTheme.headlineMedium,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.nightElevated,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.nightContainer, width: 1),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.nightElevated,
        indicatorColor: AppColors.lantern.withValues(alpha: 0.2),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.lantern);
          }
          return const IconThemeData(color: AppColors.ivoryMuted);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelMedium?.copyWith(
              color: AppColors.lantern,
              fontWeight: FontWeight.w700,
            );
          }
          return textTheme.labelMedium?.copyWith(
            color: AppColors.ivoryMuted,
          );
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lantern,
          foregroundColor: AppColors.night,
          elevation: 0,
          minimumSize: const Size(48, 48),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.nightContainer,
        thickness: 1,
      ),
    );
  }
}
