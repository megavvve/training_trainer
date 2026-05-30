import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

/// Modal bottom sheet with drag handle and optional title/subtitle.
/// Mirrors [showCustomBottomSheet](uikit.md:928).
Future<T?> showCustomBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  String? subtitle,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.9,
    ),
    builder: (ctx) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: AnimatedPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          duration: const Duration(milliseconds: 100),
          child: _BottomSheetWrapper(
            title: title,
            subtitle: subtitle,
            child: child,
          ),
        ),
      );
    },
  );
}

class _BottomSheetWrapper extends StatelessWidget {
  const _BottomSheetWrapper({required this.child, this.title, this.subtitle});
  final Widget child;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      color: AppColorsExt.bg1,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: MediaQuery.of(context).viewPadding.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DragHandle(),
            if ((title?.isNotEmpty ?? false) ||
                (subtitle?.isNotEmpty ?? false)) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title?.isNotEmpty ?? false)
                      Text(
                        title!,
                        style: TextStyles.h3.copyWith(
                          color: AppColorsExt.fill1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    if ((title?.isNotEmpty ?? false) &&
                        (subtitle?.isNotEmpty ?? false))
                      const SizedBox(height: 4),
                    if (subtitle?.isNotEmpty ?? false)
                      Text(
                        subtitle!,
                        style: TextStyles.textSReg.copyWith(
                          color: AppColorsExt.fill2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ],
            Flexible(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: SafeArea(top: false, child: child),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 5,
        width: 64,
        decoration: BoxDecoration(
          color: AppColorsExt.border3,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
