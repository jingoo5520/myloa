import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? leadingIcon;
  final String? actionIcon;
  final Function()? onTap;

  const CustomAppBar({
    required this.title,
    this.leadingIcon,
    this.actionIcon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          leadingIcon != null
              ? GestureDetector(
                  onTap: onTap ??
                      () {
                        Navigator.of(context).pop();
                      },
                  child: Image.asset(leadingIcon!, width: 40.w, height: 40.w))
              : const SizedBox(),
          SizedBox(width: 24.w),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 22.sp),
          )
        ],
      ),
    );
  }
}
