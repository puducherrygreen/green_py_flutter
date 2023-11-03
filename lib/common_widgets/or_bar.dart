import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/constant.dart';
import 'g_text.dart';

class ORBar extends StatelessWidget {
  const ORBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2.h,
          width: 0.30.sw,
          color: GreenColors.kMainColor50,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GText(
            "or",
            style: TextStyle(color: GreenColors.kMainColor),
          ),
        ),
        Container(
          height: 2.h,
          width: 0.30.sw,
          color: GreenColors.kMainColor50,
        )
      ],
    );
  }
}
