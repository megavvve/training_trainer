import 'package:flutter/material.dart';
import 'package:training_trainer/core/config/theme/app_colors.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.lightBackground,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightText),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: AppColors.darkPrimary,
        secondary: AppColors.darkSecondary,
        background: AppColors.darkBackground,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkText),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkPrimary,
      ),
    );
  }
}