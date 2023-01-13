import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pock_notification/custom_local_notification/custom_local_notification.dart';

import '../main.dart';

abstract class NotificationService {
  Future<void> initialize();

  Future<String> getDeviceToken();
}

class FirebaseMessagingService implements NotificationService {
  final CustomLocalNotification customLocalNotification =
      CustomLocalNotification();

  @override
  Future<void> initialize() async {
    await FirebaseMessaging //
        .instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true,
    );
    getDeviceToken();
    _onMessage();
  }

  @override
  Future<String> getDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('=======================');
    debugPrint('$token');
    debugPrint('=======================');
    return token!;
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        customLocalNotification.androidNotification(notification, android);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      navigatorKey.currentState?.pushNamed(message.data['route']);
    });
  }
}
