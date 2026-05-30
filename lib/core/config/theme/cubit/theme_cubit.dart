import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';

import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.prefs})
    : super(const ThemeState(Brightness.light)) {
    _checkTheme();
  }
  final Box<dynamic> prefs;

  static const isDarkThemeKey = 'dark_theme';

  Future<void> setThemeBrightness(Brightness brightness) async {
    emit(ThemeState(brightness));
    _syncCurrentColors(brightness);
    await prefs.put(isDarkThemeKey, brightness == Brightness.dark);
  }

  void _checkTheme() {
    final isDark = prefs.get(isDarkThemeKey) ?? false;
    final brightness = isDark ? Brightness.dark : Brightness.light;
    _syncCurrentColors(brightness);
    emit(ThemeState(brightness));
  }

  void _syncCurrentColors(Brightness brightness) {
    currentColors.value =
        brightness == Brightness.dark ? AppColors.dark : AppColors.light;
  }
}
