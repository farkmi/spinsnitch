import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:spinsnitch_api/api.dart';
import 'background_recognition_service.dart';

class RecognitionProvider extends ChangeNotifier {
  final ApiClient _apiClient;
  
  bool _isListening = false;
  bool _isRecording = false;
  RecognitionResult? _lastResult;
  String? _error;
  
  StreamSubscription? _resultSub;
  StreamSubscription? _statusSub;
  StreamSubscription? _errorSub;

  RecognitionProvider(this._apiClient) {
    _init();
  }

  void _init() async {
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

    // Get auth token if available
    String? token;
    if (_apiClient.authentication is HttpBearerAuth) {
      token = (_apiClient.authentication as HttpBearerAuth).accessToken;
    }

    await BackgroundRecognitionService.initialize(
      _apiClient.basePath,
      authToken: token,
    );

    final service = FlutterBackgroundService();
    await service.startService();
    
    _isListening = true;
    _error = null;
    notifyListeners();
  }

  Future<void> stopListening() async {
    final service = FlutterBackgroundService();
    service.invoke('stop');
    
    _isListening = false;
    _isRecording = false;
    notifyListeners();
  }
}
