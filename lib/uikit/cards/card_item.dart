import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';

/// Card wrapper with border radius and padding.
/// Mirrors [CardItem](uikit.md:1072).
class CardItem extends StatelessWidget {
  const CardItem({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorsExt.bg1,
        borderRadius: borderRadius,
        border: Border.all(color: AppColorsExt.border2, width: 1),
      ),
      padding: padding,
      child: child,
    );
  }
}
