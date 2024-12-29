part of 'question_list_bloc.dart';


abstract class QuestionListState {}

class QuestionListInitialState extends QuestionListState {}

class QuestionListLoadingState extends QuestionListState {}

class QuestionListLoadedState extends QuestionListState {
  final List<Question> questions;

  QuestionListLoadedState(this.questions);
}

class QuestionListErrorState extends QuestionListState {
  final String message;

  QuestionListErrorState(this.message);
}
