// features/auth/domain/models/app_user.dart

class AppUser {
  AppUser({required this.uid, required this.email, required this.login});
  final String uid;
  final String email;
  final String login;

  @override
  String toString() => 'AppUser(uid: $uid, email: $email, login: $login)';
}
