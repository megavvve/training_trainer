import 'package:flutter/material.dart';

/// Semantic color system for the entire app.
/// Supports light and dark themes via [AppColors.light] and [AppColors.dark].
class AppColors {
  const AppColors({
    required this.fill1,
    required this.fill1Dis,
    required this.fill2,
    required this.fill2Dis,
    required this.fill3,
    required this.fill3Dis,
    required this.bg1,
    required this.bg1Press,
    required this.bg2,
    required this.bg2Press,
    required this.bg3,
    required this.bg3Press,
    required this.bg3Dis,
    required this.bg4,
    required this.bg4Press,
    required this.bg4Dis,
    required this.border1,
    required this.border2,
    required this.border3,
    required this.primary,
    required this.primaryPress,
    required this.primaryDis,
    required this.negative,
    required this.negativePress,
    required this.negativeDis,
    required this.warning,
    required this.warningPress,
    required this.warningDis,
    required this.positive,
    required this.positivePress,
    required this.positiveDis,
    required this.fade,
    this.white = const Color(0xFFFFFFFF),
    this.black = const Color(0xFF000000),
    this.whiteDis = const Color(0x80FFFFFF),
  });

  final Color white;
  final Color black;

  final Color fill1;
  final Color fill1Dis;
  final Color fill2;
  final Color fill2Dis;
  final Color fill3;
  final Color fill3Dis;

  final Color bg1;
  final Color bg1Press;
  final Color bg2;
  final Color bg2Press;
  final Color bg3;
  final Color bg3Press;
  final Color bg3Dis;
  final Color bg4;
  final Color bg4Press;
  final Color bg4Dis;

  final Color border1;
  final Color border2;
  final Color border3;

  final Color primary;
  final Color primaryPress;
  final Color primaryDis;

  final Color negative;
  final Color negativePress;
  final Color negativeDis;

  final Color warning;
  final Color warningPress;
  final Color warningDis;

  final Color positive;
  final Color positivePress;
  final Color positiveDis;

  final Color fade;
  final Color whiteDis;

  /// Light theme — original blue academic style.
  static const AppColors light = AppColors(
    fill1: Color(0xFF171717),
    fill1Dis: Color(0xFFA3A3A3),
    fill2: Color(0xFF737373),
    fill2Dis: Color(0xFFA3A3A3),
    fill3: Color(0xFFA3A3A3),
    fill3Dis: Color(0xFFA3A3A3),

    bg1: Color(0xFFFFFFFF),
    bg1Press: Color(0xFFE5E5E5),
    bg2: Color(0xFFF5F5F5),
    bg2Press: Color(0xFFE5E5E5),
    bg3: Color(0xFFE5E5E5),
    bg3Press: Color(0xFFD4D4D4),
    bg3Dis: Color(0xFFF5F5F5),
    bg4: Color(0xFFD4D4D4),
    bg4Press: Color(0xFFA3A3A3),
    bg4Dis: Color(0xFFE5E5E5),

    border1: Color(0xFFF5F5F5),
    border2: Color(0xFFE5E5E5),
    border3: Color(0xFFD4D4D4),

    primary: Color(0xFF5B94F1),
    primaryPress: Color(0xFF4A7FCC),
    primaryDis: Color(0x665B94F1),

    negative: Color(0xFFEF4444),
    negativePress: Color(0xFFDC2626),
    negativeDis: Color(0x66EF4444),

    warning: Color(0xFFF59E0B),
    warningPress: Color(0xFFD97706),
    warningDis: Color(0x66F59E0B),

    positive: Color(0xFF10B981),
    positivePress: Color(0xFF059669),
    positiveDis: Color(0x6610B981),

    fade: Color(0x800D0A0A),
  );

  static const AppColors dark = AppColors(
    fill1: Color(0xFFF5F5F5),
    fill1Dis: Color(0xFF525252),
    fill2: Color(0xFFA3A3A3),
    fill2Dis: Color(0xFF737373),
    fill3: Color(0xFFA3A3A3),
    fill3Dis: Color(0xFF737373),

    bg1: Color(0xFF1E293B),
    bg1Press: Color(0xFF334155),
    bg2: Color(0xFF0F172A),
    bg2Press: Color(0xFF1E293B),
    bg3: Color(0xFF334155),
    bg3Press: Color(0xFF475569),
    bg3Dis: Color(0xFF1E293B),
    bg4: Color(0xFF475569),
    bg4Press: Color(0xFF64748B),
    bg4Dis: Color(0xFF334155),

    border1: Color(0xFF334155),
    border2: Color(0xFF475569),
    border3: Color(0xFF64748B),

    primary: Color(0xFF93C5FD),
    primaryPress: Color(0xFF60A5FA),
    primaryDis: Color(0x6693C5FD),

    negative: Color(0xFFEF4444),
    negativePress: Color(0xFFDC2626),
    negativeDis: Color(0x66EF4444),

    warning: Color(0xFFF59E0B),
    warningPress: Color(0xFFD97706),
    warningDis: Color(0x66F59E0B),

    positive: Color(0xFF10B981),
    positivePress: Color(0xFF059669),
    positiveDis: Color(0x6610B981),

    fade: Color(0x80000000),
  );
}

/// Global notifier for current color palette.
final ValueNotifier<AppColors> currentColors = ValueNotifier(AppColors.light);

/// Convenience extension to access [currentColors] via [AppColorsExt].
class AppColorsExt {
  static AppColors get c => currentColors.value;

  static Color get white => c.white;
  static Color get black => c.black;

  static Color get fill1 => c.fill1;
  static Color get fill1Dis => c.fill1Dis;
  static Color get fill2 => c.fill2;
  static Color get fill2Dis => c.fill2Dis;
  static Color get fill3 => c.fill3;
  static Color get fill3Dis => c.fill3Dis;

  static Color get bg1 => c.bg1;
  static Color get bg1Press => c.bg1Press;
  static Color get bg2 => c.bg2;
  static Color get bg2Press => c.bg2Press;
  static Color get bg3 => c.bg3;
  static Color get bg3Press => c.bg3Press;
  static Color get bg3Dis => c.bg3Dis;
  static Color get bg4 => c.bg4;
  static Color get bg4Press => c.bg4Press;
  static Color get bg4Dis => c.bg4Dis;

  static Color get border1 => c.border1;
  static Color get border2 => c.border2;
  static Color get border3 => c.border3;

  static Color get primary => c.primary;
  static Color get primaryPress => c.primaryPress;
  static Color get primaryDis => c.primaryDis;

  static Color get negative => c.negative;
  static Color get negativePress => c.negativePress;
  static Color get negativeDis => c.negativeDis;

  static Color get warning => c.warning;
  static Color get warningPress => c.warningPress;
  static Color get warningDis => c.warningDis;

  static Color get positive => c.positive;
  static Color get positivePress => c.positivePress;
  static Color get positiveDis => c.positiveDis;

  static Color get fade => c.fade;
  static Color get whiteDis => c.whiteDis;
}
