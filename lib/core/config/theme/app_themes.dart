import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: mainColorLight,
    scaffoldBackgroundColor: backgroundColorLight,
    dividerColor: secondColorLight,
    appBarTheme: AppBarTheme(
      backgroundColor: settingsAppBar,
      elevation: 2,
      titleTextStyle: TextStyles.h1.copyWith(
        color: colorForMaterialCardDark,
      ),
      iconTheme: IconThemeData(color: thirdColor),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: mainColorLight,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: mainColorLight,
      brightness: Brightness.light,
      primary: mainColorLight,
      onPrimary: Colors.white,
      secondary: thirdColor,
      onSecondary: Colors.white,
      error: colorForButton,
      onError: Colors.white,
      surface: trainerBottomSheetBackground,
      onSurface: colorForMaterialCardDark,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyles.h1.copyWith(color: colorForMaterialCardDark),
      displayMedium: TextStyles.h2.copyWith(color: colorForMaterialCardDark),
      displaySmall: TextStyles.h3.copyWith(color: colorForMaterialCardDark),
      headlineLarge: TextStyles.textBold.copyWith(color: colorForMaterialCardDark),
      headlineMedium: TextStyles.textMed.copyWith(color: colorForMaterialCardDark),
      headlineSmall: TextStyles.text.copyWith(color: colorForMaterialCardDark),
      titleLarge: TextStyles.textSmall.copyWith(color: colorForMaterialCardDark),
      titleMedium: TextStyles.textSmallMed.copyWith(color: colorForMaterialCardDark),
      bodyLarge: TextStyles.text.copyWith(color: colorForMaterialCardDark),
      bodyMedium: TextStyles.textMed.copyWith(color: colorForMaterialCardDark),
      labelLarge: TextStyles.textBold.copyWith(color: colorForMaterialCardDark),
      bodySmall: TextStyles.desk.copyWith(color: colorForMaterialCardDark),
      labelSmall: TextStyles.deskMed.copyWith(color: colorForMaterialCardDark),
    ),
    extensions: <ThemeExtension<dynamic>>[
      CustomButtonTheme(
        primaryBackground: mainColorLight,
        primaryText: Colors.white,
        primaryDisabledBackground: secondColorLight,
        errorBackground: colorForButton,
        errorText: Colors.white,
        errorDisabledBackground: colorForFindTextDark,
      ),
    ],
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: trainerBottomSheetBackground,
      contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w), 
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondColorLight),
        borderRadius: BorderRadius.circular(8.r), 
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColorLight, width: 2.w), 
        borderRadius: BorderRadius.circular(8.r), 
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorForButton, width: 2.w), 
        borderRadius: BorderRadius.circular(8.r), 
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: trainerAppBarButtonsBackground),
        borderRadius: BorderRadius.circular(8.r), 
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColorLight,
        foregroundColor: Colors.white,
        textStyle: TextStyles.textBold,
        minimumSize: Size(64.w, 36.h), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)), 
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: mainColorDark,
    scaffoldBackgroundColor: backgroundColorDark,
    dividerColor: semanticBg3,
    appBarTheme: AppBarTheme(
      backgroundColor: colorForMaterialCardDark,
      elevation: 2,
      titleTextStyle: TextStyles.h1.copyWith(color: mainColorDark),
      iconTheme: IconThemeData(color: mainColorDark),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: mainColorDark,
      foregroundColor: colorForMaterialCardDark,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: mainColorDark,
      brightness: Brightness.dark,
      primary: mainColorDark,
      onPrimary: colorForMaterialCardDark,
      secondary: secondColorDark,
      onSecondary: colorForMaterialCardDark,
      error: colorForButton,
      onError: colorForMaterialCardDark,
      surface: semanticBg2,
      onSurface: mainColorDark,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyles.h1.copyWith(color: Colors.white),
      displayMedium: TextStyles.h2.copyWith(color: Colors.white),
      displaySmall: TextStyles.h3.copyWith(color: Colors.white),
      headlineLarge: TextStyles.textBold.copyWith(color: Colors.white),
      headlineMedium: TextStyles.textMed.copyWith(color: Colors.white),
      headlineSmall: TextStyles.text.copyWith(color: Colors.white),
      titleLarge: TextStyles.textSmall.copyWith(color: Colors.white),
      titleMedium: TextStyles.textSmallMed.copyWith(color: Colors.white),
      bodyLarge: TextStyles.text.copyWith(color: Colors.white),
      bodyMedium: TextStyles.textMed.copyWith(color: Colors.white),
      labelLarge: TextStyles.textBold.copyWith(color: Colors.white),
      bodySmall: TextStyles.desk.copyWith(color: Colors.white),
      labelSmall: TextStyles.deskMed.copyWith(color: Colors.white),
    ),
    extensions: <ThemeExtension<dynamic>>[
      CustomButtonTheme(
        primaryBackground: mainColorDark,
        primaryText: colorForMaterialCardDark,
        primaryDisabledBackground: semanticBg3,
        errorBackground: colorForButton,
        errorText: mainColorDark,
        errorDisabledBackground: colorForFindTextDark,
      ),
    ],
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: semanticBg2,
      contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w), 
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: semanticBg3),
        borderRadius: BorderRadius.circular(8.r), 
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColorDark, width: 2.w), 
        borderRadius: BorderRadius.circular(8.r), 
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorForButton, width: 2.w), 
        borderRadius: BorderRadius.circular(8.r), 
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: semanticBg3),
        borderRadius: BorderRadius.circular(8.r), 
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColorDark,
        foregroundColor: colorForMaterialCardDark,
        textStyle: TextStyles.textBold,
        minimumSize: Size(64.w, 36.h), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)), 
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorForMaterialCardDark,
      selectedItemColor: mainColorDark,
      unselectedItemColor: semanticBg3,
    ),
  );
}

@immutable
class CustomButtonTheme extends ThemeExtension<CustomButtonTheme> {
  final Color primaryBackground;
  final Color primaryText;
  final Color primaryDisabledBackground;
  final Color errorBackground;
  final Color errorText;
  final Color errorDisabledBackground;

  const CustomButtonTheme({
    required this.primaryBackground,
    required this.primaryText,
    required this.primaryDisabledBackground,
    required this.errorBackground,
    required this.errorText,
    required this.errorDisabledBackground,
  });

  @override
  CustomButtonTheme copyWith({
    Color? primaryBackground,
    Color? primaryText,
    Color? primaryDisabledBackground,
    Color? errorBackground,
    Color? errorText,
    Color? errorDisabledBackground,
  }) {
    return CustomButtonTheme(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      primaryText: primaryText ?? this.primaryText,
      primaryDisabledBackground: primaryDisabledBackground ?? this.primaryDisabledBackground,
      errorBackground: errorBackground ?? this.errorBackground,
      errorText: errorText ?? this.errorText,
      errorDisabledBackground: errorDisabledBackground ?? this.errorDisabledBackground,
    );
  }

  @override
  CustomButtonTheme lerp(ThemeExtension<CustomButtonTheme>? other, double t) {
    if (other is! CustomButtonTheme) return this;
    return CustomButtonTheme(
      primaryBackground: Color.lerp(primaryBackground, other.primaryBackground, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      primaryDisabledBackground: Color.lerp(primaryDisabledBackground, other.primaryDisabledBackground, t)!,
      errorBackground: Color.lerp(errorBackground, other.errorBackground, t)!,
      errorText: Color.lerp(errorText, other.errorText, t)!,
      errorDisabledBackground: Color.lerp(errorDisabledBackground, other.errorDisabledBackground, t)!,
    );
  }
}
