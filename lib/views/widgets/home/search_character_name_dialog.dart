// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_template/model/character/character_model.dart';
// import 'package:flutter_template/providers/home/home_provider.dart';
// import 'package:flutter_template/views/widgets/home/searched_character_info_card.dart';
// import 'package:provider/provider.dart';
// import 'package:tuple/tuple.dart';

// class SearchCharacterNameDialog extends StatelessWidget {
//   const SearchCharacterNameDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 200.w,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                   child: TextField(
//                 controller:
//                     context.read<HomeProvider>().dialogTextEditingController,
//               )),
//               ElevatedButton(
//                   onPressed: () {
//                     context.read<HomeProvider>().getCharacters(
//                         context,
//                         context
//                             .read<HomeProvider>()
//                             .dialogTextEditingController
//                             .text);
//                   },
//                   child: Text('검색'))
//             ],
//           ),
//           Selector<HomeProvider, bool>(
//             selector: (p0, p1) => p1.isLoading,
//             builder: (context, value, child) => value == true
//                 ? CircularProgressIndicator()
//                 : SingleChildScrollView(
//                     child: Selector<HomeProvider,
//                         Tuple2<List<CharacterModel>, List<bool>>>(
//                       selector: (p0, p1) =>
//                           Tuple2(p1.characterInfoes, p1.checkedState),
//                       builder: (context, value, child) => Column(
//                         children: List.generate(
//                             value.item1.length,
//                             (index) => SearchedCharacterInfoCard(
//                                   characterModel: value.item1[index],
//                                   index: index,
//                                   isExisted: value.item2[index],
//                                 )),
//                       ),
//                     ),
//                   ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               context.read<HomeProvider>().addCharacters(context);
//             },
//             child: Center(child: Text('선택완료')),
//           ),
//         ],
//       ),
//     );
//   }
// }
