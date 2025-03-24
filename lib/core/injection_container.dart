import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_trainer/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';

final getIt = GetIt.instance;

void setupDependencies()  {

  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<AuthRepository>(
    FirebaseAuthRepositoryImpl(getIt<FirebaseAuth>()),
  );
}