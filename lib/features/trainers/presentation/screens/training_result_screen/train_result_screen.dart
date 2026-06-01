import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/state/train_process_bloc/train_process_bloc.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/routing/app_routes.dart';
import 'package:training_trainer/uikit/buttons/primary_button.dart';

class TrainingResultScreen extends StatelessWidget {
  const TrainingResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColorsExt.bg0,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(l10n.trainingResult, style: TextStyles.h3),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            while (context.canPop()) {
              context.pop();
            }
            context.go(AppRoutes.trainers);
          },
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) context.pop();
        },
        child: BlocBuilder<TrainProcessBloc, TrainProcessState>(
          builder: (context, state) {
            if (state is TrainProcessCompleted) {
              final correctAnswers = state.correctAnswers;
              final totalQuestions = state.totalQuestions;
              final unansweredCount = state.unansweredCount;
              final incorrectAnswers = totalQuestions - correctAnswers - unansweredCount;
              final percent = totalQuestions > 0
                  ? (correctAnswers / totalQuestions * 100).round()
                  : 0;
              final isGood = percent >= 70;
              final randomResultingText = getRandomCongratulations(l10n);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Score circle
                    _buildScoreCircle(percent, isGood),
                    const SizedBox(height: 24),
                    Text(
                      randomResultingText,
                      style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    // Stats section
                    _buildStatCard(
                      icon: Icons.check_circle_rounded,
                      label: l10n.correctAnswersCount(correctAnswers),
                      value: '$correctAnswers',
                      color: AppColorsExt.primary,
                    ),
                    const SizedBox(height: 10),
                    _buildStatCard(
                      icon: Icons.cancel_rounded,
                      label: l10n.incorrectAnswersCount(incorrectAnswers),
                      value: '$incorrectAnswers',
                      color: AppColorsExt.error,
                    ),
                    const SizedBox(height: 10),
                    _buildStatCard(
                      icon: Icons.remove_circle_outline_rounded,
                      label: l10n.unansweredAnswersCount(unansweredCount),
                      value: '$unansweredCount',
                      color: AppColorsExt.fill2,
                    ),
                    const Spacer(),
                    AppPrimaryButton(
                      width: double.infinity,
                      onTap: () {
                        while (context.canPop()) {
                          context.pop();
                        }
                        context.go(AppRoutes.trainers);
                      },
                      text: l10n.continueText,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildScoreCircle(int percent, bool isGood) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isGood ? AppColorsExt.primaryContainer : AppColorsExt.errorContainer,
      ),
      child: Center(
        child: Text(
          '$percent%',
          style: TextStyles.display.copyWith(
            color: isGood ? AppColorsExt.primary : AppColorsExt.error,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColorsExt.bg1,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColorsExt.border1),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
            ),
          ),
          Text(
            value,
            style: TextStyles.h3.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  String getRandomCongratulations(AppLocalizations l10n) {
    final List<String> congratulationsList = [
      l10n.congrats1,
      l10n.congrats2,
      l10n.congrats3,
      l10n.congrats4,
      l10n.congrats5,
    ];

    final random = Random();
    final randomIndex = random.nextInt(congratulationsList.length);

    return congratulationsList[randomIndex];
  }
}
