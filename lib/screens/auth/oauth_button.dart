import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/common_widgets.dart';
import '../../constant/constant.dart';
import '../../providers/auth_provider.dart';

class OauthButton extends StatelessWidget {
  const OauthButton({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return GreenButton(
      text: 'Sign In with Google',
      textColor: GreenColors.kLinkColor,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      isSuffix: true,
      suffix: Image.asset(GreenImages.kGooglePng),
      onPressed: onPressed ??
          () async {
            await authProvider.googleOauth(context);
          },
    );
  }
}
