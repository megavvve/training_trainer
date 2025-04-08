import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talker/talker.dart';
import 'package:training_trainer/core/config/ai_config.dart';
import 'package:training_trainer/core/services/ai/ai_generator_interface.dart';
import 'package:training_trainer/core/services/ai/generator_factory.dart';
import 'package:training_trainer/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';
import 'package:training_trainer/features/auth/domain/usecases/sign_out.dart';
import 'package:training_trainer/features/trainers/data/repositories/firebase_repository_impl.dart';
import 'package:training_trainer/features/trainers/domain/repositories/trainiers_repository.dart';
import 'package:uuid/uuid.dart'; // Импортируем UseCase

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<Talker>(Talker());
  getIt.registerSingleton<Uuid>(Uuid());
  // getIt.registerSingleton<AIConfig>(
  //   GeminiConfig('AIzaSyBzvbe7Sm6rbLReiyvzo1H4eUX8O2rd5eA'),
  // );
  getIt.registerSingleton<AIConfig>(
    MistralConfig('OuVkcvXtRU1iAcH7pUW9rDPaPNOikKYU'),
  );
  getIt.registerSingleton<AIGenerator>(
    AIGeneratorFactory.create(getIt<AIConfig>()),
  );

  // Repositories
  getIt.registerSingleton<AuthRepository>(
    FirebaseAuthRepositoryImpl(getIt<FirebaseAuth>()),
  );
  getIt.registerSingleton<TrainersRepository>(
    FirebaseTrainersRepository(getIt<FirebaseFirestore>()),
  );

  // Registering ThemeRepositoryInterface (если раскомментировать)
  // getIt.registerSingleton<ThemeRepositoryInterface>(
  //   ThemeRepository(preferences: getIt<SharedPreferences>()),
  // );

  // Cubits
  // getIt.registerFactory(
  //   () => ThemeCubit(themeRepository: getIt<ThemeRepositoryInterface>()),
  // );

  // UseCases
  getIt.registerFactory<Signout>(
      () => Signout(authRepository: getIt<AuthRepository>()));
}
