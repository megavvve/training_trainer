import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

class AppThemes {
  static ThemeData _base(AppColors c, Brightness brightness) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.white,
      secondary: c.primaryPress,
      onSecondary: c.white,
      error: c.negative,
      onError: c.white,
      surface: c.bg1,
      onSurface: c.fill1,
      outline: c.border2,
      outlineVariant: c.border1,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: c.primary,
      scaffoldBackgroundColor: c.bg2,
      dividerColor: c.border1,
      cardColor: c.bg1,
      colorScheme: colorScheme,

      // ── AppBar ──
      appBarTheme: AppBarTheme(
        backgroundColor: c.bg2,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyles.h2.copyWith(color: c.fill1),
        iconTheme: IconThemeData(color: c.fill1),
      ),

      // ── Text Theme ──
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

      // ── Input Decoration ──
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.bg1,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: c.border2, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: c.border2, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: c.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: c.negative, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: c.negative, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: c.border1, width: 1.5),
        ),
      ),

      // ── Elevated Button ──
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.white,
          disabledBackgroundColor: c.primaryDis,
          disabledForegroundColor: c.whiteDis,
          textStyle: TextStyles.textSemi,
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),

      // ── Filled Button ──
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.white,
          disabledBackgroundColor: c.primaryDis,
          textStyle: TextStyles.textSemi,
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      // ── Text Button ──
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.primary,
          textStyle: TextStyles.textSemi,
        ),
      ),

      // ── Floating Action Button ──
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.primary,
        foregroundColor: c.white,
        elevation: 2,
      ),

      // ── Bottom Navigation Bar ──
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: c.bg1,
        selectedItemColor: c.primary,
        unselectedItemColor: c.fill2,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // ── Card Theme ──
      cardTheme: CardThemeData(
        color: c.bg1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: c.border2, width: 1),
        ),
      ),

      // ── Chip Theme ──
      chipTheme: ChipThemeData(
        backgroundColor: c.bg2,
        labelStyle: TextStyles.deskSemi.copyWith(color: c.fill1),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),

      // ── Custom Button Theme extension ──
      extensions: <ThemeExtension<dynamic>>[
        CustomButtonTheme(
          primaryBackground: c.primary,
          primaryText: c.white,
          primaryDisabledBackground: c.primaryDis,
          errorBackground: c.negative,
          errorText: c.white,
          errorDisabledBackground: c.negativeDis,
        ),
      ],
    );
  }

  static final ThemeData lightTheme = _base(AppColors.light, Brightness.light);
  static final ThemeData darkTheme = _base(AppColors.dark, Brightness.dark);
}

@immutable
class CustomButtonTheme extends ThemeExtension<CustomButtonTheme> {
  const CustomButtonTheme({
    required this.primaryBackground,
    required this.primaryText,
    required this.primaryDisabledBackground,
    required this.errorBackground,
    required this.errorText,
    required this.errorDisabledBackground,
  });
  final Color primaryBackground;
  final Color primaryText;
  final Color primaryDisabledBackground;
  final Color errorBackground;
  final Color errorText;
  final Color errorDisabledBackground;

  @override
  CustomButtonTheme copyWith({
    Color? primaryBackground,
    Color? primaryText,
    Color? primaryDisabledBackground,
    Color? errorBackground,
    Color? errorText,
    Color? errorDisabledBackground,
  }) {
    return CustomButtonTheme(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      primaryText: primaryText ?? this.primaryText,
      primaryDisabledBackground:
          primaryDisabledBackground ?? this.primaryDisabledBackground,
      errorBackground: errorBackground ?? this.errorBackground,
      errorText: errorText ?? this.errorText,
      errorDisabledBackground:
          errorDisabledBackground ?? this.errorDisabledBackground,
    );
  }

  @override
  CustomButtonTheme lerp(ThemeExtension<CustomButtonTheme>? other, double t) {
    if (other is! CustomButtonTheme) return this;
    return CustomButtonTheme(
      primaryBackground: Color.lerp(
        primaryBackground,
        other.primaryBackground,
        t,
      )!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      primaryDisabledBackground: Color.lerp(
        primaryDisabledBackground,
        other.primaryDisabledBackground,
        t,
      )!,
      errorBackground: Color.lerp(errorBackground, other.errorBackground, t)!,
      errorText: Color.lerp(errorText, other.errorText, t)!,
      errorDisabledBackground: Color.lerp(
        errorDisabledBackground,
        other.errorDisabledBackground,
        t,
      )!,
    );
  }
}
