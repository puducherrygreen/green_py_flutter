import 'dart:convert';

import 'package:green_puducherry/models/notification_model.dart';
import 'package:http/http.dart' as http;

import '../constant/green_api.dart';

class NotificationService {
  Future<List<NotificationModel>?> getAllNotification(
      {required String userId}) async {
    final client = http.Client();
    final res = await client.get(Uri.https(
        GreenApi.kBaseUrl, "${GreenApi.kGetUserNotificationUrl}$userId"));
    print("notfication api res ${res.body}");
    List? data = jsonDecode(res.body);
    print('-------------notification details data ------------');
    print(data);
    print('-------------notification details data ------------');
    if (data != null) {
      List<NotificationModel> notificationModelList = [];
      for (Map i in data) {
        notificationModelList.add(NotificationModel.fromJson(i));
      }

      return notificationModelList;
    }
    print('-------------notification details data end ------------');
    return null;
  }

  Future makeHasReaded({required String notificationId}) async {
    try {
      final client = http.Client();
      final res = await client.put(Uri.https(GreenApi.kBaseUrl,
          "${GreenApi.kMakeNotificationReadUrl}$notificationId"));
      print('---------------notfication reded apip----------------');
      print(res.body);
      print('---------------notfication reded apip----------------');
      return res;
    } catch (e) {
      return null;
    }
  }
}
