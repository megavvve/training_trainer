import 'package:flutter/material.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.cancelTrainingTitle),
      content: Text(l10n.cancelTrainingContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.exit),
        ),
      ],
    );
  }
}