import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/character/character_model.dart';

class CharacterInfoBox extends StatelessWidget {
  final CharacterModel characterModel;

  const CharacterInfoBox({required this.characterModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        characterModel.characterName,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
      SizedBox(width: 6.w),
      Text(
        characterModel.itemMaxLevel,
        style: TextStyle(fontSize: 11.sp, color: Color(0xffc1c1c1)),
      ),
    ]);
  }
}
