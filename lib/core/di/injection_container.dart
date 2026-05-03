import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:talker/talker.dart';
import 'package:training_trainer/core/network/rest_client.dart';
import 'package:training_trainer/core/services/ai/ai_generator_interface.dart';
import 'package:training_trainer/core/services/ai/ai_implimentation/rest_ai_generator.dart';
import 'package:training_trainer/features/auth/data/repositories/rest_auth_repository_impl.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';
import 'package:training_trainer/features/auth/domain/usecases/sign_out.dart';
import 'package:training_trainer/features/trainers/data/repositories/rest_trainers_repository_impl.dart';
import 'package:training_trainer/features/trainers/domain/repositories/trainiers_repository.dart';
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  getIt.registerSingleton<Talker>(Talker());
  getIt.registerSingleton<Uuid>(Uuid());

  final box = await Hive.openBox<dynamic>('settings');
  getIt.registerSingleton<Box<dynamic>>(box);

  // REST Client with backend URL from environment
  // Default to 10.0.2.2 for Android device testing (localhost doesn't work on physical devices)
  const backendUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'http://192.168.31.170:8000',
  );
  getIt.registerSingleton<RestClient>(
    RestClient(baseUrl: backendUrl),
  );

 

  // Repositories (now using REST API instead of Firebase)
  getIt.registerSingleton<AuthRepository>(
    RestAuthRepositoryImpl(getIt<RestClient>()),
  );
  getIt.registerSingleton<TrainersRepository>(
    RestTrainersRepositoryImpl(getIt<RestClient>()),
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
    () => Signout(authRepository: getIt<AuthRepository>()),
  );
}
