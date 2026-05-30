import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/presentation/providers/train_process_bloc/train_process_bloc.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/routing/app_routes.dart';
import 'package:training_trainer/uikit/buttons/primary_button.dart';

class TrainingResultScreen extends StatelessWidget {
  const TrainingResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColorsExt.bg2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(l10n.trainingResult, style: TextStyles.h3),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
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
              final randomResultingText = getRandomCongratulations(l10n);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColorsExt.positive.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_outline_rounded,
                        color: AppColors.light.positive,
                        size: 64,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      randomResultingText,
                      style: TextStyles.h3,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    _buildResultRow(
                      l10n.correctAnswersCount(correctAnswers),
                      AppColorsExt.positive,
                    ),
                    const SizedBox(height: 12),
                    _buildResultRow(
                      l10n.incorrectAnswersCount(totalQuestions - correctAnswers),
                      AppColorsExt.negative,
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

  Widget _buildResultRow(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Text(
        text,
        style: TextStyles.h3.copyWith(color: color),
        textAlign: TextAlign.center,
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
