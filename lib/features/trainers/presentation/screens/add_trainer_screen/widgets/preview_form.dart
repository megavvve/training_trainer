import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';

class PreviewForm extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final List<String> keywords;
  final List<Question> questions;

  const PreviewForm({super.key, 
    required this.title,
    required this.description,
    required this.time,
    required this.keywords,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Название: $title'),
        Text('Описание: $description'),
        Text('Время: $time минут'),
        Text('Ключевые слова: ${keywords.join(", ")}'),
        SizedBox(height: 16.h),
        const Text('Вопросы:'),
        ...questions.map((q) => Text('- ${q.textQuestion}')),
      ],
    );
  }
}
