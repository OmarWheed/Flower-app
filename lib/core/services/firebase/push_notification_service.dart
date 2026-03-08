import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log(message.notification?.title ?? 'No Title', name: 'BG Message');
}

@pragma('vm:entry-point')
void onBackgroundNotification(NotificationResponse response) {}

class PushNotificationService {
  static final _messaging = FirebaseMessaging.instance;
  static final _localNotification = FlutterLocalNotificationsPlugin();

  static Future<String?> initFCM() async {
    await _messaging.requestPermission();
    await _initLocalNotification();
    String? deviceToken = await _messaging.getToken();
    log(deviceToken ?? "token id is null", name: 'DeviceToken');
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      _showNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });
    return deviceToken;
  }

  static Future<void> _initLocalNotification() async {
    InitializationSettings initSettings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotification.initialize(
      settings: initSettings,
      onDidReceiveBackgroundNotificationResponse: onBackgroundNotification,
      onDidReceiveNotificationResponse: onBackgroundNotification,
    );
  }

  static void _showNotification({
    required String? title,
    required String? body,
  }) async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        "basic Notification",
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _localNotification.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: details,
      payload: "payload",
    );
  }

  static Future<bool> requestPermissions() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      bool permission = await openAppSettings();
      if (permission) return true;
      return false;
    }
    return false;
  }

  static Future<void> cancelAllNotifications() async {
    await _localNotification.cancelAll();
  }
}
