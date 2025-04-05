import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';

class Signout {
  final AuthRepository authRepository;

  Signout({required this.authRepository});

  Future<void> call() async {
    return await authRepository.signOut();
  }
}
