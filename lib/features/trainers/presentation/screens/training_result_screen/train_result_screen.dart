import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/features/trainers/presentation/providers/train_process_bloc/train_process_bloc.dart';
import 'package:training_trainer/routing/app_routes.dart';

class TrainingResultScreen extends StatelessWidget {
  const TrainingResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = context.watch<ThemeCubit>().state.brightness;

    return Scaffold(
      backgroundColor:
          brightness == Brightness.dark
              ? backgroundColorDark
              : backgroundColorLight,
      appBar: AppBar(
        backgroundColor:
            brightness == Brightness.dark
                ? backgroundColorDark
                : backgroundColorLight,
        title: const Text('Результат тренировки'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          context.pop();

          return true;
        },
        child: BlocBuilder<TrainProcessBloc, TrainProcessState>(
          builder: (context, state) {
            if (state is TrainProcessCompleted) {
              // Получаем данные из состояния
              final correctAnswers = state.correctAnswers;
              final totalQuestions = state.totalQuestions;

              // Текст поздравления
              final randomResultingText = getRandomCongratulations();

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 100.0.sp,
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Text(
                        randomResultingText,
                        style: TextStyle(fontSize: 20.0.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.0.h),
                      Text(
                        "Количество правильных",
                        style: TextStyle(color: Colors.green, fontSize: 20.sp),
                      ),
                      Text(
                        "ответов: $correctAnswers",
                        style: TextStyle(color: Colors.green, fontSize: 20.sp),
                      ),
                      SizedBox(height: 80.h),
                      Text(
                        "Количество неправильных",
                        style: TextStyle(color: Colors.red, fontSize: 20.sp),
                      ),
                      Text(
                        "ответов: ${totalQuestions - correctAnswers}",
                        style: TextStyle(color: Colors.red, fontSize: 20.sp),
                      ),
                      SizedBox(height: 80.0.h),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                brightness == Brightness.dark
                                    ? colorForButton
                                    : mainColorLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.sp,
                              vertical: 12.sp,
                            ),
                          ),
                          onPressed: () {
                            while (context.canPop()) {
                              context.pop();
                            }
                            context.go(AppRoutes.trainers);
                          },
                          child: Text(
                            'Продолжить',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // В случае, если результат тренировки еще не получен
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  String getRandomCongratulations() {
    final List<String> congratulationsList = [
      "Поздравляем! Вы успешно завершили тренажер. Продолжайте развиваться в выбранной области!",
      "Отличная работа! Теперь у вас ещё больше знаний в вашем арсенале. Применяйте их с уверенностью!",
      "Вы завершили тренажер. Не забывайте, что каждый вопрос - шаг к вашему успеху!",
      "Браво! Теперь вы стали на шаг ближе к мастерству в этой области. Продолжайте в том же духе!",
      "Тренажер пройден успешно! Ваши усилия приносят результаты. Уверены, что вы готовы к новым вызовам!",
    ];

    final random = Random();
    final randomIndex = random.nextInt(congratulationsList.length);

    return congratulationsList[randomIndex];
  }
}
