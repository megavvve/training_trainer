import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:training_trainer/core/network/token_storage.dart';
import 'package:talker/talker.dart';
import 'dart:io';

/// Modern API client using Dio with Cookie management and JWT refresh logic
class ApiClient {
  final String baseUrl;
  final TokenStorage tokenStorage;
  final Talker talker;
  late final Dio dio;
  late final PersistCookieJar cookieJar;

  ApiClient({
    required this.baseUrl,
    required this.tokenStorage,
    required this.talker,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
      ),
    );
  }

  /// Initialize persistent cookie storage and interceptors
  Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = "${appDocDir.path}/.cookies/";

    // Ensure directory exists
    await Directory(cookiePath).create(recursive: true);

    cookieJar = PersistCookieJar(
      ignoreExpires: false,
      storage: FileStorage(cookiePath),
    );

    dio.interceptors.addAll([
      CookieManager(cookieJar),
      _addAuthInterceptor(),
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    ]);
  }

  /// Interceptor for adding Auth header and handling token refresh
  QueuedInterceptorsWrapper _addAuthInterceptor() {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await tokenStorage.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        // Handle 401 Unauthorized errors
        if (e.response?.statusCode == 401) {
          talker.warning(
            '401 Unauthorized detected. Attempting token refresh...',
          );

          final refreshToken = await tokenStorage.getRefreshToken();
          if (refreshToken != null) {
            try {
              // Attempt to refresh token
              // Note: Backend implementation for /auth/refresh is required
              final refreshResponse = await dio.post(
                '/auth/refresh',
                data: {'refresh_token': refreshToken},
                options: Options(
                  extra: {'no_auth': true},
                ), // Avoid infinite loop
              );

              if (refreshResponse.statusCode == 200) {
                final newAccessToken = refreshResponse.data['access_token'];
                final newRefreshToken = refreshResponse.data['refresh_token'];

                await tokenStorage.saveAccessToken(newAccessToken);
                if (newRefreshToken != null) {
                  await tokenStorage.saveRefreshToken(newRefreshToken);
                }

                // Retry the original request with new token
                talker.info(
                  'Token refreshed successfully. Retrying request...',
                );
                return handler.resolve(await _retry(e.requestOptions));
              }
            } catch (refreshError) {
              talker.error('Token refresh failed: $refreshError');
              await tokenStorage.clear();
              // Here you could also trigger a navigation event to the login screen
            }
          } else {
            talker.warning('No refresh token available. Clearing storage.');
            await tokenStorage.clear();
          }
        }
        return handler.next(e);
      },
    );
  }

  /// Helper to retry a failed request
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  // Wrapper methods for common HTTP verbs
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
