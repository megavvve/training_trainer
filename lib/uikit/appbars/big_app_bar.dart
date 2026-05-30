import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

/// Clean app bar with optional back button and title.
/// Academic style — no colored background.
class BigAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BigAppBar({
    super.key,
    this.title,
    this.actions,
    this.useBackButton = false,
    this.onBackTap,
  });
  final String? title;
  final List<Widget>? actions;
  final bool useBackButton;
  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      titleSpacing: useBackButton ? 0 : 18,
      elevation: 0,
      backgroundColor: AppColorsExt.bg1,
      automaticallyImplyLeading: useBackButton,
      iconTheme: IconThemeData(color: AppColorsExt.fill1),
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      title: title == null
          ? null
          : Padding(
              padding: EdgeInsets.only(left: useBackButton ? 0 : 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title!,
                  style: TextStyles.h1.copyWith(color: AppColorsExt.fill1),
                ),
              ),
            ),
      actions: actions != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions!,
                ),
              ),
            ]
          : null,
      leading: useBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: onBackTap ?? () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
