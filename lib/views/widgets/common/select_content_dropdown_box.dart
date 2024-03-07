import 'package:flutter/material.dart';
import 'package:flutter_template/model/content/week_content_model.dart';
import 'package:flutter_template/resources/constants/constants.dart';

class SelectContentDropDownBox extends StatelessWidget {
  final selectedContent;
  final onChanged;
  final contents;

  const SelectContentDropDownBox(
      {required this.selectedContent,
      required this.onChanged,
      required this.contents,
      super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedContent,
        items: contents
            .map<DropdownMenuItem<Object>>((e) => DropdownMenuItem<Object>(
                  value: e,
                  child: Text(e.contentName),
                ))
            .toList(),
        onChanged: (value) {
          onChanged(value);
        });
  }
}
