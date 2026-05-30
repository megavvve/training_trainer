import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/core/utils/checks.dart';
import 'package:training_trainer/core/utils/pop_up_notifications.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/widgets/email_form.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/widgets/headline.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/widgets/login_form.dart';
import 'package:training_trainer/features/auth/presentation/auth_screen/widgets/password_form.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/routing/app_routes.dart';
import 'package:training_trainer/uikit/buttons/primary_button.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = TextEditingController();
  bool _isRegistry = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      debugPrint('[Auth] Submitting: isRegistry=$_isRegistry, email=${_emailController.text}');

      if (_isRegistry) {
        if (_emailController.text.isEmpty ||
            _passwordController.text.isEmpty ||
            _loginController.text.isEmpty) {
          inputFieldsNotFilledIn(context);
          return;
        }
        if (!isValidEmail(_emailController.text)) {
          showErrorSnackBar(context, l10n.invalidEmail);
          return;
        }
        debugPrint('[Auth] Calling signUpProvider...');
        await ref.read(signUpProvider).call(
              email: _emailController.text,
              password: _passwordController.text,
              login: _loginController.text,
            );
        debugPrint('[Auth] signUpProvider succeeded');
      } else {
        if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
          inputFieldsNotFilledIn(context);
          return;
        }
        if (!isValidEmail(_emailController.text)) {
          showErrorSnackBar(context, l10n.invalidEmail);
          return;
        }
        debugPrint('[Auth] Calling signInProvider...');
        await ref.read(signInProvider).call(
              email: _emailController.text,
              password: _passwordController.text,
            );
        debugPrint('[Auth] signInProvider succeeded');
      }
      if (!mounted) return;
      debugPrint('[Auth] Navigating to trainers...');
      context.go(AppRoutes.trainers);
    } catch (e) {
      debugPrint('[Auth] ERROR: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _toggleMode() {
    setState(() {
      _isRegistry = !_isRegistry;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App icon/brand
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColorsExt.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Headline
                Headline(
                  title: _isRegistry
                      ? l10n.authHeadingSignUp
                      : l10n.authHeadingSignIn,
                  subtitle: _isRegistry
                      ? l10n.authSubtitleSignUp
                      : l10n.authSubtitleSignIn,
                ),

                const SizedBox(height: 32),

                // Login field (registration only)
                if (_isRegistry) ...[
                  LoginForm(controller: _loginController),
                  const SizedBox(height: 16),
                ],

                // Email field
                EmailForm(controller: _emailController),
                const SizedBox(height: 16),

                // Password field
                PasswordForm(controller: _passwordController),

                const SizedBox(height: 32),

                // Submit button
                AppPrimaryButton(
                  key: const ValueKey('submitButton'),
                  onTap: _submit,
                  text: _isRegistry ? l10n.signUp : l10n.signIn,
                  width: double.infinity,
                ),

                const SizedBox(height: 24),

                // Toggle sign in / sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isRegistry
                          ? l10n.alreadyHaveAccount
                          : l10n.noAccount,
                      style: TextStyles.textSmall.copyWith(
                        color: AppColorsExt.fill2,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: _toggleMode,
                      child: Text(
                        _isRegistry ? l10n.signIn : l10n.signUp,
                        style: TextStyles.textSSemi.copyWith(
                          color: AppColorsExt.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
