import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/services/ai/ai_generator_interface.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/general_info_form.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/keywords_form.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/preview_form.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/question_form.dart';
import 'package:training_trainer/features/trainers/presentation/providers/trainers_bloc/trainers_bloc.dart';
import 'package:training_trainer/uikit/appbars/custom_app_bar.dart';

class AddTrainerScreen extends StatefulWidget {
  const AddTrainerScreen({super.key});

  @override
  AddTrainerScreenState createState() => AddTrainerScreenState();
}

class AddTrainerScreenState extends State<AddTrainerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final keywordsController = TextEditingController();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  List<Question> questions = [];
  List<String> keywords = [];
  int _currentStep = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    keywordsController.dispose();
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Создание тренажера",useBackButton:true),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _continue,
        onStepCancel: _cancel,
        controlsBuilder: _controlsBuilder,
        steps: [
          Step(
            title: const Text('Основная информация'),
            content: GeneralInfoForm(
              titleController: _titleController,
              descriptionController: _descriptionController,
              timeController: _timeController,
              formKey: _formKey,
            ),
          ),
          Step(
            title: const Text('Добавление вопросов',),
            content: QuestionsForm(
              questionController: _questionController,
              answerController: _answerController,
              addQuestion: _addQuestion,
              questions: questions,
              removeQuestion: (String id) => setState(
                () => questions.removeWhere(
                  (q) => q.id == id,
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Ключевые слова'),
            content: KeywordsForm(
                keywordsController: keywordsController,
                keywords: keywords,
                removeKeyword: (String keyword) => setState(
                      () => keywords.remove(
                        keyword,
                      ),
                    ),
                addKeyword: (String keyword) {
                  if (keyword.isNotEmpty && !keywords.contains(keyword)) {
                    setState(() {
                      keywords.add(keyword);
                    });
                  }
                }),
          ),
          Step(
            title: const Text('Просмотр'),
            content: PreviewForm(
              title: _titleController.text,
              description: _descriptionController.text,
              time: _timeController.text,
              keywords: keywords,
              questions: questions,
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlsBuilder(BuildContext context, ControlsDetails details) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          if (_currentStep != 0)
            TextButton(
              onPressed: details.onStepCancel,
              child: const Text('Назад'),
            ),
          SizedBox(width: 16.w),
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: Text(_currentStep == 3 ? 'Сохранить' : 'Далее'),
          ),
        ],
      ),
    );
  }

  void _continue() {
    if (_currentStep == 3) {
      context.read<TrainersBloc>().add(AddTrainer(
            timeRequiredInSeconds: _timeController.text,
            title: _titleController.text,
            questions: questions,
            keywords: keywords,
            description: _descriptionController.text,
          ));
      Navigator.pop(context);
    } else {
      setState(() => _currentStep += 1);
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  Future<void> _addQuestion() async {
    if (_questionController.text.isNotEmpty &&
        _answerController.text.isNotEmpty) {
      final List<String> list = await getIt<AIGenerator>().generateWrongAnswers(
          question: _questionController.text,
          correctAnswer: _answerController.text);
      setState(() {
        questions.add(Question(
          id: questions.hashCode.toString(),
          textQuestion: _questionController.text,
          rightAnswer: _answerController.text,
          answers: list,
        ));
        _questionController.clear();
        _answerController.clear();
      });
    }
  }
}
