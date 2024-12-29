import 'package:training_trainer/domain/models/question.dart';

class QuestionFromCodeWars extends Question {
  final List<String> languages;

  final String createdBy;

  final String createdAt;

  QuestionFromCodeWars({
    required super.id,
    required super.name,
    required super.description,
    required super.url,
    required super.rank,
    required this.languages,
    required this.createdBy,
    required this.createdAt,
  });

  @override
  String get rightAnswer {
    return "Здесь будет правильный ответ";
  }
  @override
  String toString(){
    return 'Какое то задание';
  }


  @override
  List<String> get incorrectAnswers {
    return ["Неверный ответ 1", "Неверный ответ 2"];
  }
    factory QuestionFromCodeWars.fromJson(Map<String, dynamic> json) {
    return QuestionFromCodeWars(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      rank: (json['rank'] as int).toString(),
      languages: List<String>.from(json['languages'] ?? []),
      createdBy: json['createdBy'] as String,
      createdAt: json['createdAt'] as String,
    );
   
  }
}
