import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;

  final TextStyle textStyle;

  final String labelText;
  final TextStyle labelTextStyle;
  final int? maxRange;

  final String? hintText;
  final TextStyle? hintTextStyle;

  final String? initialText;

  final TextAlign? textAlign;

  final Color unfocusedBorderColor;
  final Color focusedBorderColor;
  final Color cursorColor;

  final TextInputType? keyboardType;

  final String? Function(String?)? validator;

  const CustomTextField({
    required this.controller,
    required this.textStyle,
    required this.labelText,
    required this.labelTextStyle,
    this.maxRange,
    this.hintText,
    this.hintTextStyle,
    this.initialText,
    this.textAlign,
    required this.unfocusedBorderColor,
    required this.focusedBorderColor,
    required this.cursorColor,
    this.keyboardType,
    this.validator,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focus = FocusNode();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialText ?? '';
    _focus.addListener(onFocused);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(onFocused);
    _focus.dispose();
  }

  onFocused() {
    widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length));
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialText != widget.initialText) {
      Future.microtask(() {
        widget.controller.text = widget.initialText ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: widget.labelTextStyle),
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          focusNode: _focus,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textAlign: widget.textAlign ?? TextAlign.start,
          style: widget.textStyle,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            helperText: "",
            suffixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: Text(
              '/ ${widget.maxRange}',
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            suffixStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.unfocusedBorderColor)),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.unfocusedBorderColor)),
            focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.focusedBorderColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.focusedBorderColor)),
          ),
          cursorColor: widget.cursorColor,
        ),
        Text(errorMessage ?? ''),
      ],
    );
  }
}
