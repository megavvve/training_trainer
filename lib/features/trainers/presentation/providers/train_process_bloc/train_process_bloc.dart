import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';

part 'train_process_event.dart';
part 'train_process_state.dart';

class TrainProcessBloc extends Bloc<TrainProcessEvent, TrainProcessState> {
  late List<Question> _questions;
  int _remainingTime = 0;
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  Timer? _timer;

  String? _selectedAnswer;
  bool _isAnswerChecked = false;
  TrainProcessBloc() : super(TrainProcessInitial()) {
    on<StartTrainingSession>(_onStartTrainingSession);
    on<SelectAnswer>(_onSelectAnswer);
    on<CheckAnswer>(_onCheckAnswer);
    on<NextQuestion>(_onNextQuestion);
    on<UpdateTimer>(_onUpdateTimer);
    on<FinishTrainingSession>(_onFinishTrainingSession);
  }

  FutureOr<void> _onStartTrainingSession(
    StartTrainingSession event,
    Emitter<TrainProcessState> emit,
  ) {
    try {
      final trainer = event.trainer.copyWith(
        questions:
            event.trainer.questions
                .map((x) => x.copyWith(answers: _prepareAnswers(x)))
                .toList(),
      );
      _initializeSession(trainer);
      _startTimer();
      emit(
        TrainProcessInProgress(
          remainingTime: _remainingTime,
          currentQuestion: _questions[_currentQuestionIndex],
          currentQuestionIndex: _currentQuestionIndex,
          currentRightAnswers: _correctAnswers,
    
          isAnswerChecked: false,
          selectedAnswer: null,
        ),
      );
    } catch (e) {
      emit(TrainProcessError(errorMessage: 'Ошибка запуска тренировки'));
    }
  }

  FutureOr<void> _onSelectAnswer(
    SelectAnswer event,
    Emitter<TrainProcessState> emit,
  ) {
    if (_isAnswerChecked) return Future.value();

    _selectedAnswer = event.answer;
    emit(
      (state as TrainProcessInProgress).copyWith(
        selectedAnswer: _selectedAnswer,
      ),
    );
  }

  FutureOr<void> _onCheckAnswer(
    CheckAnswer event,
    Emitter<TrainProcessState> emit,
  ) {
    final current = state as TrainProcessInProgress;
    final isCorrect = _selectedAnswer == current.currentQuestion.rightAnswer;

    emit(
      current.copyWith(
        selectedAnswer: _selectedAnswer,
        isAnswerChecked: true,
        
        currentRightAnswers: isCorrect ? _correctAnswers + 1 : _correctAnswers,
      ),
    );

    if (isCorrect) _correctAnswers++;
  }

  FutureOr<void> _onNextQuestion(
    NextQuestion event,
    Emitter<TrainProcessState> emit,
  ) {
    _currentQuestionIndex++;
    _selectedAnswer = null;
    _isAnswerChecked = false;

    if (_currentQuestionIndex >= _questions.length) {
      add(FinishTrainingSession(correctAnswers: _correctAnswers));
      return Future.value();
    }

    emit(
      (state as TrainProcessInProgress).copyWith(
        currentQuestion: _questions[_currentQuestionIndex],
        currentQuestionIndex: _currentQuestionIndex,
        selectedAnswer: null,
        isAnswerChecked: false,
      ),
    );
  }

  FutureOr<void> _onUpdateTimer(
    UpdateTimer event,
    Emitter<TrainProcessState> emit,
  ) {
    final currentState = state as TrainProcessInProgress;

    emit(
      currentState.copyWith(
        remainingTime: event.timeRemaining,
        currentQuestion: currentState.currentQuestion,
        currentQuestionIndex: currentState.currentQuestionIndex,
        currentRightAnswers: currentState.currentRightAnswers,
        isAnswerChecked: currentState.isAnswerChecked,
        selectedAnswer: currentState.selectedAnswer,
      ),
    );
  }

  FutureOr<void> _onFinishTrainingSession(
    FinishTrainingSession event,
    Emitter<TrainProcessState> emit,
  ) {
    _timer?.cancel();
    emit(
      TrainProcessCompleted(
        totalQuestions: _questions.length,
        correctAnswers: event.correctAnswers,
      ),
    );
    return Future.value();
  }

  void _initializeSession(Trainer trainer) {
    _questions = trainer.questions;
    _remainingTime = 300; //TODO
    _currentQuestionIndex = 0;
    _correctAnswers = 0;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        add(UpdateTimer(timeRemaining: _remainingTime));
      } else {
        add(FinishTrainingSession(correctAnswers: _correctAnswers));
      }
    });
  }
}

List<String> _prepareAnswers(Question question) {
  final answers = List<String>.from(question.answers);
  if (!answers.contains(question.rightAnswer)) {
    answers.add(question.rightAnswer);
  }
  answers.shuffle();
  return answers;
}
