import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/domain/state/trainers_bloc/trainers_bloc.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/widgets/trainer_app_bar.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/widgets/trainer_empty_state.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/widgets/trainer_list_card.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/widgets/trainer_sort_modal.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/widgets/trainer_tile_item.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/routing/app_routes.dart';

class TrainerScreen extends StatelessWidget {
  const TrainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainersBloc, TrainersState>(
      builder: (context, state) {
        if (state is TrainersLoading) {
          return Scaffold(
            backgroundColor: AppColorsExt.bg0,
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is TrainersLoadSuccess) {
          return _TrainerListContent(trainers: state.trainers);
        } else if (state is TrainersLoadFailure) {
          return Scaffold(
            backgroundColor: AppColorsExt.bg0,
            body: Center(child: Text(state.error)),
          );
        }
        return Scaffold(
          backgroundColor: AppColorsExt.bg0,
          body: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class _TrainerListContent extends StatefulWidget {
  const _TrainerListContent({required this.trainers});
  final List<Trainer> trainers;

  @override
  State<_TrainerListContent> createState() => _TrainerListContentState();
}

class _TrainerListContentState extends State<_TrainerListContent> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isGridView = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Trainer> get _filteredTrainers {
    if (_searchQuery.isEmpty) {
      return widget.trainers.where((t) => t.questions.isNotEmpty).toList();
    }
    return widget.trainers
        .where((t) =>
            t.questions.isNotEmpty &&
            t.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> _onRefresh() async {
    context.read<TrainersBloc>().add(LoadTrainers());
    // Wait briefly for the refresh to complete
    await context.read<TrainersBloc>().stream.firstWhere(
      (state) => state is TrainersLoadSuccess || state is TrainersLoadFailure,
    );
  }

  void _startTraining(BuildContext context, Trainer trainer) {
    GoRouter.of(context).push(AppRoutes.trainingProcess, extra: trainer);
  }

  Future<void> _confirmAndDelete(BuildContext context, Trainer trainer) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColorsExt.bg1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Удалить тренажёр?'),
        content: Text('Удалить "${trainer.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColorsExt.error),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<TrainersBloc>().add(DeleteTrainer(trainer));
    }
  }

  void _enterDeleteMode(BuildContext context, Trainer trainer) {
    HapticFeedback.heavyImpact();
    context.read<TrainersBloc>().add(EnterDeleteMode());
  }

  void _exitDeleteMode(BuildContext context) {
    context.read<TrainersBloc>().add(ExitDeleteMode());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filtered = _filteredTrainers;
    final hasResults = filtered.isNotEmpty;

    return BlocBuilder<TrainersBloc, TrainersState>(
      builder: (context, state) {
        final isDeleteMode = state is TrainersLoadSuccess && state.isDeleteMode;

        return Scaffold(
          backgroundColor: AppColorsExt.bg0,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: NormalAppBar(
              title: isDeleteMode ? 'Выберите для удаления' : l10n.appTitle,
              actionsWidgets: isDeleteMode
                  ? [
                      HeaderIconButton(
                        icon: Icons.close,
                        onTap: () => _exitDeleteMode(context),
                      ),
                      const SizedBox(width: 8),
                    ]
                  : [
                      HeaderIconButton(
                        icon: Icons.history_rounded,
                        onTap: () => context.push(AppRoutes.history),
                      ),
                      const SizedBox(width: 4),
                      HeaderIconButton(
                        icon: Icons.settings_rounded,
                        onTap: () => context.push(AppRoutes.settings),
                      ),
                      const SizedBox(width: 8),
                    ],
            ),
          ),
          body: Column(
            children: [
              // ── Search ──
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColorsExt.bg1,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColorsExt.border1),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: l10n.searchHint,
                      hintStyle: TextStyles.text.copyWith(color: AppColorsExt.fill3),
                      prefixIcon: Icon(Icons.search_rounded, size: 20, color: AppColorsExt.fill3),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    style: TextStyles.text.copyWith(color: AppColorsExt.fill1),
                    onChanged: (v) => setState(() => _searchQuery = v),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // ── Sort row (hidden when empty or in delete mode) ──
              if (hasResults && !isDeleteMode)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        filtered.length == 1
                            ? l10n.foundTrainers(filtered.length)
                            : l10n.foundTrainersPlural(filtered.length),
                        style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                      ),
                      Row(
                        children: [
                          HeaderIconButton(
                            icon: _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
                            onTap: () => setState(() => _isGridView = !_isGridView),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => TrainersSortModal.show(context),
                            child: Row(
                              children: [
                                Icon(Icons.swap_vert_rounded, size: 16, color: AppColorsExt.primary),
                                const SizedBox(width: 4),
                                Text(
                                  l10n.sort,
                                  style: TextStyles.textSSemi.copyWith(color: AppColorsExt.primary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              // ── Content ──
              Expanded(
                child: GestureDetector(
                  onTap: isDeleteMode ? () => _exitDeleteMode(context) : null,
                  behavior: HitTestBehavior.translucent,
                  child: !hasResults && !isDeleteMode
                      ? RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: const TrainerEmptyState(),
                            ),
                          ),
                        )
                      : _buildTrainerList(filtered, isDeleteMode),
                ),
              ),
            ],
          ),
          floatingActionButton: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isDeleteMode
                ? const SizedBox.shrink(key: ValueKey('fab-hidden'))
                : Container(
                    key: const ValueKey('fab-visible'),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColorsExt.primary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColorsExt.primary.withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => context.push(AppRoutes.addTrainer),
                        child: const Icon(Icons.add, color: Colors.white, size: 28),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildTrainerList(List<Trainer> filtered, bool isDeleteMode) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
        child: _isGridView
            ? GridView.builder(
                key: const ValueKey('grid'),
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 100),
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: 1.0,
                ),
                itemCount: filtered.length,
                itemBuilder: (context, index) => TrainerTileItem(
                  trainer: filtered[index],
                  isDeleteMode: isDeleteMode,
                  onLongPress: () => _enterDeleteMode(context, filtered[index]),
                  onTap: () {
                    if (!isDeleteMode) {
                      _startTraining(context, filtered[index]);
                    }
                  },
                  onDelete: () => _confirmAndDelete(context, filtered[index]),
                ),
              )
            : isDeleteMode
                ? ListView.builder(
                    key: const ValueKey('delete-list'),
                    padding: const EdgeInsets.only(bottom: 100),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) => TrainerListCard(
                      trainer: filtered[index],
                      isDeleteMode: true,
                      onLongPress: () {},
                      onTap: () {}, // в режиме удаления тап по карточке не удаляет
                      onDelete: () => _confirmAndDelete(context, filtered[index]),
                    ),
                  )
                : ListView.builder(
                    key: const ValueKey('list'),
                    padding: const EdgeInsets.only(bottom: 100),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) => TrainerListCard(
                      trainer: filtered[index],
                      isDeleteMode: false,
                      onLongPress: () => _enterDeleteMode(context, filtered[index]),
                      onTap: () => _startTraining(context, filtered[index]),
                      onDelete: () {},
                    ),
                  ),
      ),
    );
  }
}
