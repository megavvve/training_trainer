import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/buttons/secondary_button.dart';
import 'package:training_trainer/uikit/inputs/app_text_field.dart';

class KeywordsForm extends StatelessWidget {
  const KeywordsForm({
    required this.keywordsController,
    required this.keywords,
    required this.addKeyword,
    required this.removeKeyword,
    super.key,
  });
  final TextEditingController keywordsController;
  final List<String> keywords;
  final Function(String) addKeyword;
  final Function(String) removeKeyword;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CustomTextField(
                label: l10n.keywordsTitle,
                controller: keywordsController,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 48,
              child: AppSecondaryButton(
                onTap: () {
                  if (keywordsController.text.isNotEmpty) {
                    addKeyword(keywordsController.text.trim());
                    keywordsController.clear();
                  }
                },
                text: l10n.add,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: keywords
              .map(
                (keyword) => Chip(
                  label: Text(
                    keyword,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () => removeKeyword(keyword),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
