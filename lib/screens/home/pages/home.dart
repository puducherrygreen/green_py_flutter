import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/constant/green_colors.dart';
import 'package:green_puducherry/constant/green_images.dart';
import 'package:green_puducherry/helpers/green_push_notification/notification_manager.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/helpers/pop_scope_function.dart';
import 'package:green_puducherry/providers/auth_provider.dart';
import 'package:green_puducherry/providers/bottom_nav_provider.dart';
import 'package:green_puducherry/screens/add_photo/pages/select_plant.dart';
import 'package:green_puducherry/screens/auth/pages/lets_start.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/g_text.dart';
import '../../../common_widgets/green_buttons.dart';
import '../../../common_widgets/green_drawer.dart';
import '../../../common_widgets/green_floating_action_button.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return BackgroundScaffold(
        isDashboard: true,
        scaffoldKey: scaffoldKey,
        drawer: GreenDrawer(),
        floatingActionButton: const GreenFloatingActionButton(),
        appBar: greenAppBar(
            leading: GreenMenuButton(
              scaffoldKey: scaffoldKey,
            ),
            enableNotificationButton: true),
        body: WillPopScope(
          onWillPop: () async => await willPopBack(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 1.sw,
                      child: Image.asset(
                        GreenImages.kGroupLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                GText(
                  "Green Puducherry",
                  style: TextStyle(fontSize: 25.sp),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Text(
                    GreenText.kHomeContent,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[800]),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ));
  }
}
