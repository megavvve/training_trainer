import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:talker/talker.dart';

/// REST API client for communicating with FastAPI backend
class RestClient {

  RestClient({required this.baseUrl, this.talker});
  final String baseUrl;
  final Talker? talker;
  String? _token;

  /// Set JWT token for authenticated requests
  void setToken(String? token) {
    _token = token;
  }

  /// Get JWT token
  String? getToken() => _token;

  /// Clear token (on logout)
  void clearToken() {
    _token = null;
  }

  /// Build headers for HTTP requests
  Map<String, String> _buildHeaders({bool includeAuth = true}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (includeAuth && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }

    return headers;
  }

  /// GET request
  Future<dynamic> get(
    String path, {
    bool includeAuth = true,
  }) async {
    final url = Uri.parse('$baseUrl$path');
    talker?.debug('REST GET: $url');
    try {
      final response = await http.get(
        url,
        headers: _buildHeaders(includeAuth: includeAuth),
      );
      return _handleResponse(response, 'GET $path');
    } catch (e, st) {
      talker?.handle(e, st, 'REST GET FAILED: $path');
      throw RestClientException('GET $path failed: $e');
    }
  }

  /// POST request
  Future<dynamic> post(
    String path, {
    required Map<String, dynamic> body,
    bool includeAuth = true,
  }) async {
    final url = Uri.parse('$baseUrl$path');
    talker?.debug('REST POST: $url\nBody: ${jsonEncode(body)}');
    try {
      final response = await http.post(
        url,
        headers: _buildHeaders(includeAuth: includeAuth),
        body: jsonEncode(body),
      );
      return _handleResponse(response, 'POST $path');
    } catch (e, st) {
      talker?.handle(e, st, 'REST POST FAILED: $path');
      throw RestClientException('POST $path failed: $e');
    }
  }

  /// PUT request
  Future<dynamic> put(
    String path, {
    required Map<String, dynamic> body,
    bool includeAuth = true,
  }) async {
    final url = Uri.parse('$baseUrl$path');
    talker?.debug('REST PUT: $url\nBody: ${jsonEncode(body)}');
    try {
      final response = await http.put(
        url,
        headers: _buildHeaders(includeAuth: includeAuth),
        body: jsonEncode(body),
      );
      return _handleResponse(response, 'PUT $path');
    } catch (e, st) {
      talker?.handle(e, st, 'REST PUT FAILED: $path');
      throw RestClientException('PUT $path failed: $e');
    }
  }

  /// DELETE request
  Future<dynamic> delete(
    String path, {
    bool includeAuth = true,
  }) async {
    final url = Uri.parse('$baseUrl$path');
    talker?.debug('REST DELETE: $url');
    try {
      final response = await http.delete(
        url,
        headers: _buildHeaders(includeAuth: includeAuth),
      );
      return _handleResponse(response, 'DELETE $path');
    } catch (e, st) {
      talker?.handle(e, st, 'REST DELETE FAILED: $path');
      throw RestClientException('DELETE $path failed: $e');
    }
  }

  /// Handle HTTP response and decode JSON
  dynamic _handleResponse(http.Response response, String logPrefix) {
    talker?.debug('$logPrefix RESPONSE [${response.statusCode}]: ${response.body}');
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      clearToken();
      throw UnauthorizedException('Unauthorized - token may have expired');
    } else if (response.statusCode == 403) {
      throw ForbiddenException('Access forbidden');
    } else if (response.statusCode == 404) {
      throw NotFoundException('Resource not found');
    } else if (response.statusCode >= 500) {
      throw ServerException('Server error: ${response.statusCode}');
    } else {
      try {
        final error = jsonDecode(response.body);
        final message = error['detail'] ?? error['message'] ?? 'Unknown error';
        throw RestClientException(message);
      } catch (_) {
        throw RestClientException('HTTP ${response.statusCode}: ${response.body}');
      }
    }
  }
}

/// Custom exceptions for REST client
class RestClientException implements Exception {
  RestClientException(this.message);
  final String message;

  @override
  String toString() => 'RestClientException: $message';
}

class UnauthorizedException extends RestClientException {
  UnauthorizedException(super.message);
}

class ForbiddenException extends RestClientException {
  ForbiddenException(super.message);
}

class NotFoundException extends RestClientException {
  NotFoundException(super.message);
}

class ServerException extends RestClientException {
  ServerException(super.message);
}
