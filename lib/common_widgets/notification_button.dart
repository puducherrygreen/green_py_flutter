import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/notification_provider.dart';
import 'package:green_puducherry/screens/notification/pages/notification_page.dart';
import 'package:provider/provider.dart';

import '../constant/green_colors.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NotificationProvider>(context);
    return GestureDetector(
      onTap: () {
        MyNavigation.to(context, const NotificationPage());
      },
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Badge(
            backgroundColor: np.hasNew ? Colors.red : Colors.transparent,
            child: const Icon(
              FeatherIcons.bell,
              size: 20,
              color: GreenColors.kMainColor,
            ),
          ),
        ),
      ),
    );
  }
}
