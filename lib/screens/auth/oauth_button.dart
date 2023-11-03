import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/screens/home/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common_widgets/common_widgets.dart';
import '../../constant/constant.dart';
import '../../providers/auth_provider.dart';
import '../../providers/loading_provider.dart';

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
