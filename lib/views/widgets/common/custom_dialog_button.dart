import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialogButton extends StatelessWidget {
  final String text;
  final Color textColor;

  final Color backgroundColor;
  final Color borderColor;
  final Function ontap;

  const CustomDialogButton(
      {required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.borderColor,
      required this.ontap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10.w),
            color: backgroundColor),
        height: 48.h,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
