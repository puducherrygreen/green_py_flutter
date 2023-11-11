import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';

import '../constant/constant.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    this.controller,
    this.isPassword = false,
    this.hintText,
    this.keyboardType = TextInputType.name,
    this.maxLine,
    this.minLine,
    this.isValid = true,
    this.onChange,
    this.errorText,
  });

  final TextEditingController? controller;
  final bool isPassword;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final int? maxLine;
  final int? minLine;
  final bool isValid;
  final ValueChanged? onChange;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool showPassword = false;

  toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GreenBox(
      border: widget.isValid ? null : Colors.red,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Stack(
        alignment: Alignment.bottomLeft,
        clipBehavior: Clip.none,
        children: [
          TextField(
            controller: widget.controller,
            maxLines: widget.isPassword ? 1 : widget.maxLine ?? 3,
            minLines: widget.minLine ?? 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: GreenColors.kInputBg,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: toggleShowPassword,
                      icon: showPassword
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      color: GreenColors.kMainColor,
                    )
                  : SizedBox(),
            ),
            keyboardType: widget.keyboardType,
            style: TextStyle(fontSize: 18.sp, color: GreenColors.kMainColor),
            obscureText: showPassword,
            onChanged: widget.onChange,
          ),
          if (!widget.isValid)
            Positioned(
              bottom: -10.h,
              left: 20,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(3),
                child: Text(
                  widget.errorText ?? "Invalid value",
                  style: TextStyle(color: Colors.red[600]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
