import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trainers_event.dart';
part 'trainers_state.dart';

class TrainersBloc extends Bloc<TrainersEvent, TrainersState> {
  TrainersBloc() : super(TrainersInitial()) {
    on<TrainersEvent>((event, emit) {
      // TODO: загрузка тренажеров
    });
  }
}
