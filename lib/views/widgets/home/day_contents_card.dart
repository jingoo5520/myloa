import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/views/widgets/home/day_content_box.dart';

class BasicContentsCard extends StatefulWidget {
  final String characterName;
  final List<ContentModel> basicContents;
  const BasicContentsCard({
    required this.characterName,
    required this.basicContents,
    super.key,
  });

  @override
  State<BasicContentsCard> createState() => _BasicContentsCardState();
}

class _BasicContentsCardState extends State<BasicContentsCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.basicContents.length, (index) {
        final data = widget.basicContents[index];

        return Row(
          children: [
            DayContentBox(
              dayContentModel: ContentModel(
                  icon: data.icon,
                  contentName: data.contentName,
                  maxCount: data.maxCount,
                  currentCount: data.currentCount,
                  maxRestGauge: data.maxRestGauge,
                  currentRestGauge: data.currentRestGauge,
                  priority: data.priority),
            ),
            if (index != widget.basicContents.length - 1) SizedBox(width: 15.w),
          ],
        );
      }),
    );
  }
}
