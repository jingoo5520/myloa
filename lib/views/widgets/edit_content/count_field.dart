// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_template/providers/edit_content/edit_content_provider.dart';
// import 'package:flutter_template/resources/constants/theme.dart';
// import 'package:provider/provider.dart';

// class CountField extends StatelessWidget {
//   const CountField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '금일 남은 횟수',
//           style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w600,
//               color: Color(0xffEDEDED)),
//         ),
//         Container(
//           height: 40.h,
//           // decoration: BoxDecoration(
//           //     border: Border(bottom: BorderSide(color: Color(0xff313131)))),
//           child: TextFormField(
//             controller:
//                 context.read<EditContentProvider>().countTextEditingController,
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.right,
//             style: TextStyle(
//               fontSize: 20.sp,
//               color: Colors.white,
//               fontWeight: FontWeight.w500,
//             ),
//             onTap: () {
//               context.read<EditContentProvider>().moveCursor(context
//                   .read<EditContentProvider>()
//                   .countTextEditingController);
//             },
//             cursorColor: Colors.white,
//             decoration: InputDecoration(
//               suffixText: '/ 3',
//               suffixStyle: TextStyle(
//                 fontSize: 20.sp,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//               enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xff313131))),
//               focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
