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
    required this.totalQuestions,
    required this.currentRightAnswers,
    required this.currentUnansweredCount,
    required this.isAnswerChecked,
    this.selectedAnswer,
  });
  final int remainingTime;
  final Question currentQuestion;
  final int currentQuestionIndex;
  final int totalQuestions;
  final int currentRightAnswers;
  final int currentUnansweredCount;
  final bool isAnswerChecked;
  final String? selectedAnswer;

  TrainProcessInProgress copyWith({
    int? remainingTime,
    Question? currentQuestion,
    int? currentQuestionIndex,
    int? totalQuestions,
    int? currentRightAnswers,
    int? currentUnansweredCount,
    bool? isAnswerChecked,
    String? selectedAnswer,
  }) {
    return TrainProcessInProgress(
      remainingTime: remainingTime ?? this.remainingTime,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      currentRightAnswers: currentRightAnswers ?? this.currentRightAnswers,
      currentUnansweredCount: currentUnansweredCount ?? this.currentUnansweredCount,
      isAnswerChecked: isAnswerChecked ?? this.isAnswerChecked,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }

  @override
  List<Object> get props => [
    remainingTime,
    currentQuestion,
    currentQuestionIndex,
    totalQuestions,
    currentRightAnswers,
    currentUnansweredCount,
    isAnswerChecked,
    selectedAnswer ?? '',
  ];
}


class TrainProcessCompleted extends TrainProcessState {

  const TrainProcessCompleted({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.unansweredCount,
  });
  final int totalQuestions;
  final int correctAnswers;
  final int unansweredCount;
}

class TrainProcessError extends TrainProcessState {

  const TrainProcessError({required this.errorMessage});
  final String errorMessage;
}
