import 'dart:io';
import 'package:flutter/foundation.dart';

class AppConfig {
  static const String _envApiBaseUrl = String.fromEnvironment('API_BASE_URL');

  static String get apiBaseUrl {
    String url;
    if (_envApiBaseUrl.isNotEmpty) {
      url = _envApiBaseUrl;
    } else if (!kIsWeb && Platform.isAndroid) {
      url = 'http://10.0.2.2:8080';
    } else {
      url = 'http://localhost:8080';
    }
    debugPrint('Using API Base URL: $url');
    return url;
  }
}
