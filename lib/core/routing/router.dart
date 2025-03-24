import 'package:go_router/go_router.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/auth_screen.dart';
import 'package:training_trainer/features/trainers/presentation/home_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AuthScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
  ],
);