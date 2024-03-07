// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_template/model/character/character_model.dart';
// import 'package:flutter_template/providers/home/home_provider.dart';
// import 'package:provider/provider.dart';

// class SearchedCharacterInfoCard extends StatefulWidget {
//   final CharacterModel characterModel;
//   final int index;
//   final bool isExisted;

//   const SearchedCharacterInfoCard({
//     required this.characterModel,
//     required this.index,
//     required this.isExisted,
//     super.key,
//   });

//   @override
//   State<SearchedCharacterInfoCard> createState() =>
//       _SearchedCharacterInfoCardState();
// }

// class _SearchedCharacterInfoCardState extends State<SearchedCharacterInfoCard> {
//   bool checkState = false;

//   @override
//   void initState() {
//     // TODO: implement initState

//     checkState = widget.isExisted;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: widget.isExisted == true ? Colors.grey : null,
//       height: 30.h,
//       child: Row(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 Text(widget.characterModel.characterName),
//                 Text(' '),
//                 Text(widget.characterModel.characterClassName),
//                 Text(' '),
//                 Text(widget.characterModel.itemMaxLevel),
//               ],
//             ),
//           ),
//           Checkbox(
//               value: checkState,
//               onChanged: (isChecked) {
//                 widget.isExisted == true
//                     ? null
//                     : setState(() {
//                         checkState = !checkState;
//                         context
//                             .read<HomeProvider>()
//                             .checkCharacter(widget.index);
//                       });
//               }),
//         ],
//       ),
//     );
//   }
// }
