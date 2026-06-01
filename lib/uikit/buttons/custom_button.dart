import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';

/// Base button with press effect and loading state.
class CustomButton extends StatefulWidget {
  const CustomButton({
    required this.onTap,
    required this.child,
    super.key,
    this.baseColor,
    this.width,
    this.disabled = false,
    this.isLoading = false,
  });
  final VoidCallback? onTap;
  final Widget child;
  final Color? baseColor;
  final double? width;
  final bool disabled;
  final bool isLoading;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.disabled
        ? AppColorsExt.primaryDis
        : (widget.baseColor ?? AppColorsExt.primary);

    final opacity = _isPressed ? 0.8 : 1.0;

    return GestureDetector(
      onTapDown: widget.disabled || widget.isLoading
          ? null
          : (_) => setState(() => _isPressed = true),
      onTapUp: widget.disabled || widget.isLoading
          ? null
          : (_) => setState(() => _isPressed = false),
      onTapCancel: widget.disabled || widget.isLoading
          ? null
          : () => setState(() => _isPressed = false),
      onTap: widget.disabled || widget.isLoading ? null : widget.onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: opacity,
        child: Container(
          width: widget.width,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: widget.isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColorsExt.onPrimary,
                    ),
                  ),
                )
              : widget.child,
        ),
      ),
    );
  }
}
