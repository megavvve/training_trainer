import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/utils/checks.dart';
import 'package:training_trainer/core/utils/pop_up_notifications.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/routing/app_routes.dart';

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
  bool _showPassword = false;
  bool _rememberMe = false;

  static const String _hiveRememberEmail = 'remember_email';
  static const String _hiveRememberPassword = 'remember_password';

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedCredentials() async {
    final box = getIt<Box<dynamic>>();
    final savedEmail = box.get(_hiveRememberEmail) as String?;
    final savedPassword = box.get(_hiveRememberPassword) as String?;
    if (savedEmail != null && savedPassword != null) {
      _emailController.text = savedEmail;
      _passwordController.text = savedPassword;
      setState(() => _rememberMe = true);
    }
  }

  Future<void> _saveCredentials() async {
    final box = getIt<Box<dynamic>>();
    await box.put(_hiveRememberEmail, _emailController.text);
    await box.put(_hiveRememberPassword, _passwordController.text);
  }

  static Future<void> clearSavedCredentials() async {
    final box = getIt<Box<dynamic>>();
    await box.delete(_hiveRememberEmail);
    await box.delete(_hiveRememberPassword);
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    try {
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
        await ref.read(signUpProvider).call(
              email: _emailController.text,
              password: _passwordController.text,
              login: _loginController.text,
            );
      } else {
        if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
          inputFieldsNotFilledIn(context);
          return;
        }
        if (!isValidEmail(_emailController.text)) {
          showErrorSnackBar(context, l10n.invalidEmail);
          return;
        }
        await ref.read(signInProvider).call(
              email: _emailController.text,
              password: _passwordController.text,
            );
      }

      // Save credentials if "Remember me" is on
      if (_rememberMe) {
        await _saveCredentials();
      } else {
        await clearSavedCredentials();
      }

      if (!mounted) return;
      context.go(AppRoutes.trainers);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка входа. Проверьте email и пароль.')),
      );
    }
  }

  void _toggleMode() {
    setState(() {
      _isRegistry = !_isRegistry;
      _loginController.clear();
      _emailController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColorsExt.bg0,
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // ── Icon with glow ──
                Center(
                  child: Stack(
                    children: [
                      // Glow effect
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColorsExt.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColorsExt.primary.withValues(alpha: 0.3),
                              blurRadius: 24,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      // Icon
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColorsExt.primary, AppColorsExt.primaryPress],
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── Training Trainer heading ──
                Text(
                  'Training Trainer',
                  style: TextStyles.h2.copyWith(
                    color: AppColorsExt.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  _isRegistry ? l10n.authSubtitleSignUp : l10n.authSubtitleSignIn,
                  style: TextStyles.text.copyWith(color: AppColorsExt.fill2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),


                // ── Form Card ──
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColorsExt.bg1,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColorsExt.border1.withValues(alpha: 0.5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Username field (sign up only)
                      if (_isRegistry) ...[
                        _buildField(
                          label: l10n.usernameLabel,
                          hint: l10n.usernameHint,
                          icon: Icons.person_outline,
                          controller: _loginController,
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Email field
                      _buildField(
                        label: l10n.emailLabel,
                        hint: l10n.emailLabel,
                        icon: Icons.mail_outline,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      _buildPasswordField(),

                      // ── Remember me (sign in only) ──
                      if (!_isRegistry) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            SizedBox(
                              height: 28,
                              width: 28,
                              child: Checkbox(
                                value: _rememberMe,
                                onChanged: (v) => setState(() => _rememberMe = v ?? false),
                                activeColor: AppColorsExt.primary,
                                checkColor: Colors.white,
                                side: const BorderSide(color: Colors.grey, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _rememberMe = !_rememberMe),
                                child: Text(
                                  l10n.rememberMe,
                                  style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: AppColorsExt.primary,
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                l10n.forgotPassword,
                                style: TextStyles.textSmall.copyWith(color: AppColorsExt.primary),
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 32),

                      // Submit button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColorsExt.primary, AppColorsExt.primaryPress],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColorsExt.primary.withValues(alpha: 0.3),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: _submit,
                              child: Center(
                                child: Text(
                                  _isRegistry ? l10n.authHeadingSignUp : l10n.signIn,
                                  style: TextStyles.textSemi.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Toggle ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isRegistry ? l10n.alreadyHaveAccount : l10n.noAccount,
                      style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                    ),
                    GestureDetector(
                      onTap: _toggleMode,
                      child: Text(
                        _isRegistry ? l10n.signIn : l10n.signUp,
                        style: TextStyles.textSSemi.copyWith(
                          color: AppColorsExt.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyles.textSSemi.copyWith(color: AppColorsExt.fill2, fontSize: 12),
          ),
        ),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppColorsExt.bg2,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.transparent, width: 2),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 20, color: AppColorsExt.fill3),
              hintText: hint,
              hintStyle: TextStyles.text.copyWith(color: AppColorsExt.fill3),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            l10n.passwordLabel,
            style: TextStyles.textSSemi.copyWith(color: AppColorsExt.fill2, fontSize: 12),
          ),
        ),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppColorsExt.bg2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline, size: 20, color: AppColorsExt.fill3),
              hintText: l10n.passwordHint,
              hintStyle: TextStyles.text.copyWith(color: AppColorsExt.fill3),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  color: AppColorsExt.fill3,
                ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              ),
            ),
            style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
          ),
        ),
      ],
    );
  }
}
