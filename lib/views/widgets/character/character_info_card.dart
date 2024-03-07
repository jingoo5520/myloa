import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/character/character_model.dart';
import 'package:flutter_template/resources/constants/class_names.dart';

class CharacterInfoCard extends StatelessWidget {
  final CharacterModel characterModel;
  const CharacterInfoCard({required this.characterModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: className.containsKey(characterModel.characterClassName)
                  ? AssetImage(
                      'assets/character_info_card/${className[characterModel.characterClassName]}.png')
                  : const AssetImage('assets/character_info_card/none.png'),
              fit: BoxFit.cover)),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      height: 350.h,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 250.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  characterModel.characterName,
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4.h),
                Text(
                  characterModel.itemMaxLevel,
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xff898989)),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/icons/restart.png',
                  width: 20.w,
                  height: 20.w,
                ),
                SizedBox(height: 4.h)
              ],
            )
          ],
        ),
      ]),
    );
  }
}
