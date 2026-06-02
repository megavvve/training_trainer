import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:training_trainer/core/network/api_client.dart';
import 'package:training_trainer/core/network/token_storage.dart';
import 'package:training_trainer/features/auth/data/datasources/auth_dto.dart';
import 'package:training_trainer/features/auth/domain/entities/app_user.dart';
import 'package:training_trainer/features/auth/domain/repositories/auth_repository.dart';

/// REST API implementation of AuthRepository using Modern ApiClient
class RestAuthRepositoryImpl implements AuthRepository {

  RestAuthRepositoryImpl(this._tokenStorage, this._apiClient) {
    // When the API client detects an unrecoverable auth failure
    // (token refresh failed), force sign-out so GoRouter redirects to login.
    _apiClient.onAuthFailure = signOut;
    _init();
  }
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;
  AppUser? _currentUser;
  final _authStateController = StreamController<AppUser?>.broadcast();

  /// Initialize by loading saved user data
  Future<void> _init() async {
    try {
      final userData = await _tokenStorage.getUser();

      if (userData != null) {
        final userDto = UserDTO.fromJson(userData);
        _currentUser = _userDtoToEntity(userDto);
      } else {
        _currentUser = null;
      }
      _authStateController.add(_currentUser);
    } catch (e) {
      _currentUser = null;
      _authStateController.add(null);
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

      debugPrint('[AuthRepo] POST /api/v1/auth/register body: ${requestDto.toJson()}');

      final response = await _apiClient.post(
        '/api/v1/auth/register',
        data: requestDto.toJson(),
      );

      debugPrint('[AuthRepo] Response status: ${response.statusCode}');
      debugPrint('[AuthRepo] Response data: ${response.data}');

      final authResponse = AuthResponseDTO.fromJson(response.data);

      // Persist token and user data
      await _tokenStorage.saveAccessToken(authResponse.accessToken);
      if (authResponse.refreshToken != null) {
        await _tokenStorage.saveRefreshToken(authResponse.refreshToken!);
      }
      await _tokenStorage.saveUser(authResponse.user.toJson());

      final user = _userDtoToEntity(authResponse.user);
      _currentUser = user;
      _authStateController.add(user);

      debugPrint('[AuthRepo] Registration success: uid=${user.uid}, login=${user.login}');
      return user;
    } catch (e) {
      debugPrint('[AuthRepo] Registration FAILED: $e');
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final requestDto = LoginRequestDTO(email: email, password: password);

      debugPrint('[AuthRepo] POST /api/v1/auth/login body: ${requestDto.toJson()}');

      final response = await _apiClient.post(
        '/api/v1/auth/login',
        data: requestDto.toJson(),
      );

      debugPrint('[AuthRepo] Response status: ${response.statusCode}');
      debugPrint('[AuthRepo] Response data: ${response.data}');

      final authResponse = AuthResponseDTO.fromJson(response.data);

      // Persist token and user data
      await _tokenStorage.saveAccessToken(authResponse.accessToken);
      if (authResponse.refreshToken != null) {
        await _tokenStorage.saveRefreshToken(authResponse.refreshToken!);
      }
      await _tokenStorage.saveUser(authResponse.user.toJson());

      final user = _userDtoToEntity(authResponse.user);
      _currentUser = user;
      _authStateController.add(user);

      debugPrint('[AuthRepo] Sign in success: uid=${user.uid}, login=${user.login}');
      return user;
    } catch (e) {
      debugPrint('[AuthRepo] Sign in FAILED: $e');
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _tokenStorage.clear();
      await _apiClient.cookieJar.deleteAll();
      _currentUser = null;
      _authStateController.add(null);
      // Clear saved "remember me" credentials
      await _clearRememberMeCredentials();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  /// Clear saved email/password from "remember me" feature.
  Future<void> _clearRememberMeCredentials() async {
    try {
      final box = await Hive.openBox<dynamic>('settings');
      await box.delete('remember_email');
      await box.delete('remember_password');
    } catch (_) {
      // Silently fail — credentials are not critical.
    }
  }

  /// Convert UserDTO to AppUser entity
  AppUser _userDtoToEntity(UserDTO dto) {
    return AppUser(
      uid: dto.uid,
      email: dto.email,
      login: dto.login,
    );
  }

  /// Extract a user-friendly error message from Dio (or other) exceptions.
  String _extractErrorMessage(Object error) {
    // DioException carries the response body from FastAPI
    final dioErr = error is DioException ? error : null;
    if (dioErr != null && dioErr.response?.data is Map) {
      final detail = (dioErr.response!.data as Map)['detail'];
      if (detail is String && detail.isNotEmpty) return detail;
    }
    if (dioErr != null && dioErr.response?.data is String) {
      final body = dioErr.response!.data as String;
      if (body.isNotEmpty) return body;
    }
    return 'Authentication failed. Please check your credentials.';
  }

  /// Clean up resources
  void dispose() {
    _authStateController.close();
  }
}
