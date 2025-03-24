import 'package:training_trainer/features/questions/domain/entities/question.dart';
import 'package:training_trainer/features/questions/data/models/question_from_code_war.dart';

abstract class QuestionRepo {
  Future<QuestionFromCodeWars?> fetchQuestion();
  Future<List<Question>> fetchAllQuestions();
}
