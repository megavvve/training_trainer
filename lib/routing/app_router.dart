import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/core/widgets/scaffold_with_nav_bar.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/auth_screen.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/settings_screen.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/add_trainer_screen.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/trainer_screen.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_process_screen/training_process_screen.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_result_screen/train_result_screen.dart';
import 'package:training_trainer/routing/app_routes.dart';

/// Provider for the router
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.trainers,
    // Use the authState as a refresh listenable if it were a listenable, 
    // but here we rely on the provider rebuild which is also fine with current setup
    // however re-creating GoRouter on every change is not ideal.
    // For now, let's keep it but fix the redirect logic.
    
    redirect: (context, state) {
      // If still loading auth, don't redirect yet
      if (authState.isLoading) return null;

      final isAuth = authState.value != null;
      final isAuthRoute = state.matchedLocation == AppRoutes.auth;

      if (!isAuth) {
        // User not logged in, force to auth page
        return isAuthRoute ? null : AppRoutes.auth;
      }

      // User is logged in
      if (isAuthRoute) {
        // Logged in user shouldn't see auth page
        return AppRoutes.trainers;
      }

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
