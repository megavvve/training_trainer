import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

/// Secondary action button — outlined style with border.
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
    return SizedBox(
      width: width,
      height: 48,
      child: OutlinedButton(
        onPressed: disabled || isLoading ? null : onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorsExt.primary,
          disabledForegroundColor: AppColorsExt.fill3,
          side: BorderSide(
            color: disabled ? AppColorsExt.border2 : AppColorsExt.primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColorsExt.primary),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyles.textSemi,
                  ),
                ],
              ),
      ),
    );
  }
}
