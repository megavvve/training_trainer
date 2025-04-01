import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:json_annotation/json_annotation.dart';
part 'trainer.g.dart';
@JsonSerializable()
class Trainer {
  final String id;
  final String userId;
  final double starCount;
  final int timeRequiredInSeconds;
  final String title;
  final List<Question> questions;
  final List<String> keywords;
  final String description;
  final DateTime createdAt;

  Trainer({
    required this.id,
    required this.starCount,
    required this.userId,
    required this.timeRequiredInSeconds,
    required this.title,
    this.questions = const [],
    this.keywords = const [],
    required this.description,
    DateTime? createdAt,
  })  : createdAt = createdAt ?? DateTime.now();
   factory Trainer.fromJson(Map<String, dynamic> json) => _$TrainerFromJson(json);

  /// Connect the generated [_$TrainerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TrainerToJson(this);}
  