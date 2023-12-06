import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationAndroid =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings initializationIos =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (id, title, body, payload) {});
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationAndroid, iOS: initializationIos);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {});
  }

  Future<void> simpleNotificationShow(
      {required int id,
      required String title,
      required String message,
      String? payload}) async {
    await Future.delayed(const Duration(seconds: 5));

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "Channel_id",
      "Channel_name",
      priority: Priority.high,
      importance: Importance.max,
      channelShowBadge: true,
      icon: 'mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(id, title, message, notificationDetails,
        payload: payload);
  }
//
// Future<void> bigPicNotificationShow() async {
//   BigPictureStyleInformation bigPictureStyleInformation =
//       BigPictureStyleInformation(
//     DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
//     contentTitle: "Big pic",
//     largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
//   );
//   AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//     "big_Channel_id",
//     "big_Channel_name",
//     priority: Priority.high,
//     importance: Importance.max,
//     styleInformation: bigPictureStyleInformation,
//   );
//   NotificationDetails notificationDetails =
//       NotificationDetails(android: androidNotificationDetails);
//   await notificationsPlugin.show(
//       1, "big Simple Notification", 'big new message', notificationDetails);
// }
}
