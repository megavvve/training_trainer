// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: (json['id'] as String).toString(),
      textQuestion: json['textQuestion'] as String,
      rightAnswer: json['rightAnswer'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'textQuestion': instance.textQuestion,
      'rightAnswer': instance.rightAnswer,
      'answers': instance.answers,
    };
