import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/resources/constants/theme.dart';

class TabBarItem extends StatelessWidget {
  final int index;
  final String tabName;
  final TabController tabController;

  const TabBarItem(
      {required this.index,
      required this.tabName,
      required this.tabController,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          tabName,
          style: TextStyle(
              fontSize: 18.sp,
              color: tabController.index == index ? Colors.white : hintColor),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }
}
