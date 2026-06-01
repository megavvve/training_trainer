/// DTO for Trainer from REST API
library;
import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';

class TrainerDTO {

  TrainerDTO({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.questions,
    required this.keywords,
    required this.starCount, required this.createdAt, this.timeRequiredInSeconds,
  });

  factory TrainerDTO.fromJson(Map<String, dynamic> json) {
    List<QuestionDTO> parseQuestions(List<dynamic>? questions) {
      if (questions == null) return [];
      return questions
          .map((q) => QuestionDTO.fromJson(q as Map<String, dynamic>))
          .toList();
    }

    List<String> parseKeywords(List<dynamic>? keywords) {
      if (keywords == null) return [];
      return keywords.map((k) => k.toString()).toList();
    }

    // Mapping aliases from backend
    return TrainerDTO(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? json['user_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      questions: parseQuestions(json['questions'] as List<dynamic>?),
      keywords: parseKeywords(json['keywords'] as List<dynamic>?),
      timeRequiredInSeconds: json['timeRequiredInSeconds'] as int? ?? json['time_required_in_seconds'] as int?,
      starCount: (json['starCount'] ?? json['star_count'] ?? 0).toDouble(),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : (json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now()),
    );
  }
  final String id;
  final String userId;
  final String title;
  final String description;
  final List<QuestionDTO> questions;
  final List<String> keywords;
  final int? timeRequiredInSeconds;
  final double starCount;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'description': description,
    'questions': questions.map((q) => q.toJson()).toList(),
    'keywords': keywords,
    if (timeRequiredInSeconds != null) 'timeRequiredInSeconds': timeRequiredInSeconds,
    'starCount': starCount,
    'createdAt': createdAt.toIso8601String(),
  };
  
  Trainer toEntity() {
    return Trainer(
      id: id,
      userId: userId,
      title: title,
      description: description,
      questions: questions.map((q) => q.toEntity()).toList(),
      keywords: keywords,
      timeRequiredInSeconds: timeRequiredInSeconds,
      starCount: starCount,
      createdAt: createdAt,
    );
  }
}

/// DTO for Question from REST API
class QuestionDTO {

  QuestionDTO({
    required this.id,
    required this.textQuestion,
    required this.rightAnswer,
    required this.answers,
  });

  factory QuestionDTO.fromJson(Map<String, dynamic> json) {
    List<String> parseAnswers(List<dynamic>? answers) {
      if (answers == null) return [];
      return answers.map((a) => a.toString()).toList();
    }

    return QuestionDTO(
      id: json['id'] as String? ?? '',
      textQuestion: json['textQuestion'] as String? ?? json['question'] as String? ?? '',
      rightAnswer: json['rightAnswer'] as String? ?? json['correct_answer'] as String? ?? '',
      answers: parseAnswers(json['answers'] as List<dynamic>?),
    );
  }
  final String id;
  final String textQuestion;
  final String rightAnswer;
  final List<String> answers;

  Map<String, dynamic> toJson() => {
    'id': id,
    'textQuestion': textQuestion,
    'rightAnswer': rightAnswer,
    'answers': answers,
  };
  
  Question toEntity() {
    return Question(
      id: id,
      textQuestion: textQuestion,
      rightAnswer: rightAnswer,
      answers: answers,
    );
  }
}

/// DTO for creating trainer request
class CreateTrainerRequestDTO {

  CreateTrainerRequestDTO({
    required this.title,
    required this.description,
    required this.questions,
    required this.keywords,
    this.timeRequiredInSeconds,
  });
  final String title;
  final String description;
  final List<QuestionDTO> questions;
  final List<String> keywords;
  final int? timeRequiredInSeconds;

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'questions': questions.map((q) => q.toJson()).toList(),
    'keywords': keywords,
    if (timeRequiredInSeconds != null) 'timeRequiredInSeconds': timeRequiredInSeconds,
  };
}

/// DTO for updating trainer request
class UpdateTrainerRequestDTO {

  UpdateTrainerRequestDTO({
    required this.title,
    required this.description,
    required this.questions,
    required this.keywords,
    this.timeRequiredInSeconds,
    this.starCount = 0,
  });
  final String title;
  final String description;
  final List<QuestionDTO> questions;
  final List<String> keywords;
  final int? timeRequiredInSeconds;
  final double starCount;

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'questions': questions.map((q) => q.toJson()).toList(),
    'keywords': keywords,
    if (timeRequiredInSeconds != null) 'timeRequiredInSeconds': timeRequiredInSeconds,
    'starCount': starCount,
  };
}
