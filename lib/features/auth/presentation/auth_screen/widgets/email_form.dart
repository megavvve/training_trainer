import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/uikit/inputs/app_text_field.dart';

class EmailForm extends StatelessWidget {
  const EmailForm({required this.controller, super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      key: const ValueKey('emailInput'),
      controller: controller,
      label: 'Почта',
      keyboardType: TextInputType.emailAddress,
      showLeftIcon: true,
      leftIcon: Icon(Icons.email_outlined, size: 20, color: AppColorsExt.fill2),
      showClearButton: true,
    );
  }
}
