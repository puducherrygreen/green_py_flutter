import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/constant.dart';
import 'green_box.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({
    this.hintText = "Select",
    this.errorText = "Invalid",
    this.items = const <String>[],
    this.onChange,
    this.value,
    this.border,
    super.key,
  });

  final String hintText;
  final String errorText;
  final List<String> items;
  final ValueChanged? onChange;
  final String? value;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return GreenBox(
      border: border,
      child: Stack(
        alignment: Alignment.bottomLeft,
        clipBehavior: Clip.none,
        children: [
          DropdownButtonFormField2(
            hint: Text(
              hintText,
              style: TextStyle(color: Colors.grey),
            ),
            value: value,
            isExpanded: true,
            onChanged: onChange,
            style: TextStyle(color: GreenColors.kMainColor, fontSize: 18.sp),
            decoration: const InputDecoration(border: InputBorder.none),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              offset: Offset(0.w, -5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
          ),
          if (border != null)
            Positioned(
              bottom: -8.h,
              left: 20,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(3),
                child: Text(
                  errorText,
                  style: TextStyle(color: Colors.red[600]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
