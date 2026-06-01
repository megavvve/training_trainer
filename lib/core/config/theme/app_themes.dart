import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

class AppThemes {
  /// Build a ThemeData from the current color palette.
  /// Uses [currentColors] ValueNotifier so it stays in sync with theme switches.
  static ThemeData fromBrightness(Brightness brightness) {
    final c = brightness == Brightness.dark ? AppColors.dark : AppColors.light;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.onPrimary,
      secondary: c.secondary,
      onSecondary: c.onSecondary,
      tertiary: c.tertiary,
      onTertiary: c.onTertiary,
      error: c.error,
      onError: c.onError,
      surface: c.bg1,
      onSurface: c.fill1,
      surfaceContainerHighest: c.bg2,
      outline: c.outline,
      outlineVariant: c.border1,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: c.primary,
      scaffoldBackgroundColor: c.bg0,
      dividerColor: c.border1,
      cardColor: c.bg1,
      colorScheme: colorScheme,

      appBarTheme: AppBarTheme(
        backgroundColor: c.bg1,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyles.h2.copyWith(color: c.fill1),
        iconTheme: IconThemeData(color: c.fill1),
      ),

      textTheme: TextTheme(
        displayLarge: TextStyles.h1.copyWith(color: c.fill1),
        displayMedium: TextStyles.h2.copyWith(color: c.fill1),
        displaySmall: TextStyles.h3.copyWith(color: c.fill1),
        headlineLarge: TextStyles.textSemi.copyWith(color: c.fill1),
        headlineMedium: TextStyles.text.copyWith(color: c.fill1),
        headlineSmall: TextStyles.textSmall.copyWith(color: c.fill1),
        titleLarge: TextStyles.textSemi.copyWith(color: c.fill1),
        titleMedium: TextStyles.textSReg.copyWith(color: c.fill2),
        bodyLarge: TextStyles.text.copyWith(color: c.fill1),
        bodyMedium: TextStyles.textSmall.copyWith(color: c.fill2),
        labelLarge: TextStyles.textSBold.copyWith(color: c.fill1),
        bodySmall: TextStyles.deskSemi.copyWith(color: c.fill2),
        labelSmall: TextStyles.deskMed.copyWith(color: c.fill2),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.bg1,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.border2, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.border2, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.border1, width: 1.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.onPrimary,
          disabledBackgroundColor: c.primaryDis,
          disabledForegroundColor: c.fill3,
          textStyle: TextStyles.textSemi,
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.onPrimary,
          disabledBackgroundColor: c.primaryDis,
          disabledForegroundColor: c.fill3,
          textStyle: TextStyles.textSemi,
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.primary,
          textStyle: TextStyles.textSemi,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.primary,
          side: BorderSide(color: c.primary),
          textStyle: TextStyles.textSemi,
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.primary,
        foregroundColor: c.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: c.bg1,
        selectedItemColor: c.primary,
        unselectedItemColor: c.fill2,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyles.deskSemi,
        unselectedLabelStyle: TextStyles.deskMed,
      ),

      cardTheme: CardThemeData(
        color: c.bg1,
        elevation: 0,
        shadowColor: c.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: c.border2, width: 1),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: c.bg2,
        labelStyle: TextStyles.deskSemi.copyWith(color: c.fill1),
        secondaryLabelStyle: TextStyles.deskSemi.copyWith(color: c.primary),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.primary,
        linearTrackColor: c.bg3,
        circularTrackColor: c.bg3,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: c.fill1,
        contentTextStyle: TextStyles.textSmall.copyWith(color: c.bg1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: c.bg1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  /// Convenience — build theme from current colors
  static ThemeData get lightTheme => fromBrightness(Brightness.light);
  static ThemeData get darkTheme => fromBrightness(Brightness.dark);
}
