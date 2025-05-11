import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/sign_out_button.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/text_pattern_widget.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/theme_switch_button.dart';
import 'package:training_trainer/uikit/appbars/big_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  DateTime? registrationDate;
  User? user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    registrationDate = user?.metadata.creationTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = context.watch<ThemeCubit>().state.brightness;

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
                          child: Row(
                            children: [
                              SizedBox(width: 15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${user?.displayName}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'почта: ${user?.email}',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        registrationDate != null
                                            ? 'Дата регистрации: ${registrationDate!.day}.${registrationDate!.month}.${registrationDate!.year}'
                                            : 'Дата регистрации: Недоступно',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h), // Add space between user info and theme switch button
                        const ThemeSwitchButton(), // Place the button below the user info
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
