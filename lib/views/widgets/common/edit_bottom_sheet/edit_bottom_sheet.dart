import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:flutter_template/views/widgets/common/custom_button.dart';
import 'package:flutter_template/views/widgets/common/edit_bottom_sheet/bottom_sheet_item.dart';

class EditBottomSheet extends StatelessWidget {
  final List<BottomSheetItem> items;

  const EditBottomSheet({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: dialogBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: List.generate(
              items.length,
              (index) => Column(
                children: [
                  items[index],
                  if (index != items.length - 1)
                    const Divider(color: hintColor),
                ],
              ),
            ),
          ),
          CustomButton(
            text: '취소',
            ontap: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.white,
            backgroundColor: Colors.transparent,
            borderColor: hintColor,
          ),
          SizedBox(height: 40.h)
        ],
      ),
    );
  }
}
