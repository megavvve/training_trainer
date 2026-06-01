class TrainingResult {

  TrainingResult({
    required this.id,
    required this.userId,
    required this.trainerId,
    required this.correctAnswers,
    required this.unansweredCount,
    required this.totalQuestions,
    required this.scorePercent,
    required this.completedAt,
  });
  final String id;
  final String userId;
  final String trainerId;
  final int correctAnswers;
  final int unansweredCount;
  final int totalQuestions;
  final double scorePercent;
  final DateTime completedAt;

  @override
  String toString() {
    return 'TrainingResult(id: $id, userId: $userId, trainerId: $trainerId, score: $scorePercent%)';
  }
}
