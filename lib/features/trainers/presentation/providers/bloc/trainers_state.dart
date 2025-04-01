part of 'trainers_bloc.dart';

@immutable
sealed class TrainersState {}

final class TrainersInitial extends TrainersState {}

final class TrainersLoading extends TrainersState {}

final class TrainersLoaded extends TrainersState {}

final class TrainersLoadFailure extends TrainersState {}
