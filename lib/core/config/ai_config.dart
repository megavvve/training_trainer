abstract class AIConfig {
  String get apiKey;
  String get modelName;
}

class GeminiConfig implements AIConfig {
  @override final String apiKey;
  @override final String modelName;

  GeminiConfig(this.apiKey, {this.modelName = 'gemini-2.0-flash'});
}
class MistralConfig implements AIConfig {
  @override
  final String apiKey;
  @override
  final String modelName;

  MistralConfig(this.apiKey, {this.modelName = 'mistral-large-latest'});
}