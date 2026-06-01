import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/results/domain/entities/training_result.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/buttons/primary_button.dart';

class ResultDetailScreen extends StatelessWidget {
  const ResultDetailScreen({required this.resultId, super.key, this.result});

  final String resultId;
  final TrainingResult? result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Данные из переданного объекта либо заглушка
    final r = result;
    final correct = r?.correctAnswers ?? 0;
    final unanswered = r?.unansweredCount ?? 0;
    final total = r?.totalQuestions ?? 0;
    final incorrect = total - correct - unanswered;
    final percent = total > 0 ? correct / total : 0.0;
    final isGood = percent >= 0.7;
    final hasData = r != null;

    return Scaffold(
      backgroundColor: AppColorsExt.bg0,
      appBar: AppBar(
        backgroundColor: AppColorsExt.bg1,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.resultDetail, style: TextStyles.h2.copyWith(color: AppColorsExt.fill1)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: hasData ? Column(
          children: [
            const Spacer(flex: 2),

            // Score Circle
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isGood ? AppColorsExt.primaryContainer : AppColorsExt.errorContainer,
              ),
              child: Center(
                child: Text(
                  '${(percent * 100).round()}%',
                  style: TextStyles.display.copyWith(
                    color: isGood ? AppColorsExt.primary : AppColorsExt.error,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              isGood ? l10n.greatJob : l10n.keepPracticing,
              style: TextStyles.h2.copyWith(color: AppColorsExt.fill1),
            ),
            const SizedBox(height: 32),

            // Stats
            _statRow(l10n.statCorrect, '$correct', AppColorsExt.primary),
            const SizedBox(height: 12),
            if (incorrect > 0)
              _statRow(l10n.statWrong, '$incorrect', AppColorsExt.error),
            if (unanswered > 0) ...[
              const SizedBox(height: 12),
              _statRow(l10n.statUnanswered, '$unanswered', AppColorsExt.fill2),
            ],
            const SizedBox(height: 12),
            _statRow(l10n.statTotal, '$total', AppColorsExt.fill2),

            const Spacer(flex: 3),

            AppPrimaryButton(
              width: double.infinity,
              text: l10n.backToHistory,
              onTap: () => context.pop(),
            ),
            const SizedBox(height: 16),
          ],
        ) : Center(
          child: Text(
            'Результат не найден',
            style: TextStyles.text.copyWith(color: AppColorsExt.fill2),
          ),
        ),
      ),
    );
  }

  Widget _statRow(String label, String value, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColorsExt.bg1,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColorsExt.border1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyles.text.copyWith(color: AppColorsExt.fill2)),
          Text(value, style: TextStyles.h3.copyWith(color: color)),
        ],
      ),
    );
  }
}
