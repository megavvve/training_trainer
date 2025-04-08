import 'package:firebase_auth/firebase_auth.dart';

abstract class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class AddTrainerException extends AppException {
  AddTrainerException(super.message);
}

class LoadTrainersException extends AppException {
  LoadTrainersException(super.message);
}

class DeleteTrainerException extends AppException {
  DeleteTrainerException(super.message);
}

class AIGenerationException implements Exception {
  final String message;
  AIGenerationException(this.message);

  @override
  String toString() => 'AIGenerationException: $message';
}

String handleFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'Ошибка доступа';
      case 'not-found':
        return 'Данные не найдены';
      default:
        return 'Ошибка Firebase: ${e.message}';
    }
  }