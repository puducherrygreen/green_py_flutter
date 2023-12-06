import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'green_push_notification/qc_push_notification_helper.dart';

mainInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    await QCPushNotificationHelper().initNotification();
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    // print('----TK -- $fcmToken');
  }
}
