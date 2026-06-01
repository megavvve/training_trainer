import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/state/trainers_bloc/trainers_bloc.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/modal/custom_modal_bottom_sheet.dart';

class TrainersSortModal {
  static void show(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showCustomBottomSheet(
      context: context,
      title: l10n.sorting,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SortOption(title: l10n.sortByTitle, icon: Icons.sort_by_alpha, sortBy: 'title'),
          _SortOption(title: l10n.sortByDate, icon: Icons.date_range, sortBy: 'createdAt'),
          _SortOption(title: l10n.sortByQuestions, icon: Icons.format_list_numbered, sortBy: 'questions'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  const _SortOption({required this.title, required this.icon, required this.sortBy});
  final String title;
  final IconData icon;
  final String sortBy;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 24, color: AppColorsExt.fill1),
      title: Text(title, style: TextStyles.text),
      onTap: () {
        context.read<TrainersBloc>().add(SortTrainers(sortBy: sortBy));
        context.pop();
      },
    );
  }
}
