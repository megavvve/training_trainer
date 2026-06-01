import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/buttons/primary_button.dart';
import 'package:training_trainer/uikit/buttons/secondary_button.dart';
import 'package:training_trainer/uikit/cards/card_item.dart';
import 'package:training_trainer/uikit/inputs/app_text_field.dart';

class QuestionsForm extends StatelessWidget {
  const QuestionsForm({
    required this.questionController,
    required this.answerController,
    required this.addQuestion,
    required this.questions,
    required this.removeQuestion,
    required this.onUpdateQuestion,
    this.addFormFirst = false,
    super.key,
  });
  final TextEditingController questionController;
  final TextEditingController answerController;
  final VoidCallback addQuestion;
  final List<Question> questions;
  final Function(String) removeQuestion;
  final Function(String id, String text, String rightAnswer, List<String> answers) onUpdateQuestion;
  final bool addFormFirst;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Add new question form ──
        if (addFormFirst) ...[
          CardItem(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.addQuestionBtn,
                  style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: l10n.question,
                  controller: questionController,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: l10n.correctAnswer,
                  controller: answerController,
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  text: l10n.addQuestionBtn,
                  onTap: addQuestion,
                  width: double.infinity,
                  icon: Icons.add,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],

        // ── Existing questions list ──
        _buildQuestionsList(context),

        // ── Add form below (for auto mode) ──
        if (!addFormFirst) ...[
          const SizedBox(height: 24),
          CardItem(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.addQuestionBtn,
                  style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: l10n.question,
                  controller: questionController,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: l10n.correctAnswer,
                  controller: answerController,
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  text: l10n.addQuestionBtn,
                  onTap: addQuestion,
                  width: double.infinity,
                  icon: Icons.add,
                ),
              ],
            ),
          ),
        ],
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
          '${l10n.addedQuestions} (${questions.length}):',
          style: TextStyles.textSemi.copyWith(color: AppColorsExt.fill1),
        ),
        const SizedBox(height: 12),
        ...questions.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final question = entry.value;
            final wrongAnswers = question.answers
                .where((a) => a.isNotEmpty && a != question.rightAnswer)
                .toList();

            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColorsExt.border1),
              ),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                leading: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColorsExt.primaryContainer,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: AppColorsExt.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                title: Text(
                  question.textQuestion.isEmpty ? '(empty question)' : question.textQuestion,
                  style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${l10n.correctAnswer}: ${question.rightAnswer}',
                  style: TextStyles.textSmall.copyWith(color: AppColorsExt.primary),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => removeQuestion(question.id),
                ),
                children: [
                  if (wrongAnswers.isNotEmpty) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Wrong answers:',
                        style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...wrongAnswers.map(
                      (wa) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(Icons.close, size: 14, color: AppColorsExt.error),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                wa,
                                style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  // Edit button
                SizedBox(
                  width: double.infinity,
                  child: AppSecondaryButton(
                    onTap: () => _editQuestion(context, question),
                    text: 'Edit',
                    icon: Icons.edit,
                  ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _editQuestion(BuildContext context, Question question) {
    final l10n = AppLocalizations.of(context)!;
    final textCtrl = TextEditingController(text: question.textQuestion);
    final answerCtrl = TextEditingController(text: question.rightAnswer);
    final wrongCtrls = question.answers
        .where((a) => a.isNotEmpty && a != question.rightAnswer)
        .map((a) => TextEditingController(text: a))
        .toList();

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColorsExt.bg1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit Question', style: TextStyles.h3),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Question',
                  controller: textCtrl,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: 'Correct Answer',
                  controller: answerCtrl,
                ),
                const SizedBox(height: 12),
                Text('Wrong Answers:', style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2)),
                const SizedBox(height: 8),
                ...List.generate(3, (i) {
                  if (i >= wrongCtrls.length) {
                    wrongCtrls.add(TextEditingController());
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CustomTextField(
                      label: 'Wrong answer ${i + 1}',
                      controller: wrongCtrls[i],
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppSecondaryButton(
                        text: 'Cancel',
                        onTap: () => Navigator.pop(ctx),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppPrimaryButton(
                        text: 'Save',
                        onTap: () {
                          final newAnswers = [
                            answerCtrl.text,
                            ...wrongCtrls.map((c) => c.text).where((t) => t.isNotEmpty),
                          ];
                          onUpdateQuestion(
                            question.id,
                            textCtrl.text,
                            answerCtrl.text,
                            newAnswers,
                          );
                          Navigator.pop(ctx);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
