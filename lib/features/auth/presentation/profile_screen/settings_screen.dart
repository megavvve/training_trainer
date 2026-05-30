import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/language_selector.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/sign_out_button.dart';
import 'package:training_trainer/features/auth/presentation/profile_screen/widgets/theme_switch_button.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/appbars/big_app_bar.dart';
import 'package:training_trainer/uikit/cards/card_item.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColorsExt.bg2,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: BigAppBar(title: l10n.settings),
            backgroundColor: AppColorsExt.bg2,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Profile Section
                Text(
                  l10n.profileLabel,
                  style: TextStyles.textSReg.copyWith(
                    color: AppColorsExt.fill2,
                  ),
                ),
                const SizedBox(height: 10),
                CardItem(
                  child: authState.when(
                    data: (user) {
                      if (user == null) {
                        return Center(
                          child: Text(
                            l10n.userNotAuthenticated,
                            style: TextStyles.text,
                          ),
                        );
                      }
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColorsExt.primary,
                            child: Text(
                              user.login[0].toUpperCase(),
                              style: TextStyles.h2.copyWith(color: AppColorsExt.white),
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
                    error: (error, _) => Center(
                      child: Text(
                        '${l10n.profileLoadError}: $error',
                        style: TextStyles.textSmall.copyWith(color: AppColorsExt.negative),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Settings Section
                Text(
                  l10n.appSettings,
                  style: TextStyles.textSReg.copyWith(
                    color: AppColorsExt.fill2,
                  ),
                ),
                const SizedBox(height: 10),
                const ThemeSwitchButton(),
                const SizedBox(height: 12),
                const LanguageSelector(),

                const SizedBox(height: 40),

                // Logout Button
                const SignOutButton(),
                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
