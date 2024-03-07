import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/providers/login/login_provider.dart';
import 'package:flutter_template/providers/sign_up/sign_up_provider.dart';
import 'package:provider/provider.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          context.read<SignUpProvider>().signUp(context);
        },
        child: Container(
            height: 50.h,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30.w),
                border: Border.all(color: Colors.white)),
            child: Center(
              child: Text(
                '가입하기',
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}
