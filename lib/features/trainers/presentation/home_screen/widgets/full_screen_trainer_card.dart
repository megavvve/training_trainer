import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';

class FullScreenTrainerCard extends StatelessWidget {
  final Trainer trainer;

  const FullScreenTrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade800, Colors.blue.shade200],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              trainer.title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: Center(
                child: Text(
                  '${trainer.questions.length} вопросов',
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12.0.w,
              children: [
                Column(
                  children: [
                    Icon(Icons.timer, color: Colors.white, size: 32.h),
                    Text(
                      '${trainer.timeRequiredInSeconds ~/ 60} мин',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 32.h),
                    Text(
                      trainer.starCount.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
              ),
              onPressed: () {},
              child: Text(
                'Начать тренировку',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
