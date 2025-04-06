part of 'trainers_bloc.dart';

@immutable
sealed class TrainersState {}

final class TrainersInitial extends TrainersState {}

final class TrainersLoading extends TrainersState {}

final class TrainersLoaded extends TrainersState {
   final List<Trainer> trainers;
  TrainersLoaded(this.trainers);
}

final class TrainersLoadFailure extends TrainersState {
  final String message;
  TrainersLoadFailure(this.message);
}
