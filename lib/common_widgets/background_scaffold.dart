import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/helpers/green_push_notification/internet_helper.dart';
import 'package:green_puducherry/screens/bottom_nav.dart';

import '../constant/constant.dart';

class BackgroundScaffold extends StatefulWidget {
  const BackgroundScaffold({
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
  State<BackgroundScaffold> createState() => _BackgroundScaffoldState();
}

class _BackgroundScaffoldState extends State<BackgroundScaffold> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Connectivity().onConnectivityChanged.listen((result) {
      InternetHelper.connectivityStreamController
          .add(result != ConnectivityResult.none);
    });
  }

  // @override
  // void dispose() {
  //   InternetHelper.connectivityStreamController
  //       .close(); // Close the stream controller when the widget is disposed
  //   super.dispose();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: InternetHelper.connectivityStreamController.stream,
        builder: (context, snapshot) {
          bool isConnected = snapshot.data ?? true;
          if (!isConnected) {
            // Navigate to the page when the connection is lost
            return Scaffold(
              body: Center(
                child: Text(
                  'Check Your Internet Connection',
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            bottomNavigationBar:
                widget.isDashboard ? const GreenBottomNav() : null,
            drawer: widget.drawer,
            appBar: widget.appBar,
            key: widget.scaffoldKey,
            floatingActionButton: widget.floatingActionButton,
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
                      widget.body,

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
                  if (widget.loading)
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
        });
  }
}
