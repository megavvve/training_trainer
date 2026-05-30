import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/core/config/localization/cubit/locale_cubit.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>().state;
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
                Icons.language_rounded,
                color: AppColorsExt.primary,
              ),
              const SizedBox(width: 12),
              Text(
                l10n.language,
                style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
              ),
            ],
          ),
          DropdownButton<String>(
            value: locale.languageCode,
            underline: const SizedBox(),
            dropdownColor: AppColorsExt.bg1,
            items: [
              DropdownMenuItem(
                value: 'ru',
                child: Text(l10n.russian),
              ),
              DropdownMenuItem(
                value: 'en',
                child: Text(l10n.english),
              ),
            ],
            onChanged: (String? value) {
              if (value != null) {
                context.read<LocaleCubit>().setLocale(Locale(value));
              }
            },
          ),
        ],
      ),
    );
  }
}
