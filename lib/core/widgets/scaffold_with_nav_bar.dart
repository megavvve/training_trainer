import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: l10n.home),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: l10n.profile),
        ],
        onTap: (index) => _onTap(context, index),
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