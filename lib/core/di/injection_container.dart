import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_trainer/core/domain/theme_repository.dart';
import 'package:training_trainer/core/presentation/cubits/theme_cubit.dart';
import 'package:training_trainer/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';
import 'package:training_trainer/features/auth/domain/usecases/sign_out.dart'; // Импортируем UseCase

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  // Repositories
  getIt.registerSingleton<AuthRepository>(
    FirebaseAuthRepositoryImpl(getIt<FirebaseAuth>()),
  );
  
  // Registering ThemeRepositoryInterface (если раскомментировать)
  // getIt.registerSingleton<ThemeRepositoryInterface>(
  //   ThemeRepository(preferences: getIt<SharedPreferences>()),
  // );

  // Cubits
  getIt.registerFactory(
    () => ThemeCubit(themeRepository: getIt<ThemeRepositoryInterface>()),
  );

  // UseCases
  getIt.registerFactory<Signout>(() => Signout(authRepository:getIt<AuthRepository>()));
}
