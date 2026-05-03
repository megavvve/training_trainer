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
