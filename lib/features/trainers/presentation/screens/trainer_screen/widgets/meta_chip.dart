import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

class MetaChip extends StatelessWidget {
  const MetaChip(this.icon, this.text, {super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColorsExt.fill2),
        const SizedBox(width: 4),
        Text(text, style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2)),
      ],
    );
  }
}
