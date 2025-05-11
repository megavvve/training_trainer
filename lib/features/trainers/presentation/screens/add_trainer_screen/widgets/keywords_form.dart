import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeywordsForm extends StatelessWidget {
  final TextEditingController keywordsController;
  final List<String> keywords;
  final Function(String) addKeyword;
  final Function(String) removeKeyword;

  const KeywordsForm({
    super.key,
    required this.keywordsController,
    required this.keywords,
    required this.addKeyword,
    required this.removeKeyword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: keywordsController,
                decoration: const InputDecoration(
                  labelText: 'Ключевое слово',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            ElevatedButton(
              onPressed: () {
                if (keywordsController.text.isNotEmpty) {
                  addKeyword(keywordsController.text.trim());
                  keywordsController.clear();
                }
              },
              child: const Text('Добавить'),
            ),
          ],
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