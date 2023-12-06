import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/screens/auth/widgets/green_puducherry.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/common_widgets.dart';
import '../../../constant/constant.dart';
import '../../../providers/auth_provider.dart';
import '../oauth_button.dart';
import 'auth_with_email.dart';

class AuthLanding extends StatefulWidget {
  const AuthLanding({super.key});

  @override
  State<AuthLanding> createState() => _AuthLandingState();
}

class _AuthLandingState extends State<AuthLanding> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return BackgroundScaffold(
        loading: loading,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const GreenPuducherry(),
              Column(
                children: [
                  OauthButton(
                    onPressed: () async {
                      loading = true;
                      setState(() {});
                      try {
                        await authProvider.googleOauth(context);
                      } catch (e) {
                        print(e);
                      }
                      loading = false;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10.h),
                  const ORBar(),
                  SizedBox(height: 10.h),
                  GreenButton(
                    text: 'Sign Up with Email',
                    textColor: GreenColors.kMainColor,
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    isSuffix: true,
                    suffix: Icon(
                      Icons.mail,
                      color: GreenColors.kMainColor,
                      size: 25.sp,
                    ),
                    onPressed: () {
                      MyNavigation.to(context, const AuthWithEmail());
                    },
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    MyNavigation.to(
                        context, const AuthWithEmail(isLogin: true));
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                            fontSize: 18.sp, color: GreenColors.kMainColor),
                        children: const [
                          TextSpan(
                              text: "Login",
                              style: TextStyle(color: GreenColors.kLinkColor))
                        ]),
                  ),
                ),
              ),
              SizedBox(width: 50.w),
            ],
          ),
        ));
  }
}
