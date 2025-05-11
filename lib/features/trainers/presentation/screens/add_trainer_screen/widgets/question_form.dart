import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';

class QuestionsForm extends StatelessWidget {
  final TextEditingController questionController;
  final TextEditingController answerController;
  final VoidCallback addQuestion;
  final List<Question> questions;
  final Function(String) removeQuestion;

  const QuestionsForm({super.key, 
    required this.questionController,
    required this.answerController,
    required this.addQuestion,
    required this.questions,
    required this.removeQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: questionController,
          decoration: const InputDecoration(
            labelText: 'Вопрос',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: answerController,
          decoration: const InputDecoration(
            labelText: 'Правильный ответ',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.h),
        ElevatedButton(
          onPressed: addQuestion,
          child: const Text('Добавить вопрос'),
        ),
        SizedBox(height: 24.h),
        _buildQuestionsList(),
      ],
    );
  } Widget _buildQuestionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Добавленные вопросы:'),
        SizedBox(height: 8.h),
        ...questions.map((question) => Card(
          child: ListTile(
            title: Text(question.textQuestion),
            subtitle: Text('Правильный ответ: ${question.rightAnswer}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => removeQuestion(question.id.toString()),
            ),
          ),
        )),
      ],
    );
  }
}