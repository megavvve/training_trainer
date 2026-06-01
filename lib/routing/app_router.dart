import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/auth_screen.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/settings_screen.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/features/history/screens/history_screen.dart';
import 'package:training_trainer/features/history/screens/result_detail_screen.dart';
import 'package:training_trainer/features/results/domain/entities/training_result.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/add_trainer_screen.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/trainer_screen.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_process_screen/training_process_screen.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_result_screen/train_result_screen.dart';
import 'package:training_trainer/routing/app_routes.dart';

/// Provider for the router — no bottom nav, standalone screens with header icons
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.trainers,

    redirect: (context, state) {
      if (authState.isLoading) return null;

      final isAuth = authState.value != null;
      final isAuthRoute = state.matchedLocation == AppRoutes.auth;

      if (!isAuth) {
        return isAuthRoute ? null : AppRoutes.auth;
      }

      if (isAuthRoute) {
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
        path: AppRoutes.trainers,
        builder: (context, state) => const TrainerScreen(),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.resultDetail,
        builder: (context, state) {
          final resultId = state.pathParameters['resultId'] ?? '1';
          return ResultDetailScreen(
            resultId: resultId,
            result: state.extra as TrainingResult?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
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
    ],
  );
});
