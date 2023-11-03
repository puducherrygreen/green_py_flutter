import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/constant/constant.dart';

import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widgets/background_scaffold.dart';
import '../../../providers/auth_provider.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.email});
  final String email;
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool loading = false;

  String btnLabel = "Verify Link has been sent";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return BackgroundScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verify Your Email",
              style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.sp),
            const Text(
              "Please check your email for a link to verify your email address.\nonce verified you'll be able to continue.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18.h),
            Icon(
              Icons.mail_rounded,
              size: 80.w,
              color: GreenColors.kMainColor,
            ),
            loading ? CircularProgressIndicator() : SizedBox(),
            SizedBox(height: 16.sp),
            GreenButton(
              text: "Get Verification Link",
              onPressed: () {
                AuthProvider.verificationTimer(context);
                setState(() {
                  loading = true;
                });
              },
            ),
            SizedBox(height: 20),
            if (loading)
              RichText(
                text: TextSpan(
                    text: "Didn't receive an email? ",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16.sp),
                    children: [
                      TextSpan(
                          text: "Resend",
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              authProvider.sendEmailVerification(context);
                            })
                    ]),
              )
          ],
        ),
      ),
    );
  }
}
