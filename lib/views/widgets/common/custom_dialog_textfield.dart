import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/resources/constants/constants.dart';

class CustomDialogTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle textStyle;

  final String hintText;
  final TextStyle hintTextStyle;

  final String? errorMessage;

  final Color backgroundColor;

  final Color cursorColor;

  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  CustomDialogTextField(
      {required this.controller,
      required this.textStyle,
      required this.hintText,
      required this.hintTextStyle,
      required this.backgroundColor,
      required this.cursorColor,
      this.validator,
      this.onChanged,
      this.errorMessage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(10.w)),
      height: 48.h,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        style: textStyle,
        scrollPadding: EdgeInsets.zero,
        decoration: InputDecoration(
          errorText: errorMessage,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
          hintText: hintText,
          hintStyle: hintTextStyle,
        ),
        cursorColor: cursorColor,
        validator: validator,
      ),
    );
  }
}
