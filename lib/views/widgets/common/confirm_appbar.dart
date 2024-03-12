import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/providers/home/home_provider.dart';
import 'package:provider/provider.dart';

class ConfirmAppBar extends StatelessWidget {
  final cancleOntap;
  final confirmOntap;

  const ConfirmAppBar(
      {required this.cancleOntap, required this.confirmOntap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              cancleOntap();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Text(
                '취소',
                style: TextStyle(
                  color: const Color(0xffF15A5A),
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              confirmOntap();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Text(
                '완료',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
