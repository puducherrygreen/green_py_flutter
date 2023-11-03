class NotificationModel {
  final String id;
  final String notificationId;
  final String userId;
  final String date;
  final bool isReaded;
  final NotificationData notificationData;

  NotificationModel(
      {required this.id,
      required this.notificationId,
      required this.userId,
      required this.date,
      required this.isReaded,
      required this.notificationData});

  factory NotificationModel.fromJson(json) {
    return NotificationModel(
        id: json["_id"],
        notificationId: json["notificationId"],
        userId: json["userId"],
        date: json["date"],
        isReaded: json["isReaded"],
        notificationData: NotificationData.fromJson(json["notificationData"]));
  }
}

class NotificationData {
  final String title;
  final String message;
  final String date;

  NotificationData(
      {required this.title, required this.message, required this.date});
  factory NotificationData.fromJson(json) {
    return NotificationData(
        title: json["title"], message: json["message"], date: json["date"]);
  }
}
