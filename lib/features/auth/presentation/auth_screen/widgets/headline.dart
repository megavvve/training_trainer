import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

/// Centered headline with optional subtitle for auth and onboarding screens.
class Headline extends StatelessWidget {
  const Headline({
    required this.title,
    super.key,
    this.subtitle,
  });
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyles.h1.copyWith(color: AppColorsExt.fill1),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: TextStyles.textSmall.copyWith(
                color: AppColorsExt.fill2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
