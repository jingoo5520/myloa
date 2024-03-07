import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/providers/login/login_provider.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:provider/provider.dart';

class EmailField extends StatelessWidget {
  final TextEditingController textEditingController;

  const EmailField({required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '이메일',
          style: TextStyle(color: Colors.white),
        ),
        TextField(
          style: TextStyle(color: hintColor),
          controller: textEditingController,
          decoration: InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: hintColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            hintText: '이메일을 입력해주세요',
            hintStyle: TextStyle(color: hintColor),
          ),
        ),
      ],
    );
  }
}
