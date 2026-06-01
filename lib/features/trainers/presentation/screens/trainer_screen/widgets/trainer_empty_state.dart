import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class TrainerEmptyState extends StatelessWidget {
  const TrainerEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.book_outlined, size: 64, color: AppColorsExt.fill3),
          const SizedBox(height: 16),
          Text(
            l10n.noTrainersFound,
            style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.noTrainersHint,
            style: TextStyles.text.copyWith(color: AppColorsExt.fill2),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
