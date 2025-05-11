import 'package:flutter/material.dart';

/// {@template custom_big_app_bar}
/// CustomBigAppBar widget.
/// {@endtemplate}
class BigAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// {@macro custom_big_app_bar}
  const BigAppBar({super.key, this.actions, this.title});
  final List<Widget>? actions;
  final String? title;

  @override
  Widget build(BuildContext context) => AppBar(
    toolbarHeight: 72,
    titleSpacing: 0,
    elevation: 0,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    automaticallyImplyLeading: true,
    actions: actions,

    scrolledUnderElevation: 0,
    
    title:
        title == null
            ? null
            : Padding(
              padding: EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(color:Colors.white),
                ),
              ),
            ),
  );

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
