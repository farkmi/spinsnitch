import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:spinsnitch_api/api.dart';
import 'package:http/http.dart' as http;
import 'background_recognition_service.dart';
import 'recognition_service.dart';
import 'settings_provider.dart';

class RecognitionProvider extends ChangeNotifier {
  final ApiClient _apiClient;
  late final RecognitionService _localService;
  final SettingsProvider _settings;
  
  bool _isListening = false;
  bool _isRecording = false;
  RecognitionResult? _lastResult;
  String? _error;
  
  StreamSubscription? _resultSub;
  StreamSubscription? _statusSub;
  StreamSubscription? _errorSub;
  Timer? _localLoopTimer;

  RecognitionProvider(this._apiClient, this._settings) {
    _localService = RecognitionService(_apiClient);
    _init();
  }

  void _init() async {
    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
      final service = FlutterBackgroundService();
      _isListening = await service.isRunning();
      
      _resultSub = service.on('result').listen((event) {
        if (event != null) {
          _lastResult = RecognitionResult.fromJson(event);
          notifyListeners();
        }
      });

      _statusSub = service.on('status').listen((event) {
        _isRecording = event?['isRecording'] ?? false;
        notifyListeners();
      });

      _errorSub = service.on('error').listen((event) {
        _error = event?['message'];
        notifyListeners();
      });
    }
    
    notifyListeners();
  }

  bool get isListening => _isListening;
  bool get isRecording => _isRecording;
  RecognitionResult? get lastResult => _lastResult;
  String? get error => _error;

  @override
  void dispose() {
    _resultSub?.cancel();
    _statusSub?.cancel();
    _errorSub?.cancel();
    _localLoopTimer?.cancel();
    _localService.dispose();
    super.dispose();
  }

  Future<void> toggleListening() async {
    if (_isListening) {
      await stopListening();
    } else {
      await startListening();
    }
  }

  Future<void> startListening() async {
    if (_isListening) return;

    _isListening = true;
    _error = null;
    notifyListeners();

    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
      // Mobile: Use background service
      String? token;
      if (_apiClient.authentication is HttpBearerAuth) {
        token = (_apiClient.authentication as HttpBearerAuth).accessToken;
      }

      await BackgroundRecognitionService.initialize(
        _apiClient.basePath,
        authToken: token,
        haWebhookUrl: _settings.useHomeAssistant ? _settings.haWebhookUrl : null,
      );

      final service = FlutterBackgroundService();
      await service.startService();
    } else {
      // Linux/Web/Others: Use local loop
      _runLocalLoop();
    }
  }

  void _runLocalLoop() async {
    if (!_isListening) return;

    _isRecording = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _localService.recordAndRecognize();
      _lastResult = result;
      _isRecording = false;
      
      if (result != null && (result.success ?? false)) {
        _autoLogIfNeeded(result);
      }
      
      final cooldown = (result?.success ?? false) ? 20 : 8;
      notifyListeners();
      
      _localLoopTimer = Timer(Duration(seconds: cooldown), _runLocalLoop);
    } catch (e) {
      _error = e.toString();
      _isRecording = false;
      notifyListeners();
      _localLoopTimer = Timer(const Duration(seconds: 10), _runLocalLoop);
    }
  }

  Future<void> _autoLogIfNeeded(RecognitionResult result) async {
    if (!_settings.autoLogEnabled) return;

    if (_settings.useHomeAssistant) {
      await _sendToHomeAssistant(result);
    } else {
      await _sendToBackend(result);
    }
  }

  Future<void> _sendToBackend(RecognitionResult result) async {
    try {
      final vinylApi = VinylApi(_apiClient);
      final payload = PlayPayload(
        artist: result.artist ?? 'Unknown',
        title: result.title ?? 'Unknown',
      );
      await vinylApi.postPlayRoute(payload: payload);
      debugPrint('Auto-logged to backend: ${result.title}');
    } catch (e) {
      debugPrint('Failed to auto-log to backend: $e');
    }
  }

  Future<void> _sendToHomeAssistant(RecognitionResult result) async {
    final url = _settings.haWebhookUrl;
    if (url.isEmpty) return;
    try {
      final uri = Uri.parse(url);
      await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'artist': result.artist,
          'title': result.title,
        }),
      );
      debugPrint('Auto-logged to Home Assistant: ${result.title}');
    } catch (e) {
      debugPrint('Failed to send to Home Assistant: $e');
    }
  }

  Future<void> stopListening() async {
    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
      final service = FlutterBackgroundService();
      service.invoke('stop');
    } else {
      _localLoopTimer?.cancel();
    }
    
    _isListening = false;
    _isRecording = false;
    notifyListeners();
  }
}
