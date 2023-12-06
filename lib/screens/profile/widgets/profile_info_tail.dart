import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/g_text.dart';

class ProfileInfoTail extends StatelessWidget {
  const ProfileInfoTail({
    super.key,
    this.field = "Field Name",
    this.value = "Value",
  });

  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
            ],
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field,
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Expanded(child: GText(value)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ProfileInfoTail extends StatelessWidget {
//   const ProfileInfoTail({
//     super.key,
//     this.field = "Field Name",
//     this.value = "Value",
//   });
//
//   final String field;
//   final String value;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             field,
//             style: TextStyle(fontSize: 20, color: Colors.grey[700]),
//           ),
//           SizedBox(height: 5.h),
//           GreenBox(
//             // height: 40.h,
//             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15),
//             alignment: Alignment.centerLeft,
//             child: GText(value),
//           )
//         ],
//       ),
//     );
//   }
// }
