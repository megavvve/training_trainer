import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/widgets/meta_chip.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class TrainerListCard extends StatefulWidget {
  const TrainerListCard({required this.trainer, super.key,
    this.isDeleteMode = false,
    this.onLongPress,
    this.onTap,
    this.onDelete,
  });

  final Trainer trainer;
  final bool isDeleteMode;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  State<TrainerListCard> createState() => _TrainerListCardState();
}

class _TrainerListCardState extends State<TrainerListCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _shakeController;
  Animation<double>? _shakeAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.isDeleteMode) _startShake();
  }

  @override
  void didUpdateWidget(TrainerListCard old) {
    super.didUpdateWidget(old);
    if (widget.isDeleteMode && !old.isDeleteMode) {
      _startShake();
    } else if (!widget.isDeleteMode && old.isDeleteMode) {
      _stopShake();
    }
  }

  void _startShake() {
    _shakeController?.dispose();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _shakeAnimation = Tween<double>(begin: -0.03, end: 0.03).animate(
      CurvedAnimation(parent: _shakeController!, curve: Curves.easeInOut),
    );
    _shakeController!.repeat(reverse: true);
  }

  void _stopShake() {
    _shakeController?.stop();
    _shakeController?.dispose();
    _shakeController = null;
    _shakeAnimation = null;
  }

  @override
  void dispose() {
    _shakeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final timeText = widget.trainer.timeRequiredInSeconds != null
        ? l10n.minutesShort((widget.trainer.timeRequiredInSeconds! / 60).ceil())
        : '∞';

    final content = Container(
      decoration: BoxDecoration(
        color: AppColorsExt.bg1,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColorsExt.border1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.trainer.title,
            style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              MetaChip(Icons.help_outline, l10n.questionsCount(widget.trainer.questions.length)),
              if (widget.trainer.timeRequiredInSeconds != null) ...[
                const SizedBox(width: 16),
                MetaChip(Icons.access_time, timeText),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.trainer.description,
            style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.trainer.keywords.take(3).map((kw) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColorsExt.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          kw,
                          style: TextStyles.deskSemi.copyWith(color: AppColorsExt.primary),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!widget.isDeleteMode)
            SizedBox(
              width: double.infinity,
              height: 40,
              child: FilledButton(
                onPressed: widget.onTap,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColorsExt.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l10n.start, style: TextStyles.textSemi.copyWith(color: Colors.white)),
              ),
            ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _shakeAnimation ?? const AlwaysStoppedAnimation(0.0),
          builder: (_, child) =>
              Transform.rotate(angle: _shakeAnimation?.value ?? 0.0, child: child),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (widget.isDeleteMode)
                const Positioned(
                  left: -20,
                  top: 0,
                  bottom: 0,
                  child: Center(child: Icon(Icons.drag_indicator, color: Colors.white54, size: 20)),
                ),
              content,
              if (widget.isDeleteMode)
                Positioned(
                  top: -10,
                  right: -10,
                  child: GestureDetector(
                    onTap: widget.onDelete,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 16, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
