import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/resources/routes.dart';

class CommonCard extends StatelessWidget {
  const CommonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.commonContents);
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        height: 60.h,
        child: Center(
          child: Text('공동 컨텐츠'),
        ),
      ),
    );
  }
}
