import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/inputs/app_text_field.dart';

class PreviewForm extends StatelessWidget {
  const PreviewForm({
    required this.title,
    required this.description,
    required this.time,
    required this.keywords,
    required this.questions,
    this.titleController,
    this.descriptionController,
    this.timeController,
    this.timeUnitMinutes = true,
    this.onTimeUnitChanged,
    this.onTitleChanged,
    this.onDescriptionChanged,
    this.onTimeChanged,
    super.key,
  });
  final String title;
  final String description;
  final String time;
  final List<String> keywords;
  final List<Question> questions;

  // Editable controllers
  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  final TextEditingController? timeController;
  final bool timeUnitMinutes;
  final ValueChanged<bool>? onTimeUnitChanged;
  final ValueChanged<String>? onTitleChanged;
  final ValueChanged<String>? onDescriptionChanged;
  final ValueChanged<String>? onTimeChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Editable info section
        Text(
          l10n.mainInfo,
          style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
        ),
        const SizedBox(height: 12),

        // Title (editable)
        if (titleController != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CustomTextField(
              label: l10n.trainerTitle,
              controller: titleController,
              onChanged: onTitleChanged,
            ),
          )
        else
          _buildInfoItem(l10n.trainerTitle, title),

        // Description (editable)
        if (descriptionController != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CustomTextField(
              label: l10n.trainerDescription,
              controller: descriptionController,
              onChanged: onDescriptionChanged,
            ),
          )
        else
          _buildInfoItem(l10n.trainerDescription, description),

        // Time (editable)
        if (timeController != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: l10n.enterTime,
                    controller: timeController,
                    keyboardType: TextInputType.number,
                    onChanged: onTimeChanged,
                  ),
                ),
                const SizedBox(width: 12),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('мин')),
                    ButtonSegment(value: false, label: Text('сек')),
                  ],
                  selected: {timeUnitMinutes},
                  onSelectionChanged: (v) => onTimeUnitChanged?.call(v.first),
                ),
              ],
            ),
          )
        else
          _buildInfoItem(l10n.timeLimit, time.isEmpty ? '—' : '$time ${_timeUnitLabel(time)}'),

        _buildInfoItem(l10n.keywordsTitle, keywords.isEmpty ? '—' : keywords.join(', ')),
        const Divider(height: 32),
        // Questions section
        Text(
          '${l10n.addQuestions} (${questions.length}):',
          style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
        ),
        const SizedBox(height: 12),
        if (questions.isEmpty)
          Text(
            'No questions yet',
            style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill3),
          )
        else
          ...questions.asMap().entries.map((entry) {
            final index = entry.key;
            final q = entry.value;
            final wrongAnswers = q.answers
                .where((a) => a.isNotEmpty && a != q.rightAnswer)
                .toList();

            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColorsExt.bg0,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColorsExt.border1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColorsExt.primaryContainer,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: AppColorsExt.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          q.textQuestion.isEmpty ? '(empty)' : q.textQuestion,
                          style: TextStyles.textSemi.copyWith(color: AppColorsExt.fill1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.check_circle, size: 16, color: AppColorsExt.primary),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          q.rightAnswer,
                          style: TextStyles.textSmall.copyWith(color: AppColorsExt.primary),
                        ),
                      ),
                    ],
                  ),
                  if (wrongAnswers.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    ...wrongAnswers.map(
                      (wa) => Padding(
                        padding: const EdgeInsets.only(bottom: 2, left: 22),
                        child: Row(
                          children: [
                            Icon(Icons.close, size: 14, color: AppColorsExt.error),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                wa,
                                style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '—' : value,
              style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
            ),
          ),
        ],
      ),
    );
  }

  String _timeUnitLabel(String timeStr) {
    final parsed = int.tryParse(timeStr);
    if (parsed != null && parsed <= 120) return 'min';
    return 'sec';
  }
}
