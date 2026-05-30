import 'package:training_trainer/core/network/api_client.dart';
import 'package:training_trainer/features/results/data/datasources/results_dto.dart';
import 'package:training_trainer/features/results/domain/entities/training_result.dart';
import 'package:training_trainer/features/results/domain/repositories/results_repository.dart';

class RestResultsRepositoryImpl implements ResultsRepository {

  RestResultsRepositoryImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<List<TrainingResult>> getMyResults() async {
    try {
      final response = await _apiClient.get('/api/v1/results/me');
      final results = (response.data as List?)
          ?.map((item) => TrainingResultDTO.fromJson(item as Map<String, dynamic>))
          .toList();
      return results?.map((dto) => dto.toEntity()).toList() ?? [];
    } catch (e) {
      throw Exception('Failed to fetch results: $e');
    }
  }

  @override
  Future<TrainingResult> createResult({
    required String trainerId,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    try {
      final dto = CreateResultRequestDTO(
        trainerId: trainerId,
        correctAnswers: correctAnswers,
        totalQuestions: totalQuestions,
      );

      final response = await _apiClient.post(
        '/api/v1/results',
        data: dto.toJson(),
      );
      return TrainingResultDTO.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to save result: $e');
    }
  }
}
