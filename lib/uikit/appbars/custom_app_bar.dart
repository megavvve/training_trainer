import 'package:flutter/material.dart';

/// {@template custom_big_app_bar}
/// CustomBigAppBar widget.
/// {@endtemplate}
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// {@macro custom_big_app_bar}
  const CustomAppBar({
    super.key,
    this.actions,
    this.useBackButton = false,
    this.title,
  });
  final List<Widget>? actions;
  final bool useBackButton;
  final String? title;

  @override
  Widget build(BuildContext context) => AppBar(
    
    toolbarHeight: 72,
    titleSpacing: 0,
    elevation: 0,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    automaticallyImplyLeading: false,
    actions: actions,
    leadingWidth: useBackButton ? 64 : 0,
    scrolledUnderElevation: 0,
    leading:
        useBackButton
            ? IconButton(
              iconSize: 24,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                size: 24,
                Icons.chevron_left,
                color: Colors.white,
              ),
            )
            : null,
    title:
        title == null
            ? null
            : Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title!,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white,),
              ),
            ),
  );

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
