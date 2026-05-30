import 'package:flutter/material.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.error, super.key});
  final String error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Text('${l10n.error}: $error'),
      ),
    );
  }
}