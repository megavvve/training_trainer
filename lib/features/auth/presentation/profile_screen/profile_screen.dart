import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/core/config/theme/app_colors.dart';
import 'package:training_trainer/core/widgets/text_pattern_screen.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/sign_out_button.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    //final brightness = context.watch<ThemeCubit>().state.brightness;

    
        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          // backgroundColor: brightness == Brightness.dark
          //     ? backgroundColorDark
          //     : backgroundColorLight,
          body: Stack(
            children: [
           TextPatternScreen(),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                   backgroundColor: AppColors.lightBackground,
                    // backgroundColor: brightness == Brightness.dark
                    //     ? backgroundColorDark
                    //     : settingsAppBar,
                    centerTitle: true,
                    title: const Text(
                      "Настройки",
                      style: TextStyle(
                        color: AppColors.lightText,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Stack(
                            children: [
                              // brightness == Brightness.dark
                              //     ? settingsBackgroundDark
                              //     : settingsBackgroundLight,
                              Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(13.sp),
                                  //width: 315.w,
                                  //height: 90.h,
                                  decoration: BoxDecoration(
                                    // color: brightness == Brightness.dark
                                    //     ? colorForMaterialCardDark
                                    //     : const Color(0xFFAEC6FF),
                                    boxShadow: [
                                      BoxShadow(
                                        // color: brightness == Brightness.dark
                                        //     ? colorForMaterialCardDark
                                        //     : const Color(0xFFAEC6FF),
                                        offset: const Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ), 
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.sp),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Stack(
                                      //   children: [
                                      //     Positioned(
                                      //       child: duckBackground,
                                      //     ),
                                      //     Positioned(
                                      //       top: 10,
                                      //       left: 10,
                                      //       child: duck,
                                      //     ),
                                      //   ],
                                      // ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${user?.displayName}',
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold),
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
                              ),
                              // Positioned(
                              //   top: 120.h,
                              //   left: 0.w,
                              //   right: 0.w,
                              //   child: const ThemeSwitchButton(),
                              // ),
                          
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton:  const SignOutButton(),
        );
      }
    
  }
