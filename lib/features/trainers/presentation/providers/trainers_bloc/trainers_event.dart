part of 'trainers_bloc.dart';

@immutable
sealed class TrainersEvent {}

final class DeleteTrainer extends TrainersEvent {
  final Trainer trainer;
  DeleteTrainer(this.trainer);
}

class LoadTrainers extends TrainersEvent {}

final class AddTrainer extends TrainersEvent {
  final String timeRequiredInSeconds;
  final String title;
  final List<Question> questions;
  final List<String> keywords;
  final String description;

  AddTrainer({
    required this.timeRequiredInSeconds,
    required this.title,
    required this.questions,
    required this.keywords,
    required this.description,
  });
}
class SortTrainers extends TrainersEvent {
  final String sortBy;

  SortTrainers({required this.sortBy});
}
class SearchTrainers extends TrainersEvent {
  final String query;

  SearchTrainers({required this.query});
}