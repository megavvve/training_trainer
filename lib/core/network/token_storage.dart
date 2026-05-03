import 'package:hive_ce/hive.dart';

/// Service for persisting JWT token using Hive (more stable in this environment than secure_storage)
class TokenStorage {
  static const String _boxName = 'auth_box';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';

  /// Save access token
  Future<void> saveAccessToken(String token) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_accessTokenKey, token);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    final box = await Hive.openBox(_boxName);
    return box.get(_accessTokenKey) as String?;
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_refreshTokenKey, token);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    final box = await Hive.openBox(_boxName);
    return box.get(_refreshTokenKey) as String?;
  }

  /// Save user data
  Future<void> saveUser(Map<String, dynamic> userData) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_userKey, userData);
  }

  /// Get user data
  Future<Map<String, dynamic>?> getUser() async {
    final box = await Hive.openBox(_boxName);
    final data = box.get(_userKey);
    if (data == null) return null;
    return Map<String, dynamic>.from(data as Map);
  }

  /// Clear all stored auth data
  Future<void> clear() async {
    final box = await Hive.openBox(_boxName);
    await box.clear();
  }
  
  // Backward compatibility
  Future<String?> getToken() => getAccessToken();
  Future<void> saveToken(String token) => saveAccessToken(token);
}
