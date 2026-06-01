part of 'trainers_bloc.dart';

@immutable
sealed class TrainersState {}

class TrainersInitial extends TrainersState {}

class TrainersLoading extends TrainersState {}

class TrainersLoadSuccess extends TrainersState {
  TrainersLoadSuccess(
    this.trainers, {
    this.isDeleteMode = false,
    this.isRefreshing = false,
  });

  final List<Trainer> trainers;
  final bool isDeleteMode;
  final bool isRefreshing;

  TrainersLoadSuccess copyWith({
    List<Trainer>? trainers,
    bool? isDeleteMode,
    bool? isRefreshing,
  }) {
    return TrainersLoadSuccess(
      trainers ?? this.trainers,
      isDeleteMode: isDeleteMode ?? this.isDeleteMode,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}


class TrainersLoadFailure extends TrainersState {
  TrainersLoadFailure(this.error);
  final String error;
}
