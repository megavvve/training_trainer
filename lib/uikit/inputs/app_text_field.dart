import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

/// Text field with floating label, eye button, clear button, and icon support.
/// Mirrors the reference UIKit [CustomTextField](uikit.md:539).
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.label,
    super.key,
    this.text = '',
    this.errorText = '',
    this.showLeftIcon = false,
    this.showClearButton = false,
    this.showEyeButton = false,
    this.isSuccess = false,
    this.leftIcon,
    this.controller,
    this.isDisabled = false,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String text;
  final String errorText;
  final bool showLeftIcon;
  final bool showClearButton;
  final bool showEyeButton;
  final bool isSuccess;
  final Widget? leftIcon;
  final TextEditingController? controller;
  final bool isDisabled;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isInternalController = false;

  @override
  void initState() {
    super.initState();
    _isInternalController = widget.controller == null;
    _controller =
        widget.controller ?? TextEditingController(text: widget.text);
    _focusNode = FocusNode()..addListener(() {
      if (mounted) setState(() {});
    });
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
        widget.onChanged?.call(_controller.text);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasFocus = _focusNode.hasFocus;
    final hasError = widget.errorText.isNotEmpty;
    final isDisabled = widget.isDisabled;
    final hasText = _controller.text.isNotEmpty;
    final isFloating = hasText || hasFocus;

    final Color borderCol = _getBorderColor(hasError, hasFocus);
    final Color fillCol = _getFillColor(isDisabled);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            TextField(
              obscuringCharacter: '•',
              controller: _controller,
              focusNode: _focusNode,
              enabled: !isDisabled,
              keyboardType: widget.keyboardType,
              obscureText: widget.showEyeButton && !_isPasswordVisible,
              textAlignVertical: TextAlignVertical.bottom,
              style: isDisabled
                  ? TextStyles.text.copyWith(color: AppColorsExt.fill2)
                  : TextStyles.text.copyWith(color: AppColorsExt.fill1),
              decoration: InputDecoration(
                isDense: false,
                contentPadding: EdgeInsets.only(
                  left: widget.showLeftIcon ? 0 : 16,
                  right: 8,
                  top: (isFloating && widget.label.isNotEmpty) ? 24 : 16,
                  bottom: (isFloating && widget.label.isNotEmpty) ? 8 : 16,
                ),
                filled: true,
                fillColor: fillCol,
                border: _outlineBorder(borderCol),
                enabledBorder: _outlineBorder(borderCol),
                focusedBorder: _outlineBorder(borderCol),
                errorBorder: _outlineBorder(borderCol),
                focusedErrorBorder: _outlineBorder(borderCol),
                errorText: null,
                hintText: null,
                prefixIcon: widget.showLeftIcon
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 8,
                          top: 0,
                        ),
                        child: widget.leftIcon ??
                            Icon(Icons.person_outline,
                                size: 20, color: AppColorsExt.fill2),
                      )
                    : null,
                prefixIconConstraints: widget.showLeftIcon
                    ? const BoxConstraints(minWidth: 0, minHeight: 0)
                    : null,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isDisabled && widget.showEyeButton)
                        _EyeButton(
                          isPasswordVisible: _isPasswordVisible,
                          onPressed: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible,
                          ),
                        ),
                      if (!isDisabled && widget.showClearButton && hasText)
                        _ClearButton(
                          onPressed: () {
                            setState(() => _controller.clear());
                            widget.onChanged?.call('');
                          },
                        ),
                      if (!isDisabled && widget.isSuccess)
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.light.positive,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
              ),
            ),

            // Floating label
            AnimatedPositioned(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              top: isFloating ? 6 : null,
              left: widget.showLeftIcon ? 48 : 16,
              right: 0,
              child: isFloating && widget.label.isNotEmpty
                  ? Text(
                      '${widget.label}:',
                      style: TextStyles.textSmall.copyWith(
                        fontSize: 12,
                        color: isDisabled
                            ? AppColorsExt.fill2
                            : hasError
                                ? AppColorsExt.negative
                                : hasFocus
                                    ? AppColorsExt.primary
                                    : AppColorsExt.fill1,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            // Placeholder label when not floating
            if (!isFloating && widget.label.isNotEmpty)
              Positioned(
                left: widget.showLeftIcon ? 48 : 16,
                right: 0,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IgnorePointer(
                    child: Text(
                      widget.label,
                      style: TextStyles.textReg.copyWith(
                        color:
                            isDisabled ? AppColorsExt.fill2 : AppColorsExt.fill1,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),

        if (hasError) ...[
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.errorText,
              style: TextStyle(
                color: widget.isSuccess
                    ? AppColorsExt.positive
                    : AppColorsExt.negative,
                fontSize: 12,
              ),
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ],
    );
  }

  OutlineInputBorder _outlineBorder(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color, width: 1.5),
      );

  Color _getBorderColor(bool hasError, bool hasFocus) {
    if (widget.isDisabled) return AppColorsExt.border1;
    if (widget.isSuccess && hasError) return AppColorsExt.positive;
    if (hasError) return AppColorsExt.negative;
    if (hasFocus) return AppColorsExt.primary;
    return AppColorsExt.border2;
  }

  Color _getFillColor(bool isDisabled) {
    if (isDisabled) return AppColorsExt.bg3;
    return AppColorsExt.bg1;
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        child: Icon(Icons.close, size: 19, color: AppColorsExt.fill2),
      );
}

class _EyeButton extends StatelessWidget {
  const _EyeButton({
    required this.isPasswordVisible,
    required this.onPressed,
  });
  final bool isPasswordVisible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        child: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          size: 19,
          color: AppColorsExt.fill2,
        ),
      );
}
