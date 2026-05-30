abstract class AppException implements Exception {
  AppException(this.message);
  final String message;
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
  AIGenerationException(this.message);
  final String message;

  @override
  String toString() => 'AIGenerationException: $message';
}
