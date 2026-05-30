part of 'train_process_bloc.dart';

sealed class TrainProcessState extends Equatable {
  const TrainProcessState();

  @override
  List<Object> get props => [];
}

class TrainProcessInitial extends TrainProcessState {}

class TrainProcessInProgress extends TrainProcessState {

  const TrainProcessInProgress({
    required this.remainingTime,
    required this.currentQuestion,
    required this.currentQuestionIndex,
    required this.currentRightAnswers,
    required this.isAnswerChecked,
    this.selectedAnswer,
  });
  final int remainingTime;
  final Question currentQuestion;
  final int currentQuestionIndex;
  final int currentRightAnswers;
  final bool isAnswerChecked;
  final String? selectedAnswer;

  TrainProcessInProgress copyWith({
    int? remainingTime,
    Question? currentQuestion,
    int? currentQuestionIndex,
    int? currentRightAnswers,
    bool? isAnswerChecked,
    String? selectedAnswer,
  }) {
    return TrainProcessInProgress(
      remainingTime: remainingTime ?? this.remainingTime,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentRightAnswers: currentRightAnswers ?? this.currentRightAnswers,
      isAnswerChecked: isAnswerChecked ?? this.isAnswerChecked,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }

  @override
  List<Object> get props => [
    remainingTime,
    currentQuestion, 
    currentQuestionIndex,
    currentRightAnswers,
    isAnswerChecked,
    selectedAnswer ?? '', 
  ];
}


class TrainProcessCompleted extends TrainProcessState {

  const TrainProcessCompleted({
    required this.totalQuestions,
    required this.correctAnswers,
  });
  final int totalQuestions;
  final int correctAnswers;
}

class TrainProcessError extends TrainProcessState {

  const TrainProcessError({required this.errorMessage});
  final String errorMessage;
}
