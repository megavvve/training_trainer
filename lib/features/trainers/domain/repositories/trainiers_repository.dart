import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';

abstract class TrainersRepository {
  /// Получить поток всех тренажеров
  Future<List<Trainer>> getTrainers();

  

  /// Получить конкретный тренажер по ID
  Future<Trainer?> getTrainerById(String id);

  /// Добавить новый тренажер
  Future<void> addTrainer(Trainer exercise);
  /// Добавить новые тренажеры
  Future<void> addTrainers(List<Trainer> exercise);

  /// Обновить существующий тренажер
  Future<void> updateTrainer(Trainer exercise);

  /// Удалить тренажер
  Future<void> deleteTrainer(String id);
}