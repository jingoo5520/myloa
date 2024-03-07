import 'package:flutter/material.dart';

class CommonDayContentModel {
  final String icon;
  final String contentName;
  final int maxCount;
  final int currentCount;
  final int priority;

  CommonDayContentModel({
    required this.icon,
    required this.contentName,
    required this.maxCount,
    required this.currentCount,
    required this.priority,
  });

  @override
  String toString() {
    return 'countentName : $contentName, maxCount : $maxCount, currentCount : $currentCount';
  }
}
