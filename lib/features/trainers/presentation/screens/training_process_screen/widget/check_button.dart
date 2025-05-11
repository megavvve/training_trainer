import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/features/trainers/presentation/providers/train_process_bloc/train_process_bloc.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainProcessBloc, TrainProcessState>(
      builder: (context, state) {
        if (state is! TrainProcessInProgress) return const SizedBox.shrink();

        return SizedBox(
          width: 335.w,
          height: 60.h,
          child: ElevatedButton(
            onPressed: () => _handleCheckAnswer(context, state),
            style: _styleForCheckButton(state, context), 
            child: Text(
              state.isAnswerChecked ? 'Продолжить' : 'Проверка',
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  ButtonStyle _styleForCheckButton(
    TrainProcessInProgress state,
    BuildContext context,
  ) {


    return ElevatedButton.styleFrom(
      backgroundColor:
          state.selectedAnswer != null
              ? mainColorLight
              : Colors.grey, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
    );
  }

  void _handleCheckAnswer(BuildContext context, TrainProcessInProgress state) {
    if (!state.isAnswerChecked) {
      if (state.selectedAnswer == null) return;
      context.read<TrainProcessBloc>().add(CheckAnswer());

      final newState =
          context.read<TrainProcessBloc>().state as TrainProcessInProgress;
      _showResultDialog(
        context,
        newState.selectedAnswer == newState.currentQuestion.rightAnswer,
      );
    } else {
      context.read<TrainProcessBloc>().add(NextQuestion());
    }
  }

  void _showResultDialog(BuildContext context, bool isCorrect) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(isCorrect ? 'Правильно!' : 'Ошибка'),
            content: Text(isCorrect ? 'Молодец!' : 'Посмотреть правильный ответ.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
