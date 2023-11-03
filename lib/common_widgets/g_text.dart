import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/constant.dart';

class GText extends StatelessWidget {
  const GText(
    this.data, {
    super.key,
    this.style,
  });
  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: style?.fontSize ?? 18.sp,
        color: style?.color ?? GreenColors.kMainColor,
        fontFamily: style?.fontFamily ?? "Roboto",
        fontWeight: style?.fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
