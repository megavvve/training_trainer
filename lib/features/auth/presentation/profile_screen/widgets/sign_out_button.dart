import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/core/di/injection_container.dart';
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
        borderRadius: BorderRadius.circular(20.0),
      ),
      color:  Colors.red,
       
      onPressed: () async {
        await getIt<Signout>().call();
      },
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
            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: 
        Colors.white
            ),
          ),
        ],
      ),
    );
  }
}
