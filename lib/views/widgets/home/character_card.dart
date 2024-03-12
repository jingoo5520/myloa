import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/character/character_card_model.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/home/home_provider.dart';
import 'package:flutter_template/resources/constants/class_names.dart';
import 'package:flutter_template/resources/routes.dart';
import 'package:flutter_template/views/widgets/home/character_info_box.dart';
import 'package:flutter_template/views/widgets/home/day_contents_card.dart';
import 'package:provider/provider.dart';

class CharacterCard extends StatefulWidget {
  CharacterCardModel characterCardModel;
  final int mode;
  final int index;

  CharacterCard(
      {required this.characterCardModel,
      required this.mode,
      required this.index,
      super.key});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: GestureDetector(
        onTap: () async {
          if (context.read<HomeProvider>().mode == 0) {
            await Navigator.of(context).pushNamed(AppRoutes.character,
                arguments: {
                  'characterModel': widget.characterCardModel
                }).then((value) {
              List<ContentModel> resultList = value as List<ContentModel>;

              if (const DeepCollectionEquality().equals(
                      widget.characterCardModel.dayContentList, resultList) ==
                  false) {
                setState(() {
                  widget.characterCardModel = widget.characterCardModel
                      .copyWith(basicContents: resultList.sublist(0, 3));
                });

                context.read<HomeProvider>().setCharacterContents(
                      context,
                      characterName: widget
                          .characterCardModel.characterModel.characterName,
                      dayContents: resultList,
                    );
              }
            });
          }
        },
        child: Container(
          padding:
              EdgeInsets.only(top: 10.h, bottom: 10.h, left: 15.w, right: 11.w),
          margin: EdgeInsets.only(bottom: 24.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              image: DecorationImage(
                  image: className.containsKey(widget
                          .characterCardModel.characterModel.characterClassName)
                      ? AssetImage(
                          'assets/character_card/${className[widget.characterCardModel.characterModel.characterClassName]}.png')
                      : const AssetImage('assets/character_card/none.png'),
                  fit: BoxFit.cover)),
          height: 90.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CharacterInfoBox(
                        characterModel:
                            widget.characterCardModel.characterModel),
                    BasicContentsCard(
                      characterName: widget
                          .characterCardModel.characterModel.characterName,
                      basicContents: widget.characterCardModel.basicContents,
                    ),
                  ]),
              Builder(builder: (context) {
                switch (widget.mode) {
                  case 1:
                    return ReorderableDragStartListener(
                      index: widget.index,
                      child: Image.asset(
                        'assets/icons/drag_button.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                    );
                  case 2:
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = false;
                        });
                        context
                            .read<HomeProvider>()
                            .temporaryDeleteCharacter(widget.index);
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/icons/remove_button.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    );
                  default:
                    return const SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
