import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';

/// Centered loading indicator for full-page loading states.
class PageLoader extends StatelessWidget {
  const PageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColorsExt.primary,
      ),
    );
  }
}
