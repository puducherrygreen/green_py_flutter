import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/green_colors.dart';

class ImageInfoTail extends StatelessWidget {
  const ImageInfoTail(
      {super.key, this.value = "Value", this.fieldName = "Field Name"});
  final String fieldName;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 10.sp),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: GreenColors.kMainColor50)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fieldName,
                    style: TextStyle(
                        fontSize: 15.sp, color: GreenColors.kMainColor),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    value,
                    style: TextStyle(
                        fontSize: 20.sp, color: GreenColors.kSecondColor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
