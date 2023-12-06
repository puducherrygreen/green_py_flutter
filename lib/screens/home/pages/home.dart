import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/common_widgets/notification_button.dart';
import 'package:green_puducherry/common_widgets/show_case_view.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/constant/green_plan_type.dart';
import 'package:green_puducherry/helpers/local_storage.dart';
import 'package:green_puducherry/helpers/pop_scope_function.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../common_widgets/g_text.dart';
import '../../../common_widgets/green_buttons.dart';
import '../../../common_widgets/green_drawer.dart';
import '../../../common_widgets/green_floating_action_button.dart';
import '../widgets/plant_type_button.dart';

class Home extends StatefulWidget {
  Home({super.key, this.showcaseHidden = false});
  final bool showcaseHidden;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  getRequest() async {
    final plantProvider = Provider.of<PlantProvider>(context, listen: false);
    final locationStatus = await Permission.location.status;
    final cameraStatus = await Permission.camera.status;
    final micStatus = await Permission.microphone.status;
    final audioStatus = await Permission.audio.status;
    if (!locationStatus.isGranted) {
      await plantProvider.getAllPermissionRequest();
    }
    if (!cameraStatus.isGranted) {
      await plantProvider.getAllPermissionRequest();
    }
    if (!micStatus.isGranted) {
      await plantProvider.getAllPermissionRequest();
    }
    if (!audioStatus.isGranted) {
      await plantProvider.getAllPermissionRequest();
    }
  }

  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) => getRequest());
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_one, _two, _three]));
    LocalStorage.setBool(GreenText.kShowcase, true);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      isDashboard: true,
      scaffoldKey: scaffoldKey,
      drawer: const GreenDrawer(),
      floatingActionButton: ShowCaseView(
          globalKey: _one,
          description: "Add Plant",
          title: "add",
          showDone: widget.showcaseHidden,
          child: const GreenFloatingActionButton()),
      // floatingActionButton: const GreenFloatingActionButton(),
      appBar: greenAppBar(
          leading: ShowCaseView(
            globalKey: _two,
            description: "Menu",
            title: "You can Navigate to others",
            showDone: widget.showcaseHidden,
            child: GreenMenuButton(
              scaffoldKey: scaffoldKey,
            ),
          ),
          enableNotificationButton: true,
          notificationWidget: ShowCaseView(
              globalKey: _three,
              description: "Notification",
              title: "Notification",
              showDone: widget.showcaseHidden,
              child: NotificationButton())),
      body: PopScope(
        canPop: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
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
      ),
    );
  }
}
