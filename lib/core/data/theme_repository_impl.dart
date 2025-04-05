// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:training_trainer/core/domain/theme_repository.dart';

// class ThemeRepository implements ThemeRepositoryInterface {

//   ThemeRepository({required this.preferences});

//   final SharedPreferences preferences;

//   static const isDarkThemeKey = "dark_theme";

//   @override
//   bool isDarkTheme() {
//     final darkTheme = preferences.getBool(isDarkThemeKey);
//     return darkTheme ?? false;
//   }

//   @override
//   Future<void> setDarkTheme(bool value) async {
//     await preferences.setBool(isDarkThemeKey, value);
//   }
  
// }