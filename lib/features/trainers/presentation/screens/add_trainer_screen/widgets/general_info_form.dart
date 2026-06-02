import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/inputs/app_text_field.dart';

class GeneralInfoForm extends StatefulWidget {
  const GeneralInfoForm({required this.titleController, required this.descriptionController, required this.timeController, required this.formKey, super.key,
    this.timeUnitMinutes = true,
    this.onTimeUnitChanged,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController timeController;
  final GlobalKey<FormState> formKey;
  final bool timeUnitMinutes;
  final ValueChanged<bool>? onTimeUnitChanged;

  @override
  State<GeneralInfoForm> createState() => _GeneralInfoFormState();
}

class _GeneralInfoFormState extends State<GeneralInfoForm> {
  bool _timeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // Title (mandatory)
          CustomTextField(
            label: '${l10n.trainerTitle} *',
            controller: widget.titleController,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),

          // Description
          CustomTextField(
            label: l10n.trainerDescription,
            controller: widget.descriptionController,
          ),
          const SizedBox(height: 16),

          // Time toggle on/off
          Row(
            children: [
              SizedBox(
                height: 24,
                child: Switch(
                  value: _timeEnabled,
                  activeColor: AppColorsExt.primary,
                  onChanged: (v) => setState(() {
                    _timeEnabled = v;
                    if (!v) widget.timeController.clear();
                  }),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                l10n.timeLimit,
                style: TextStyles.textSReg.copyWith(color: AppColorsExt.fill1),
              ),
            ],
          ),

          if (_timeEnabled) ...[
            const SizedBox(height: 16),

            // Time input + unit toggle
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: l10n.enterTime,
                    controller: widget.timeController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('мин')),
                    ButtonSegment(value: false, label: Text('сек')),
                  ],
                  selected: {widget.timeUnitMinutes},
                  onSelectionChanged: (v) =>
                      widget.onTimeUnitChanged?.call(v.first),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
