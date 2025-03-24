import 'package:training_trainer/features/auth/domain/entities/app_user.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';

class SignUpWithEmail {
  final AuthRepository authRepository;

  SignUpWithEmail(this.authRepository);

  Future<AppUser?> call({
    required String email,
    required String password,
    required String login,
  }) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      login: login,
    );
  }
}