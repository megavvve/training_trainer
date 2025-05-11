part of 'trainers_bloc.dart';

@immutable
sealed class TrainersState {}

class TrainersInitial extends TrainersState {}

class TrainersLoading extends TrainersState {}

class TrainersLoadSuccess extends TrainersState {
  final List<Trainer> trainers;
  TrainersLoadSuccess(this.trainers);
}


class TrainersLoadFailure extends TrainersState {
  final String error;
  TrainersLoadFailure(this.error);
}
