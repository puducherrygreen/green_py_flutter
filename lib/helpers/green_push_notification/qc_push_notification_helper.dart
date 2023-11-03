import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'device_token_helper.dart';
import 'notification_manager.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('-------------------notitification info-----------------------------');
  print('title : ${message.notification?.title}');
  print('body : ${message.notification?.body}');
  print('payload : ${message.data}');

  print('-------------------notitification info-----------------------------');
}

class QCPushNotificationHelper {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final AndroidFlutterLocalNotificationsPlugin _notificationsPlugin =
      AndroidFlutterLocalNotificationsPlugin();

  Future<void> handleMessage(RemoteMessage? message) async {
    print('Message data ---------------> ${message?.data}');
    print('Message data ---------------> ${message?.data['route']}');
    String? route = message?.data['route'];
    print("Notification Route : $route");

    // String? deepLink = message?.data['deepLink'];
    // if (deepLink != null) {
    //   final url = Uri.parse(deepLink.toString());
    //   await launchUrl(url);
    //   return;
    // }
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;

      if (notification == null) return;
      NotificationManager().simpleNotificationShow(
        id: notification.hashCode,
        title: notification.title ?? "No Title",
        message: notification.body ?? "Empty Message",
      );
    });
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    final fCMToken = await _firebaseMessaging.getToken();
    DeviceToken.setDeviceToken(fCMToken);
    await initPushNotifications();
    await NotificationManager().initNotification();
  }
}
