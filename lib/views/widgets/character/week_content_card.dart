import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/week_content_model.dart';
import 'package:flutter_template/views/widgets/character/clear_stage_box.dart';
import 'package:flutter_template/views/widgets/character/content_complete_button.dart';
import 'package:flutter_template/views/widgets/character/content_modify_button.dart';

class WeekContentCard extends StatelessWidget {
  final WeekContentModel weekContentModel;
  final String characterName;

  const WeekContentCard(
      {required this.weekContentModel, required this.characterName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: weekContentModel.clearedStage == weekContentModel.maxStage
          ? Colors.grey[300]
          : null,
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(weekContentModel.iconData),
          Text(weekContentModel.contentName),
          ClearStageBox(
            clearedStage: weekContentModel.clearedStage,
            maxStage: weekContentModel.maxStage,
          ),
          Row(
            children: [
              // ContentCompleteButton(
              //   contentType: 1,
              //   characterName: characterName,
              //   weekContentModel: weekContentModel,
              // ),
              // ContentModifyButton(
              //   contentType: 1,
              //   characterName: characterName,
              //   weekContentModel: weekContentModel,
              // )
            ],
          ),
        ],
      ),
    );
  }
}
