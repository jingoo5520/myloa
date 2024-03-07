import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';

class DayContentBox extends StatelessWidget {
  final ContentModel dayContentModel;

  const DayContentBox({
    required this.dayContentModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Image.asset(
          'assets/${dayContentModel.icon}.png',
          width: 22.w,
          height: 22.w,
        )),
        SizedBox(
          height: 6.h,
        ),
        Center(
          child: SizedBox(
              child: Text(
            '${dayContentModel.currentCount}/${dayContentModel.maxCount}',
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          )),
        ),
      ],
    );
  }
}
