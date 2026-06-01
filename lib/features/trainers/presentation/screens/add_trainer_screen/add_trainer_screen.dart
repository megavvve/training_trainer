import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talker/talker.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/constants/app_fonts.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/services/ai/ai_generator_interface.dart';
import 'package:training_trainer/features/auth/presentation/providers/auth_providers.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/features/trainers/domain/state/trainers_bloc/trainers_bloc.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/general_info_form.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/keywords_form.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/preview_form.dart';
import 'package:training_trainer/features/trainers/presentation/screens/add_trainer_screen/widgets/question_form.dart';
import 'package:training_trainer/l10n/app_localizations.dart';
import 'package:training_trainer/uikit/buttons/primary_button.dart';
import 'package:training_trainer/uikit/buttons/secondary_button.dart';
import 'package:training_trainer/uikit/inputs/app_text_field.dart';
import 'package:training_trainer/uikit/modal/custom_modal_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

enum CreationMode { automatic, manual }

class AddTrainerScreen extends ConsumerStatefulWidget {
  const AddTrainerScreen({super.key});

  @override
  ConsumerState<AddTrainerScreen> createState() => AddTrainerScreenState();
}

class AddTrainerScreenState extends ConsumerState<AddTrainerScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final keywordsController = TextEditingController();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  final _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  List<Question> questions = [];
  List<String> keywords = [];
  int _currentStep = 0;
  CreationMode? _mode;
  bool _timeUnitMinutes = true;
  bool _isGenerating = false;

  bool get _isTitleValid => _titleController.text.trim().isNotEmpty;

  bool get _isNextDisabled {
    if (_currentStep == 0 && !_isTitleValid) return true;
    if (_currentStep == 1 && _mode == null) return true;
    if (_isGenerating) return true;
    return false;
  }

  final int _totalSteps = 4;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    keywordsController.dispose();
    _questionController.dispose();
    _answerController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    // From Mode step with Auto: start generation flow
    if (_currentStep == 1 && _mode == CreationMode.automatic) {
      _startAutoGeneration();
      return;
    }

    // При переходе с вопросов на превью — проверяем неправильные ответы
    // только для автоматического режима
    if (_currentStep == 2 && _mode == CreationMode.automatic && questions.isNotEmpty) {
      final emptyQuestions = <int>[];
      for (int i = 0; i < questions.length; i++) {
        final wrong = questions[i].answers
            .where((a) => a.isNotEmpty && a != questions[i].rightAnswer)
            .toList();
        if (wrong.isEmpty) {
          emptyQuestions.add(i + 1);
        }
      }
      if (emptyQuestions.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Вопрос${emptyQuestions.length > 1 ? "ы" : ""} ${emptyQuestions.join(", ")} не ${emptyQuestions.length > 1 ? "имеют" : "имеет"} неправильных ответов. Добавьте хотя бы один.'),
            backgroundColor: AppColorsExt.error,
          ),
        );
        return;
      }
    }

    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _startAutoGeneration() async {
    final l10n = AppLocalizations.of(context)!;

    // Bottom sheet 1: question count
    int? questionCount = await showCustomBottomSheet<int>(
      context: context,
      title: l10n.questionCount,
      subtitle: l10n.questionCountHint,
      child: _QuestionCountSheet(l10n: l10n),
    );
    if (questionCount == null || !mounted) return;

    // Bottom sheet 2: prompt/topic
    String? topic = await showCustomBottomSheet<String>(
      context: context,
      title: l10n.topicHint,
      subtitle: l10n.describeTopic,
      child: _TopicSheet(l10n: l10n),
    );
    if (topic == null || !mounted) return;

    // Jump to questions step FIRST to show loading animation
    setState(() {
      _isGenerating = true;
      _currentStep = 2;
    });
    _pageController.animateToPage(2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut);

    try {
      final ai = getIt<AIGenerator>();
      final langCode = AppLocalizations.of(context)!.localeName.substring(0, 2);
      final result = await ai.generateFullTrainer(
        topic: topic,
        questionCount: questionCount,
        title: _titleController.text,
        language: langCode,
      );

      // Update fields from generated result
      if (_titleController.text.isEmpty && result['title'] != null) {
        _titleController.text = result['title'] as String;
      }
      if (_descriptionController.text.isEmpty && result['description'] != null) {
        _descriptionController.text = result['description'] as String;
      }

      // Parse keywords
      final keywordsList = (result['keywords'] as List?)?.cast<String>() ?? [];
      keywords = keywordsList;

      // Parse questions
      final questionsList = (result['questions'] as List?) ?? [];
      questions = questionsList.map((q) {
        final m = q as Map<String, dynamic>;
        return Question(
          id: getIt<Uuid>().v4(),
          textQuestion: m['text_question'] as String? ?? m['textQuestion'] as String? ?? '',
          rightAnswer: m['right_answer'] as String? ?? m['rightAnswer'] as String? ?? '',
          answers: (m['answers'] as List?)?.cast<String>() ?? [],
        );
      }).toList();

      if (mounted) {
        setState(() => _isGenerating = false);
        // Stay on questions step — data is loaded
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isGenerating = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка генерации: $e')),
        );
      }
    }
  }

  void _goBack() {
    // После AI-генерации (mode automatic и есть вопросы) — возврат назад запрещён
    if (_mode == CreationMode.automatic && questions.isNotEmpty && _currentStep >= 2) return;
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final hasData = _titleController.text.isNotEmpty ||
        _descriptionController.text.isNotEmpty ||
        questions.isNotEmpty ||
        keywords.isNotEmpty;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (!hasData) {
          context.pop();
          return;
        }
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppColorsExt.bg1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('Выйти из создания?'),
            content: const Text('Введённые данные будут потеряны.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: FilledButton.styleFrom(backgroundColor: AppColorsExt.error),
                child: Text(l10n.exit),
              ),
            ],
          ),
        );
        if (shouldExit == true && context.mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColorsExt.bg0,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Text(l10n.createTrainer, style: TextStyles.h3.copyWith(color: AppColorsExt.fill1)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        body: Column(
        children: [
          // ── Animated Step Indicator ──
          _StepIndicator(
            currentStep: _currentStep,
            totalSteps: _totalSteps,
            labels: [l10n.mainInfo, l10n.modeStep, l10n.addQuestions, l10n.preview],
          ),

          // ── Step Content ──
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildInfoStep(l10n),
                _buildModeStep(l10n),
                _buildQuestionsStep(l10n),
                _buildPreviewStep(l10n),
              ],
            ),
          ),

          // ── Bottom Navigation ──
          _buildBottomNav(l10n),
        ],
      ),
      ),
    );
  }

  // ── Step 1: General Info ──
  Widget _buildInfoStep(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColorsExt.bg1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColorsExt.border1),
        ),
        child: GeneralInfoForm(
          titleController: _titleController,
          descriptionController: _descriptionController,
          timeController: _timeController,
          formKey: _formKey,
          timeUnitMinutes: _timeUnitMinutes,
          onTimeUnitChanged: (v) => setState(() => _timeUnitMinutes = v),
        ),
      ),
    );
  }

  // ── Step 2: Mode Selection ──
  Widget _buildModeStep(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Auto mode
          GestureDetector(
            onTap: () => setState(() => _mode = CreationMode.automatic),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColorsExt.bg1,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _mode == CreationMode.automatic
                      ? AppColorsExt.primary
                      : AppColorsExt.border1,
                  width: _mode == CreationMode.automatic ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _mode == CreationMode.automatic
                          ? AppColorsExt.primary.withValues(alpha: 0.1)
                          : AppColorsExt.bg3,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.auto_awesome,
                      color: _mode == CreationMode.automatic
                          ? AppColorsExt.primary
                          : AppColorsExt.fill3,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.modeAutomatic,
                          style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.modeAutoDesc,
                          style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                        ),
                      ],
                    ),
                  ),
                  Radio<CreationMode>(
                    value: CreationMode.automatic,
                    groupValue: _mode,
                    onChanged: (v) => setState(() => _mode = v),
                    activeColor: AppColorsExt.primary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Manual mode
          GestureDetector(
            onTap: () => setState(() => _mode = CreationMode.manual),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColorsExt.bg1,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _mode == CreationMode.manual
                      ? AppColorsExt.primary
                      : AppColorsExt.border1,
                  width: _mode == CreationMode.manual ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _mode == CreationMode.manual
                          ? AppColorsExt.primary.withValues(alpha: 0.1)
                          : AppColorsExt.bg3,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.edit_note,
                      color: _mode == CreationMode.manual
                          ? AppColorsExt.primary
                          : AppColorsExt.fill3,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.modeManual,
                          style: TextStyles.h3.copyWith(color: AppColorsExt.fill1),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.modeManualDesc,
                          style: TextStyles.textSmall.copyWith(color: AppColorsExt.fill2),
                        ),
                      ],
                    ),
                  ),
                  Radio<CreationMode>(
                    value: CreationMode.manual,
                    groupValue: _mode,
                    onChanged: (v) => setState(() => _mode = v),
                    activeColor: AppColorsExt.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Step 3: Questions (editable for both modes) ──
  Widget _buildQuestionsStep(AppLocalizations l10n) {
    // For auto mode, show animated loading if still generating
    if (_mode == CreationMode.automatic && _isGenerating) {
      return _AiGenerationLoading(l10n: l10n);
    }

    final isAuto = _mode == CreationMode.automatic;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColorsExt.bg1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColorsExt.border1),
        ),
        child: Column(
          children: [
            KeywordsForm(
              keywordsController: keywordsController,
              keywords: keywords,
              removeKeyword: (String kw) => setState(() => keywords.remove(kw)),
              addKeyword: (String kw) {
                if (kw.isNotEmpty && !keywords.contains(kw)) {
                  setState(() => keywords.add(kw));
                }
              },
            ),
            const SizedBox(height: 24),
            // В ручном режиме — блок добавления вопроса сверху списка
            // В авто-режиме — блок добавления снизу (после списка)
            QuestionsForm(
              questionController: _questionController,
              answerController: _answerController,
              addQuestion: _addQuestion,
              questions: questions,
              removeQuestion: (String id) =>
                  setState(() => questions.removeWhere((q) => q.id == id)),
              onUpdateQuestion: _updateQuestion,
              addFormFirst: !isAuto, // manual = сверху, auto = снизу
            ),
          ],
        ),
      ),
    );
  }

  // ── Step 4: Preview (editable info) ──
  Widget _buildPreviewStep(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColorsExt.bg1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColorsExt.border1),
        ),
        child: PreviewForm(
          title: _titleController.text,
          description: _descriptionController.text,
          time: _timeController.text,
          keywords: keywords,
          questions: questions,
          // Editable controllers for in-place editing
          titleController: _titleController,
          descriptionController: _descriptionController,
          timeController: _timeController,
          timeUnitMinutes: _timeUnitMinutes,
          onTimeUnitChanged: (v) => setState(() => _timeUnitMinutes = v),
        ),
      ),
    );
  }

  // ── Bottom Nav ──
  Widget _buildBottomNav(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      decoration: BoxDecoration(
        color: AppColorsExt.bg1,
        border: Border(top: BorderSide(color: AppColorsExt.border1)),
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _goBack,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColorsExt.primary,
                  side: BorderSide(color: AppColorsExt.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(l10n.back),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: _isNextDisabled
                  ? null
                  : (_currentStep == _totalSteps - 1 ? _save : _goNext),
              style: FilledButton.styleFrom(
                backgroundColor: AppColorsExt.primary,
                disabledBackgroundColor: AppColorsExt.primaryDis,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                _currentStep == _totalSteps - 1 ? l10n.save : l10n.next,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    final authState = ref.read(authStateProvider);
    final l10n = AppLocalizations.of(context)!;

    // Проверка только в автоматическом режиме — что есть неправильные ответы
    if (_mode == CreationMode.automatic) {
      final emptyQuestions = <int>[];
      for (int i = 0; i < questions.length; i++) {
        final wrong = questions[i].answers
            .where((a) => a.isNotEmpty && a != questions[i].rightAnswer)
            .toList();
        if (wrong.isEmpty) {
          emptyQuestions.add(i + 1);
        }
      }
      if (emptyQuestions.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Вопрос${emptyQuestions.length > 1 ? "ы" : ""} ${emptyQuestions.join(", ")} не ${emptyQuestions.length > 1 ? "имеют" : "имеет"} неправильных ответов.'),
            backgroundColor: AppColorsExt.error,
          ),
        );
        return;
      }
    }

    authState.whenData((user) {
      if (user != null) {
        getIt<Talker>().info('AddTrainerScreen: Dispatching AddTrainer event');
        // Convert time to seconds
        int? timeInSeconds;
        if (_timeController.text.isNotEmpty) {
          final parsed = int.tryParse(_timeController.text);
          if (parsed != null) {
            timeInSeconds = _timeUnitMinutes ? parsed * 60 : parsed;
          }
        }
        context.read<TrainersBloc>().add(
          AddTrainer(
            userId: user.uid,
            timeRequiredInSeconds: timeInSeconds?.toString() ?? '',
            title: _titleController.text,
            questions: questions,
            keywords: keywords,
            description: _descriptionController.text,
          ),
        );
        context.pop();
      } else {
        getIt<Talker>().error('AddTrainerScreen: User is null');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.userNotAuthenticated)),
        );
      }
    });
  }

  void _addQuestion() {
    if (_questionController.text.isNotEmpty && _answerController.text.isNotEmpty) {
      setState(() {
        questions.add(
          Question(
            id: getIt<Uuid>().v4(),
            textQuestion: _questionController.text,
            rightAnswer: _answerController.text,
            answers: [_answerController.text],
          ),
        );
        _questionController.clear();
        _answerController.clear();
      });
    }
  }

  void _updateQuestion(String id, String text, String rightAnswer, List<String> answers) {
    setState(() {
      final idx = questions.indexWhere((q) => q.id == id);
      if (idx != -1) {
        questions[idx] = Question(
          id: id,
          textQuestion: text,
          rightAnswer: rightAnswer,
          answers: answers,
        );
      }
    });
  }
}

// ── Animated Step Indicator ──
class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.labels,
  });

  final int currentStep;
  final int totalSteps;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      color: AppColorsExt.bg1,
      child: Column(
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              final isActive = index <= currentStep;

              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive ? AppColorsExt.primary : AppColorsExt.bg3,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              final isCurrent = index == currentStep;
              return Text(
                labels[index],
                style: TextStyles.deskSemi.copyWith(
                  color: isCurrent ? AppColorsExt.primary : AppColorsExt.fill3,
                  fontSize: 10,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Bottom sheet widgets for AI auto-generation flow
// ═══════════════════════════════════════════════════════════════════════════════

/// Bottom sheet: enter the number of questions to generate.
class _QuestionCountSheet extends StatefulWidget {
  const _QuestionCountSheet({required this.l10n});
  final AppLocalizations l10n;

  @override
  State<_QuestionCountSheet> createState() => _QuestionCountSheetState();
}

class _QuestionCountSheetState extends State<_QuestionCountSheet> {
  final _controller = TextEditingController(text: '5');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: widget.l10n.questionCount,
            controller: _controller,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(
            text: widget.l10n.next,
            onTap: () => Navigator.pop(context, int.tryParse(_controller.text) ?? 5),
          ),
          const SizedBox(height: 8),
          AppSecondaryButton(
            text: widget.l10n.cancel,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet: enter the topic / prompt for AI generation.
class _TopicSheet extends StatefulWidget {
  const _TopicSheet({required this.l10n});
  final AppLocalizations l10n;

  @override
  State<_TopicSheet> createState() => _TopicSheetState();
}

class _TopicSheetState extends State<_TopicSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: widget.l10n.describeTopic,
            controller: _controller,
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(
            text: widget.l10n.generate,
            icon: Icons.auto_awesome,
            onTap: () => Navigator.pop(context, _controller.text),
          ),
          const SizedBox(height: 8),
          AppSecondaryButton(
            text: widget.l10n.cancel,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Animated loading screen for AI trainer generation
// ═══════════════════════════════════════════════════════════════════════════════

/// Full-screen animated loading with rotating icon and cycling status messages.
class _AiGenerationLoading extends StatefulWidget {
  const _AiGenerationLoading({required this.l10n});
  final AppLocalizations l10n;

  @override
  State<_AiGenerationLoading> createState() => _AiGenerationLoadingState();
}

class _AiGenerationLoadingState extends State<_AiGenerationLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _currentMessageIndex = 0;

  static const _statusMessages = [
    'generatingStatus1',
    'generatingStatus2',
    'generatingStatus3',
    'generatingStatus4',
    'generatingStatus5',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Cycle through status messages every 2.5 seconds
    _startMessageCycle();
  }

  void _startMessageCycle() {
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _currentMessageIndex =
              (_currentMessageIndex + 1) % _statusMessages.length;
        });
        _startMessageCycle();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Glowing icon container ──
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColorsExt.primary.withValues(alpha: 0.2),
                    AppColorsExt.primary.withValues(alpha: 0.05),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColorsExt.primary.withValues(alpha: 0.25),
                    blurRadius: 32,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: RotationTransition(
                turns: _controller,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColorsExt.primary, AppColorsExt.primaryPress],
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ── Animated dots ──
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                final delay = i * 300;
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    final value = ((_controller.value * 1000 + delay) % 1000) / 1000;
                    final scale = 0.5 + (value * 0.5);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColorsExt.primary.withValues(
                              alpha: 0.4 + (value * 0.6),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 32),

            // ── Status message ──
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.15),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: Text(
                _getStatusMessage(),
                key: ValueKey(_currentMessageIndex),
                style: TextStyles.h3.copyWith(
                  color: AppColorsExt.fill1,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              widget.l10n.pleaseWait,
              style: TextStyles.text.copyWith(
                color: AppColorsExt.fill3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusMessage() {
    switch (_currentMessageIndex) {
      case 0: return widget.l10n.generatingStatus1;
      case 1: return widget.l10n.generatingStatus2;
      case 2: return widget.l10n.generatingStatus3;
      case 3: return widget.l10n.generatingStatus4;
      case 4: return widget.l10n.generatingStatus5;
      default: return widget.l10n.generatingStatus1;
    }
  }
}
