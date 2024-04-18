import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:flutter_template/providers/edit_content/edit_content_provider.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:flutter_template/views/widgets/common/custom_appbar.dart';
import 'package:flutter_template/views/widgets/common/custom_button.dart';
import 'package:flutter_template/views/widgets/edit_content/content_infos_board.dart';
import 'package:provider/provider.dart';

class EditContentPage extends StatefulWidget {
  final int type; //0: 일일 컨텐츠, 1: 주간 컨텐츠, 2:
  final int mode; //0: 추가, 1: 수정
  final ContentModel? contentModel;

  const EditContentPage({
    required this.type,
    required this.mode,
    this.contentModel,
    super.key,
  });

  @override
  State<EditContentPage> createState() => _EditContentPageState();
}

class _EditContentPageState extends State<EditContentPage> {
  late ContentModel selectedContent;

  @override
  void initState() {
    super.initState();
    //수정 모드
    if (widget.mode == 1) {
      selectedContent = widget.contentModel!;
    }
    //추가 모드
    else {
      if (widget.type == 0) {
        selectedContent = dayContents[0];
      } else if (widget.type == 1) {
        selectedContent = weekContents[0];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          CustomAppBar(
            title: widget.mode == 0 ? '추가하기' : '수정하기',
            leadingIcon: 'assets/icons/arrow_left.png',
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 32.h),
                              widget.mode == 1
                                  ? Text(
                                      widget.contentModel!.contentName,
                                      style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xfffcfbfc)),
                                    )
                                  :
                                  //추가 모드 드롭다운 버튼
                                  Column(
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            selectedItemBuilder: (context) =>
                                                selectedContentList(
                                                    widget.type == 0
                                                        ? dayContents
                                                        : weekContents),
                                            value: selectedContent,
                                            items: contentsList(widget.type == 0
                                                ? dayContents
                                                : weekContents),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedContent = value!;
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 0.w)),
                                            iconStyleData: const IconStyleData(
                                                iconSize: 0),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 0),
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                                    //수정 필요
                                                    maxHeight: 400.h,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 18.h,
                                                            horizontal: 10.w),
                                                    width: 190.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.w),
                                                        color: const Color(
                                                            0xff373737))),
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 32.h),
                              ContentInfosBoard(
                                type: widget.type,
                                mode: widget.mode,
                                contentModel: selectedContent,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Selector<EditContentProvider, bool>(
                                  selector: (p0, p1) => p1.validation,
                                  builder: (context, value, child) =>
                                      CustomButton(
                                          text: widget.mode == 0
                                              ? '추가하기'
                                              : '수정하기',
                                          ontap: () async {
                                            if (value) {
                                              await context
                                                  .read<EditContentProvider>()
                                                  .editContent(context,
                                                      type: widget.type,
                                                      mode: widget.mode,
                                                      contentModel:
                                                          selectedContent);

                                              context
                                                  .read<CommonProvider>()
                                                  .offLoad();
                                            }
                                          },
                                          textColor: value == true
                                              ? const Color(0xffFCFBFC)
                                              : const Color(0xff565656),
                                          backgroundColor: backgroundColor,
                                          borderColor: value == true
                                              ? const Color(0xffFCFBFC)
                                              : const Color(0xff565656))),
                              SizedBox(height: 40.h)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<DropdownMenuItem> contentsList(List contents) {
  List<DropdownMenuItem> tempList = [];

  if (contents is List<ContentModel>) {
    for (var content in contents) {
      tempList.add(DropdownMenuItem(
          value: content,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: content != contents.last
                        ? const BorderSide(color: Color(0xff565656))
                        : BorderSide.none)),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: Text(
              content.contentName,
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xfffcfbfc)),
            ),
          )));
    }
  }

  return tempList;
}

List<Widget> selectedContentList(List contents) {
  List<Widget> tempList = [];
  if (contents is List<ContentModel>) {
    for (var content in contents) {
      tempList.add(
        Row(
          children: [
            Text(
              content.contentName,
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xfffcfbfc)),
            ),
            SizedBox(width: 4.w),
            Image.asset(
              'assets/icons/arrow_bottom.png',
              width: 32.w,
              height: 32.w,
            ),
          ],
        ),
      );
    }
  }

  return tempList;
}
