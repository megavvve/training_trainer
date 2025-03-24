// features/auth/domain/models/app_user.dart
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String email;
  final String login;

  AppUser({
    required this.uid,
    required this.email,
    required this.login,
  });

  factory AppUser.fromFirebase(User user) => AppUser(
        uid: user.uid,
        email: user.email ?? '',
        login: user.displayName ?? '',
      );
}