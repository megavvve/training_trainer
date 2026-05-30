import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/uikit/inputs/app_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({required this.controller, super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      key: const ValueKey('loginInput'),
      controller: controller,
      label: 'Логин',
      keyboardType: TextInputType.text,
      showLeftIcon: true,
      leftIcon: Icon(Icons.person_outline, size: 20, color: AppColorsExt.fill2),
      showClearButton: true,
    );
  }
}
