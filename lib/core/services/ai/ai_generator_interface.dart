abstract class AIGenerator {
  Future<List<String>> generateWrongAnswers({
    required String question,
    required String correctAnswer,
    int count = 3,
  });

  Future<List<String>> generateKeywords({
    required String text,
    int count = 5,
  });

  Future<void> initialize();
  void dispose();
}