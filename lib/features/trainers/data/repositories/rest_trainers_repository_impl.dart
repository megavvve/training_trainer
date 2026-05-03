import 'package:training_trainer/core/network/rest_client.dart';
import 'package:training_trainer/features/trainers/data/datasources/trainers_dto.dart';
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/domain/repositories/trainiers_repository.dart';

/// REST API implementation of TrainersRepository
class RestTrainersRepositoryImpl implements TrainersRepository {
  final RestClient _restClient;

  RestTrainersRepositoryImpl(this._restClient);

  @override
  Future<List<Trainer>> getTrainers() async {
    try {
      final response = await _restClient.get('/api/v1/trainers');
      final trainers = (response as List?)
          ?.map((item) => TrainerDTO.fromJson(item as Map<String, dynamic>))
          .toList();
      return trainers?.map((dto) => _trainerDtoToEntity(dto)).toList() ?? [];
    } on RestClientException catch (e) {
      throw Exception('Failed to fetch trainers: ${e.message}');
    }
  }

  @override
  Future<Trainer?> getTrainerById(String id) async {
    try {
      final response = await _restClient.get('/api/v1/trainers/$id');
      final dto = TrainerDTO.fromJson(response);
      return _trainerDtoToEntity(dto);
    } on NotFoundException {
      return null;
    } on RestClientException catch (e) {
      throw Exception('Failed to fetch trainer: ${e.message}');
    }
  }

  @override
  Future<void> addTrainer(Trainer trainer) async {
    try {
      final dto = CreateTrainerRequestDTO(
        title: trainer.title,
        description: trainer.description,
        questions: trainer.questions
            .map(
              (q) => QuestionDTO(
                id: q.id,
                question: q.textQuestion,
                correctAnswer: q.rightAnswer,
                distractors: q.answers
                    .where((answer) => answer != q.rightAnswer)
                    .toList(),
              ),
            )
            .toList(),
        keywords: trainer.keywords,
        timeRequiredInSeconds: trainer.timeRequiredInSeconds,
      );

      await _restClient.post('/api/v1/trainers', body: dto.toJson());
    } on RestClientException catch (e) {
      throw Exception('Failed to create trainer: ${e.message}');
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
                question: q.textQuestion,
                correctAnswer: q.rightAnswer,
                distractors: q.answers
                    .where((answer) => answer != q.rightAnswer)
                    .toList(),
              ),
            )
            .toList(),
        keywords: trainer.keywords,
        timeRequiredInSeconds: trainer.timeRequiredInSeconds,
      );

      await _restClient.put(
        '/api/v1/trainers/${trainer.id}',
        body: dto.toJson(),
      );
    } on RestClientException catch (e) {
      throw Exception('Failed to update trainer: ${e.message}');
    }
  }

  @override
  Future<void> deleteTrainer(String id) async {
    try {
      await _restClient.delete('/api/v1/trainers/$id');
    } on RestClientException catch (e) {
      throw Exception('Failed to delete trainer: ${e.message}');
    }
  }

  @override
  Future<List<Trainer>> getTopTrainers() async {
    try {
      final response = await _restClient.get('/api/v1/trainers/top');
      final trainers = (response as List?)
          ?.map((item) => TrainerDTO.fromJson(item as Map<String, dynamic>))
          .toList();
      return trainers?.map((dto) => _trainerDtoToEntity(dto)).toList() ?? [];
    } on RestClientException catch (e) {
      throw Exception('Failed to fetch top trainers: ${e.message}');
    }
  }

  @override
  Future<List<Trainer>> searchTrainers(
    String searchQuery,
    Map<String, dynamic> filters,
  ) async {
    try {
      final params = {'q': searchQuery, ...filters};

      // Build query string
      final queryString = Uri(
        queryParameters: params,
      ).query.split('&').where((p) => p.isNotEmpty).join('&');
      final path = queryString.isEmpty
          ? '/api/v1/trainers/search'
          : '/api/v1/trainers/search?$queryString';

      final response = await _restClient.get(path);
      final trainers = (response as List?)
          ?.map((item) => TrainerDTO.fromJson(item as Map<String, dynamic>))
          .toList();
      return trainers?.map((dto) => _trainerDtoToEntity(dto)).toList() ?? [];
    } on RestClientException catch (e) {
      throw Exception('Failed to search trainers: ${e.message}');
    }
  }

  /// Convert TrainerDTO to Trainer entity
  Trainer _trainerDtoToEntity(TrainerDTO dto) {
    return Trainer(
      id: dto.id,
      userId: dto.userId,
      title: dto.title,
      description: dto.description,
      questions: dto.questions
          .map(
            (q) => Question(
              id: q.id,
              textQuestion: q.question,
              rightAnswer: q.correctAnswer,
              answers: [q.correctAnswer, ...q.distractors],
            ),
          )
          .toList(),
      keywords: dto.keywords,
      timeRequiredInSeconds: dto.timeRequiredInSeconds,
      starCount: dto.starCount.toDouble(),
    );
  }
}
