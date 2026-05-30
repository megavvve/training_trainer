import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/presentation/providers/trainers_bloc/trainers_bloc.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/routing/app_routes.dart';
import 'package:training_trainer/uikit/appbars/big_app_bar.dart';
import 'package:training_trainer/uikit/modal/custom_modal_bottom_sheet.dart';

class TrainerScreen extends StatefulWidget {
  const TrainerScreen({super.key});

  @override
  State<TrainerScreen> createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<TrainersBloc, TrainersState>(
      builder: (context, state) {
        if (state is TrainersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TrainersLoadSuccess) {
          final trainerList = state.trainers
              .where((element) => element.questions.isNotEmpty)
              .toList();

          return Scaffold(
            backgroundColor: AppColorsExt.bg2,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: BigAppBar(title: l10n.home),
                  pinned: true,
                  snap: false,
                  floating: true,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: AppColorsExt.bg2,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildSearchField(context),
                      _buildSortingRow(context),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) =>
                        TrainerCard(trainer: trainerList[index]),
                    childCount: trainerList.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.push(AppRoutes.addTrainer),
              child: const Icon(Icons.add),
            ),
          );
        } else if (state is TrainersLoadFailure) {
          return Center(child: Text(state.error));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColorsExt.bg1,
          hintText: l10n.searchHint,
          prefixIcon: Icon(Icons.search, color: AppColorsExt.fill2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
        onChanged: (value) {
          context.read<TrainersBloc>().add(SearchTrainers(query: value));
        },
      ),
    );
  }

  Widget _buildSortingRow(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.foundElements(
                context.read<TrainersBloc>().filteredTrainers.length,
              ),
              style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
            ),
          ),
          SizedBox(
            height: 36,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColorsExt.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => _showSortingModal(context),
              icon: const Icon(Icons.sort, size: 18),
              label: Text(
                l10n.sorting,
                style: TextStyles.textSBold.copyWith(color: AppColorsExt.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSortingModal(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showCustomBottomSheet(
      context: context,
      title: l10n.sort,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSortOption(l10n.sortByTitle, Icons.sort_by_alpha, 'title', context),
          _buildSortOption(l10n.sortByDate, Icons.date_range, 'createdAt', context),
          _buildSortOption(l10n.sortByQuestions, Icons.format_list_numbered, 'questions', context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSortOption(String title, IconData icon, String sortBy, BuildContext context) {
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

class TrainerCard extends StatelessWidget {
  const TrainerCard({required this.trainer, super.key});
  final Trainer trainer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final timeText = '${(trainer.timeRequiredInSeconds / 60).ceil()} мин';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        color: AppColorsExt.bg1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColorsExt.border2, width: 1),
        ),
        child: InkWell(
          onTap: () => _showDetails(context, l10n),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        trainer.title,
                        style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColorsExt.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        color: AppColorsExt.primary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildMetaItem(Icons.question_answer_rounded, trainer.questions.length.toString()),
                    const SizedBox(width: 16),
                    _buildMetaItem(Icons.access_time_rounded, timeText),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  trainer.description,
                  style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: _buildKeywords(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 40,
                      child: FilledButton(
                        onPressed: () => _showDetails(context, l10n),
                        child: Text(l10n.start),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, AppLocalizations l10n) {
    showCustomBottomSheet(
      context: context,
      title: trainer.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: trainer.keywords.map((k) => Chip(label: Text(k))).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            '${l10n.trainerDescription}:',
            style: TextStyles.textSemi.copyWith(color: AppColorsExt.fill1),
          ),
          const SizedBox(height: 8),
          Text(trainer.description, style: TextStyles.text),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                context.pop();
                GoRouter.of(context).push(AppRoutes.trainingProcess, extra: trainer);
              },
              child: const Text('Поехали!'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColorsExt.primary),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
        ),
      ],
    );
  }

  Widget _buildKeywords() {
    const maxKeywords = 2;
    final overflowCount = trainer.keywords.length - maxKeywords;

    return Row(
      children: [
        ...trainer.keywords.take(maxKeywords).map(
              (keyword) => Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColorsExt.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    keyword,
                    style: TextStyles.deskSemi.copyWith(color: AppColorsExt.primary),
                  ),
                ),
              ),
            ),
        if (overflowCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColorsExt.bg3,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '+$overflowCount',
              style: TextStyles.deskSemi.copyWith(color: AppColorsExt.fill2),
            ),
          ),
      ],
    );
  }
}
