import 'package:training_trainer/core/config/ai_config.dart';
import 'package:training_trainer/core/services/ai/gemini_generator.dart';

class AIGeneratorFactory {
  static GeminiGenerator create(AIConfig config) {
    if (config is GeminiConfig) {
      return GeminiGenerator(config.apiKey)..initialize();
    }
    throw UnsupportedError('Unsupported AI provider');
  }
}