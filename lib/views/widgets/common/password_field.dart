import 'package:flutter/material.dart';
import 'package:flutter_template/providers/login/login_provider.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:provider/provider.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController textEditingController;

  const PasswordField({required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '비밀번호',
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
            hintText: '비밀번호를 입력해주세요',
            hintStyle: TextStyle(color: hintColor),
          ),
        ),
      ],
    );
  }
}
