import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/helpers/local_storage.dart';
import 'package:green_puducherry/providers/auth_provider.dart';
import 'package:green_puducherry/screens/auth/pages/profile_information.dart';
import 'package:green_puducherry/screens/home/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import 'constant/constant.dart';
import 'helpers/main_init.dart';
import 'providers/bottom_nav_provider.dart';
import 'providers/loading_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/plant_provider.dart';
import 'screens/auth/pages/lets_start.dart';

late List<CameraDescription> kGlobalCamera;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await mainInit();
  final pref = await SharedPreferences.getInstance();
  print("---------------------- SharedPreferences keys ---------------------");
  print(pref.getKeys());
  print("---------------------- SharedPreferences keys ---------------------");

  kGlobalCamera = await availableCameras();
  bool pendingRegister =
      await LocalStorage.getBool(GreenText.kIsPending) ?? false;
  bool isDashboard = await LocalStorage.getBool(GreenText.kIsLogged) ?? false;
  bool showcaseHidden =
      await LocalStorage.getBool(GreenText.kShowcase) ?? false;
  runApp(MyApp(
    isLogged: isDashboard,
    isPending: pendingRegister,
    showcaseHidden: showcaseHidden,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.isLogged,
      this.isPending = false,
      this.showcaseHidden = false});
  final bool isLogged;
  final bool isPending;
  final bool showcaseHidden;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => PlantProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Roboto",
              primaryColor: GreenColors.kMainColor,
            ),
            home: child,
          );
        },
        child: isPending
            ? const ProfileInformation()
            : isLogged
                ? ShowCaseWidget(builder: Builder(builder: (context) {
                    return Home(showcaseHidden: showcaseHidden);
                  }))
                : const LetsStart(),
      ),
    );
  }
}
