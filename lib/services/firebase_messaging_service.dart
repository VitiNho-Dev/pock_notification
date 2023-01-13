import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pock_notification/custom_local_notification/custom_local_notification.dart';

import '../main.dart';

class FirebaseMessagingService {
  final CustomLocalNotification customLocalNotification =
      CustomLocalNotification();

  Future<void> initialize() async {
    await FirebaseMessaging //
        .instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
  }

  Future<String> getDeviceFirebaseToken() async {
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
      navigatorKey.currentState?.pushNamed(message.data['rout']);
    });
  }
}
