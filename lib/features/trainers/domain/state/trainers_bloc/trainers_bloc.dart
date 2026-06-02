import 'dart:async';
import 'package:bloc/bloc.dart';
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

  TrainersBloc({required this.repository}) : super(TrainersInitial()) {
    on<DeleteTrainer>(_onDeleteTrainer);
    on<AddTrainer>(_onAddTrainer);
    on<LoadTrainers>(_onLoadTrainers);
    on<SearchTrainers>(_onSearchTrainers);
    on<SortTrainers>(_onSortTrainers);
    on<EnterDeleteMode>(_onEnterDeleteMode);
    on<ExitDeleteMode>(_onExitDeleteMode);
    on<ReorderTrainers>(_onReorderTrainers);
  }
  final TrainersRepository repository;
  List<Trainer> trainers = [];
  List<Trainer> filteredTrainers = [];

  FutureOr<void> _onLoadTrainers(
    LoadTrainers event,
    Emitter<TrainersState> emit,
  ) async {
    // If we already have data, refresh in background without full-screen loading
    if (state is TrainersLoadSuccess) {
      final currentState = state as TrainersLoadSuccess;
      emit(currentState.copyWith(isRefreshing: true));
      try {
        trainers = await repository.getTrainers();
        filteredTrainers = List.from(trainers);
        emit(TrainersLoadSuccess(filteredTrainers, isDeleteMode: currentState.isDeleteMode));
      } catch (e) {
        getIt<Talker>().error('LoadTrainers Error: $e');
        emit(currentState.copyWith(isRefreshing: false));
      }
    } else {
      emit(TrainersLoading());
      try {
        trainers = await repository.getTrainers();
        filteredTrainers = List.from(trainers);
        emit(TrainersLoadSuccess(filteredTrainers));
      } catch (e) {
        getIt<Talker>().error('LoadTrainers Error: $e');
        emit(TrainersLoadFailure('Не удалось загрузить тренажёры'));
      }
    }
  }

  FutureOr<void> _onAddTrainer(
    AddTrainer event,
    Emitter<TrainersState> emit,
  ) async {
    getIt<Talker>().info('TrainersBloc: _onAddTrainer triggered for ${event.title}');
    emit(TrainersLoading());
    try {
      final newTrainerTemplate = Trainer(
        id: getIt<Uuid>().v4(),
        userId: event.userId,
        starCount: 0,
        timeRequiredInSeconds: event.timeRequiredInSeconds.isNotEmpty
            ? int.tryParse(event.timeRequiredInSeconds)
            : null,
        title: event.title,
        questions: event.questions,
        keywords: event.keywords,
        description: event.description,
        createdAt: DateTime.now(),
      );
      
      final savedTrainer = await repository.addTrainer(newTrainerTemplate);
      getIt<Talker>().info('TrainersBloc: Trainer saved successfully with ID: ${savedTrainer.id}');
      
      trainers = List.from(trainers)..add(savedTrainer);
      filteredTrainers = List.from(trainers); 
      emit(TrainersLoadSuccess(filteredTrainers));
    } on AddTrainerException catch (e) {
      getIt<Talker>().error('AddTrainer Error: ${e.message}');
      emit(TrainersLoadFailure(e.message));
    } catch (e) {
      getIt<Talker>().error('AddTrainer Unexpected Error: $e');
      emit(TrainersLoadFailure('Ошибка добавления тренажёра'));
    }
  }

  FutureOr<void> _onDeleteTrainer(
    DeleteTrainer event,
    Emitter<TrainersState> emit,
  ) async {
    final _ = state is TrainersLoadSuccess ? state as TrainersLoadSuccess : null;
    try {
      await repository.deleteTrainer(event.trainer.id);
      trainers = List.from(trainers)..removeWhere((t) => t.id == event.trainer.id);
      filteredTrainers = List.from(trainers);
      // Exit delete mode after deletion
      emit(TrainersLoadSuccess(filteredTrainers));
    } on DeleteTrainerException catch (e) {
      getIt<Talker>().error('DeleteTrainer Error: ${e.message}');
      emit(TrainersLoadFailure(e.message));
    } catch (e) {
      getIt<Talker>().error('DeleteTrainer Unexpected Error: $e');
      // If 404, trainer was already deleted — just refresh
      trainers = List.from(trainers)..removeWhere((t) => t.id == event.trainer.id);
      filteredTrainers = List.from(trainers);
      emit(TrainersLoadSuccess(filteredTrainers));
    }
  }

  FutureOr<void> _onSearchTrainers(
    SearchTrainers event,
    Emitter<TrainersState> emit,
  ) async {
    final currentState = state as TrainersLoadSuccess;
    if (event.query.isEmpty) {
      filteredTrainers = List.from(trainers); 
      emit(currentState.copyWith(trainers: filteredTrainers));
    } else {
      final query = event.query.toLowerCase();
      filteredTrainers = trainers.where((trainer) {
        return trainer.title.toLowerCase().contains(query) ||
            trainer.keywords.any(
              (keyword) => keyword.toLowerCase().contains(query),
            );
      }).toList();
      emit(currentState.copyWith(trainers: filteredTrainers));
    }
  }

  FutureOr<void> _onSortTrainers(
    SortTrainers event,
    Emitter<TrainersState> emit,
  ) {
    final currentState = state as TrainersLoadSuccess;
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
    emit(currentState.copyWith(trainers: filteredTrainers));
  }

  // ── Delete Mode ──

  FutureOr<void> _onEnterDeleteMode(
    EnterDeleteMode event,
    Emitter<TrainersState> emit,
  ) {
    final currentState = state as TrainersLoadSuccess;
    emit(currentState.copyWith(isDeleteMode: true));
  }

  FutureOr<void> _onExitDeleteMode(
    ExitDeleteMode event,
    Emitter<TrainersState> emit,
  ) {
    final currentState = state as TrainersLoadSuccess;
    emit(currentState.copyWith(isDeleteMode: false));
  }

  FutureOr<void> _onReorderTrainers(
    ReorderTrainers event,
    Emitter<TrainersState> emit,
  ) {
    final currentState = state as TrainersLoadSuccess;
    // Reorder filteredTrainers based on the new ID order
    final idToTrainer = {for (final t in filteredTrainers) t.id: t};
    filteredTrainers = event.ids.map((id) => idToTrainer[id]!).toList();
    // Update allTrainers too
    final allMap = {for (final t in trainers) t.id: t};
    trainers = event.ids.where((id) => allMap.containsKey(id)).map((id) => allMap[id]!).toList();
    emit(currentState.copyWith(trainers: filteredTrainers));
  }
}
