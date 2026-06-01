import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/features/results/domain/entities/training_result.dart';
import 'package:training_trainer/features/results/domain/repositories/results_repository.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/routing/app_routes.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<TrainingResult>? _results;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final repo = getIt<ResultsRepository>();
      final results = await repo.getMyResults();
      // Отфильтровываем результаты, где все вопросы пропущены
      final filtered = results.where((r) =>
        !(r.correctAnswers == 0 && r.unansweredCount == r.totalQuestions)
      ).toList();
      if (mounted) {
        setState(() {
          _results = filtered;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Не удалось загрузить историю тренировок';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColorsExt.bg0,
      appBar: AppBar(
        backgroundColor: AppColorsExt.bg1,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.history, style: TextStyles.h2.copyWith(color: AppColorsExt.fill1)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.pop(),
        ),
      ),
      body: _buildBody(l10n),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColorsExt.error),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: TextStyles.text.copyWith(color: AppColorsExt.fill2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadResults,
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    final results = _results ?? [];

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history_rounded, size: 64, color: AppColorsExt.fill3),
            const SizedBox(height: 16),
            Text(
              l10n.noHistoryYet,
              style: TextStyles.h3.copyWith(color: AppColorsExt.fill2),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadResults,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: results.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final entry = results[index];
          final percent = entry.correctAnswers / entry.totalQuestions;
          final isGood = percent >= 0.7;

          return _HistoryCard(
            entry: entry,
            isGood: isGood,
            onTap: () => context.push(
              AppRoutes.resultDetail.replaceFirst(':resultId', entry.id),
              extra: entry,
            ),
          );
        },
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.entry,
    required this.isGood,
    required this.onTap,
  });

  final TrainingResult entry;
  final bool isGood;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final percent = entry.correctAnswers / entry.totalQuestions;
    final wrongCount = entry.totalQuestions - entry.correctAnswers - entry.unansweredCount;

    return Container(
      decoration: BoxDecoration(
        color: AppColorsExt.bg1,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColorsExt.border1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isGood
                            ? AppColorsExt.primaryContainer
                            : AppColorsExt.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isGood ? Icons.check_circle_outline : Icons.error_outline,
                        color: isGood ? AppColorsExt.primary : AppColorsExt.error,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entry.correctAnswers}/${entry.totalQuestions}',
                            style: TextStyles.textSemi.copyWith(color: AppColorsExt.fill1),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${(percent * 100).round()}% — ${isGood ? "отлично" : "нужно практиковаться"}',
                            style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: AppColorsExt.fill3),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStat(Icons.check_circle, '${entry.correctAnswers}', AppColorsExt.primary),
                    const SizedBox(width: 16),
                    _buildStat(Icons.cancel, '$wrongCount', AppColorsExt.error),
                    if (entry.unansweredCount > 0) ...[
                      const SizedBox(width: 16),
                      _buildStat(Icons.help_outline, '${entry.unansweredCount}', AppColorsExt.fill2),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percent,
                    backgroundColor: AppColorsExt.bg3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isGood ? AppColorsExt.primary : AppColorsExt.error,
                    ),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyles.textSmall.copyWith(color: color)),
      ],
    );
  }
}
