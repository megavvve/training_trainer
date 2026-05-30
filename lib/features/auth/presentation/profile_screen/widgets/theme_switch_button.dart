import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = context.watch<ThemeCubit>().state.brightness;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColorsExt.bg1,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: AppColorsExt.border2, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                brightness == Brightness.dark
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
                color: AppColorsExt.primary,
              ),
              const SizedBox(width: 12),
              Text(
                l10n.darkTheme,
                style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
              ),
            ],
          ),
          Switch(
            value: brightness == Brightness.dark,
            activeColor: AppColorsExt.primary,
            onChanged: (bool value) {
              context.read<ThemeCubit>().setThemeBrightness(
                    value ? Brightness.dark : Brightness.light,
                  );
            },
          ),
        ],
      ),
    );
  }
}
