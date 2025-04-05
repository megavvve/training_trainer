import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/features/auth/domain/entities/app_user.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';
import 'package:training_trainer/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:training_trainer/features/auth/domain/usecases/sign_up_with_email.dart';

final authRepositoryProvider = Provider<AuthRepository>((_) => getIt<AuthRepository>());

final signUpProvider = Provider<SignUpWithEmail>((ref) {
  return SignUpWithEmail(ref.watch(authRepositoryProvider));
});

final signInProvider = Provider<SignInWithEmail>((ref) {
  return SignInWithEmail(ref.watch(authRepositoryProvider));
});

final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});