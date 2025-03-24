import 'package:training_trainer/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String login,
  });

  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
  Stream<AppUser?> authStateChanges();
}
