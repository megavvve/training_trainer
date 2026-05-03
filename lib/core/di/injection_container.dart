import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:talker/talker.dart';
import 'package:training_trainer/core/network/api_client.dart';
import 'package:training_trainer/core/network/rest_client.dart';
import 'package:training_trainer/core/network/token_storage.dart';
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
  getIt.registerSingleton<TokenStorage>(TokenStorage());

  final box = await Hive.openBox<dynamic>('settings');
  getIt.registerSingleton<Box<dynamic>>(box);

  // REST Client with backend URL from environment
  const backendUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'http://192.168.31.170:8000',
  );

  // Register and initialize Modern ApiClient (Dio based)
  final apiClient = ApiClient(
    baseUrl: backendUrl,
    tokenStorage: getIt<TokenStorage>(),
    talker: getIt<Talker>(),
  );
  await apiClient.init();
  getIt.registerSingleton<ApiClient>(apiClient);

  // Keep RestClient for backward compatibility where not migrated yet
  getIt.registerSingleton<RestClient>(
    RestClient(baseUrl: backendUrl, talker: getIt<Talker>()),
  );

  getIt.registerSingleton<AIGenerator>(
    RestAIGenerator(getIt<ApiClient>()),
  );

  // Repositories migrated to ApiClient
  getIt.registerSingleton<AuthRepository>(
    RestAuthRepositoryImpl(getIt<TokenStorage>(), getIt<ApiClient>()),
  );
  getIt.registerSingleton<TrainersRepository>(
    RestTrainersRepositoryImpl(getIt<ApiClient>()),
  );


  // UseCases
  getIt.registerFactory<Signout>(
    () => Signout(authRepository: getIt<AuthRepository>()),
  );
}
