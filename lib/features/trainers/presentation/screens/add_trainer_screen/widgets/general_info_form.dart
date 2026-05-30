import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class GeneralInfoForm extends StatelessWidget {
  const GeneralInfoForm({
    required this.titleController,
    required this.descriptionController,
    required this.timeController,
    required this.formKey,
    super.key,
  });
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController timeController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Заголовок',
              border: OutlineInputBorder(),
            ),
            validator: (value) => value!.isEmpty ? l10n.enterTitle : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Описание',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: timeController,
            decoration: const InputDecoration(
              labelText: 'Время (сек)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? l10n.enterTime : null,
          ),
        ],
      ),
    );
  }
}
