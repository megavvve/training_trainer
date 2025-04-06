part of 'trainers_bloc.dart';

@immutable
sealed class TrainersEvent {}

final class LoadTrainers extends TrainersEvent {
  
  LoadTrainers();
}

final class DeleteTrainer extends TrainersEvent {
  final Trainer trainer;
  DeleteTrainer(this.trainer);
}
final class AddTrainer extends TrainersEvent {
  final Trainer trainer;
  AddTrainer(this.trainer);
}