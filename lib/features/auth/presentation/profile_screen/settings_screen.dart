import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/sign_out_button.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/text_pattern_widget.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/theme_switch_button.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/uikit/appbars/big_app_bar.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = context.watch<ThemeCubit>().state.brightness;
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: brightness == Brightness.dark
          ? backgroundColorDark
          : backgroundColorLight,
      body: Stack(  
        children: [
          TextPatternWidget(),
          
          CustomScrollView(
            slivers: [
              SliverAppBar(
                title: BigAppBar(
                            
                  title:  "Настройки",
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(13.sp),
                          decoration: BoxDecoration(
                            color: brightness == Brightness.dark
                                ? colorForMaterialCardDark
                                : const Color(0xFFAEC6FF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.sp),
                            ),
                          ),
                          child: authState.when(
                            data: (user) {
                              if (user == null) {
                                return Text(
                                  'Пользователь не аутентифицирован',
                                  style: TextStyle(fontSize: 14.sp),
                                );
                              }
                              return Row(
                                children: [
                                  SizedBox(width: 15.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        user.login,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'почта: ${user.email}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            loading: () {
                              return const CircularProgressIndicator();
                            },
                            error: (error, stackTrace) {
                              return Text(
                                'Ошибка загрузки профиля: $error',
                                style: TextStyle(fontSize: 14.sp, color: Colors.red),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        const ThemeSwitchButton(),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: const SignOutButton(),
    );
  }
}
