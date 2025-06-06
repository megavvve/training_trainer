import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talker/talker.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/core/errors/exceptions.dart';
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
      getIt<Talker>().error(e);
      throw handleFirebaseError(e);
    }
  }

  @override
  Future<Trainer?> getTrainerById(String id) async {
    try {
      final doc = await _firestore.doc('$_collectionName/$id').get();
      return doc.exists ? Trainer.fromJson(doc.data()!) : null;
    } on FirebaseException catch (e) {
      getIt<Talker>().error(e);
      throw handleFirebaseError(e);
    }
  }

  @override
  Future<void> addTrainer(Trainer trainer) async {
    try {
      
      await _firestore
          .doc('$_collectionName/${trainer.id}')
          .set(trainer.toJson());
    } on FirebaseException catch (e) {
      getIt<Talker>().error(e);
      throw handleFirebaseError(e);
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
      getIt<Talker>().error(e);
      throw handleFirebaseError(e);
    }
  }

  @override
  Future<void> updateTrainer(Trainer trainer) async {
    try {
      await _firestore
          .doc('$_collectionName/${trainer.id}')
          .update(trainer.toJson());
    } on FirebaseException catch (e) {
      getIt<Talker>().error(e);
      throw handleFirebaseError(e);
    }
  }

  @override
  Future<void> deleteTrainer(String id) async {
    try {
      await _firestore.doc('$_collectionName/$id').delete();
    } on FirebaseException catch (e) {
      getIt<Talker>().error(e);
      throw handleFirebaseError(e);
    }
  }
  
@override
Future<List<Trainer>> getTopTrainers() async {
  try {
    final query = _firestore
        .collection(_collectionName)
        .orderBy('starCount', descending: true)
        .limit(10); // Ограничиваем топ 10

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => Trainer.fromJson(doc.data()))
        .toList();
  } on FirebaseException catch (e) {
    getIt<Talker>().error(e);
    throw handleFirebaseError(e);
  }
}

@override
Future<List<Trainer>> searchTrainers(
  String searchQuery,
  Map<String, dynamic> filters,
) async {
  try {
    Query query = _firestore.collection(_collectionName);

    // Apply text search on 'searchKeywords' (indexed as arrayContains)
    if (searchQuery.isNotEmpty) {
      final searchLower = searchQuery.toLowerCase();
      query = query.where('searchKeywords', arrayContains: searchLower);
    }

    // Apply filters if available (ensure fields are indexed)
    if (filters.containsKey('minStars')) {
      query = query.where('starCount', isGreaterThanOrEqualTo: filters['minStars']);
    }

    if (filters.containsKey('maxTime')) {
      query = query.where('timeRequiredInSeconds', isLessThanOrEqualTo: filters['maxTime']);
    }

    // Additional filters can be applied here

    // Execute the query and retrieve the snapshot
    final snapshot = await query.get();

    // Return the list of trainers mapped from the snapshot
    return snapshot.docs
        .map((doc) => Trainer.fromJson(Map<String, dynamic>.from(doc.data() as Map)))
        .toList();

  } on FirebaseException catch (e) {
    // Handle errors related to Firestore
    getIt<Talker>().error(e);
    throw handleFirebaseError(e);
  }
}


  
}