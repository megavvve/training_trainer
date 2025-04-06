import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';

class TrainerCard extends StatelessWidget {
  final Trainer trainer;

  const TrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 15.h),
      child: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200.w,
                  child: Text(
                    trainer.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Chip(
                  label: Text('${trainer.timeRequiredInSeconds ~/ 60} мин'),
                ),
              ],
            ),
             SizedBox(height: 8.h),
            Wrap(
              spacing: 8.0.w,
              children: trainer.keywords
                  .map(
                    (keyword) => Chip(
                      label: Text(keyword),
                    ),
                  )
                  .toList(),
            ),
             SizedBox(height: 8.h),
            Text(
              trainer.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
             SizedBox(height: 8.h),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text('${trainer.starCount.toStringAsFixed(1)}/5.0'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}