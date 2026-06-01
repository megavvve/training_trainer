import 'package:flutter/material.dart';

/// Material Design 3 color system — redesigned for Training Trainer.
/// Light: clean white bg with indigo-purple accent
/// Dark: deep navy bg with lighter accent
class AppColors {
  const AppColors({
    required this.fill1,     // Primary text
    required this.fill1Dis,  // Primary text disabled
    required this.fill2,     // Secondary text
    required this.fill2Dis,  // Secondary text disabled
    required this.fill3,     // Tertiary / muted text
    required this.fill3Dis,
    required this.bg0,       // App background (lightest)
    required this.bg1,       // Surface / card background
    required this.bg1Press,
    required this.bg2,       // Elevated surface
    required this.bg2Press,
    required this.bg3,       // Disabled / chip bg
    required this.bg3Press,
    required this.border1,   // Subtle border
    required this.border2,   // Default border
    required this.border3,   // Strong border
    required this.primary,   // Brand primary (indigo)
    required this.onPrimary,
    required this.primaryPress,
    required this.primaryDis,
    required this.primaryContainer,   // Tinted container
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.outline,
    required this.surfaceDim,
    required this.shadow,
  });

  final Color fill1;
  final Color fill1Dis;
  final Color fill2;
  final Color fill2Dis;
  final Color fill3;
  final Color fill3Dis;

  final Color bg0;
  final Color bg1;
  final Color bg1Press;
  final Color bg2;
  final Color bg2Press;
  final Color bg3;
  final Color bg3Press;

  final Color border1;
  final Color border2;
  final Color border3;

  final Color primary;
  final Color onPrimary;
  final Color primaryPress;
  final Color primaryDis;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  final Color secondary;
  final Color onSecondary;
  final Color tertiary;
  final Color onTertiary;

  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;

  final Color outline;
  final Color surfaceDim;
  final Color shadow;

  /// Light theme — clean white + indigo
  static const AppColors light = AppColors(
    fill1: Color(0xFF1A1C2E),
    fill1Dis: Color(0xFFC4C5D0),
    fill2: Color(0xFF6B6E82),
    fill2Dis: Color(0xFFC4C5D0),
    fill3: Color(0xFF9396A8),
    fill3Dis: Color(0xFFE0E0E8),

    bg0: Color(0xFFF5F6FA),
    bg1: Color(0xFFFFFFFF),
    bg1Press: Color(0xFFF0F1F5),
    bg2: Color(0xFFF8F9FE),
    bg2Press: Color(0xFFEEF0F6),
    bg3: Color(0xFFEDEEF3),
    bg3Press: Color(0xFFE2E3EB),

    border1: Color(0xFFEDEEF3),
    border2: Color(0xFFD9DAE3),
    border3: Color(0xFFC4C5D0),

    primary: Color(0xFF5B67CA),
    onPrimary: Color(0xFFFFFFFF),
    primaryPress: Color(0xFF4A55B0),
    primaryDis: Color(0x335B67CA),
    primaryContainer: Color(0xFFE1E0FF),
    onPrimaryContainer: Color(0xFF1A1C4E),

    secondary: Color(0xFF6C63FF),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFFBB86FC),
    onTertiary: Color(0xFFFFFFFF),

    error: Color(0xFFE53E3E),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFE0E0),
    onErrorContainer: Color(0xFF5C1010),

    outline: Color(0xFFD9DAE3),
    surfaceDim: Color(0xFFE8E9F0),
    shadow: Color(0x1A000000),
  );

  /// Dark theme — deep navy + light indigo
  static const AppColors dark = AppColors(
    fill1: Color(0xFFE8E9F0),
    fill1Dis: Color(0xFF6B6E82),
    fill2: Color(0xFFA8AAB8),
    fill2Dis: Color(0xFF6B6E82),
    fill3: Color(0xFF9396A8),
    fill3Dis: Color(0xFF555770),

    bg0: Color(0xFF0D0F1C),
    bg1: Color(0xFF141627),
    bg1Press: Color(0xFF1E2038),
    bg2: Color(0xFF1A1D31),
    bg2Press: Color(0xFF242740),
    bg3: Color(0xFF242740),
    bg3Press: Color(0xFF2E3150),

    border1: Color(0xFF1E2038),
    border2: Color(0xFF2E3150),
    border3: Color(0xFF3F4270),

    primary: Color(0xFFB0B5FF),
    onPrimary: Color(0xFF1A1C4E),
    primaryPress: Color(0xFF9599E0),
    primaryDis: Color(0x33B0B5FF),
    primaryContainer: Color(0xFF3A3F7A),
    onPrimaryContainer: Color(0xFFE1E0FF),

    secondary: Color(0xFF9D95FF),
    onSecondary: Color(0xFF1A1C4E),
    tertiary: Color(0xFFD4A4FF),
    onTertiary: Color(0xFF1A1C4E),

    error: Color(0xFFFF6B6B),
    onError: Color(0xFF5C1010),
    errorContainer: Color(0xFF5C2020),
    onErrorContainer: Color(0xFFFFE0E0),

    outline: Color(0xFF2E3150),
    surfaceDim: Color(0xFF0D0F1C),
    shadow: Color(0x33000000),
  );
}

/// Global notifier for current color palette.
final ValueNotifier<AppColors> currentColors = ValueNotifier(AppColors.light);

/// Convenience extension to access [currentColors] via [AppColorsExt].
class AppColorsExt {
  static AppColors get c => currentColors.value;

  static Color get fill1 => c.fill1;
  static Color get fill1Dis => c.fill1Dis;
  static Color get fill2 => c.fill2;
  static Color get fill2Dis => c.fill2Dis;
  static Color get fill3 => c.fill3;
  static Color get fill3Dis => c.fill3Dis;

  static Color get bg0 => c.bg0;
  static Color get bg1 => c.bg1;
  static Color get bg1Press => c.bg1Press;
  static Color get bg2 => c.bg2;
  static Color get bg2Press => c.bg2Press;
  static Color get bg3 => c.bg3;
  static Color get bg3Press => c.bg3Press;

  static Color get border1 => c.border1;
  static Color get border2 => c.border2;
  static Color get border3 => c.border3;

  static Color get primary => c.primary;
  static Color get onPrimary => c.onPrimary;
  static Color get primaryPress => c.primaryPress;
  static Color get primaryDis => c.primaryDis;
  static Color get primaryContainer => c.primaryContainer;
  static Color get onPrimaryContainer => c.onPrimaryContainer;

  static Color get secondary => c.secondary;
  static Color get onSecondary => c.onSecondary;
  static Color get tertiary => c.tertiary;
  static Color get onTertiary => c.onTertiary;

  static Color get error => c.error;
  static Color get onError => c.onError;
  static Color get errorContainer => c.errorContainer;
  static Color get onErrorContainer => c.onErrorContainer;

  static Color get outline => c.outline;
  static Color get surfaceDim => c.surfaceDim;
  static Color get shadow => c.shadow;
}
