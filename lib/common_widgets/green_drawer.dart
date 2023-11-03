import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/bottom_nav_provider.dart';
import 'package:green_puducherry/screens/notification/pages/notification_page.dart';
import 'package:green_puducherry/screens/profile/pages/profile_page.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/add_photo/pages/photo_added_messege.dart';
import '../screens/auth/pages/lets_start.dart';
import '../screens/gallery/pages/selected_image_gallery.dart';
import 'g_text.dart';

class GreenDrawer extends StatelessWidget {
  const GreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    return Drawer(
      width: 0.7.sw,
      backgroundColor: Color(0xffD2FBCD),
      child: ListView(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 40.h),
        children: [
          SizedBox(
            height: 0.4.sw,
            width: 0.4.sw,
            child: Image.asset(GreenImages.kMainLogo),
          ),
          SizedBox(height: 10.h),
          Center(child: GText("${authProvider.user?.email}")),
          SizedBox(height: 10.h),
          const DrawerListTail(label: "Profile", page: ProfilePage()),
          const DrawerListTail(
            label: "Notification",
            page: NotificationPage(),
          ),
          DrawerListTail(
            label: "Image Gallery",
            page: SelectedImageGallery(),
          ),
          DrawerListTail(
            label: "Logout",
            onPressed: () async {
              await authProvider.logout();
              bottomNavProvider.setIndex(0);
              if (context.mounted) {
                MyNavigation.to(context, const LetsStart());
              }
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTail extends StatelessWidget {
  const DrawerListTail({
    super.key,
    required this.label,
    this.page,
    this.onPressed,
  });

  final String label;
  final Widget? page;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black.withOpacity(0.05),
        child: InkWell(
          onTap: onPressed ??
              () {
                MyNavigation.back(context);
                if (page != null) {
                  MyNavigation.to(context, page!);
                }
              },
          child: Container(
            height: 35.h,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: GText(
                  label,
                  style: TextStyle(color: Colors.green[900]),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
