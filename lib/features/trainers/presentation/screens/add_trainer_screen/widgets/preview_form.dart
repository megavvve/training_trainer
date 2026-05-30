import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class PreviewForm extends StatelessWidget {
  const PreviewForm({
    required this.title,
    required this.description,
    required this.time,
    required this.keywords,
    required this.questions,
    super.key,
  });
  final String title;
  final String description;
  final String time;
  final List<String> keywords;
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem(l10n.trainerTitle, title),
        _buildInfoItem(l10n.trainerDescription, description),
        _buildInfoItem(l10n.timeLimit, '$time сек.'),
        _buildInfoItem(l10n.keywordsTitle, keywords.join(', ')),
        const SizedBox(height: 16),
        Text(
          '${l10n.addQuestions}:',
          style: TextStyles.textSemi.copyWith(color: AppColorsExt.fill1),
        ),
        const SizedBox(height: 8),
        ...questions.map(
          (q) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• '),
                Expanded(child: Text(q.textQuestion)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
          ),
          const SizedBox(height: 2),
          Text(
            value.isEmpty ? '—' : value,
            style: TextStyles.text,
          ),
        ],
      ),
    );
  }
}
