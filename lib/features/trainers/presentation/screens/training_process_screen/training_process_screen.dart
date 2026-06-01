import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/domain/state/train_process_bloc/train_process_bloc.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_process_screen/widget/answer_and_question.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_process_screen/widget/check_button.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_process_screen/widget/confirmation_dialog.dart';
import 'package:training_trainer/routing/app_routes.dart';

class TrainProcessScreen extends StatefulWidget {
  const TrainProcessScreen({required this.trainer, super.key});
  final Trainer trainer;

  @override
  State<TrainProcessScreen> createState() => _TrainProcessScreenState();
}

class _TrainProcessScreenState extends State<TrainProcessScreen> {
  @override
  void initState() {
    context.read<TrainProcessBloc>().add(
          StartTrainingSession(trainer: widget.trainer),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrainProcessBloc, TrainProcessState>(
      listener: (context, state) {
        if (state is TrainProcessCompleted) {
          context.push(AppRoutes.trainingResult);
        }
      },
      child: Scaffold(
        backgroundColor: AppColorsExt.bg0,
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              _handleBackPressed(context);
            }
          },
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _buildAppBar(context, widget.trainer),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const Padding(
                        padding: EdgeInsets.only(bottom: 100),
                        child: AnswersAndQuestion(),
                      ),
                    ]),
                  ),
                ],
              ),
              const Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: CheckButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _handleBackPressed(BuildContext context) async {
  final result = await showDialog(
    context: context,
    builder: (context) => const ConfirmationDialog(),
  );
  if (result == true) {
    if (!context.mounted) {
      return false;
    }
    final bloc = context.read<TrainProcessBloc>();
    final state = bloc.state;
    // If user hasn't answered anything on first question — just exit, no stats recorded
    if (state is TrainProcessInProgress &&
        state.currentQuestionIndex == 0 &&
        !state.isAnswerChecked &&
        state.selectedAnswer == null) {
      context.pop();
    } else {
      // Let the BLoC properly calculate correct/incorrect/unanswered stats
      bloc.add(const FinishTrainingSession(
        correctAnswers: 0,
        unansweredCount: 0,
      ));
      context.pop();
    }
    return true;
  }
  return false;
}

SliverAppBar _buildAppBar(BuildContext context, Trainer trainer) {
  return SliverAppBar(
    centerTitle: true,
    pinned: true,
    snap: true,
    floating: true,
    surfaceTintColor: Colors.transparent,
    collapsedHeight: 80,
    backgroundColor: AppColorsExt.bg1,
    leading: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColorsExt.bg3,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.close, size: 18),
          onPressed: () => _handleBackPressed(context),
        ),
      ),
    ),
    title: Text(trainer.title, style: TextStyles.h3),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(10),
      child: BlocBuilder<TrainProcessBloc, TrainProcessState>(
        builder: (context, state) {
          final progress = state is TrainProcessInProgress
              ? (state.isAnswerChecked
                  ? (state.currentQuestionIndex + 1) / state.totalQuestions
                  : state.currentQuestionIndex / state.totalQuestions)
              : 0.0;
          final remainingTime =
              state is TrainProcessInProgress ? state.remainingTime : 0;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColorsExt.bg3,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColorsExt.primary),
                      minHeight: 4,
                    ),
                  ),
                ),
                if (remainingTime > 0) _buildTimer(remainingTime),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget _buildTimer(int seconds) {
  final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
  final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
  final isLow = seconds <= 60;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: isLow ? AppColorsExt.errorContainer : AppColorsExt.primaryContainer,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isLow ? Icons.timer_off : Icons.timer_outlined,
          size: 16,
          color: isLow ? AppColorsExt.error : AppColorsExt.primary,
        ),
        const SizedBox(width: 6),
        Text(
          '$minutes:$remainingSeconds',
          style: TextStyles.textSemi.copyWith(
            color: isLow ? AppColorsExt.error : AppColorsExt.primary,
          ),
        ),
      ],
    ),
  );
}
