import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeywordsForm extends StatelessWidget {
  final TextEditingController keywordsController;
  final List<String> keywords;
  final Function(String) removeKeyword;

  const KeywordsForm({super.key, 
    required this.keywordsController,
    required this.keywords,
    required this.removeKeyword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: keywordsController,
          decoration: const InputDecoration(
            labelText: 'Добавить ключевое слово',
            border: OutlineInputBorder(),
          ),
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {
              keywords.add(value.trim());
              keywordsController.clear();
            }
          },
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 8.w,
          children: keywords.map((keyword) => Chip(
            label: Text(keyword),
            deleteIcon: const Icon(Icons.close),
            onDeleted: () => removeKeyword(keyword),
          )).toList(),
        ),
      ],
    );
  }
}