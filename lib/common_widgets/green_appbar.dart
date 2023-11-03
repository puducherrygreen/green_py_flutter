import 'package:flutter/material.dart';
import 'package:green_puducherry/common_widgets/green_buttons.dart';
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
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? Colors.transparent,
    centerTitle: true,
    title: title != null
        ? Text(
            title,
            style: titleStyle ?? TextStyle(color: GreenColors.kMainColor),
          )
        : null,
    elevation: 0,
    leading: leading,
    actions: [
      ...action ?? [],
      if (enableNotificationButton) NotificationButton(),
      SizedBox(width: 10)
    ],
    bottom: bottom,
  );
}
