import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/views/widgets/common/select_content_dropdown_box.dart';
import 'package:provider/provider.dart';

class EditDayContentDialog extends StatefulWidget {
  final String characterName;
  final int mode; //추가 모드: 0, 수정 모드: 1
  final ContentModel? dayContentModel;

  const EditDayContentDialog(
      {required this.characterName,
      required this.mode,
      this.dayContentModel,
      super.key});

  @override
  State<EditDayContentDialog> createState() => _EditDayContentDialogState();
}

class _EditDayContentDialogState extends State<EditDayContentDialog> {
  late ContentModel selectedContent;

  @override
  void initState() {
    selectedContent = widget.dayContentModel ?? dayContents[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.mode == 0
              ? SelectContentDropDownBox(
                  selectedContent: selectedContent,
                  onChanged: selectContent,
                  contents: dayContents,
                )
              : Text(selectedContent.contentName),
          TextField(
              controller: context
                  .read<CharacterProvider>()
                  .currentCountTextEditingController,
              decoration: InputDecoration(hintText: '금일 남은 횟수')),
          selectedContent.maxRestGauge != 0
              ? TextField(
                  controller: context
                      .read<CharacterProvider>()
                      .restGaugeTextEditingController,
                  decoration: InputDecoration(hintText: '휴식게이지'))
              : const SizedBox(),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop({
                  'result': true,
                  'mode': widget.mode,
                  'content': selectedContent,
                });
              },
              child: Text(widget.mode == 0 ? '추가' : '수정'))
        ],
      ),
    );
  }

  void selectContent(ContentModel dayContent) {
    setState(() {
      selectedContent = dayContent;
    });
  }
}
