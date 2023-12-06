import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/constant/firebase_exception.dart';
import 'package:green_puducherry/helpers/local_storage.dart';
import 'package:green_puducherry/helpers/validation_helper.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:green_puducherry/screens/auth/pages/verification_screen.dart';
import 'package:green_puducherry/screens/home/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common_widgets/common_widgets.dart';
import '../../../constant/constant.dart';
import '../../../helpers/my_navigation.dart';
import '../../../models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../oauth_button.dart';
import '../widgets/green_puducherry.dart';
import 'profile_information.dart';

class AuthWithEmail extends StatefulWidget {
  const AuthWithEmail({super.key, this.isLogin = false});
  final bool isLogin;

  @override
  State<AuthWithEmail> createState() => _AuthWithEmailState();
}

class _AuthWithEmailState extends State<AuthWithEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLogin = false;

  bool emailValidate = true;
  bool passwordValidate = true;

  bool allValidation() {
    emailValidate =
        ValidationHelper.emailValidation(value: emailController.text.trim());
    passwordValidate = ValidationHelper.passwordValidation(
        value: passwordController.text.trim());
    setState(() {});
    return emailValidate && passwordValidate;
  }

  toggleMethod() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  signIn(BuildContext context, AuthProvider authProvider) async {
    final data = await authProvider.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (context.mounted) {
      if (data == MyFirebaseException.kUserExist) {
        VxToast.show(context,
            msg: data,
            bgColor: Colors.black,
            textColor: Colors.white,
            textSize: 16.sp);
      } else {
        // MyNavigation.replace(context, const ProfileInformation());

        MyNavigation.to(
            context,
            VerificationScreen(
              email: emailController.text.toString().trim(),
            ));
      }
    }
  }

  logIn(BuildContext context, AuthProvider authProvider,
      PlantProvider plantProvider) async {
    UserModel? userModel = await authProvider.loginWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (context.mounted) {
      if (userModel == null) {
        VxToast.show(context,
            msg: "Invalid User",
            bgColor: Colors.black,
            textColor: Colors.white,
            textSize: 16.sp);
      } else {
        plantProvider.loadLocalPlant();
        MyNavigation.to(
            context,
            ShowCaseWidget(
                builder: Builder(
                    builder: (context) => Home(
                          showcaseHidden: true,
                        ))));
      }
    }
  }

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLogin = widget.isLogin;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final plantProvider = Provider.of<PlantProvider>(context);
    return BackgroundScaffold(
        loading: loading,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              const SizedBox(),
              const GreenPuducherry(),
              Column(
                children: [
                  MyTextField(
                    isValid: emailValidate,
                    controller: emailController,
                    isPassword: false,
                    hintText: "Email",
                    errorText: "Invalid Email",
                    keyboardType: TextInputType.emailAddress,
                    onChange: (val) {
                      emailValidate = true;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10.h),
                  MyTextField(
                    isValid: passwordValidate,
                    controller: passwordController,
                    isPassword: true,
                    hintText: 'Password',
                    errorText: 'Invalid Password',
                    onChange: (val) {
                      passwordValidate = true;
                      setState(() {});
                    },
                  ),
                  isLogin
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final res = await authProvider.forgetPassword(
                                    email: emailController.text);
                                if (res == MyFirebaseException.kInvalidEmail) {
                                  if (context.mounted) {
                                    VxToast.show(context,
                                        msg: "Invalid Email",
                                        textColor: Colors.white,
                                        bgColor: Colors.black);
                                  }
                                }
                                print("forget password error $res");
                              },
                              child: GText(
                                'Forget Password',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(height: 10.h),
                  GreenButton(
                    text: isLogin ? "Login" : 'Sign Up',
                    textColor: GreenColors.kMainColor,
                    height: 40.h,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    onPressed: () async {
                      loading = true;
                      setState(() {});
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (allValidation()) {
                        if (isLogin) {
                          await logIn(context, authProvider, plantProvider);
                        } else {
                          await signIn(context, authProvider);
                        }
                      } else {
                        VxToast.show(context, msg: "Something went wrong");
                      }
                      loading = false;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10.h),
                  const ORBar(),
                  SizedBox(height: 10.h),
                  const OauthButton(),
                ],
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: toggleMethod,
                  child: !isLogin
                      ? RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: GreenColors.kMainColor),
                              children: const [
                                TextSpan(
                                    text: "Login",
                                    style: TextStyle(
                                        color: GreenColors.kLinkColor))
                              ]),
                        )
                      : RichText(
                          text: TextSpan(
                              text: "Don’t have an account? ",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: GreenColors.kMainColor),
                              children: const [
                                TextSpan(
                                    text: "Sign Up Free!",
                                    style: TextStyle(
                                        color: GreenColors.kLinkColor))
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
