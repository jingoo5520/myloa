import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/common_day_content_model.dart';
import 'package:flutter_template/providers/common_contents/common_contents_provider.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/views/widgets/common/select_content_dropdown_box.dart';
import 'package:provider/provider.dart';

class EditCommonDayContentDialog extends StatefulWidget {
  final int mode; //추가 모드: 0, 수정 모드: 1
  final CommonDayContentModel? commonDayContentModel;

  const EditCommonDayContentDialog({
    required this.mode,
    this.commonDayContentModel,
    super.key,
  });

  @override
  State<EditCommonDayContentDialog> createState() =>
      _EditCommonDayContentDialogState();
}

class _EditCommonDayContentDialogState
    extends State<EditCommonDayContentDialog> {
  late CommonDayContentModel selectedContent;

  @override
  void initState() {
    selectedContent = widget.commonDayContentModel ?? commonDayContents[0];
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
                  contents: commonDayContents,
                )
              : Text(selectedContent.contentName),
          TextField(
              controller: context
                  .read<CommonContentsProvider>()
                  .currentCountTextEditingController,
              decoration: InputDecoration(hintText: '금일 남은 횟수')),
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

  void selectContent(CommonDayContentModel commonDayContentModel) {
    setState(() {
      selectedContent = commonDayContentModel;
    });
  }
}
