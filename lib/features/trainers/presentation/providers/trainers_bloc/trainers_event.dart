part of 'trainers_bloc.dart';

@immutable
sealed class TrainersEvent {}

final class DeleteTrainer extends TrainersEvent {
  DeleteTrainer(this.trainer);
  final Trainer trainer;
}

class LoadTrainers extends TrainersEvent {}

final class AddTrainer extends TrainersEvent {

  AddTrainer({
    required this.userId,
    required this.timeRequiredInSeconds,
    required this.title,
    required this.questions,
    required this.keywords,
    required this.description,
  });
  final String userId;
  final String timeRequiredInSeconds;
  final String title;
  final List<Question> questions;
  final List<String> keywords;
  final String description;
}
class SortTrainers extends TrainersEvent {

  SortTrainers({required this.sortBy});
  final String sortBy;
}
class SearchTrainers extends TrainersEvent {

  SearchTrainers({required this.query});
  final String query;
}