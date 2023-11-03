import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common_widgets/green_buttons.dart';
import '../../../providers/notification_provider.dart';
import '../widgets/notification_message.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NotificationProvider>(context);
    return BackgroundScaffold(
        appBar: greenAppBar(
          leading: const GreenBackButton(),
          title: "All Notification",
        ),
        body: np.allNotification == null
            ? const Center(
                child: GText("No Notification"),
              )
            : ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: np.allNotification!
                    .map(
                      (e) => NotificationMessage(
                        title: e.notificationData.title,
                        message: e.notificationData.message,
                        isReaded: e.isReaded,
                        id: e.id,
                      ),
                    )
                    .toList(),
              ));
  }
}
