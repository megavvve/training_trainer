import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';

class Signout {
  Signout({required this.authRepository});
  final AuthRepository authRepository;

  Future<void> call() async {
    return await authRepository.signOut();
  }
}
