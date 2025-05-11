import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/routing/app_routes.dart';
import 'package:training_trainer/uikit/modal/custom_modal_bottom_sheet.dart';

class TrainerCard extends StatelessWidget {
  final Trainer trainer;

  const TrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    final isDark =
        context.watch<ThemeCubit>().state.brightness == Brightness.dark;
    final theme = Theme.of(context);
    final timeText = '${(trainer.timeRequiredInSeconds / 60).ceil()} мин';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Card(
        elevation: 2,
        color: isDark ? colorForMaterialCardDark : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
          side: BorderSide(
            color:
                isDark
                    ? mainColorDark.withOpacity(0.2)
                    : mainColorLight.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      trainer.title,
                      style: theme.textTheme.displaySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Icon(
                    Icons.school_rounded,
                    color: isDark ? mainColorDark : mainColorLight,
                    size: 28,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              Wrap(
                spacing: 16.h,
                runSpacing: 8.h,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _buildMetaItem(
                    context,
                    icon: Icons.question_answer_rounded,
                    value:
                        trainer.questions.length
                            .toString(), // Количество вопросов
                    isDark: isDark,
                  ),
                  _buildMetaItem(
                    context,
                    icon: Icons.access_time_rounded,
                    value: timeText,
                    isDark: isDark,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              Text(
                trainer.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildKeywords(context, isDark),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                trainer.title,
                                style: theme.textTheme.displayMedium,
                              ),
                            ),
                            SizedBox(height: 24.h),

                            Text(
                              trainer.keywords.join(", "),
                              textAlign: TextAlign.start,
                              style: theme.textTheme.bodyLarge,
                            ),
                            SizedBox(height: 10.h),

                            Text(
                              'Описание:',
                              style: theme.textTheme.displaySmall,
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              trainer.description,
                              textAlign: TextAlign.start,
                              style: theme.textTheme.bodyLarge,
                            ),
                            SizedBox(height: 30.h),

                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                child: Text('Поехали!'),
                                onPressed: () {
                                  context.pop();
                                  GoRouter.of(context).push(
                                    AppRoutes.trainingProcess,
                                    extra: trainer,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: isDark ? mainColorDark : mainColorLight,
                      backgroundColor: isDark ? mainColorDark : mainColorLight,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 10.h,
                      ),
                    ),
                    child: const Text(
                      'Начать',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required bool isDark,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.sp, color: isDark ? mainColorDark : thirdColor),
        SizedBox(width: 6.w),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildKeywords(BuildContext context, bool isDark) {
    const maxKeywords = 3;
    final overflowCount = trainer.keywords.length - maxKeywords;

    return Wrap(
      spacing: 8.h,
      runSpacing: 8.h,
      children: [
        ...trainer.keywords
            .take(maxKeywords)
            .map(
              (keyword) => Chip(
                label: Text(keyword),
                labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isDark ? mainColorDark : mainColorLight,
                ),
                backgroundColor:
                    isDark ? colorForFindTextDark : secondColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
              ),
            ),
        if (overflowCount > 0)
          Chip(
            label: Text('+$overflowCount'),
            labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isDark ? mainColorDark : mainColorLight,
            ),
            backgroundColor: isDark ? colorForFindTextDark : secondColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.sp),
            ),
          ),
      ],
    );
  }
}
