import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/widgets/email_form.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/widgets/headline.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/widgets/login_form.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/widgets/password_form.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
 final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = TextEditingController();
  bool isRegistry = true;

  Future<void> _submit() async {
    try {
      if (isRegistry) {
        await ref.read(signUpProvider).call(
              email: _emailController.text,
              password: _passwordController.text,
              login: _loginController.text,
            );
      } else {
        await ref.read(signInProvider).call(
              email: _emailController.text,
              password: _passwordController.text,
            );
      }
      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

     @override
  Widget build(BuildContext context) {




    return Scaffold(
      // backgroundColor: brightness == Brightness.dark
      //     ? backgroundColorDark
      //     : backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: isRegistry
                ? const Headline(
                    textForHeadline: "для регистрации",
                  )
                : const Headline(
                    textForHeadline: "для входа",
                  ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: SizedBox(),
            ),
          ),
           SliverToBoxAdapter(
            child: isRegistry 
              ? LoginForm(controller: _loginController)
              : const SizedBox(),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: EmailForm(controller:_emailController),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: PasswordForm(controller: _passwordController,),
            ),
          ),
          SliverToBoxAdapter(
              child: MaterialButton(
            onPressed: _submit,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF4575CD),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.sp),
                ),
              ),
              width: 162.w,
              height: 47.h,
              child: Text(
                "Далее",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: isRegistry
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Уже есть аккаунт? ',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          Text(
                            'Войти',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.red),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Нет аккаунта? ',
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            'Зарегистрироваться',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
