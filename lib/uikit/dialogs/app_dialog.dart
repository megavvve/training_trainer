import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

/// Modal dialog with title, subtitle, and action buttons.
class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.content,
    this.title,
    this.subtitle,
    super.key,
  });

  final String? title;
  final String? subtitle;
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double maxWidth = (size.width - 32).clamp(0, 500);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            minWidth: 280,
          ),
          child: Material(
            color: AppColorsExt.bg1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title?.isNotEmpty ?? false) ...[
                    Text(
                      title!,
                      style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (subtitle?.isNotEmpty ?? false) ...[
                    Text(
                      subtitle!,
                      style: TextStyles.textSmall.copyWith(
                        color: AppColorsExt.fill2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                  ],
                  ...content,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
