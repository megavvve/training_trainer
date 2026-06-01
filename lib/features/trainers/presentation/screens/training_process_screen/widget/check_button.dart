import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/features/trainers/domain/state/train_process_bloc/train_process_bloc.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/buttons/primary_button.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<TrainProcessBloc, TrainProcessState>(
      builder: (context, state) {
        if (state is! TrainProcessInProgress) return const SizedBox.shrink();

        final isCorrect = state.isAnswerChecked &&
            state.selectedAnswer == state.currentQuestion.rightAnswer;

        return AppPrimaryButton(
          width: double.infinity,
          onTap: () => _handleCheckAnswer(context, state),
          disabled: state.selectedAnswer == null && !state.isAnswerChecked,
          text: state.isAnswerChecked ? l10n.continueText : l10n.check,
        );
      },
    );
  }

  void _handleCheckAnswer(BuildContext context, TrainProcessInProgress state) {
    final l10n = AppLocalizations.of(context)!;
    if (!state.isAnswerChecked) {
      if (state.selectedAnswer == null) return;
      context.read<TrainProcessBloc>().add(CheckAnswer());

      // Проверяем правильность ответа
      final newState =
          context.read<TrainProcessBloc>().state as TrainProcessInProgress;
      final isCorrect =
          newState.selectedAnswer == newState.currentQuestion.rightAnswer;

      // Если ответ правильный — сразу переходим к следующему вопросу
      if (isCorrect) {
        _advanceAfterDelay(context);
      }
    } else {
      context.read<TrainProcessBloc>().add(const NextQuestion());
    }
  }

  void _advanceAfterDelay(BuildContext context) {
    // Небольшая задержка, чтобы пользователь увидел зелёную подсветку
    Future.delayed(const Duration(milliseconds: 600), () {
      if (context.mounted) {
        context.read<TrainProcessBloc>().add(const NextQuestion());
      }
    });
  }
}
