import 'package:training_trainer/presentation/home_screen.dart';
import 'package:training_trainer/presentation/main_page.dart';
import 'package:training_trainer/presentation/profile_screen.dart';
import 'package:training_trainer/presentation/search_screen.dart';
import 'package:training_trainer/presentation/welcome_screen.dart';

final routes = {
  '/': (context) => WelcomeScreen(),
  '/home': (context) => HomeScreen(),
  '/main': (context) => MainPage(),
  '/search': (context) => SearchScreen(),
  '/profile': (context) => ProfileScreen(),
};
