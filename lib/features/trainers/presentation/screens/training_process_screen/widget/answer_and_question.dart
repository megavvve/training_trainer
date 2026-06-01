import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/state/train_process_bloc/train_process_bloc.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class AnswersAndQuestion extends StatelessWidget {
  const AnswersAndQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainProcessBloc, TrainProcessState>(
      builder: (context, state) {
        if (state is! TrainProcessInProgress) return const SizedBox.shrink();

        final question = state.currentQuestion;
        final totalQuestions = state.totalQuestions;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question counter
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColorsExt.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${state.currentQuestionIndex + 1} / $totalQuestions',
                    style: TextStyles.textSemi.copyWith(
                      color: AppColorsExt.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Question text card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColorsExt.bg1,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColorsExt.border2, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppColorsExt.fill1.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Text(
                  question.textQuestion,
                  style: TextStyles.h3.copyWith(
                    color: AppColorsExt.fill1,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              // Answer label
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  AppLocalizations.of(context)!.selectAnswer,
                  style: TextStyles.textSmall.copyWith(
                    color: AppColorsExt.fill2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: isAnswerChecked
                  ? null
                  : () => context.read<TrainProcessBloc>().add(
                        SelectAnswer(answer: answer),
                      ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: _buildDecoration(),
                child: Row(
                  children: [
                    _buildLeadingIcon(),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        answer,
                        style: TextStyles.text.copyWith(
                          color: _getTextColor(),
                          height: 1.3,
                        ),
                      ),
                    ),
                    if (isAnswerChecked && isCorrect)
                      const Icon(Icons.check_circle, color: Colors.white, size: 20),
                    if (isAnswerChecked && isSelected && !isCorrect)
                      const Icon(Icons.cancel, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    if (isAnswerChecked) {
      if (isCorrect) {
        return Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white24,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 16),
        );
      } else if (isSelected) {
        return Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white24,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 16),
        );
      }
    }
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColorsExt.primary : AppColorsExt.border2,
          width: isSelected ? 2 : 1.5,
        ),
        color: isSelected ? AppColorsExt.primary : Colors.transparent,
      ),
      child: isSelected
          ? const Icon(Icons.radio_button_checked, color: Colors.white, size: 16)
          : null,
    );
  }

  BoxDecoration _buildDecoration() {
    Color bgColor;
    Color borderColor;
    double borderWidth;

    if (isAnswerChecked) {
      if (isCorrect) {
        bgColor = AppColorsExt.primary;
        borderColor = AppColorsExt.primary;
        borderWidth = 0;
      } else if (isSelected) {
        bgColor = AppColorsExt.error;
        borderColor = AppColorsExt.error;
        borderWidth = 0;
      } else {
        bgColor = AppColorsExt.bg1;
        borderColor = AppColorsExt.border1;
        borderWidth = 1;
      }
    } else {
      bgColor = isSelected
          ? AppColorsExt.primary.withValues(alpha: 0.08)
          : AppColorsExt.bg1;
      borderColor = isSelected ? AppColorsExt.primary : AppColorsExt.border1;
      borderWidth = isSelected ? 2 : 1;
    }

    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: borderColor, width: borderWidth),
    );
  }

  Color _getTextColor() {
    if (isAnswerChecked && (isCorrect || isSelected)) {
      return Colors.white;
    }
    if (isSelected) {
      return AppColorsExt.primary;
    }
    return AppColorsExt.fill1;
  }
}
