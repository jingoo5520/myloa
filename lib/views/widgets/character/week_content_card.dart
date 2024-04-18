import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/resources/routes.dart';
import 'package:flutter_template/views/widgets/character/content_complete_button.dart';
import 'package:provider/provider.dart';

class WeekContentCard extends StatefulWidget {
  final ContentModel weekContentModel;
  final String characterName;
  final int mode;
  final int index;
  final bool isVisible;

  const WeekContentCard(
      {required this.weekContentModel,
      required this.characterName,
      required this.mode,
      required this.index,
      required this.isVisible,
      super.key});

  @override
  State<WeekContentCard> createState() => _WeekContentCardState();
}

class _WeekContentCardState extends State<WeekContentCard> {
  late ContentModel weekContentModel;

  @override
  void initState() {
    weekContentModel = widget.weekContentModel;

    super.initState();
  }

  //0: 1회 완료, 1: 수정
  void setContent({required int mode, ContentModel? contentModel}) async {
    int count;
    int? stage;

    setState(() {
      if (mode == 0) {
        print('일반모드 확인');
        if (weekContentModel.maxCount != 0) {
          print('맥스카운트 확인');
          if (weekContentModel.currentCount == 0) return;

          print('카운트 확인');
          count = weekContentModel.currentCount! - 1;
        } else {
          if (weekContentModel.clearedStage == weekContentModel.maxStage) {
            return;
          }
          count = weekContentModel.currentCount!;
          stage = weekContentModel.clearedStage! + 1;
        }
      } else {
        count = contentModel!.currentCount!;
        stage = contentModel.clearedStage!;
      }

      weekContentModel = weekContentModel.copyWith(
        currentCount: count,
        clearedStage: stage,
      );

      context
          .read<CharacterProvider>()
          .updateContents(contentModel: weekContentModel, type: 1);
    });

    await context.read<CharacterProvider>().updateContentsDB(
          context,
          type: 1,
          contentModel: weekContentModel,
          characterName: widget.characterName,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: Colors.black.withOpacity(0.3),
              ),
              child: Center(
                child: Image.asset(
                  'assets/${widget.weekContentModel.icon}.png',
                  width: 48.w,
                  height: 48.w,
                ),
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.weekContentModel.contentName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.of(context)
                                  .pushNamed(AppRoutes.editContent, arguments: {
                                'type': 1,
                                'mode': 1,
                                'contentModel': widget.weekContentModel
                              }).then((value) {
                                if (value != null) {
                                  ContentModel contentModel =
                                      value as ContentModel;

                                  //수정 필요
                                  setContent(
                                      mode: 1, contentModel: contentModel);
                                }
                              });
                            },
                            child: Image.asset(
                              'assets/icons/edit_pencil.png',
                              width: 16.w,
                              height: 16.w,
                            ),
                          ),
                        ],
                      ),
                      widget.weekContentModel.maxStage == 0
                          ? Container(
                              // width: 60.w,
                              // height: 24.h,

                              alignment: Alignment.center,
                              child: Text(
                                  '${widget.weekContentModel.currentCount}/${widget.weekContentModel.maxCount}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xffC1C1C1),
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          : Container(
                              // width: 60.w,
                              // height: 24.h,
                              // decoration: BoxDecoration(
                              //   color: Colors.white.withOpacity(0.1),
                              //   border: Border.all(
                              //     color: Colors.black.withOpacity(0.3),
                              //   ),
                              //   //borderRadius: BorderRadius.circular(40.w)
                              // ),
                              alignment: Alignment.center,
                              child: Text(
                                  '${widget.weekContentModel.clearedStage}/${widget.weekContentModel.maxStage}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Builder(builder: (context) {
            switch (widget.mode) {
              case 0:
                return ContentCompleteButton(
                  contentType: 1,
                  characterName: widget.characterName,
                  dayContentModel: widget.weekContentModel,
                  onTap: () {
                    setContent(mode: 0);
                  },
                );
              case 1:
                return GestureDetector(
                  onTap: () {
                    widget.weekContentModel.priority > 0
                        ? context
                            .read<CharacterProvider>()
                            .temporaryDeleteContent(widget.index)
                        : null;
                  },
                  child: Container(
                    width: 70.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    child: widget.weekContentModel.priority > 0
                        ? Image.asset(
                            'assets/icons/remove_button.png',
                            width: 32.w,
                            height: 32.w,
                          )
                        : const SizedBox(),
                  ),
                );
              default:
                return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}
