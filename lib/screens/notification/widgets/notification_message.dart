import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/notification_provider.dart';
import 'package:green_puducherry/screens/notification/pages/view_message.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constant/green_colors.dart';

class NotificationMessage extends StatelessWidget {
  const NotificationMessage(
      {super.key,
      this.isReaded = false,
      required this.title,
      required this.message,
      required this.id});

  final bool isReaded;
  final String title;
  final String message;
  final String id;
  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NotificationProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Material(
        borderRadius: BorderRadius.circular(6.r),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            if (!isReaded) {
              np.makeHasReade(notificationId: id);
            }
            MyNavigation.to(context,
                ViewNotificationMessage(message: message, title: title));
          },
          child: Opacity(
            opacity: isReaded ? 0.5 : 1,
            child: Container(
              width: 1.sw,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              // margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.capitalized,
                    style: TextStyle(
                        color: GreenColors.kMainColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    message.capitalized,
                    style: TextStyle(
                      color: GreenColors.kSecondColor,
                      fontSize: 16.sp,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
