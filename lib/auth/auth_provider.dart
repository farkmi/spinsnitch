import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spinsnitch_api/api.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final String apiBaseUrl;

  late ApiClient _apiClient;
  late AuthApi _authApi;
  PostLoginResponse? _tokenSet;

  bool _isLoading = true;
  String? _error;

  // Linux localhost is 10.0.2.2 for Android emulator, 127.0.0.1 for local linux app
  // We can pass this in constructor or detect platform.
  AuthProvider({this.apiBaseUrl = 'http://localhost:8080'}) {
    _updateApiClient(null);
    _init();
  }

  bool get isAuthenticated => _tokenSet != null;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  ApiClient get apiClient => _apiClient;

  Future<void> _init() async {
    await _loadTokens();
  }

  void _updateApiClient(String? accessToken) {
    Authentication? auth;
    if (accessToken != null) {
      final bearerAuth = HttpBearerAuth();
      bearerAuth.accessToken = accessToken;
      auth = bearerAuth;
    }
    _apiClient = ApiClient(basePath: apiBaseUrl, authentication: auth);
    _authApi = AuthApi(_apiClient);
  }

  Future<void> _loadTokens() async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      final refreshToken = await _storage.read(key: 'refresh_token');

      if (accessToken != null && refreshToken != null) {
        _tokenSet = PostLoginResponse(
          accessToken: accessToken,
          tokenType: 'bearer',
          expiresIn: 3600, // Dummy value
          refreshToken: refreshToken,
        );
        
        _updateApiClient(accessToken);
      }
    } catch (e) {
      // Storage error or invalid data
      await logout();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _handleError(Object e) {
    if (e is ApiException) {
      if (e.innerException is SocketException) {
        return 'Cannot connect to server. Please check your network or if the backend is running.';
      }
      
      // Try to parse the error body if it exists
      // The generated client often puts the raw string in e.message
      return 'API Error (${e.code}): ${e.message ?? "Unknown error"}';
    }
    if (e is SocketException) {
      return 'Network error: ${e.message}. Backend might be down.';
    }
    return 'An unexpected error occurred: $e';
  }

  Future<void> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final payload = PostLoginPayload(username: username, password: password);
      final response = await _authApi.postLoginRoute(payload: payload);
      
      if (response != null) {
        _tokenSet = response;
        await _storage.write(key: 'access_token', value: response.accessToken);
        await _storage.write(key: 'refresh_token', value: response.refreshToken);
        
        _updateApiClient(response.accessToken);
      } else {
        _error = 'Login failed: Server returned an empty response.';
      }

    } catch (e) {
      _error = _handleError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final payload = PostRegisterPayload(username: username, password: password);
      final response = await _authApi.postRegisterRoute(payload: payload);
      
      if (response != null) {
         _tokenSet = response;
         await _storage.write(key: 'access_token', value: response.accessToken);
         await _storage.write(key: 'refresh_token', value: response.refreshToken);
         _updateApiClient(response.accessToken);
      } else {
         // In some cases 202 is returned, handled via ApiException check in generator usually
         // or if it returns null, we should check if user was actually created
         _error = 'Registration status: Response was empty. Please check if your account was created.';
      }
      
    } catch (e) {
      _error = _handleError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _tokenSet = null;
    await _storage.deleteAll();
    _updateApiClient(null);
    notifyListeners();
  }
}
