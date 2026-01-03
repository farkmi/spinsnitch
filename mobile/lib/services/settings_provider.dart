import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  bool _useHomeAssistant = false;
  String _haWebhookUrl = '';
  bool _autoLogEnabled = false;
  String _customApiBaseUrl = '';
  bool _isLoading = true;

  SettingsProvider() {
    _loadSettings();
  }

  bool get useHomeAssistant => _useHomeAssistant;
  String get haWebhookUrl => _haWebhookUrl;
  bool get autoLogEnabled => _autoLogEnabled;
  String get customApiBaseUrl => _customApiBaseUrl;
  bool get isLoading => _isLoading;

  Future<void> _loadSettings() async {
    _useHomeAssistant = await _storage.read(key: 'use_home_assistant') == 'true';
    _haWebhookUrl = await _storage.read(key: 'ha_webhook_url') ?? '';
    _autoLogEnabled = await _storage.read(key: 'auto_log_enabled') == 'true';
    _customApiBaseUrl = await _storage.read(key: 'custom_api_base_url') ?? '';
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setUseHomeAssistant(bool value) async {
    _useHomeAssistant = value;
    await _storage.write(key: 'use_home_assistant', value: value.toString());
    notifyListeners();
  }

  Future<void> setHaWebhookUrl(String value) async {
    _haWebhookUrl = value;
    await _storage.write(key: 'ha_webhook_url', value: value);
    notifyListeners();
  }

  Future<void> setAutoLogEnabled(bool value) async {
    _autoLogEnabled = value;
    await _storage.write(key: 'auto_log_enabled', value: value.toString());
    notifyListeners();
  }

  Future<void> setCustomApiBaseUrl(String value) async {
    _customApiBaseUrl = value;
    await _storage.write(key: 'custom_api_base_url', value: value);
    notifyListeners();
  }
}
