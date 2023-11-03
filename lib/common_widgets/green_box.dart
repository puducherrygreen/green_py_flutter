import 'package:flutter/material.dart';
import '../constant/constant.dart';

class GreenBox extends StatelessWidget {
  const GreenBox({
    super.key,
    required this.child,
    this.padding,
    this.height,
    this.width,
    this.alignment,
    this.border,
  });

  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: GreenColors.kInputBg,
        borderRadius: BorderRadius.circular(GreenValues.kRadius),
        border: Border.all(color: border ?? GreenColors.kMainColor50, width: 2),
      ),
      child: child,
    );
  }
}
