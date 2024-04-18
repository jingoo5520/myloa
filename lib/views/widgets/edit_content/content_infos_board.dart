import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/edit_content/edit_content_provider.dart';
import 'package:flutter_template/views/widgets/common/custom_text_field.dart';
import 'package:provider/provider.dart';

class ContentInfosBoard extends StatefulWidget {
  final ContentModel contentModel;
  final int type;
  final int mode;

  const ContentInfosBoard({
    required this.contentModel,
    required this.type,
    required this.mode,
    super.key,
  });

  @override
  State<ContentInfosBoard> createState() => _ContentInfosBoardState();
}

class _ContentInfosBoardState extends State<ContentInfosBoard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        onChanged: () {
          if (_formKey.currentState!.validate()) {
            context.read<EditContentProvider>().setValidation(true);
          } else {
            context.read<EditContentProvider>().setValidation(false);
          }
        },
        child: widget.type == 0
            ? showDayContentsInfos(
                context,
                mode: widget.mode,
                contentModel: widget.contentModel,
              )
            : widget.type == 1
                ? showWeekContentsInfos(
                    context,
                    mode: widget.mode,
                    contentModel: widget.contentModel,
                  )
                : SizedBox(),
      ),
    );
  }
}

//일일 컨텐츠 정보
Widget showDayContentsInfos(
  BuildContext context, {
  required int mode,
  required ContentModel contentModel,
}) {
  return Column(
    children: [
      CustomTextField(
        controller: context
            .read<EditContentProvider>()
            .currentCountTextEditingController,
        textStyle: TextStyle(
          fontSize: 20.sp,
          color: Colors.white,
        ),
        labelText: '금일 가능 횟수',
        labelTextStyle: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xffEDEDED),
            fontWeight: FontWeight.w600),
        maxRange: contentModel.maxCount,
        initialText: mode == 0
            ? '${contentModel.maxCount}'
            : '${contentModel.currentCount}',
        textAlign: TextAlign.right,
        unfocusedBorderColor: const Color(0xff313131),
        focusedBorderColor: const Color(0xffEDEDED),
        cursorColor: const Color(0xffEDEDED),
        keyboardType: TextInputType.number,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return '값을 입력하세요.';
          }
          if (int.parse(value) < 0 ||
              int.parse(value) > contentModel.maxCount!) {
            return '입력값이 정확하지 않습니다.';
          }

          return null;
        },
      ),
      if (contentModel.maxRestGauge != 0)
        CustomTextField(
          controller: context
              .read<EditContentProvider>()
              .currentRestGaugeTextEditingController,
          textStyle: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
          ),
          labelText: '휴식게이지',
          labelTextStyle: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xffEDEDED),
              fontWeight: FontWeight.w600),
          maxRange: contentModel.maxRestGauge,
          initialText: mode == 0
              ? '${contentModel.maxRestGauge}'
              : '${contentModel.currentRestGauge}',
          textAlign: TextAlign.right,
          unfocusedBorderColor: const Color(0xff313131),
          focusedBorderColor: const Color(0xffEDEDED),
          cursorColor: const Color(0xffEDEDED),
          keyboardType: TextInputType.number,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return '값을 입력하세요.';
            }

            if (int.parse(value) < 0 ||
                int.parse(value) > contentModel.maxRestGauge! ||
                int.parse(value) % 10 != 0) {
              return '입력값이 정확하지 않습니다.';
            }
            return null;
          },
        )
    ],
  );
}

//주간 컨텐츠 정보
Widget showWeekContentsInfos(
  BuildContext context, {
  required int mode,
  required ContentModel contentModel,
}) {
  return Column(
    children: [
      if (contentModel.maxCount != 0)
        CustomTextField(
          controller: context
              .read<EditContentProvider>()
              .currentCountTextEditingController,
          textStyle: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
          ),
          labelText: '주간 가능 횟수',
          labelTextStyle: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xffEDEDED),
              fontWeight: FontWeight.w600),
          maxRange: contentModel.maxCount,
          initialText: mode == 0
              ? '${contentModel.maxCount}'
              : '${contentModel.currentCount}',
          textAlign: TextAlign.right,
          unfocusedBorderColor: const Color(0xff313131),
          focusedBorderColor: const Color(0xffEDEDED),
          cursorColor: const Color(0xffEDEDED),
          keyboardType: TextInputType.number,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return '값을 입력하세요.';
            }
            if (int.parse(value) < 0 ||
                int.parse(value) > contentModel.maxCount!) {
              return '입력값이 정확하지 않습니다.';
            }

            return null;
          },
        ),
      if (contentModel.maxStage != 0)
        CustomTextField(
          controller: context
              .read<EditContentProvider>()
              .clearedStageTextEditingController,
          textStyle: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
          ),
          labelText: '클리어 스테이지',
          labelTextStyle: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xffEDEDED),
              fontWeight: FontWeight.w600),
          maxRange: contentModel.maxStage,
          initialText: mode == 0 ? '0' : '${contentModel.clearedStage}',
          textAlign: TextAlign.right,
          unfocusedBorderColor: const Color(0xff313131),
          focusedBorderColor: const Color(0xffEDEDED),
          cursorColor: const Color(0xffEDEDED),
          keyboardType: TextInputType.number,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return '값을 입력하세요.';
            }
            if (int.parse(value) < 0 ||
                int.parse(value) > contentModel.maxStage!) {
              return '입력값이 정확하지 않습니다.';
            }

            return null;
          },
        ),
    ],
  );
}
