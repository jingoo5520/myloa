import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/views/widgets/character/day_content_card.dart';
import 'package:flutter_template/views/widgets/common/edit_bottom_sheet/edit_button.dart';
import 'package:provider/provider.dart';

class DayContentsBoard extends StatelessWidget {
  final String characterName;
  List<ContentModel> dayContentList;

  DayContentsBoard({
    required this.characterName,
    required this.dayContentList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 24.h),
          Column(
            children: List.generate(dayContentList.length, (index) {
              return Container(
                  margin: EdgeInsets.only(
                      bottom: index != dayContentList.length - 1 ? 16.h : 0),
                  child: DayContentCard(
                      mode: 0,
                      characterName: characterName,
                      dayContentModel: dayContentList[index]));
            }),
          ),
          EditButton(
              margin: 16.h,
              onTap: () {
                context
                    .read<CharacterProvider>()
                    .showEditDayContentsBottomSheet(context);
              })
        ]),
      ),
    );
  }
}
