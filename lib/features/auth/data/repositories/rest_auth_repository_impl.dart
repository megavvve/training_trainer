import 'dart:async';
import 'package:training_trainer/core/network/rest_client.dart';
import 'package:training_trainer/features/auth/data/datasources/auth_dto.dart';
import 'package:training_trainer/features/auth/domain/entities/app_user.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';

/// REST API implementation of AuthRepository
class RestAuthRepositoryImpl implements AuthRepository {
  final RestClient _restClient;
  AppUser? _currentUser;
  final _authStateController = StreamController<AppUser?>.broadcast();

  RestAuthRepositoryImpl(this._restClient) {
    _authStateController.onListen = () {
      _authStateController.add(_currentUser);
    };
  }

  @override
  Stream<AppUser?> authStateChanges() => _authStateController.stream;

  @override
  Future<AppUser?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String login,
  }) async {
    try {
      final requestDto =
          RegisterRequestDTO(email: email, password: password, login: login);

      final response = await _restClient.post(
        '/api/v1/auth/register',
        body: requestDto.toJson(),
        includeAuth: false,
      );

      final authResponse = AuthResponseDTO.fromJson(response);
      _restClient.setToken(authResponse.accessToken);

      final user = _userDtoToEntity(authResponse.user);
      _currentUser = user;
      _authStateController.add(user);

      return user;
    } on RestClientException catch (e) {
      throw Exception('Registration failed: ${e.message}');
    }
  }

  @override
  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final requestDto = LoginRequestDTO(email: email, password: password);

      final response = await _restClient.post(
        '/api/v1/auth/login',
        body: requestDto.toJson(),
        includeAuth: false,
      );

      final authResponse = AuthResponseDTO.fromJson(response);
      _restClient.setToken(authResponse.accessToken);

      final user = _userDtoToEntity(authResponse.user);
      _currentUser = user;
      _authStateController.add(user);

      return user;
    } on RestClientException catch (e) {
      throw Exception('Sign in failed: ${e.message}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      _restClient.clearToken();
      _currentUser = null;
      _authStateController.add(null);
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  /// Convert UserDTO to AppUser entity
  AppUser _userDtoToEntity(UserDTO dto) {
    return AppUser(
      uid: dto.id,
      email: dto.email,
      login: dto.login,
    );
  }

  /// Clean up resources
  void dispose() {
    _authStateController.close();
  }
}
