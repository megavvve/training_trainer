import 'package:training_trainer/features/results/domain/entities/training_result.dart';

abstract class ResultsRepository {
  /// Get all training results for the current user
  Future<List<TrainingResult>> getMyResults();

  /// Save a new training result
  Future<TrainingResult> createResult({
    required String trainerId,
    required int correctAnswers,
    required int totalQuestions,
  });
}
