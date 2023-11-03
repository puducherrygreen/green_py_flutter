import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/common_widgets/green_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constant/green_colors.dart';

class ViewNotificationMessage extends StatelessWidget {
  const ViewNotificationMessage(
      {super.key, required this.message, required this.title});
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar:
          greenAppBar(title: "View Notification", leading: GreenBackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title.capitalized,
              style: TextStyle(
                  color: GreenColors.kMainColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            Text(
              message.capitalized,
              style: TextStyle(
                color: GreenColors.kSecondColor,
                fontSize: 16.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
