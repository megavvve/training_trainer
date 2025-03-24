import 'package:training_trainer/features/auth/domain/entities/app_user.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmail {
  final AuthRepository authRepository;

  SignInWithEmail(this.authRepository);

  Future<AppUser?> call({
    required String email,
    required String password,
  }) async {
    return await authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}