import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_state.dart';

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  late MockBox mockBox;
  late ThemeCubit cubit;

  setUp(() {
    mockBox = MockBox();
    when(() => mockBox.get(any(), defaultValue: any(named: 'defaultValue')))
        .thenReturn(null);
    cubit = ThemeCubit(prefs: mockBox);
  });

  tearDown(() {
    cubit.close();
  });

  group('ThemeCubit', () {
    test('initial state is light theme', () {
      expect(cubit.state.brightness, Brightness.light);
    });

    test('setThemeBrightness to dark updates state', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await cubit.setThemeBrightness(Brightness.dark);

      expect(cubit.state.brightness, Brightness.dark);
      expect(cubit.state.isDark, isTrue);
    });

    test('setThemeBrightness to light after dark', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await cubit.setThemeBrightness(Brightness.dark);
      expect(cubit.state.isDark, isTrue);

      await cubit.setThemeBrightness(Brightness.light);
      expect(cubit.state.isDark, isFalse);
    });

    test('setThemeBrightness persists to Hive', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await cubit.setThemeBrightness(Brightness.dark);

      verify(() => mockBox.put(ThemeCubit.isDarkThemeKey, true)).called(1);
    });

    test('loads dark theme when Hive has dark_theme=true', () {
      when(() => mockBox.get(any(), defaultValue: any(named: 'defaultValue')))
          .thenReturn(true);

      final darkCubit = ThemeCubit(prefs: mockBox);

      expect(darkCubit.state.brightness, Brightness.dark);
      darkCubit.close();
    });
  });

  group('ThemeState', () {
    test('isDark returns true for dark brightness', () {
      const state = ThemeState(Brightness.dark);
      expect(state.isDark, isTrue);
    });

    test('isDark returns false for light brightness', () {
      const state = ThemeState(Brightness.light);
      expect(state.isDark, isFalse);
    });

    test('Equatable works', () {
      const state1 = ThemeState(Brightness.dark);
      const state2 = ThemeState(Brightness.dark);
      const state3 = ThemeState(Brightness.light);

      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
    });

    test('props contains brightness', () {
      const state = ThemeState(Brightness.dark);
      expect(state.props, contains(Brightness.dark));
    });
  });
}
