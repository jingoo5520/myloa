// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_template/model/content/common_day_content_model.dart';
// import 'package:flutter_template/model/content/day_content_model.dart';
// import 'package:flutter_template/model/content/week_content_model.dart';
// import 'package:flutter_template/providers/character/character_provider.dart';
// import 'package:flutter_template/providers/common_contents/common_contents_provider.dart';
// import 'package:provider/provider.dart';

// class ContentModifyButton extends StatelessWidget {
//   final int contentType;
//   final String? characterName;
//   final DayContentModel? dayContentModel;
//   final WeekContentModel? weekContentModel;
//   final CommonDayContentModel? commonDayContentModel;

//   const ContentModifyButton({
//     required this.contentType,
//     this.characterName,
//     this.dayContentModel,
//     this.weekContentModel,
//     this.commonDayContentModel,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 30.w,
//       height: 30.h,
//       child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//               minimumSize: Size(0, 30), padding: EdgeInsets.zero),
//           onPressed: () {
//             switch (contentType) {
//               case 0:
//                 context.read<CharacterProvider>().showEditDayContentDialog(
//                     context,
//                     characterName: characterName!,
//                     mode: 1,
//                     dayContentModel: dayContentModel);
//               case 1:
//                 context.read<CharacterProvider>().showEditWeekContentDialog(
//                     context,
//                     characterName: characterName!,
//                     mode: 1,
//                     weekContentModel: weekContentModel);

//               case 2:
//                 context
//                     .read<CommonContentsProvider>()
//                     .showEditCommonDayContentDialog(context,
//                         mode: 1, commonDayContentModel: commonDayContentModel);
//             }
//           },
//           child: Text('수정')),
//     );
//   }
// }
