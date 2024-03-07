import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditButton extends StatelessWidget {
  final double margin;
  final Function onTap;

  const EditButton({required this.margin, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Text(
            '편집하기',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14.sp,
                color: const Color(0xffAEAEAE)),
          ),
        ),
      ),
    );
  }
}
