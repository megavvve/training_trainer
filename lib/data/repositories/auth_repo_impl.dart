import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_trainer/domain/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<User?> signInWithGoogle() async {
    //final s = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
    // firebaseAuth.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     print(user.uid);
    //   }
    // });
    return null;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
