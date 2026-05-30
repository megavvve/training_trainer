import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/uikit/inputs/app_text_field.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({required this.controller, super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      key: const ValueKey('passwordInput'),
      controller: controller,
      label: 'Пароль',
      keyboardType: TextInputType.visiblePassword,
      showLeftIcon: true,
      leftIcon: Icon(Icons.lock_outlined, size: 20, color: AppColorsExt.fill2),
      showEyeButton: true,
    );
  }
}
