import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_trainer/features/auth/domain/entities/app_user.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepositoryImpl(this._firebaseAuth);

  @override
  Stream<AppUser?> authStateChanges() => _firebaseAuth.authStateChanges().map(
        (user) => user != null ? AppUser.fromFirebase(user) : null,
      );

  @override
  Future<AppUser?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String login,
  }) async {
     
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    
    await userCredential.user!.updateDisplayName(login);
    return AppUser.fromFirebase(userCredential.user!);
  }

  @override
  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    return AppUser.fromFirebase(userCredential.user!);
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}