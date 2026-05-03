/// DTO for register/login response from REST API
class AuthResponseDTO {
  final String accessToken;
  final String tokenType;
  final UserDTO user;

  AuthResponseDTO({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory AuthResponseDTO.fromJson(Map<String, dynamic> json) {
    return AuthResponseDTO(
      accessToken: json['access_token'] as String? ?? '',
      tokenType: json['token_type'] as String? ?? 'bearer',
      user: UserDTO.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'token_type': tokenType,
    'user': user.toJson(),
  };
}

/// DTO for user data from REST API
class UserDTO {
  final String id;
  final String email;
  final String login;

  UserDTO({
    required this.id,
    required this.email,
    required this.login,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      login: json['login'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'login': login,
  };
}

/// DTO for register request
class RegisterRequestDTO {
  final String email;
  final String password;
  final String login;

  RegisterRequestDTO({
    required this.email,
    required this.password,
    required this.login,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'login': login,
  };
}

/// DTO for login request
class LoginRequestDTO {
  final String email;
  final String password;

  LoginRequestDTO({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}
