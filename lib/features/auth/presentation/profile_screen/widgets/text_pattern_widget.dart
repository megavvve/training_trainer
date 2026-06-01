import 'package:flutter/material.dart';
import 'package:training_trainer/constants/app_colors.dart';

class TextPatternWidget extends StatelessWidget {
  const TextPatternWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const baseText = 'TRAININGTRAINER';
    final lines = _generatePattern(baseText);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < lines.length; i++) _buildTextLine(lines[i], i),
        ],
      ),
    );
  }

  List<String> _generatePattern(String text) {
    final pattern = <String>[];
    for (int i = 0; i < text.length; i++) {
      final shifted = text.substring(i) + text.substring(0, i);
      pattern.add(shifted);
    }
    return pattern;
  }

  Widget _buildTextLine(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          height: 2.5,
          fontSize: 16,
          color: AppColorsExt.primary.withValues(alpha: 0.3),
          fontFamily: 'RobotoMono',
          fontWeight: FontWeight.w500,
          letterSpacing: 15,
        ),
      ),
    );
  }
}
