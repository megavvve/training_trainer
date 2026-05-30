import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/presentation/providers/train_process_bloc/train_process_bloc.dart';

class AnswersAndQuestion extends StatelessWidget {
  const AnswersAndQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainProcessBloc, TrainProcessState>(
      builder: (context, state) {
        if (state is! TrainProcessInProgress) return const SizedBox.shrink();

        final question = state.currentQuestion;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColorsExt.bg1,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColorsExt.border2, width: 1),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    question.textQuestion,
                    style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Answers(
                list: question.answers,
                correctAnswer: question.rightAnswer,
                isAnswerChecked: state.isAnswerChecked,
              ),
            ],
          ),
        );
      },
    );
  }
}

class Answers extends StatelessWidget {
  const Answers({
    required this.list,
    required this.correctAnswer,
    required this.isAnswerChecked,
    super.key,
  });
  final List<String> list;
  final String correctAnswer;
  final bool isAnswerChecked;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TrainProcessBloc, TrainProcessState, String?>(
      selector: (state) =>
          state is TrainProcessInProgress ? state.selectedAnswer : null,
      builder: (context, selectedAnswer) {
        return Column(
          children: [
            for (int i = 0; i < list.length; i++)
              _AnswerItem(
                answer: list[i],
                isSelected: list[i] == selectedAnswer,
                isCorrect: list[i] == correctAnswer,
                isAnswerChecked: isAnswerChecked,
              ),
          ],
        );
      },
    );
  }
}

class _AnswerItem extends StatelessWidget {
  const _AnswerItem({
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswerChecked,
  });
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswerChecked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: _styleForAnswer(
            isSelected: isSelected,
            isCorrect: isCorrect,
            isAnswerChecked: isAnswerChecked,
          ),
          onPressed: isAnswerChecked
              ? null
              : () => context.read<TrainProcessBloc>().add(
                    SelectAnswer(answer: answer),
                  ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              answer,
              style: TextStyles.text.copyWith(
                color: _getTextColor(isSelected, isCorrect, isAnswerChecked),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTextColor(
    bool isSelected,
    bool isCorrect,
    bool isAnswerChecked,
  ) {
    if (isAnswerChecked && (isCorrect || isSelected)) {
      return Colors.white;
    }
    return AppColorsExt.fill1;
  }

  ButtonStyle _styleForAnswer({
    required bool isSelected,
    required bool isCorrect,
    required bool isAnswerChecked,
  }) {
    Color backgroundColor;

    if (isAnswerChecked) {
      if (isCorrect) {
        backgroundColor = AppColorsExt.positive;
      } else if (isSelected) {
        backgroundColor = AppColorsExt.negative;
      } else {
        backgroundColor = AppColorsExt.bg1;
      }
    } else {
      backgroundColor = isSelected
          ? AppColorsExt.primary.withOpacity(0.15)
          : AppColorsExt.bg1;
    }

    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isAnswerChecked
              ? Colors.transparent
              : isSelected
                  ? AppColorsExt.primary
                  : AppColorsExt.border2,
          width: isAnswerChecked ? 0 : 1.5,
        ),
      ),
    );
  }
}
