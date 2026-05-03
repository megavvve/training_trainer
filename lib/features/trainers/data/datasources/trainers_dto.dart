/// DTO for Trainer from REST API
class TrainerDTO {
  final String id;
  final String userId;
  final String title;
  final String description;
  final List<QuestionDTO> questions;
  final List<String> keywords;
  final int timeRequiredInSeconds;
  final int starCount;

  TrainerDTO({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.questions,
    required this.keywords,
    required this.timeRequiredInSeconds,
    required this.starCount,
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

    return TrainerDTO(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      questions: parseQuestions(json['questions'] as List<dynamic>?),
      keywords: parseKeywords(json['keywords'] as List<dynamic>?),
      timeRequiredInSeconds: json['time_required_in_seconds'] as int? ?? 0,
      starCount: json['star_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'title': title,
    'description': description,
    'questions': questions.map((q) => q.toJson()).toList(),
    'keywords': keywords,
    'time_required_in_seconds': timeRequiredInSeconds,
    'star_count': starCount,
  };
}

/// DTO for Question from REST API
class QuestionDTO {
  final String id;
  final String question;
  final String correctAnswer;
  final List<String> distractors;

  QuestionDTO({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.distractors,
  });

  factory QuestionDTO.fromJson(Map<String, dynamic> json) {
    List<String> parseDistractors(List<dynamic>? distractors) {
      if (distractors == null) return [];
      return distractors.map((d) => d.toString()).toList();
    }

    return QuestionDTO(
      id: json['id'] as String? ?? '',
      question: json['question'] as String? ?? '',
      correctAnswer: json['correct_answer'] as String? ?? '',
      distractors: parseDistractors(json['distractors'] as List<dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'correct_answer': correctAnswer,
    'distractors': distractors,
  };
}

/// DTO for creating trainer request
class CreateTrainerRequestDTO {
  final String title;
  final String description;
  final List<QuestionDTO> questions;
  final List<String> keywords;
  final int timeRequiredInSeconds;

  CreateTrainerRequestDTO({
    required this.title,
    required this.description,
    required this.questions,
    required this.keywords,
    required this.timeRequiredInSeconds,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'questions': questions.map((q) => q.toJson()).toList(),
    'keywords': keywords,
    'time_required_in_seconds': timeRequiredInSeconds,
  };
}

/// DTO for updating trainer request
class UpdateTrainerRequestDTO {
  final String title;
  final String description;
  final List<QuestionDTO> questions;
  final List<String> keywords;
  final int timeRequiredInSeconds;

  UpdateTrainerRequestDTO({
    required this.title,
    required this.description,
    required this.questions,
    required this.keywords,
    required this.timeRequiredInSeconds,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'questions': questions.map((q) => q.toJson()).toList(),
    'keywords': keywords,
    'time_required_in_seconds': timeRequiredInSeconds,
  };
}
