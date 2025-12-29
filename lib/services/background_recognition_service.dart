import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spinsnitch_api/api.dart';
import 'recognition_service.dart';

// Key for the API base URL in service communication
const String kServiceApiBaseUrl = 'api_base_url';
const String kServiceAuthToken = 'auth_token';

class BackgroundRecognitionService {
  static Future<void> initialize(String apiBaseUrl, {String? authToken}) async {
    final service = FlutterBackgroundService();

    // Configure foreground notification for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'recognition_service',
      'Music Recognition',
      description: 'Active Listener is running',
      importance: Importance.low,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (defaultTargetPlatform == TargetPlatform.android) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: 'recognition_service',
        initialNotificationTitle: 'SpinSnitch',
        initialNotificationContent: 'Active Listener ready',
        foregroundServiceTypes: [AndroidForegroundType.microphone],
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );

    // Pass configuration to service
    service.invoke('set_config', {
      kServiceApiBaseUrl: apiBaseUrl,
      kServiceAuthToken: authToken,
    });
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    String? apiBaseUrl;
    String? authToken;
    Timer? cycleTimer;

    service.on('set_config').listen((event) {
      apiBaseUrl = event?[kServiceApiBaseUrl];
      authToken = event?[kServiceAuthToken];
    });

    service.on('stop').listen((event) {
      cycleTimer?.cancel();
      service.stopSelf();
    });

    // Recognition loop
    void runCycle() async {
      if (apiBaseUrl == null) {
        // Wait for config if not set yet
        cycleTimer = Timer(const Duration(seconds: 2), runCycle);
        return;
      }

      service.invoke('status', {'isRecording': true});
      
      try {
        final result = await _recordAndRecognize(apiBaseUrl!, authToken);
        
        service.invoke('result', result?.toJson());
        
        final cooldown = (result?.success ?? false) ? 20 : 8;
        service.invoke('status', {'isRecording': false, 'cooldown': cooldown});
        
        cycleTimer = Timer(Duration(seconds: cooldown), runCycle);
      } catch (e) {
        service.invoke('error', {'message': e.toString()});
        cycleTimer = Timer(const Duration(seconds: 10), runCycle);
      }
    }

    runCycle();
  }
  static Future<RecognitionResult?> _recordAndRecognize(
    String apiBaseUrl,
    String? authToken,
  ) async {
    // Setup API Client inside service
    Authentication? auth;
    if (authToken != null) {
      final bearerAuth = HttpBearerAuth();
      bearerAuth.accessToken = authToken;
      auth = bearerAuth;
    }

    final apiClient = ApiClient(basePath: apiBaseUrl, authentication: auth);
    final recognitionService = RecognitionService(apiClient);

    return await recognitionService.recordAndRecognize();
  }
}
