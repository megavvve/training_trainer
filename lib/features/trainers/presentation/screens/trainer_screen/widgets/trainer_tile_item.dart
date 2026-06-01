import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/l10n/app_localizations.dart';

class TrainerTileItem extends StatelessWidget {
  const TrainerTileItem({required this.trainer, super.key,
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: GestureDetector(
        onLongPress: onLongPress,
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColorsExt.bg1,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColorsExt.border1),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    trainer.title,
                    style: TextStyles.textSemi.copyWith(
                      color: AppColorsExt.fill1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),

                  // Description — растягивается, заполняя пространство
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        trainer.description,
                        style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Counts row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.help_outline, size: 12, color: AppColorsExt.fill2),
                      const SizedBox(width: 2),
                      Text(
                        '${trainer.questions.length}',
                        style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                      ),
                      if (trainer.timeRequiredInSeconds != null) ...[
                        const SizedBox(width: 6),
                        Icon(Icons.access_time, size: 12, color: AppColorsExt.fill2),
                        const SizedBox(width: 2),
                        Text(
                          l10n.minutesShort((trainer.timeRequiredInSeconds! / 60).ceil()),
                          style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Keyword chips
                  if (trainer.keywords.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: trainer.keywords.take(2).map((kw) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColorsExt.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            kw.length > 8 ? '${kw.substring(0, 8)}..' : kw,
                            style: TextStyle(
                              color: AppColorsExt.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )).toList(),
                    ),
                ],
              ),
            ),

            if (isDeleteMode)
              Positioned(
                top: -10,
                right: -10,
                child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: const Icon(Icons.close, size: 14, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
