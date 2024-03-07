import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/resources/constants/theme.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        color: backgroundColor,
        height: 56.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 100.w,
              height: 25.h,
            ),
            Image.asset(
              'assets/dots.png',
              width: 4.w,
              height: 22.h,
            ),
          ],
        ),
      ),
    );
  }
}
