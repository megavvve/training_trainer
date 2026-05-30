import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/presentation/providers/train_process_bloc/train_process_bloc.dart';
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
        backgroundColor: AppColorsExt.bg2,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: const AnswersAndQuestion(),
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
    context.read<TrainProcessBloc>().add(
          const FinishTrainingSession(correctAnswers: 0),
        );
    context.pop();
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
    backgroundColor: AppColorsExt.bg2,
    leading: IconButton(
      icon: const Icon(Icons.close),
      onPressed: () => _handleBackPressed(context),
    ),
    title: Text(trainer.title, style: TextStyles.h3),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(10),
      child: BlocBuilder<TrainProcessBloc, TrainProcessState>(
        builder: (context, state) {
          final progress = state is TrainProcessInProgress
              ? (state.isAnswerChecked
                  ? (state.currentQuestionIndex + 1) / trainer.questions.length
                  : state.currentQuestionIndex / trainer.questions.length)
              : 0.0;
          final remainingTime =
              state is TrainProcessInProgress ? state.remainingTime : 0;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: LinearProgressIndicator(
                  value: progress,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColorsExt.primary),
                ),
              ),
              _buildTimer(remainingTime),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildTimer(int seconds) {
  final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
  final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');

  return Text(
    '$minutes:$remainingSeconds',
    style: TextStyles.h3.copyWith(color: AppColorsExt.primary),
  );
}
