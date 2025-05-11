import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/presentation/providers/train_process_bloc/train_process_bloc.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_process_screen/widget/answer_and_question.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_process_screen/widget/check_button.dart';
import 'package:training_trainer/features/trainers/presentation/screens/training_process_screen/widget/confirmation_dialog.dart';
import 'package:training_trainer/routing/app_routes.dart';

class TrainProcessScreen extends StatefulWidget {
  final Trainer trainer;
  const TrainProcessScreen({super.key, required this.trainer});

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
    final brightness = context.watch<ThemeCubit>().state.brightness;

    return BlocListener<TrainProcessBloc, TrainProcessState>(
      listener: (context, state) {
        if (state is TrainProcessCompleted) {
          context.push(AppRoutes.trainingResult);
        }
      },
      child: Scaffold(
        backgroundColor:
            brightness == Brightness.dark
                ? backgroundColorDark
                : backgroundColorLight,
        body: WillPopScope(
          onWillPop: () async => _handleBackPressed(context),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _buildAppBar(context, widget.trainer),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: EdgeInsets.only(bottom: 100.h),
                        child: AnswersAndQuestion(),
                      ),
                    ]),
                  ),
                ],
              ),
              Positioned(
                bottom: 40.h,
                left: 20.w,
                right: 20.w,
                child: const CheckButton(),
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
      FinishTrainingSession(correctAnswers: 0),
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
    collapsedHeight: 80.h,
    backgroundColor:
        context.watch<ThemeCubit>().state.brightness == Brightness.dark
            ? backgroundColorDark
            : backgroundColorLight,
    leading: IconButton(
      icon: const Icon(Icons.close),
      onPressed: () => _handleBackPressed(context),
    ),
    title: Text(trainer.title, style: TextStyle(fontSize: 18.sp)),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(10.h),
      child: BlocBuilder<TrainProcessBloc, TrainProcessState>(
        builder: (context, state) {
          final progress =
              state is TrainProcessInProgress
                  ? (state.isAnswerChecked)?(state.currentQuestionIndex+1) / trainer.questions.length:(state.currentQuestionIndex) / trainer.questions.length
                  : 0.0;
          final remainingTime =
              state is TrainProcessInProgress ? state.remainingTime : 0;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 8.h),
                child: LinearProgressIndicator(
                  value: progress,
                  valueColor: AlwaysStoppedAnimation<Color>(mainColorLight),
                ),
              ),
              _buildTimer(remainingTime),
              SizedBox(height: 8.h),
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
    style: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: mainColorLight,
    ),
  );
}
