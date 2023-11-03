import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/green_drawer.dart';
import 'package:green_puducherry/helpers/green_drawer_key.dart';
import 'package:green_puducherry/screens/bottom_nav.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constant/constant.dart';

class BackgroundScaffold extends StatelessWidget {
  BackgroundScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.isDashboard = false,
    this.appbarColor,
    this.scaffoldKey,
    this.transparentOpacity = 0.5,
    this.floatingActionButton,
    this.drawer,
    this.loading = false,
  });
  final Widget body;
  final AppBar? appBar;
  final Color? appbarColor;
  final double? transparentOpacity;
  final bool isDashboard;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: isDashboard ? const GreenBottomNav() : null,
      drawer: drawer,
      appBar: appBar,
      key: scaffoldKey,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 1.sh,
              width: 1.sw,
              constraints: BoxConstraints(
                maxHeight: 1.sh,
                maxWidth: 1.sw,
              ),
              color: Colors.white,
              child: Image.asset(
                GreenImages.kBG,
                fit: BoxFit.cover,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: 1.sw,
                  height: 1.sh,
                ),
                body,

                ///appbar
                // if (appBar != null)
                // Positioned(
                //   child: SizedBox(
                //     height: GreenValues.kAppbarHeight,
                //     width: 1.sw,
                //     child: AppBar(
                //       backgroundColor: Colors.transparent,
                //       elevation: 0,
                //       leading: appBar?.leading,
                //       title: appBar?.title,
                //       centerTitle: appBar?.centerTitle ?? true,
                //       flexibleSpace: Container(
                //         decoration: BoxDecoration(
                //           gradient: LinearGradient(
                //               begin: Alignment.topCenter,
                //               stops: const [0.7, 1],
                //               end: Alignment.bottomCenter,
                //               colors: [
                //                 appbarColor ??
                //                     GreenColors.kMainColor50
                //                         .withOpacity(transparentOpacity ?? 1),
                //                 GreenColors.kMainColor50.withOpacity(0.0)
                //               ]),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                ///dashboard
                // if (isDashboard)
                //   Positioned(
                //     bottom: 0,
                //     child: Container(
                //       height: GreenValues.kBottomAppbarHeight,
                //       padding: EdgeInsets.symmetric(horizontal: 10.w),
                //
                //       width: 1.sw,
                //       decoration: const BoxDecoration(
                //         color: Colors.white,
                //         // borderRadius: BorderRadius.only(
                //         //   topLeft: Radius.circular(20.r),
                //         //   topRight: Radius.circular(20.r),
                //         // ),
                //       ),
                //       // color: Colors.red,
                //       child: Row(),
                //     ),
                //   )
              ],
            ),
            if (loading)
              Container(
                color: Colors.black38,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
