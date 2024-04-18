import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestGaugeBox extends StatelessWidget {
  final double gauge;

  const RestGaugeBox({required this.gauge, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ...List.generate(gauge.toInt(), (index) {
          return Container(
            width: 28.w,
            height: 8.h,
            decoration: BoxDecoration(color: Color(0xff4AB661)),
          );
        }),
        if (gauge % 1 != 0)
          Container(
            width: 30.w,
            height: 8.h,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xff4AB661)),
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(color: Color(0xFF565656))),
                ),
              ],
            ),
          ),
        ...List.generate(
            gauge % 1 != 0 ? 5 - gauge.toInt() - 1 : 5 - gauge.toInt(),
            (index) {
          return Container(
            width: 28.w,
            height: 8.h,
            decoration: BoxDecoration(color: Color(0xFF565656)),
          );
        }),
      ]),
    );
  }
}
