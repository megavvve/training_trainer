import 'dart:async';
import 'package:training_trainer/core/network/api_client.dart';
import 'package:training_trainer/core/network/token_storage.dart';
import 'package:training_trainer/features/auth/data/datasources/auth_dto.dart';
import 'package:training_trainer/features/auth/domain/entities/app_user.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';

/// REST API implementation of AuthRepository using Modern ApiClient
class RestAuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;
  AppUser? _currentUser;
  final _authStateController = StreamController<AppUser?>.broadcast();

  RestAuthRepositoryImpl(this._tokenStorage, this._apiClient) {
    _authStateController.onListen = () {
      _authStateController.add(_currentUser);
    };
    _init();
  }

  /// Initialize by loading saved user data
  Future<void> _init() async {
    final userData = await _tokenStorage.getUser();

    if (userData != null) {
      final userDto = UserDTO.fromJson(userData);
      _currentUser = _userDtoToEntity(userDto);
      _authStateController.add(_currentUser);
    }
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

      final response = await _apiClient.post(
        '/api/v1/auth/register',
        data: requestDto.toJson(),
      );

      final authResponse = AuthResponseDTO.fromJson(response.data);
      
      // Persist token and user data
      await _tokenStorage.saveAccessToken(authResponse.accessToken);
      // Backend doesn't return refresh token yet, but we're ready
      // await _tokenStorage.saveRefreshToken(authResponse.refreshToken);
      await _tokenStorage.saveUser(authResponse.user.toJson());
      
      final user = _userDtoToEntity(authResponse.user);
      _currentUser = user;
      _authStateController.add(user);

      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final requestDto = LoginRequestDTO(email: email, password: password);

      final response = await _apiClient.post(
        '/api/v1/auth/login',
        data: requestDto.toJson(),
      );

      final authResponse = AuthResponseDTO.fromJson(response.data);
      
      // Persist token and user data
      await _tokenStorage.saveAccessToken(authResponse.accessToken);
      await _tokenStorage.saveUser(authResponse.user.toJson());
      
      final user = _userDtoToEntity(authResponse.user);
      _currentUser = user;
      _authStateController.add(user);

      return user;
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _tokenStorage.clear();
      await _apiClient.cookieJar.deleteAll();
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
