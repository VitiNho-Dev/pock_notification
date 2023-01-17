import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotificationData {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  const CustomNotificationData({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
  });
}

class CustomLocalNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  late NotificationDetails notificationDetails;

  CustomLocalNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    inicializeNotifications();
  }

  inicializeNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: android),
    );

    androidDetails = const AndroidNotificationDetails(
      'id_1',
      'andoridNotification',
      channelDescription: 'Notificações do android',
      importance: Importance.max,
      priority: Priority.max,
    );

    notificationDetails = NotificationDetails(
      android: androidDetails,
    );
  }

  showNotification(CustomNotificationData notificationData) {
    flutterLocalNotificationsPlugin.show(
      notificationData.id,
      notificationData.title,
      notificationData.body,
      notificationDetails,
      payload: notificationData.payload,
    );
  }
}
