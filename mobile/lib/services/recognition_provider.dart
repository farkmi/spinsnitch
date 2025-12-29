import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:spinsnitch_api/api.dart';
import 'background_recognition_service.dart';
import 'recognition_service.dart';

class RecognitionProvider extends ChangeNotifier {
  final ApiClient _apiClient;
  late final RecognitionService _localService;
  
  bool _isListening = false;
  bool _isRecording = false;
  RecognitionResult? _lastResult;
  String? _error;
  
  StreamSubscription? _resultSub;
  StreamSubscription? _statusSub;
  StreamSubscription? _errorSub;
  Timer? _localLoopTimer;

  RecognitionProvider(this._apiClient) {
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
