import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/providers/home/home_provider.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:flutter_template/views/widgets/common/custom_dialog_button.dart';
import 'package:flutter_template/views/widgets/common/custom_dialog_textfield.dart';
import 'package:provider/provider.dart';

class AddCharacterDialog extends StatefulWidget {
  const AddCharacterDialog({super.key});

  @override
  State<AddCharacterDialog> createState() => _AddCharacterDialogState();
}

class _AddCharacterDialogState extends State<AddCharacterDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validation = false;
  String? errorMessage;

  setValidation(bool valid) {
    setState(() {
      validation = valid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          color: dialogBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '캐릭터 추가하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDialogTextField(
                    onChanged: (value) {
                      setState(() {
                        validation = value.isNotEmpty;
                        errorMessage = null;
                      });
                    },
                    controller: context
                        .read<HomeProvider>()
                        .searchCharacterNameTextEditingController,
                    textStyle: TextStyle(
                        color: const Color(0xffFCFBFC),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        decorationThickness: 0),
                    hintText: '닉네임을 입력해주세요.',
                    hintTextStyle: TextStyle(
                        color: const Color(0xff6C6C6C), fontSize: 16.sp),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    cursorColor: const Color(0xffFCFBFC),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 6.w, horizontal: 12.w),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(
                          color: const Color(0xffF15A5A),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(height: 14.h),
                  CustomDialogButton(
                    text: '추가하기',
                    textColor: validation ? const Color(0xffFCFBFC) : hintColor,
                    backgroundColor: Colors.white.withOpacity(0.01),
                    borderColor:
                        validation ? const Color(0xffFCFBFC) : hintColor,
                    ontap: () async {
                      String? message;
                      validation
                          ? {
                              message = await context
                                  .read<HomeProvider>()
                                  .addCharacter(
                                      context,
                                      context
                                          .read<HomeProvider>()
                                          .searchCharacterNameTextEditingController
                                          .text),
                              if (message != null)
                                {
                                  if (_formKey.currentState!.validate())
                                    setState(() {
                                      validation = false;
                                      errorMessage = message!;
                                    })
                                }
                            }
                          : null;
                    },
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
