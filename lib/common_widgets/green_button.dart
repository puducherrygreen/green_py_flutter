import 'package:flutter/material.dart';
import '../constant/constant.dart';
import 'g_text.dart';
import 'green_box.dart';

class GreenButton extends StatelessWidget {
  const GreenButton({
    super.key,
    required this.text,
    this.height,
    this.textColor,
    this.onPressed,
    this.suffix,
    this.padding,
    this.isSuffix = false,
    this.enabled = true,
  });

  final String text;
  final Color? textColor;
  final double? height;
  final VoidCallback? onPressed;
  final Widget? suffix;
  final EdgeInsets? padding;
  final bool isSuffix;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white,
          onTap: enabled ? onPressed : null,
          child: GreenBox(
            child: Container(
              height: height ?? GreenValues.kButtonHeight,
              padding: padding,
              child: Row(
                mainAxisAlignment: isSuffix
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  if (isSuffix)
                    Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(30)),
                      child: suffix,
                    ),
                  GText(
                    text,
                    style: TextStyle(color: textColor),
                  ),
                  if (isSuffix)
                    const SizedBox(
                      width: 50,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
