import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDialog extends StatelessWidget {
  final text;
  final confirmText;
  final cancelText;

  const ConfirmDialog(
      {required this.text,
      required this.confirmText,
      required this.cancelText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          height: 80.h,
          child: Center(
            child: Text(text),
          )),
      Container(
        decoration: BoxDecoration(border: Border(top: BorderSide())),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  decoration:
                      BoxDecoration(border: Border(right: BorderSide())),
                  height: 40.h,
                  child: Center(child: Text(cancelText))),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: Container(
                  color: Colors.grey,
                  height: 40.h,
                  child: Center(child: Text(confirmText))),
            )),
          ],
        ),
      )
    ]);
  }
}
