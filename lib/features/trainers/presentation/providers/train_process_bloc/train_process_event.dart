part of 'train_process_bloc.dart';

sealed class TrainProcessEvent extends Equatable {
  const TrainProcessEvent();

  @override
  List<Object> get props => [];
}

class StartTrainingSession extends TrainProcessEvent {
  final Trainer trainer;

  const StartTrainingSession({required this.trainer});
}

class AnswerQuestion extends TrainProcessEvent {
  final String selectedAnswer;


  const AnswerQuestion({required this.selectedAnswer, });
}

class UpdateTimer extends TrainProcessEvent {
  final int timeRemaining;

  const UpdateTimer({required this.timeRemaining});
}

class FinishTrainingSession extends TrainProcessEvent {
  final int correctAnswers;

  const FinishTrainingSession({required this.correctAnswers});
}
class NextQuestion extends TrainProcessEvent {


  const NextQuestion();
}
class SelectAnswer extends TrainProcessEvent {
  final String answer;

  const SelectAnswer({required this.answer});
}

class CheckAnswer extends TrainProcessEvent {}