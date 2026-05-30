import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

/// Compact app bar with back button, title, and optional subtitle.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.actions,
    this.useBackButton = true,
    this.onBackTap,
    this.isLoading = false,
  });
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool useBackButton;
  final VoidCallback? onBackTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backBgColor = isDark ? AppColorsExt.bg2 : AppColorsExt.bg3;

    return AppBar(
      toolbarHeight: 50,
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: AppColorsExt.bg1,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      leadingWidth: useBackButton ? 64 : 0,
      leading: useBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: backBgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: IconButton(
                  iconSize: 24,
                  onPressed: onBackTap ?? () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.chevron_left,
                    size: 24,
                    color: isLoading
                        ? AppColorsExt.fill2
                        : AppColorsExt.fill1,
                  ),
                ),
              ),
            )
          : null,
      title: title == null
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyles.h3.copyWith(
                    color: isLoading
                        ? AppColorsExt.fill2
                        : AppColorsExt.fill1,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyles.textSmall.copyWith(
                      color: isLoading
                          ? AppColorsExt.fill2
                          : AppColorsExt.fill2,
                    ),
                  ),
              ],
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
