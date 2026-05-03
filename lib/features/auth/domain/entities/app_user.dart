// features/auth/domain/models/app_user.dart

class AppUser {
  final String uid;
  final String email;
  final String login;

  AppUser({
    required this.uid,
    required this.email,
    required this.login,
  });

  @override
  String toString() => 'AppUser(uid: $uid, email: $email, login: $login)';
}