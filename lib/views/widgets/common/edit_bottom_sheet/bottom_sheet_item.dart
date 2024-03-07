import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetItem extends StatelessWidget {
  final String title;
  final Color color;
  final Function ontap;

  const BottomSheetItem(
      {required this.title,
      required this.color,
      required this.ontap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
          color: Colors.transparent,
          height: 72.h,
          child: Center(
            child: Text(title, style: TextStyle(fontSize: 16.sp, color: color)),
          )),
    );
  }
}
