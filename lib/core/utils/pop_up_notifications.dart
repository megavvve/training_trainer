import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

void inputFieldsNotFilledIn(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        l10n.emptyFields,
        style: TextStyles.text.copyWith(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.hideCurrentSnackBar();
  scaffold.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyles.text.copyWith(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
