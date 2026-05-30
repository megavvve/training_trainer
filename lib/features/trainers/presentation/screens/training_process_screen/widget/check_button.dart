import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_trainer/features/trainers/presentation/providers/train_process_bloc/train_process_bloc.dart';
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

      final newState =
          context.read<TrainProcessBloc>().state as TrainProcessInProgress;
      _showResultDialog(
        context,
        newState.selectedAnswer == newState.currentQuestion.rightAnswer,
        l10n,
      );
    } else {
      context.read<TrainProcessBloc>().add(const NextQuestion());
    }
  }

  void _showResultDialog(
      BuildContext context, bool isCorrect, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isCorrect ? l10n.correct : l10n.error),
        content: Text(isCorrect ? l10n.wellDone : l10n.showCorrectAnswer),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }
}
