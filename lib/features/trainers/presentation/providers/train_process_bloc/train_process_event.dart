part of 'train_process_bloc.dart';

sealed class TrainProcessEvent extends Equatable {
  const TrainProcessEvent();

  @override
  List<Object> get props => [];
}

class StartTrainingSession extends TrainProcessEvent {

  const StartTrainingSession({required this.trainer});
  final Trainer trainer;
}

class AnswerQuestion extends TrainProcessEvent {


  const AnswerQuestion({required this.selectedAnswer, });
  final String selectedAnswer;
}

class UpdateTimer extends TrainProcessEvent {

  const UpdateTimer({required this.timeRemaining});
  final int timeRemaining;
}

class FinishTrainingSession extends TrainProcessEvent {

  const FinishTrainingSession({required this.correctAnswers});
  final int correctAnswers;
}
class NextQuestion extends TrainProcessEvent {


  const NextQuestion();
}
class SelectAnswer extends TrainProcessEvent {

  const SelectAnswer({required this.answer});
  final String answer;
}

class CheckAnswer extends TrainProcessEvent {}