import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/features/trainers/presentation/providers/trainers_bloc/trainers_bloc.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/general_info_form.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/keywords_form.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/preview_form.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/question_form.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/appbars/custom_app_bar.dart';
import 'package:training_trainer/uikit/buttons/primary_button.dart';
import 'package:training_trainer/uikit/buttons/secondary_button.dart';
import 'package:uuid/uuid.dart';

class AddTrainerScreen extends ConsumerStatefulWidget {
  const AddTrainerScreen({super.key});

  @override
  ConsumerState<AddTrainerScreen> createState() => AddTrainerScreenState();
}

class AddTrainerScreenState extends ConsumerState<AddTrainerScreen> {
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: l10n.createTrainer, useBackButton: true),
      body: Stepper(
        elevation: 0,
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: _continue,
        onStepCancel: _cancel,
        controlsBuilder: _controlsBuilder,
        margin: const EdgeInsets.all(0),
        steps: [
          Step(
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            title: const SizedBox.shrink(),
            label: _stepLabel(l10n.mainInfo),
            content: GeneralInfoForm(
              titleController: _titleController,
              descriptionController: _descriptionController,
              timeController: _timeController,
              formKey: _formKey,
            ),
          ),
          Step(
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            title: const SizedBox.shrink(),
            label: _stepLabel(l10n.addQuestions),
            content: QuestionsForm(
              questionController: _questionController,
              answerController: _answerController,
              addQuestion: _addQuestion,
              questions: questions,
              removeQuestion: (String id) =>
                  setState(() => questions.removeWhere((q) => q.id == id)),
            ),
          ),
          Step(
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            title: const SizedBox.shrink(),
            label: _stepLabel(l10n.keywordsTitle),
            content: KeywordsForm(
              keywordsController: keywordsController,
              keywords: keywords,
              removeKeyword: (String keyword) =>
                  setState(() => keywords.remove(keyword)),
              addKeyword: (String keyword) {
                if (keyword.isNotEmpty && !keywords.contains(keyword)) {
                  setState(() {
                    keywords.add(keyword);
                  });
                }
              },
            ),
          ),
          Step(
            isActive: _currentStep >= 3,
            state: _currentStep == 3 ? StepState.editing : StepState.indexed,
            title: const SizedBox.shrink(),
            label: _stepLabel(l10n.preview),
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

  Widget _stepLabel(String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: TextStyles.deskSemi.copyWith(color: AppColorsExt.fill2),
        maxLines: 1,
      ),
    );
  }

  Widget _controlsBuilder(BuildContext context, ControlsDetails details) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        children: [
          if (_currentStep != 0)
            Expanded(
              child: AppSecondaryButton(
                onTap: details.onStepCancel,
                text: l10n.back,
              ),
            ),
          if (_currentStep != 0) const SizedBox(width: 16),
          Expanded(
            child: AppPrimaryButton(
              onTap: details.onStepContinue,
              text: _currentStep == 3 ? l10n.save : l10n.next,
            ),
          ),
        ],
      ),
    );
  }

  void _continue() {
    if (_currentStep == 3) {
      final authState = ref.read(authStateProvider);
      final l10n = AppLocalizations.of(context)!;
      authState.whenData((user) {
        if (user != null) {
          getIt<Talker>().info('AddTrainerScreen: Dispatching AddTrainer event');
          context.read<TrainersBloc>().add(
            AddTrainer(
              userId: user.uid,
              timeRequiredInSeconds: _timeController.text,
              title: _titleController.text,
              questions: questions,
              keywords: keywords,
              description: _descriptionController.text,
            ),
          );
          Navigator.pop(context);
        } else {
          getIt<Talker>().error('AddTrainerScreen: User is null, cannot save trainer');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.userNotAuthenticated)),
          );
        }
      });
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
      final String questionText = _questionController.text;
      final String correctAnswer = _answerController.text;

      setState(() {
        questions.add(
          Question(
            id: getIt<Uuid>().v4(),
            textQuestion: questionText,
            rightAnswer: correctAnswer,
            // Server will generate wrong answers via local MLX on trainer creation
            answers: [correctAnswer],
          ),
        );
        _questionController.clear();
        _answerController.clear();
      });
    }
  }
}
