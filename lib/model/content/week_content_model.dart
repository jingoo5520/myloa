import 'package:flutter/material.dart';
import 'package:flutter_template/model/content/content_model.dart';

class WeekContentModel {
  final IconData iconData;
  final String contentName;
  final int maxStage;
  final int clearedStage;
  final int priority;

  WeekContentModel({
    required this.iconData,
    required this.contentName,
    required this.maxStage,
    required this.clearedStage,
    required this.priority,
  });

  // @override
  // String toString() {
  //   return 'countentName : $contentName, maxCount : $maxCount, currentCount : $currentCount, maxRestGauge : $maxRestGauge, currentRestGauge : $currentRestGauge';
  // }
}
