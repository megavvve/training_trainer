import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/features/auth/domain/usecases/sign_out.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColorsExt.negative,
          foregroundColor: AppColorsExt.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          await getIt<Signout>().call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              l10n.signOut,
              style: TextStyles.textSemi.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
