
import 'package:training_trainer/features/questions/data/models/repositories/question_repo_impl.dart';
import 'package:training_trainer/features/questions/domain/entities/question.dart';
import 'package:bloc/bloc.dart';

part 'question_list_event.dart';
part 'question_list_state.dart';

class QuestionListBloc extends Bloc<QuestionListEvent, QuestionListState> {
  final QuestionRepoImpl questionRepo;
  QuestionListBloc({required this.questionRepo})
      : super(QuestionListInitialState()) {
    on<LoadQuestionsEvent>(_onLoadQuestions);
  }

  Future<void> _onLoadQuestions(
      LoadQuestionsEvent event, Emitter<QuestionListState> emit) async {
    emit(QuestionListLoadingState());
    try {
      final List<Question> questions = await questionRepo.fetchAllQuestions();
      emit(QuestionListLoadedState(questions));
    } catch (e) {
      emit(QuestionListErrorState("Не удалось загрузить список вопросов."));
    }
  }
}
