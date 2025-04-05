import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/core/presentation/widgets/error_screen.dart';
import 'package:training_trainer/core/presentation/widgets/loading_screen.dart';
import 'package:training_trainer/core/routing/app_router.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              final authState = ref.watch(authStateProvider);

              return authState.when(
                loading: () => const LoadingScreen(),
                error: (error, stack) => ErrorScreen(error: error.toString()),
                data: (user) => child!,
              );
            },
          );
        });
  }
}
