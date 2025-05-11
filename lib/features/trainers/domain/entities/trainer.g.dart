// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trainer _$TrainerFromJson(Map<String, dynamic> json) => Trainer(
  id: json['id'] as String,
  starCount: (json['starCount'] as num).toDouble(),
  userId: json['userId'] as String,
  timeRequiredInSeconds: (json['timeRequiredInSeconds'] as num).toInt(),
  title: json['title'] as String,
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  keywords:
      (json['keywords'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  description: json['description'] as String,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TrainerToJson(Trainer instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'starCount': instance.starCount,
  'timeRequiredInSeconds': instance.timeRequiredInSeconds,
  'title': instance.title,
  'questions': instance.questions,
  'keywords': instance.keywords,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
};
