/// DTO for register/login response from REST API
class AuthResponseDTO {
  AuthResponseDTO({
    required this.accessToken,
    required this.tokenType,
    required this.user,
    this.refreshToken,
  });

  factory AuthResponseDTO.fromJson(Map<String, dynamic> json) {
    return AuthResponseDTO(
      accessToken: json['access_token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String?,
      tokenType: json['token_type'] as String? ?? 'bearer',
      user: UserDTO.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }
  final String accessToken;
  final String? refreshToken;
  final String tokenType;
  final UserDTO user;

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'token_type': tokenType,
    'user': user.toJson(),
  };
}

/// DTO for user data from REST API
class UserDTO {
  UserDTO({required this.uid, required this.email, required this.login});

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      login: json['login'] as String? ?? '',
    );
  }
  final String uid;
  final String email;
  final String login;

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email, 'login': login};
}

/// DTO for register request
class RegisterRequestDTO {
  RegisterRequestDTO({
    required this.email,
    required this.password,
    required this.login,
  });
  final String email;
  final String password;
  final String login;

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'login': login,
  };
}

/// DTO for login request
class LoginRequestDTO {
  LoginRequestDTO({required this.email, required this.password});
  final String email;
  final String password;

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
