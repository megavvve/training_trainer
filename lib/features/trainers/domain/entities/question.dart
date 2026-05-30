import 'package:json_annotation/json_annotation.dart';
part 'question.g.dart';
@JsonSerializable()
class Question {
      factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Question(
      {required this.id,
      required this.textQuestion,
      required this.rightAnswer,
      required this.answers});
  final String id;

  final String textQuestion;

  final String rightAnswer;

  final List<String> answers;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
  Question copyWith({
    String? id,
    String? textQuestion,
    String? rightAnswer,
    List<String>? answers,
  }) {
    return Question(
      id: id ?? this.id,
      textQuestion: textQuestion ?? this.textQuestion,
      rightAnswer: rightAnswer ?? this.rightAnswer,
      answers: answers ?? this.answers,
    );}
}
