import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/presentation/home_screen.dart';
import 'package:training_trainer/presentation/welcome_screen.dart';
import 'package:training_trainer/utils/routing.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (con, _) {
          return MaterialApp(
            initialRoute: '/',
            routes: routes,
            home: WelcomeScreen(),
          );
        });
  }
}
