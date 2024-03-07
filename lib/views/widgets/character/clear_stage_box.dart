import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClearStageBox extends StatelessWidget {
  final clearedStage;
  final maxStage;

  const ClearStageBox({
    required this.clearedStage,
    required this.maxStage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...List.generate(
          maxStage,
          (index) => Row(
                children: [
                  Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: clearedStage > index ? Colors.green[300] : null,
                      )),
                  Container(
                    width: 5.w,
                    height: 5.w,
                  )
                ],
              )),
    ]);
  }
}
