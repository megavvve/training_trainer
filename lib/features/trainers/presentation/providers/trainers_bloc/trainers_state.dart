part of 'trainers_bloc.dart';

@immutable
sealed class TrainersState {}

class TrainersInitial extends TrainersState {}

class TrainersLoading extends TrainersState {}

class TrainersLoadSuccess extends TrainersState {
  TrainersLoadSuccess(this.trainers);
  final List<Trainer> trainers;
}


class TrainersLoadFailure extends TrainersState {
  TrainersLoadFailure(this.error);
  final String error;
}
