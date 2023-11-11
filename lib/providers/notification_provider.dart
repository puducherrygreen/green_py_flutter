import 'package:flutter/material.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/local_storage.dart';
import 'package:green_puducherry/models/notification_model.dart';
import 'package:green_puducherry/models/query_model.dart';
import 'package:green_puducherry/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider() {
    getAllNotification();
    getAllQueryResponse();
  }

  final NotificationService _notificationService = NotificationService();
  List<NotificationModel>? allNotification;
  List<QueryModel>? allQueries;
  bool hasNew = false;

  getAllNotification() async {
    print('-----------------  Checking Notification----------------------');
    String? userid = await LocalStorage.getString(GreenText.kUserId);
    if (userid != null) {
      List<NotificationModel>? res =
          await _notificationService.getAllNotification(userId: userid);
      allNotification = res;
      for (NotificationModel i in res ?? []) {
        if (i.isReaded == false) {
          hasNew = true;
          break;
        }
        hasNew = false;
      }
    } else {
      print("no user ===== user null---");
    }
    notifyListeners();
  }

  getAllQueryResponse() async {
    print('-----------------  Checking Notification----------------------');
    String? userid = await LocalStorage.getString(GreenText.kUserId);
    if (userid != null) {
      List<QueryModel>? res =
          await _notificationService.getUserQuery(userId: userid);
      allQueries = res;
    } else {
      print("no user ===== user null---");
    }
    notifyListeners();
  }

  makeHasReade({required String notificationId}) async {
    await _notificationService.makeHasReaded(notificationId: notificationId);
    await getAllNotification();
  }
}
