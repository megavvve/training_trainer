bool isValidEmail(String email) {
  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    caseSensitive: false,
  );
  return emailRegExp.hasMatch(email.trim());
}

bool isValidPassword(String password) {
  final passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  return passwordRegExp.hasMatch(password);
}