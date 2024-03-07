import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/resources/routes.dart';
import 'package:flutter_template/views/widgets/common/custom_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/onboarding_image.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: 145.h),
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/logo_image.png',
                width: 100.w,
                height: 120.h,
              ),
            ),
            SizedBox(height: 250.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    text: '로그인',
                    ontap: () {
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    },
                    textColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.white,
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    text: '회원가입',
                    ontap: () {
                      Navigator.of(context).pushNamed(AppRoutes.signUp);
                    },
                    textColor: Colors.white,
                    backgroundColor: Color(0xFF191919).withOpacity(0.7),
                    borderColor: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
