import 'dart:async';
import 'package:flutter/services.dart';

class RecognizedTrack {
  final String artist;
  final String title;
  final DateTime timestamp;

  RecognizedTrack({
    required this.artist,
    required this.title,
    required this.timestamp,
  });

  @override
  String toString() => '$artist - $title';
}

class RecognitionService {
  static const MethodChannel _channel = MethodChannel('com.farkmi.spinsnitch_mobile/recognition');
  
  final _trackController = StreamController<RecognizedTrack>.broadcast();
  Stream<RecognizedTrack> get trackStream => _trackController.stream;

  bool _isListening = false;

  RecognitionService() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onTrackRecognized':
        final Map<dynamic, dynamic> args = call.arguments;
        _onTrackRecognized(args['title'], args['text']);
        break;
    }
  }

  void _onTrackRecognized(String? title, String? text) {
    if (text != null && text.contains('•')) {
      final parts = text.split('•').map((s) => s.trim()).toList();
      if (parts.length >= 2) {
        _trackController.add(RecognizedTrack(
          artist: parts[0],
          title: parts[1],
          timestamp: DateTime.now(),
        ));
      }
    } else if (title != null && text != null) {
      _trackController.add(RecognizedTrack(
        artist: text,
        title: title,
        timestamp: DateTime.now(),
      ));
    }
  }

  Future<bool> hasPermission() async {
    final bool? hasPermission = await _channel.invokeMethod('hasPermission');
    return hasPermission ?? false;
  }

  Future<void> openPermissionSettings() async {
    await _channel.invokeMethod('openPermissionSettings');
  }

  Future<void> startListening() async {
    _isListening = true;
  }

  void stopListening() {
    _isListening = false;
  }

  void dispose() {
    _trackController.close();
  }
}
