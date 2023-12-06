import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/helpers/local_storage.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/screens/auth/pages/auth_landing.dart';

import '../../../common_widgets/common_widgets.dart';
import '../../../constant/constant.dart';
import '../../../helpers/pop_scope_function.dart';
import '../widgets/green_puducherry.dart';

class LetsStart extends StatelessWidget {
  const LetsStart({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
        body: WillPopScope(
      onWillPop: () async => await willPopBack(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            SizedBox(
                height: 100.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(GreenImages.kPPCC),
                    SizedBox(width: 20.w),
                    Image.asset(GreenImages.kLionLogo)
                  ],
                )),
            const GreenPuducherry(),
            GreenButton(
              text: "Let's Start",
              onPressed: () {
                LocalStorage.setBool(GreenText.kLetsStart, true);
                MyNavigation.to(context, const AuthLanding());
              },
            ),
            const SizedBox()
          ],
        ),
      ),
    ));
  }
}
