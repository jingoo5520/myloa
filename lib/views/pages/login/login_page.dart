import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/providers/login/login_provider.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:flutter_template/views/widgets/common/custom_appbar.dart';
import 'package:flutter_template/views/widgets/home/home_appbar.dart';
import 'package:flutter_template/views/widgets/common/email_field.dart';
import 'package:flutter_template/views/widgets/common/password_field.dart';
import 'package:flutter_template/views/widgets/login/sign_in_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: '로그인',
              leadingIcon: 'assets/icons/arrow_left.png',
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 80.h),
                        EmailField(
                          textEditingController: context
                              .read<LoginProvider>()
                              .emailTextEditingController,
                        ),
                        SizedBox(height: 40.h),
                        PasswordField(
                          textEditingController: context
                              .read<LoginProvider>()
                              .passwordTextEditingController,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SignInButton(),
                        SizedBox(height: 40.h),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
