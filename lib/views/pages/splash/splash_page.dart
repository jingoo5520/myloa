import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:flutter_template/resources/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.onboarding, (route) => false);
      });
    });

    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
          ],
        ));
  }
}
