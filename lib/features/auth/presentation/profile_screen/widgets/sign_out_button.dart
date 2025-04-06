import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/config/theme/app_colors.dart';
import 'package:training_trainer/features/auth/domain/usecases/sign_out.dart';


class SignOutButton extends StatefulWidget {
  const SignOutButton({super.key});

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  


  @override
  Widget build(BuildContext context) {

            return MaterialButton(
              shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),),
              color: AppColors.primary,
              onPressed: getIt<Signout>(),
             
              // style: ElevatedButton.styleFrom(
              //   // backgroundColor: brightness == Brightness.dark
              //   //     ? colorForButton
              //   //     : mainColorLight,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(16.sp),
              //   ),
              // ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Выйти',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }
     }