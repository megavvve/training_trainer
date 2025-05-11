import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final Box<dynamic> prefs;
  ThemeCubit({required this.prefs})
    : super(const ThemeState(Brightness.light)) {
    _checkTheme();
  }

  static const isDarkThemeKey = "dark_theme";

  Future<void> setThemeBrightness(Brightness brightness) async {
    emit(ThemeState(brightness));
    await prefs.put(isDarkThemeKey, brightness == Brightness.dark);
  }

  void _checkTheme() {
    final isDark = prefs.get(isDarkThemeKey) ?? false;
    final brightness = isDark ? Brightness.dark : Brightness.light;
    emit(ThemeState(brightness));
  }
}
