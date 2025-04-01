import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/domain/repositories/trainiers_repository.dart';

class FirebaseTrainersRepository implements TrainersRepository {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'trainers';

  FirebaseTrainersRepository(this._firestore);

  @override
  Future<List<Trainer>> getTrainers() async {
    try {
      final snapshot = await _firestore.collection(_collectionName).get();
      return snapshot.docs
          .map((doc) => Trainer.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  @override
  Future<Trainer?> getTrainerById(String id) async {
    try {
      final doc = await _firestore.doc('$_collectionName/$id').get();
      return doc.exists ? Trainer.fromJson(doc.data()!) : null;
    } on FirebaseException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  @override
  Future<void> addTrainer(Trainer trainer) async {
    try {
      await _firestore
          .doc('$_collectionName/${trainer.id}')
          .set(trainer.toJson());
    } on FirebaseException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  @override
  Future<void> addTrainers(List<Trainer> trainers) async {
    final batch = _firestore.batch();
    try {
      for (final trainer in trainers) {
        final docRef = _firestore.collection(_collectionName).doc(trainer.id);
        batch.set(docRef, trainer.toJson());
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  @override
  Future<void> updateTrainer(Trainer trainer) async {
    try {
      await _firestore
          .doc('$_collectionName/${trainer.id}')
          .update(trainer.toJson());
    } on FirebaseException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  @override
  Future<void> deleteTrainer(String id) async {
    try {
      await _firestore.doc('$_collectionName/$id').delete();
    } on FirebaseException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  String _handleFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'Ошибка доступа';
      case 'not-found':
        return 'Данные не найдены';
      default:
        return 'Ошибка Firebase: ${e.message}';
    }
  }
}