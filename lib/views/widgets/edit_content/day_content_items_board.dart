import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/edit_content/edit_content_provider.dart';
import 'package:flutter_template/views/widgets/common/custom_text_field.dart';
import 'package:provider/provider.dart';

class DayContentItemsBoard extends StatefulWidget {
  final ContentModel? dayContentModel;
  final int mode;

  const DayContentItemsBoard({
    this.dayContentModel,
    required this.mode,
    super.key,
  });

  @override
  State<DayContentItemsBoard> createState() => _DayContentItemsBoardState();
}

class _DayContentItemsBoardState extends State<DayContentItemsBoard> {
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
        child: Column(
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
              maxRange: widget.dayContentModel!.maxCount,
              initialText: widget.mode == 0
                  ? '${widget.dayContentModel!.maxCount}'
                  : '${widget.dayContentModel!.currentCount}',
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
                    int.parse(value) > widget.dayContentModel!.maxCount!) {
                  return '입력값이 정확하지 않습니다.';
                }

                return null;
              },
            ),
            //SizedBox(height: 30.h),
            if (widget.dayContentModel!.maxRestGauge != 0)
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
                maxRange: widget.dayContentModel!.maxRestGauge,
                initialText: widget.mode == 0
                    ? '${widget.dayContentModel!.maxRestGauge}'
                    : '${widget.dayContentModel!.currentRestGauge}',
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
                      int.parse(value) >
                          widget.dayContentModel!.maxRestGauge! ||
                      int.parse(value) % 10 != 0) {
                    return '입력값이 정확하지 않습니다.';
                  }

                  return null;
                },
              )
          ],
        ),
      ),
    );
  }
}
