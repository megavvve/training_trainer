import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/core/widgets/scaffold_with_nav_bar.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_process_screen/training_process_screen.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_result_screen/train_result_screen.dart';
import 'package:training_trainer/routing/app_routes.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/auth_screen.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/settings_screen.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/add_trainer_screen.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/trainer_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuth = authState.value != null;
      final isAuthRoute = state.matchedLocation == AppRoutes.auth;

      if (authState.isLoading || authState.hasError) return null;

      if (!isAuth && !isAuthRoute) return AppRoutes.auth;

      if (isAuth && isAuthRoute) return AppRoutes.trainers;

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.addTrainer,
        builder: (context, state) => const AddTrainerScreen(),
      ),
       GoRoute(
        path: AppRoutes.trainingResult,
        builder: (context, state) => const TrainingResultScreen(),
      ),
      GoRoute(
        path: AppRoutes.trainingProcess,
        builder: (context, state) {
          final trainer = state.extra as Trainer?;

          if (trainer == null) {
            return const TrainerScreen();
          }

          return TrainProcessScreen(trainer: trainer);
        },
      ),

      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) =>
                ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              // GoRoute(
              //   path: AppRoutes.home,
              //   pageBuilder: (context, state) =>  NoTransitionPage(
              //     child: HomeScreen(),
              //   ),
              // ),
              GoRoute(
                path: AppRoutes.trainers,
                builder: (context, state) => const TrainerScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: SettingsScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
