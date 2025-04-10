import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/errors/exceptions.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/domain/repositories/trainiers_repository.dart';
import 'package:uuid/uuid.dart';

part 'trainers_event.dart';
part 'trainers_state.dart';

class TrainersBloc extends Bloc<TrainersEvent, TrainersState> {
  final TrainersRepository repository;
  List<Trainer> _currentTrainers = [];

  TrainersBloc({required this.repository}) : super(TrainersInitial()) {
    on<LoadTrainers>(_onLoadTrainers);
    on<DeleteTrainer>(_onDeleteTrainer);
    on<AddTrainer>(_onAddTrainer);
  }

  FutureOr<void> _onLoadTrainers(
    LoadTrainers event,
    Emitter<TrainersState> emit,
  ) async {
    emit(TrainersLoading());
    try {
      _currentTrainers = await repository.getTrainers();
      emit(TrainersLoaded(_currentTrainers));
    } on LoadTrainersException catch (e) {
      getIt<Talker>().error(e);
      emit(TrainersLoadFailure(e.message));
    } catch (e) {
      getIt<Talker>().error(e);
      emit(TrainersLoadFailure('Неизвестная ошибка'));
    }
  }

  FutureOr<void> _onAddTrainer(
    AddTrainer event,
    Emitter<TrainersState> emit,
  ) async {
    emit(TrainersLoading());
    try {
      final newTrainer = Trainer(
        id: getIt<Uuid>().v4(),
        userId: getIt<FirebaseAuth>().currentUser!.uid,
        starCount: 0,
        timeRequiredInSeconds: int.parse(event.timeRequiredInSeconds) * 60,
        title: event.title,
        questions: event.questions,
        keywords: event.keywords,
        description: event.description,
        createdAt: DateTime.now(),
      );
      await repository.addTrainer(newTrainer);
      _currentTrainers = List.from(_currentTrainers)..add(newTrainer);
      emit(TrainersLoaded(_currentTrainers));
    } on AddTrainerException catch (e) {
      getIt<Talker>().error(e);
      emit(TrainersLoadFailure(e.message));
    } catch (e) {
      getIt<Talker>().error(e);
      emit(TrainersLoadFailure('Ошибка добавления тренажера'));
    }
  }

  FutureOr<void> _onDeleteTrainer(
    DeleteTrainer event,
    Emitter<TrainersState> emit,
  ) async {
    emit(TrainersLoading());
    try {
      await repository.deleteTrainer(event.trainer.id);
      _currentTrainers = List.from(_currentTrainers)
        ..removeWhere((t) => t.id == event.trainer.id);
      emit(TrainersLoaded(_currentTrainers));
    } on DeleteTrainerException catch (e) {
      getIt<Talker>().error(e);
      emit(TrainersLoadFailure(e.message));
    } catch (e) {
      getIt<Talker>().error(e);
      emit(TrainersLoadFailure('Ошибка удаления тренажера'));
    }
  }
}
