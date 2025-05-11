import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/features/trainers/presentation/providers/train_process_bloc/train_process_bloc.dart';

class AnswersAndQuestion extends StatelessWidget {
  const AnswersAndQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainProcessBloc, TrainProcessState>(
      builder: (context, state) {
        final brightness = context.watch<ThemeCubit>().state.brightness;

        if (state is! TrainProcessInProgress) return const SizedBox.shrink();

        final question = state.currentQuestion;

        return Padding(
          padding: EdgeInsets.all(17.0.sp),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color:
                      brightness == Brightness.dark
                          ? colorForMaterialCardDark
                          : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(14.sp)),
                ),
                width: 335.w,
                child: Center(
                  child: Text(
                    question.textQuestion,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
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
  final List<String> list;
  final String correctAnswer;
  final bool isAnswerChecked;

  const Answers({
    super.key,
    required this.list,
    required this.correctAnswer,
    required this.isAnswerChecked,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TrainProcessBloc, TrainProcessState, String?>(
      selector:
          (state) =>
              state is TrainProcessInProgress ? state.selectedAnswer : null,
      builder: (context, selectedAnswer) {
        final brightness = context.watch<ThemeCubit>().state.brightness;

        return Column(
          children: [
            for (int i = 0; i < list.length; i++)
              _AnswerItem(
                answer: list[i],
                isSelected: list[i] == selectedAnswer,
                isCorrect: list[i] == correctAnswer,
                brightness: brightness,
                isAnswerChecked: isAnswerChecked,
              ),
          ],
        );
      },
    );
  }
}

class _AnswerItem extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswerChecked;
  final Brightness brightness;

  const _AnswerItem({
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.brightness,
    required this.isAnswerChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 320.w,
          child: ElevatedButton(
            style: _styleForAnswer(
              isSelected: isSelected,
              isCorrect: isCorrect,
              isAnswerChecked: isAnswerChecked,
              context: context,
            ),
            onPressed: isAnswerChecked
                ? ()
{}                : () => context.read<TrainProcessBloc>().add(
                      SelectAnswer(answer: answer),
                    ),
            child: Padding(
              padding: EdgeInsets.all(14.0.sp),
              child: Text(answer, 
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: _getTextColor(
                    brightness,
                    isSelected,
                    isCorrect,
                    isAnswerChecked,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 23.h),
      ],
    );
  }

  Color _getTextColor(
    Brightness brightness,
    bool isSelected,
    bool isCorrect,
    bool isAnswerChecked,
  ) {
    if (isAnswerChecked&&isCorrect|| isSelected||isAnswerChecked&&isSelected) {
      return Colors.white;
    }
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }
}

ButtonStyle _styleForAnswer({
  required bool isSelected,
  required bool isCorrect,
  required bool isAnswerChecked,
  required BuildContext context,
}) {
  final brightness = context.watch<ThemeCubit>().state.brightness;
  Color backgroundColor;

  if (isAnswerChecked) {
    if (isCorrect) {
      backgroundColor = Colors.green; 
    } else if (isSelected) {
      backgroundColor = Colors.red; 
    } else {
      backgroundColor = brightness == Brightness.dark
          ? colorForMaterialCardDark
          : Colors.white;
    }
  } else {
    // Before the answer is checked
    backgroundColor = isSelected
        ? Colors.blue.withOpacity(0.3) // Highlight selected answer before checking
        : (brightness == Brightness.dark
            ? colorForMaterialCardDark
            : Colors.white); // Default color if no selection
  }

  return ElevatedButton.styleFrom(
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.sp),
      side: BorderSide(
        color: isAnswerChecked
            ? Colors.transparent
            : isSelected
                ? Colors.blue
                : Colors.transparent,
        width: 2.w,
      ),
    ),
  );
}
