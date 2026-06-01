import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/language_selector.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/sign_out_button.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/theme_switch_button.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColorsExt.bg0,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.settings, style: TextStyles.h2.copyWith(color: AppColorsExt.fill1)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Profile Section ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColorsExt.bg1,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColorsExt.border1),
            ),
            child: authState.when(
              data: (user) {
                if (user == null) {
                  return Text(
                    l10n.userNotAuthenticated,
                    style: TextStyles.text,
                  );
                }
                return Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColorsExt.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          user.login[0].toUpperCase(),
                          style: TextStyles.h2.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.login,
                            style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text(
                '${l10n.profileLoadError}: $error',
                style: TextStyles.textSmall.copyWith(color: AppColorsExt.error),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ── Appearance ──
          Text(
            l10n.appSettings,
            style: TextStyles.textSSemi.copyWith(color: AppColorsExt.fill2, fontSize: 12),
          ),
          const SizedBox(height: 10),
          const ThemeSwitchButton(),
          const SizedBox(height: 12),

          Text(
            l10n.language,
            style: TextStyles.textSSemi.copyWith(color: AppColorsExt.fill2, fontSize: 12),
          ),
          const SizedBox(height: 10),
          const LanguageSelector(),

          const SizedBox(height: 40),
          const SignOutButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
