import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

import 'package:training_trainer/core/config/localization/cubit/locale_cubit.dart';

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  late MockBox mockBox;
  late LocaleCubit cubit;

  setUp(() {
    mockBox = MockBox();
    when(() => mockBox.get(any(), defaultValue: any(named: 'defaultValue')))
        .thenReturn(null);
    cubit = LocaleCubit(prefs: mockBox);
  });

  tearDown(() {
    cubit.close();
  });

  group('LocaleCubit', () {
    test('initial state is Russian locale', () {
      expect(cubit.state, const Locale('ru'));
    });

    test('setLocale updates to English', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await cubit.setLocale(const Locale('en'));

      expect(cubit.state, const Locale('en'));
    });

    test('setLocale updates to Russian', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await cubit.setLocale(const Locale('ru'));

      expect(cubit.state, const Locale('ru'));
    });

    test('setLocale persists language code to Hive', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await cubit.setLocale(const Locale('en'));

      verify(() => mockBox.put('app_locale', 'en')).called(1);
    });

    test('loads persisted locale from Hive', () {
      when(() => mockBox.get(any(), defaultValue: any(named: 'defaultValue')))
          .thenReturn('en');

      final loadedCubit = LocaleCubit(prefs: mockBox);

      expect(loadedCubit.state, const Locale('en'));
      loadedCubit.close();
    });

    test('setLocale ignores same locale (no duplicate save)', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await cubit.setLocale(const Locale('ru'));

      verifyNever(() => mockBox.put(any(), any()));
    });

    test('emits new state when locale changes', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      final emitted = <Locale>[];
      final subscription = cubit.stream.listen(emitted.add);

      await cubit.setLocale(const Locale('en'));
      await Future(() {}); // let stream settle

      expect(emitted, contains(const Locale('en')));

      await subscription.cancel();
    });
  });
}
