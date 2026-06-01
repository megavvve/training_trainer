import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/core/config/localization/cubit/locale_cubit.dart';
import 'package:training_trainer/core/config/theme/app_themes.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_state.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/widgets/loading_screen.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/features/trainers/domain/repositories/trainiers_repository.dart';
import 'package:training_trainer/features/trainers/domain/state/train_process_bloc/train_process_bloc.dart';
import 'package:training_trainer/features/trainers/domain/state/trainers_bloc/trainers_bloc.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/routing/app_router.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final authState = ref.watch(authStateProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(prefs: getIt<Box<dynamic>>()),
        ),
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit(prefs: getIt<Box<dynamic>>()),
        ),
        BlocProvider<TrainProcessBloc>(create: (context) => TrainProcessBloc()),
        BlocProvider<TrainersBloc>(
          create: (context) =>
              TrainersBloc(repository: getIt<TrainersRepository>())
                ..add(LoadTrainers()),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              // Sync currentColors for AppColorsExt before building theme
              currentColors.value = themeState.isDark ? AppColors.dark : AppColors.light;

              final themeMode = themeState.isDark
                  ? ThemeMode.dark
                  : ThemeMode.light;

              if (authState.isLoading || !authState.hasValue) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: AppThemes.fromBrightness(Brightness.light),
                  darkTheme: AppThemes.fromBrightness(Brightness.dark),
                  themeMode: themeMode,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: locale,
                  home: const LoadingScreen(),
                );
              }

              return MaterialApp.router(
                key: ValueKey(themeState.brightness),
                routerConfig: router,
                debugShowCheckedModeBanner: false,
                theme: AppThemes.fromBrightness(Brightness.light),
                darkTheme: AppThemes.fromBrightness(Brightness.dark),
                themeMode: themeMode,
                localizationsDelegates:
                    AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: locale,
              );
            },
          );
        },
      ),
    );
  }
}
