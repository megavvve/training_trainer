import 'package:json_annotation/json_annotation.dart';
part 'question.g.dart';
@JsonSerializable()
class Question {
  final int id;

  final String textQuestion;

  final String rightAnswer;

  final List<String> answers;

  Question(
      {required this.id,
      required this.textQuestion,
      required this.rightAnswer,
      required this.answers});
      factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  /// Connect the generated [_$QuestionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
