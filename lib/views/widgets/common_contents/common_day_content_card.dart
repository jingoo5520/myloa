import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/common_day_content_model.dart';
import 'package:flutter_template/views/widgets/character/content_complete_button.dart';
import 'package:flutter_template/views/widgets/character/content_modify_button.dart';

class CommonDayContentCard extends StatelessWidget {
  final CommonDayContentModel commonDayContentModel;

  const CommonDayContentCard({required this.commonDayContentModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: commonDayContentModel.currentCount == 0 ? Colors.grey[300] : null,
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(commonDayContentModel.icon),
          Text(commonDayContentModel.contentName),
          SizedBox(
              width: 20.w,
              child: Text(
                  '${commonDayContentModel.currentCount}/${commonDayContentModel.maxCount}')),
          Row(
            children: [
              // ContentCompleteButton(
              //   contentType: 2,
              //   commonDayContentModel: commonDayContentModel,
              // ),
              // ContentModifyButton(
              //   contentType: 2,
              //   commonDayContentModel: commonDayContentModel,
              // )
            ],
          ),
        ],
      ),
    );
  }
}
