import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/buttons/secondary_button.dart';

class QuestionsForm extends StatelessWidget {
  const QuestionsForm({
    required this.questionController,
    required this.answerController,
    required this.addQuestion,
    required this.questions,
    required this.removeQuestion,
    super.key,
  });
  final TextEditingController questionController;
  final TextEditingController answerController;
  final VoidCallback addQuestion;
  final List<Question> questions;
  final Function(String) removeQuestion;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextField(
          controller: questionController,
          decoration: InputDecoration(
            labelText: l10n.question,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: answerController,
          decoration: InputDecoration(
            labelText: l10n.correctAnswer,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        AppSecondaryButton(
          onTap: addQuestion,
          text: l10n.addQuestionBtn,
          width: double.infinity,
          icon: Icons.add,
        ),
        const SizedBox(height: 24),
        _buildQuestionsList(context),
      ],
    );
  }

  Widget _buildQuestionsList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (questions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.addedQuestions}:',
          style: TextStyles.textSemi.copyWith(color: AppColorsExt.fill1),
        ),
        const SizedBox(height: 12),
        ...questions.map(
          (question) => Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              title: Text(
                question.textQuestion,
                style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
              ),
              subtitle: Text(
                '${l10n.correctAnswer}: ${question.rightAnswer}',
                style: TextStyles.textSmall.copyWith(
                  color: AppColorsExt.positive,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => removeQuestion(question.id.toString()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
