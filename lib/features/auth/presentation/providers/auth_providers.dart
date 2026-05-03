import 'dart:async';

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

final authStateProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  // Start with null user (not loading state)
  final repository = ref.watch(authRepositoryProvider);
  final stream = repository.authStateChanges();
  
  // Create a stream that emits null first, then continues with the actual stream
  final StreamController<AppUser?> controller = StreamController<AppUser?>();
  controller.add(null); // Emit null immediately as initial value
  
  final subscription = stream.listen(
    (user) => controller.add(user),
    onError: (error) => controller.addError(error),
    onDone: () => controller.close(),
  );
  
  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });
  
  return controller.stream;
});