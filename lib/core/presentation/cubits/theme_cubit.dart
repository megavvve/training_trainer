import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_trainer/core/domain/theme_repository.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ThemeRepositoryInterface themeRepository,
  })  : _themeRepository = themeRepository,
        super(const ThemeState(Brightness.light)) {
    _checkTheme();
  }

  final ThemeRepositoryInterface _themeRepository;

  Future<void> setThemeBrightness(Brightness brightness) async {
    emit(ThemeState(brightness));
    await _themeRepository.setDarkTheme(
      brightness == Brightness.dark,
    );
  }

  void _checkTheme() {
    final brightness =
        _themeRepository.isDarkTheme() ? Brightness.dark : Brightness.light;
    emit(ThemeState(brightness));
  }
}