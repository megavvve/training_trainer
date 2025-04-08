// core/services/ai/ai_generator_factory.dart
import 'package:training_trainer/core/config/ai_config.dart';
import 'package:training_trainer/core/services/ai/ai_generator_interface.dart';
import 'package:training_trainer/core/services/ai/ai_implimentation/gemini_generator.dart';
import 'package:training_trainer/core/services/ai/ai_implimentation/mistral_generator.dart';

class AIGeneratorFactory {
  static AIGenerator create(AIConfig config) {
    if (config is GeminiConfig) {
      return GeminiGenerator(config.apiKey)..initialize();
    } else if (config is MistralConfig) {
      return MistralGenerator(config.apiKey, model: config.modelName)..initialize();
    }
    throw UnsupportedError('Unsupported AI provider');
  }
}