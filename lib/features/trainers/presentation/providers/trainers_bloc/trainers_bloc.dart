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
  List<Trainer> trainers = [];
  List<Trainer> filteredTrainers = []; // New list for filtered trainers

  TrainersBloc({required this.repository}) : super(TrainersInitial()) {
    on<DeleteTrainer>(_onDeleteTrainer);
    on<AddTrainer>(_onAddTrainer);
    on<LoadTrainers>(_onLoadTrainers);
    on<SearchTrainers>(_onSearchTrainers);
    on<SortTrainers>(_onSortTrainers);
  }

  FutureOr<void> _onLoadTrainers(
    LoadTrainers event,
    Emitter<TrainersState> emit,
  ) async {
    emit(TrainersLoading());
    try {
      trainers = await repository.getTrainers();
      filteredTrainers = List.from(trainers); // Initialize filtered list with all trainers
      emit(TrainersLoadSuccess(filteredTrainers));
    } catch (e) {
      getIt<Talker>().error(e);
      emit(TrainersLoadFailure(e.toString()));
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
      trainers = List.from(trainers)..add(newTrainer);
      filteredTrainers = List.from(trainers); // Update filtered list as well
      emit(TrainersLoadSuccess(filteredTrainers));
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
      trainers = List.from(trainers)..removeWhere((t) => t.id == event.trainer.id);
      filteredTrainers = List.from(trainers); // Ensure filtered list is updated
      emit(TrainersLoadSuccess(filteredTrainers));
    } on DeleteTrainerException catch (e) {
      getIt<Talker>().error(e);
      emit(TrainersLoadFailure(e.message));
    } catch (e) {
      getIt<Talker>().error(e);
      emit(TrainersLoadFailure('Ошибка удаления тренажера'));
    }
  }

  FutureOr<void> _onSearchTrainers(
    SearchTrainers event,
    Emitter<TrainersState> emit,
  ) async {
    if (event.query.isEmpty) {
      filteredTrainers = List.from(trainers); 
      emit(TrainersLoadSuccess(filteredTrainers));
    } else {
      final query = event.query.toLowerCase();

      filteredTrainers = trainers.where((trainer) {
        return trainer.title.toLowerCase().contains(query) ||
            trainer.keywords.any(
              (keyword) => keyword.toLowerCase().contains(query),
            );
      }).toList();

      emit(TrainersLoadSuccess(filteredTrainers)); 
    }
  }
   FutureOr<void> _onSortTrainers(
    SortTrainers event,
    Emitter<TrainersState> emit,
  ) {
    switch (event.sortBy) {
      case 'title':
        filteredTrainers.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'createdAt':
        filteredTrainers.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 'questions':
        filteredTrainers.sort((a, b) => a.questions.length.compareTo(b.questions.length));
        break;
      default:
        break;
    }
    emit(TrainersLoadSuccess(filteredTrainers));
  }
}
