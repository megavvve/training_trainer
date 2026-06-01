import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class ScaffoldWithNavBar extends StatelessWidget {

  const ScaffoldWithNavBar({
    required this.navigationShell, super.key,
  });
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColorsExt.bg1,
          border: Border(
            top: BorderSide(color: AppColorsExt.border1, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColorsExt.primary,
          unselectedItemColor: AppColorsExt.fill2,
          selectedLabelStyle: TextStyles.deskSemi.copyWith(color: AppColorsExt.primary),
          unselectedLabelStyle: TextStyles.deskMed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_rounded, size: 24),
              activeIcon: Icon(Icons.home_rounded, size: 24, color: AppColorsExt.primary),
              label: l10n.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_rounded, size: 24),
              activeIcon: Icon(Icons.person_rounded, size: 24, color: AppColorsExt.primary),
              label: l10n.profile,
            ),
          ],
          onTap: (index) => _onTap(context, index),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
