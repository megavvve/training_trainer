 import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';

class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({required this.icon, required this.onTap, super.key});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, size: 20, color: AppColorsExt.primary),
        ),
      ),
    );
  }
}

class DeleteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DeleteAppBar({required this.onExit, super.key});

  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: onExit,
      ),
      title: Text(
        'Выберите для удаления',
        style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NormalAppBar({required this.title, super.key, this.actionsWidgets});

  final String title;
  final List<Widget>? actionsWidgets;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.h2.copyWith(
          color: AppColorsExt.fill1,
        ),
      ),
      actions: actionsWidgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
