import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:spinsnitch_api/api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:http_parser/http_parser.dart';

import 'dart:io' if (dart.library.html) 'web_dummy.dart' show File;

class RecognitionService {
  final ApiClient apiClient;
  final AudioRecorder _recorder = AudioRecorder();

  RecognitionService(this.apiClient);

  Future<void> dispose() async {
    await _recorder.dispose();
  }

  Future<RecognitionResult?> recordAndRecognize() async {
    if (!await _recorder.hasPermission()) {
      throw Exception('Microphone permission not granted');
    }

    final config = RecordConfig(
      encoder: kIsWeb ? AudioEncoder.opus : AudioEncoder.aacLc,
      bitRate: 128000,
      sampleRate: 44100,
    );

    if (kIsWeb) {
      await _recorder.start(config, path: '');
      await Future.delayed(const Duration(seconds: 5));
      final path = await _recorder.stop();
      
      if (path == null) return null;

      final response = await http.get(Uri.parse(path));
      final bytes = response.bodyBytes;

      final multipartFile = MultipartFile.fromBytes(
        'file',
        bytes,
        filename: 'snippet.webm',
        contentType: MediaType('audio', 'webm'),
      );

      return await VinylApi(apiClient).postRecognizeRoute(multipartFile);
    } else {
      final tempDir = await getTemporaryDirectory();
      final filePath = p.join(tempDir.path, 'snippet_${DateTime.now().millisecondsSinceEpoch}.m4a');

      await _recorder.start(config, path: filePath);
      await Future.delayed(const Duration(seconds: 5));
      final stoppedPath = await _recorder.stop();

      if (stoppedPath == null) return null;

      // On native, we use File to read the bytes
      // The conditional import above ensures this compiles on web (though it won't run)
      final file = File(stoppedPath);
      final bytes = await file.readAsBytes();

      final multipartFile = MultipartFile.fromBytes(
        'file',
        bytes,
        filename: 'snippet.m4a',
      );

      return await VinylApi(apiClient).postRecognizeRoute(multipartFile);
    }
  }
}
