import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';
import 'package:training_trainer/core/config/theme/app_themes.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_state.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/widgets/error_screen.dart';
import 'package:training_trainer/core/widgets/loading_screen.dart';
import 'package:training_trainer/features/trainers/presentation/providers/train_process_bloc/train_process_bloc.dart';
import 'package:training_trainer/routing/app_router.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(prefs: getIt<Box<dynamic>>()),
          
        ),
         BlocProvider<TrainProcessBloc>(
                create: (context) => TrainProcessBloc(),

          
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp.router(
                routerConfig: router,
                debugShowCheckedModeBanner: false,
                theme:
                    themeState.brightness == Brightness.dark
                        ? AppThemes.darkTheme
                        : AppThemes.lightTheme,
                builder: (context, child) {
                  final authState = ref.watch(authStateProvider);

                  return authState.when(
                    loading: () => const LoadingScreen(),
                    error:
                        (error, stack) => ErrorScreen(error: error.toString()),
                    data: (user) => child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
