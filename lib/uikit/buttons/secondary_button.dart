import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/uikit/buttons/custom_button.dart';

/// Secondary action button — outline style.
class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    required this.text,
    super.key,
    this.onTap,
    this.icon,
    this.width,
    this.disabled = false,
    this.isLoading = false,
  });
  final String text;
  final VoidCallback? onTap;
  final IconData? icon;
  final double? width;
  final bool disabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      disabled: disabled,
      width: width,
      baseColor: AppColorsExt.bg1,
      onTap: onTap,
      isLoading: isLoading,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColorsExt.fill1, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyles.textSemi.copyWith(color: AppColorsExt.fill1),
          ),
        ],
      ),
    );
  }
}
