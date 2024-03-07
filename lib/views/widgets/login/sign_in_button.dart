import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/providers/login/login_provider.dart';
import 'package:provider/provider.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          context.read<LoginProvider>().signIn(context);
        },
        child: Container(
            height: 50.h,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30.w),
                border: Border.all(color: Colors.white)),
            child: Center(
              child: Text(
                '로그인',
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}
