import 'package:dio/dio.dart';
import 'package:training_trainer/core/network/api_client.dart';
import 'package:training_trainer/features/trainers/data/datasources/trainers_dto.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/domain/repositories/trainiers_repository.dart';

/// REST API implementation of TrainersRepository using Modern ApiClient
class RestTrainersRepositoryImpl implements TrainersRepository {

  RestTrainersRepositoryImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<List<Trainer>> getTrainers() async {
    try {
      final response = await _apiClient.get('/api/v1/trainers');
      final trainers = (response.data as List?)
          ?.map((item) => TrainerDTO.fromJson(item as Map<String, dynamic>))
          .toList();
      return trainers?.map((dto) => dto.toEntity()).toList() ?? [];
    } catch (e) {
      throw Exception('Failed to fetch trainers: $e');
    }
  }

  @override
  Future<Trainer?> getTrainerById(String id) async {
    try {
      final response = await _apiClient.get('/api/v1/trainers/$id');
      final dto = TrainerDTO.fromJson(response.data);
      return dto.toEntity();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      throw Exception('Failed to fetch trainer: $e');
    } catch (e) {
      throw Exception('Failed to fetch trainer: $e');
    }
  }

  @override
  Future<Trainer> addTrainer(Trainer trainer) async {
    try {
      final dto = CreateTrainerRequestDTO(
        title: trainer.title,
        description: trainer.description,
        questions: trainer.questions
            .map(
              (q) => QuestionDTO(
                id: q.id,
                textQuestion: q.textQuestion,
                rightAnswer: q.rightAnswer,
                answers: q.answers,
              ),
            )
            .toList(),
        keywords: trainer.keywords,
        timeRequiredInSeconds: trainer.timeRequiredInSeconds,
      );

      final response = await _apiClient.post(
        '/api/v1/trainers',
        data: dto.toJson(),
      );
      final newTrainer = TrainerDTO.fromJson(response.data);
      return newTrainer.toEntity();
    } catch (e) {
      throw Exception('Failed to create trainer: $e');
    }
  }

  @override
  Future<void> addTrainers(List<Trainer> trainers) async {
    for (final trainer in trainers) {
      await addTrainer(trainer);
    }
  }

  @override
  Future<void> updateTrainer(Trainer trainer) async {
    try {
      final dto = UpdateTrainerRequestDTO(
        title: trainer.title,
        description: trainer.description,
        questions: trainer.questions
            .map(
              (q) => QuestionDTO(
                id: q.id,
                textQuestion: q.textQuestion,
                rightAnswer: q.rightAnswer,
                answers: q.answers,
              ),
            )
            .toList(),
        keywords: trainer.keywords,
        timeRequiredInSeconds: trainer.timeRequiredInSeconds,
        starCount: trainer.starCount,
      );

      await _apiClient.put(
        '/api/v1/trainers/${trainer.id}',
        data: dto.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update trainer: $e');
    }
  }

  @override
  Future<void> deleteTrainer(String id) async {
    try {
      await _apiClient.delete('/api/v1/trainers/$id');
    } catch (e) {
      throw Exception('Failed to delete trainer: $e');
    }
  }

  @override
  Future<List<Trainer>> getTopTrainers() async {
    try {
      final response = await _apiClient.get('/api/v1/trainers/top');
      final trainers = (response.data as List?)
          ?.map((item) => TrainerDTO.fromJson(item as Map<String, dynamic>))
          .toList();
      return trainers?.map((dto) => dto.toEntity()).toList() ?? [];
    } catch (e) {
      throw Exception('Failed to fetch top trainers: $e');
    }
  }

  @override
  Future<List<Trainer>> searchTrainers(
    String searchQuery,
    Map<String, dynamic> filters,
  ) async {
    try {
      final params = {'q': searchQuery, ...filters};

      final response = await _apiClient.get(
        '/api/v1/trainers/search',
        queryParameters: params,
      );
      final trainers = (response.data as List?)
          ?.map((item) => TrainerDTO.fromJson(item as Map<String, dynamic>))
          .toList();
      return trainers?.map((dto) => dto.toEntity()).toList() ?? [];
    } catch (e) {
      throw Exception('Failed to search trainers: $e');
    }
  }
}
