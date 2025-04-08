import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:talker/talker.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/errors/exceptions.dart';
import 'package:training_trainer/core/services/ai/ai_generator_interface.dart';

class GeminiGenerator implements AIGenerator {
  final String apiKey;
  late GenerativeModel _model;

  GeminiGenerator(this.apiKey);

  @override
  Future<void> initialize() async {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
    );
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

      final response = await _model.generateContent([Content.text(prompt)]);
      return _parseResponse(response.text ?? '');
    } catch (e) {
      getIt<Talker>().error('Gemini error: ${e.toString()}');
      throw AIGenerationException('Gemini error: ${e.toString()}');
      
    }
  }

  @override
  Future<List<String>> generateKeywords({
    required String text,
    int count = 5,
  }) async {
    final prompt = '''
Extract $count key technical terms from the text:
"$text"

Format: comma-separated list
''';

    final response = await _model.generateContent([Content.text(prompt)]);
    return _parseResponse(response.text ?? '');
  }

  List<String> _parseResponse(String response) {
    return response.split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
  }

  @override
  void dispose() {
    // Очистка ресурсов при необходимости
  }
}