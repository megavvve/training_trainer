import 'package:mistralai_client_dart/mistralai_client_dart.dart';
import 'package:talker/talker.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/errors/exceptions.dart';
import 'package:training_trainer/core/services/ai/ai_generator_interface.dart';

class MistralGenerator implements AIGenerator {
  final String _apiKey;
  final String _model;
  late MistralAIClient _client;

  MistralGenerator(this._apiKey, {String? model})
      : _model = model ?? 'mistral-large-latest';

  @override
  Future<void> initialize() async {
    _client = MistralAIClient(apiKey: _apiKey);
  }

  @override
  Future<List<String>> generateWrongAnswers({
    required String question,
    required String correctAnswer,
    int count = 3,
  }) async {
    try {
      final prompt = '''
Generate $count incorrect but plausible answers for the question:
"$question"

Correct answer: "$correctAnswer"

Requirements:
- Answers must sound realistic
- Do not repeat correct answer
- Format: comma-separated list
''';

      final request = ChatCompletionRequest(
        model: _model,
        messages: [
          UserMessage(content: UserMessageContent.string(prompt)),
        ],
      );

      final response = await _client.chatComplete(request: request);
      final content = response.choices?.firstOrNull?.message.content?.value.toString();
      
      if (content == null) {
        throw AIGenerationException('Empty response from Mistral');
      }
      
      return _parseResponse(content);
    } catch (e) {
      getIt<Talker>().error('Mistral error: ${e.toString()}');
      throw AIGenerationException('Mistral error: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> generateKeywords({
    required String text,
    int count = 5,
  }) async {
    try {
      final prompt = '''
Extract $count key technical terms from the text:
"$text"

Format: comma-separated list
''';

      final request = ChatCompletionRequest(
        model: _model,
        messages: [
          UserMessage(content: UserMessageContent.string(prompt)),
        ],
      );

      final response = await _client.chatComplete(request: request);
      final content = response.choices?.firstOrNull?.message.content?.value.toString();
      
      if (content == null) {
        throw AIGenerationException('Empty response from Mistral');
      }
      
      return _parseResponse(content);
    } catch (e) {
      getIt<Talker>().error('Mistral error: ${e.toString()}');
      throw AIGenerationException('Mistral error: ${e.toString()}');
    }
  }

  List<String> _parseResponse(String response) {
    return response.split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
  }

  @override
  void dispose() {

  }
}