import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/views/widgets/character/week_content_card.dart';
import 'package:flutter_template/views/widgets/common/edit_bottom_sheet/edit_button.dart';
import 'package:provider/provider.dart';

class WeekContentsBoard extends StatelessWidget {
  final int mode;
  final String characterName;
  final List<ContentModel> weekContentList;

  const WeekContentsBoard(
      {required this.mode,
      required this.characterName,
      required this.weekContentList,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 24.h),
          ...List.generate(weekContentList.length, (index) {
            return Container(
              margin: EdgeInsets.only(
                  bottom: index != weekContentList.length - 1 ? 16.h : 0),
              child: Selector<CharacterProvider, List<bool>>(
                selector: (p0, p1) => p1.temporaryDeleteState,
                builder: (context, value, child) => WeekContentCard(
                  isVisible: value.isEmpty ? true : !value[index],
                  index: index,
                  mode: mode,
                  characterName: characterName,
                  weekContentModel: weekContentList[index],
                ),
              ),
            );
          }),
          mode == 0
              ? EditButton(
                  margin: 16.h,
                  onTap: () {
                    context
                        .read<CharacterProvider>()
                        .showEditContentsBottomSheet(context, type: 1);
                  })
              : const SizedBox(),
        ]),
      ),
    );
  }
}
