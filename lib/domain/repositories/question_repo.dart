import 'package:training_trainer/domain/models/question.dart';
import 'package:training_trainer/domain/models/question_from_code_war.dart';

abstract class QuestionRepo {
  Future<QuestionFromCodeWars?> fetchQuestion();
  Future<List<Question>> fetchAllQuestions();
}
