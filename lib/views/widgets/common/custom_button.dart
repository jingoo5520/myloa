import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function ontap;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  const CustomButton({
    required this.text,
    required this.ontap,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          ontap();
        },
        child: Container(
            height: 56.h,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(color: borderColor)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 18.sp, color: textColor),
              ),
            )));
  }
}
