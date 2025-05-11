import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralInfoForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController timeController;
  final GlobalKey<FormState> formKey;

  const GeneralInfoForm({super.key, 
    required this.titleController,
    required this.descriptionController,
    required this.timeController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Название тренажера',
              border: OutlineInputBorder(),
            ),
            validator: (value) => value!.isEmpty ? 'Введите название' : null,
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Описание тренажера',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: timeController,
            decoration: const InputDecoration(
              labelText: 'Время на прохождение (минуты)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? 'Введите время' : null,
          ),
        ],
      ),
    );
  }
}