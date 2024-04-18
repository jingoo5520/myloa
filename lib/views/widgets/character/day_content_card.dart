import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/resources/routes.dart';
import 'package:flutter_template/views/widgets/character/content_complete_button.dart';
import 'package:flutter_template/views/widgets/character/rest_gauge_box.dart';
import 'package:provider/provider.dart';

class DayContentCard extends StatefulWidget {
  final ContentModel dayContentModel;
  final String characterName;
  final int mode;
  final int index;
  final bool isVisible;

  const DayContentCard({
    required this.isVisible,
    required this.dayContentModel,
    required this.characterName,
    required this.mode,
    required this.index,
    super.key,
  });

  @override
  State<DayContentCard> createState() => _DayContentCardState();
}

class _DayContentCardState extends State<DayContentCard> {
  late ContentModel dayContentModel;

  @override
  void initState() {
    dayContentModel = widget.dayContentModel;
    super.initState();
  }

  //0: 1회 완료, 1: 수정
  void setContent({required int mode, ContentModel? contentModel}) async {
    int count;
    int? restGauge;

    setState(() {
      if (mode == 0) {
        if (dayContentModel.currentCount == 0) return;

        count = dayContentModel.currentCount! - 1;

        restGauge = dayContentModel.currentRestGauge! >= 20
            ? dayContentModel.currentRestGauge! - 20
            : dayContentModel.currentRestGauge!;
      } else {
        count = contentModel!.currentCount!;
        restGauge = contentModel.currentRestGauge!;
      }

      dayContentModel = dayContentModel.copyWith(
        currentCount: count,
        currentRestGauge: restGauge,
      );

      context
          .read<CharacterProvider>()
          .updateContents(contentModel: dayContentModel, type: 0);
    });

    await context.read<CharacterProvider>().updateContentsDB(
          context,
          type: 0,
          contentModel: dayContentModel,
          characterName: widget.characterName,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: SizedBox(
        height: 70.h,
        child: Row(
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
                    'assets/${widget.dayContentModel.icon}.png',
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
                              widget.dayContentModel.contentName,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: () async {
                                await Navigator.of(context).pushNamed(
                                    AppRoutes.editContent,
                                    arguments: {
                                      'type': 0,
                                      'mode': 1,
                                      'contentModel': dayContentModel
                                    }).then((value) {
                                  if (value != null) {
                                    ContentModel contentModel =
                                        value as ContentModel;

                                    // 수정필요
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
                        Container(
                          // width: 60.w,
                          // height: 24.h,
                          // alignment: Alignment.center,
                          // color: Colors.red,
                          child: Text(
                              '${dayContentModel.currentCount}/${widget.dayContentModel.maxCount}',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xffC1C1C1),
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      ],
                    ),
                    if (widget.dayContentModel.maxRestGauge != 0)
                      RestGaugeBox(
                          gauge: dayContentModel.currentRestGauge! / 20)
                  ],
                ),
              ),
            ),
            Builder(builder: (context) {
              switch (widget.mode) {
                case 0:
                  return ContentCompleteButton(
                    contentType: 0,
                    characterName: widget.characterName,
                    dayContentModel: widget.dayContentModel,
                    onTap: () {
                      setContent(mode: 0);
                    },
                  );
                case 1:
                  return GestureDetector(
                    onTap: () {
                      widget.dayContentModel.priority > 2
                          ? context
                              .read<CharacterProvider>()
                              .temporaryDeleteContent(widget.index)
                          : null;
                    },
                    child: Container(
                      width: 70.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      child: widget.dayContentModel.priority > 2
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
      ),
    );
  }
}
