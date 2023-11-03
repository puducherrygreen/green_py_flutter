import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant//green_colors.dart';
import '../../../constant/green_images.dart';

class GreenPuducherry extends StatelessWidget {
  const GreenPuducherry({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 0.25.sh,
          child: Image.asset(GreenImages.kMainLogo),
        ),
        SizedBox(height: 15.h),
        Text(
          "Green Puducherry",
          style: TextStyle(
              fontFamily: "Sacramento",
              fontSize: 40.sp,
              color: GreenColors.kMainColor),
        )
      ],
    );
  }
}
