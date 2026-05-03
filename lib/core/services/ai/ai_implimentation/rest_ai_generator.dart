import 'package:training_trainer/core/network/api_client.dart';
import 'package:training_trainer/core/services/ai/ai_generator_interface.dart';

class RestAIGenerator implements AIGenerator {
  final ApiClient _apiClient;

  RestAIGenerator(this._apiClient);

  @override
  Future<void> initialize() async {
    // No initialization needed for REST API
  }

  @override
  Future<List<String>> generateWrongAnswers({
    required String question,
    required String correctAnswer,
    int count = 3,
  }) async {
    try {
      final response = await _apiClient.post(
        '/api/v1/ai/wrong-answers',
        data: {
          'question': question,
          'correct_answer': correctAnswer,
          'count': count,
        },
      );

      final List<dynamic> wrongAnswers = response.data['wrong_answers'];
      return wrongAnswers.cast<String>();
    } catch (e) {
      throw Exception('Failed to generate wrong answers: $e');
    }
  }

  @override
  Future<List<String>> generateKeywords({
    required String text,
    int count = 5,
  }) async {
    try {
      final response = await _apiClient.post(
        '/api/v1/ai/keywords',
        data: {
          'text': text,
          'count': count,
        },
      );

      final List<dynamic> keywords = response.data['keywords'];
      return keywords.cast<String>();
    } catch (e) {
      throw Exception('Failed to generate keywords: $e');
    }
  }

  @override
  void dispose() {
    // No resources to dispose
  }
}
