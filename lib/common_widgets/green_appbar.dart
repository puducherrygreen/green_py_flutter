import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/constant/constant.dart';

import 'notification_button.dart';

AppBar greenAppBar({
  String? title,
  Widget? leading,
  List<Widget>? action,
  TabBar? bottom,
  bool enableNotificationButton = false,
  Color? backgroundColor,
  TextStyle? titleStyle,
  Widget? notificationWidget,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? Colors.transparent,
    centerTitle: true,
    title: title != null
        ? Text(
            title,
            style: titleStyle ?? const TextStyle(color: GreenColors.kMainColor),
          )
        : null,
    elevation: 0,
    leading: leading,
    actions: [
      ...action ?? [],
      if (enableNotificationButton)
        notificationWidget ?? const NotificationButton(),
      SizedBox(width: 10.w)
    ],
    bottom: bottom,
  );
}
