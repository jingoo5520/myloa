import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/week_content_model.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/views/widgets/common/select_content_dropdown_box.dart';
import 'package:provider/provider.dart';

class EditWeekContentDialog extends StatefulWidget {
  final String characterName;
  final int mode;
  final WeekContentModel? weekContentModel;

  const EditWeekContentDialog(
      {required this.characterName,
      required this.mode,
      this.weekContentModel,
      super.key});

  @override
  State<EditWeekContentDialog> createState() => _EditWeekContentDialogState();
}

class _EditWeekContentDialogState extends State<EditWeekContentDialog> {
  late WeekContentModel selectedContent;

  @override
  void initState() {
    selectedContent = widget.weekContentModel ?? weekContents[0];
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
                  contents: weekContents,
                )
              : Text(selectedContent.contentName),
          TextField(
              controller: context
                  .read<CharacterProvider>()
                  .clearedStageTextEditingController,
              decoration: InputDecoration(hintText: '클리어 스테이지')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop({
                      'result': true,
                      'mode': widget.mode,
                      'weekContentModel': selectedContent
                    });
                  },
                  child: Text('추가')),
              ElevatedButton(
                  onPressed: () async {
                    // Navigator.of(context).pop({
                    //   'result': true,
                    //   'mode': widget.mode,
                    //   'weekContentModel': selectedContent
                    // });
                  },
                  child: Text('삭제')),
            ],
          )
        ],
      ),
    );
  }

  void selectContent(WeekContentModel weekContent) {
    setState(() {
      selectedContent = weekContent;
    });
  }
}
