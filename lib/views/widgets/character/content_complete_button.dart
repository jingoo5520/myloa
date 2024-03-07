import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/common_day_content_model.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/model/content/week_content_model.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/providers/common_contents/common_contents_provider.dart';
import 'package:provider/provider.dart';

class ContentCompleteButton extends StatelessWidget {
  final int contentType;
  final String? characterName;
  final Function onTap;
  final ContentModel? dayContentModel;
  final WeekContentModel? weekContentModel;
  final CommonDayContentModel? commonDayContentModel;

  const ContentCompleteButton(
      {required this.contentType,
      this.characterName,
      required this.onTap,
      this.dayContentModel,
      this.weekContentModel,
      this.commonDayContentModel,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          switch (contentType) {
            //캐릭터 일일 컨텐츠
            case 0:
              onTap();
            // context.read<CharacterProvider>().completeDayContent(
            //     context: context,
            //     dayContentModel: dayContentModel!,
            //     characterName: characterName);
            //캐릭터 주간 컨텐츠
            case 1:
            // context.read<CharacterProvider>().completeWeekContent(
            //     context: context,
            //     weekContentModel: weekContentModel!,
            //     characterName: characterName);
            //공통 일일 컨텐츠
            case 2:
              context.read<CommonContentsProvider>().completeCommonDayContent(
                    context,
                    commonDayContentModel: commonDayContentModel!,
                  );
          }
        },
        child: SizedBox(
          width: 70.w,
          height: 50.h,
          child: Center(
            child: Text(
              '완료',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }
}
