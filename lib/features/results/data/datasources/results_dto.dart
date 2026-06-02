import 'package:training_trainer/features/results/domain/entities/training_result.dart';

class TrainingResultDTO {

  TrainingResultDTO({
    required this.id,
    required this.userId,
    required this.trainerId,
    required this.correctAnswers,
    required this.unansweredCount,
    required this.totalQuestions,
    required this.scorePercent,
    required this.completedAt,
    this.trainerTitle = '',
  });

  factory TrainingResultDTO.fromJson(Map<String, dynamic> json) {
    return TrainingResultDTO(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? json['user_id'] as String? ?? '',
      trainerId: json['trainerId'] as String? ?? json['trainer_id'] as String? ?? '',
      correctAnswers: json['correctAnswers'] as int? ?? json['correct_answers'] as int? ?? 0,
      unansweredCount: json['unansweredCount'] as int? ?? json['unanswered_count'] as int? ?? 0,
      totalQuestions: json['totalQuestions'] as int? ?? json['total_questions'] as int? ?? 0,
      scorePercent: (json['scorePercent'] ?? json['score_percent'] ?? 0.0).toDouble(),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : (json['completed_at'] != null ? DateTime.parse(json['completed_at']) : DateTime.now()),
      trainerTitle: json['trainerTitle'] as String? ?? json['trainer_title'] as String? ?? '',
    );
  }
  final String id;
  final String userId;
  final String trainerId;
  final int correctAnswers;
  final int unansweredCount;
  final int totalQuestions;
  final double scorePercent;
  final DateTime completedAt;
  final String trainerTitle;

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'trainerId': trainerId,
    'correctAnswers': correctAnswers,
    'unansweredCount': unansweredCount,
    'totalQuestions': totalQuestions,
    'scorePercent': scorePercent,
    'completedAt': completedAt.toIso8601String(),
    'trainerTitle': trainerTitle,
  };

  TrainingResult toEntity() {
    return TrainingResult(
      id: id,
      userId: userId,
      trainerId: trainerId,
      correctAnswers: correctAnswers,
      unansweredCount: unansweredCount,
      totalQuestions: totalQuestions,
      scorePercent: scorePercent,
      completedAt: completedAt,
      trainerTitle: trainerTitle,
    );
  }
}

class CreateResultRequestDTO {

  CreateResultRequestDTO({
    required this.trainerId,
    required this.correctAnswers,
    required this.unansweredCount,
    required this.totalQuestions,
  });
  final String trainerId;
  final int correctAnswers;
  final int unansweredCount;
  final int totalQuestions;

  double get scorePercent => totalQuestions > 0
      ? (correctAnswers / totalQuestions) * 100
      : 0.0;

  Map<String, dynamic> toJson() => {
    'trainerId': trainerId,
    'correctAnswers': correctAnswers,
    'unansweredCount': unansweredCount,
    'totalQuestions': totalQuestions,
    'scorePercent': scorePercent,
  };
}
