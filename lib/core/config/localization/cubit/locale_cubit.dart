import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({required this.prefs}) : super(const Locale('ru')) {
    _loadLocale();
  }
  final Box<dynamic> prefs;

  static const _localeKey = 'app_locale';

  Future<void> setLocale(Locale locale) async {
    if (state == locale) return;
    emit(locale);
    await prefs.put(_localeKey, locale.languageCode);
  }

  void _loadLocale() {
    final languageCode = prefs.get(_localeKey) as String?;
    if (languageCode != null) {
      emit(Locale(languageCode));
    } else {
      // Default to system locale if available, else Russian
      emit(const Locale('ru'));
    }
  }
}
