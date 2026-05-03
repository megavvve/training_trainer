import 'package:http/http.dart' as http;
import 'dart:convert';

/// REST API client for communicating with FastAPI backend
class RestClient {
  final String baseUrl;
  String? _token;

  RestClient({required this.baseUrl});

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
    try {
      final url = Uri.parse('$baseUrl$path');
      final response = await http.get(
        url,
        headers: _buildHeaders(includeAuth: includeAuth),
      );
      return _handleResponse(response);
    } catch (e) {
      throw RestClientException('GET $path failed: $e');
    }
  }

  /// POST request
  Future<dynamic> post(
    String path, {
    required Map<String, dynamic> body,
    bool includeAuth = true,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$path');
      final response = await http.post(
        url,
        headers: _buildHeaders(includeAuth: includeAuth),
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw RestClientException('POST $path failed: $e');
    }
  }

  /// PUT request
  Future<dynamic> put(
    String path, {
    required Map<String, dynamic> body,
    bool includeAuth = true,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$path');
      final response = await http.put(
        url,
        headers: _buildHeaders(includeAuth: includeAuth),
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw RestClientException('PUT $path failed: $e');
    }
  }

  /// DELETE request
  Future<dynamic> delete(
    String path, {
    bool includeAuth = true,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$path');
      final response = await http.delete(
        url,
        headers: _buildHeaders(includeAuth: includeAuth),
      );
      return _handleResponse(response);
    } catch (e) {
      throw RestClientException('DELETE $path failed: $e');
    }
  }

  /// Handle HTTP response and decode JSON
  dynamic _handleResponse(http.Response response) {
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
  final String message;
  RestClientException(this.message);

  @override
  String toString() => 'RestClientException: $message';
}

class UnauthorizedException extends RestClientException {
  UnauthorizedException(String message) : super(message);
}

class ForbiddenException extends RestClientException {
  ForbiddenException(String message) : super(message);
}

class NotFoundException extends RestClientException {
  NotFoundException(String message) : super(message);
}

class ServerException extends RestClientException {
  ServerException(String message) : super(message);
}
