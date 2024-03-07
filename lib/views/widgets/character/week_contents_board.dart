import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/week_content_model.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/views/widgets/character/week_content_card.dart';
import 'package:provider/provider.dart';

class WeekContentsBoard extends StatelessWidget {
  final String characterName;

  const WeekContentsBoard({required this.characterName, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: context
            .read<CharacterProvider>()
            .getCharacterWeekContents(context, characterName),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('에러 발생'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          }

          if (!snapshot.hasData) {
            return Center(child: Text('데이터 없음'));
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(snapshot.data!.docs.length, (index) {
                  final data = snapshot.data!.docs;

                  return WeekContentCard(
                      characterName: characterName,
                      weekContentModel: WeekContentModel(
                          iconData: Icons.abc,
                          contentName: data[index]['contentName'],
                          maxStage: data[index]['maxStage'],
                          clearedStage: data[index]['clearedStage'],
                          priority: data[index]['priority']));
                }),
              ),
            ),
          );
        });
  }
}
