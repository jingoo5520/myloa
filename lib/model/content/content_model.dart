import 'package:flutter/material.dart';

class ContentModel {
  final String icon;
  final String contentName;
  final int? maxCount;
  final int? currentCount;
  final int? maxRestGauge;
  final int? currentRestGauge;
  final int? maxStage;
  final int? clearedStage;
  final int priority;

  ContentModel({
    required this.icon,
    required this.contentName,
    this.maxCount,
    this.currentCount,
    this.maxRestGauge,
    this.currentRestGauge,
    this.clearedStage,
    this.maxStage,
    required this.priority,
  });

  ContentModel copyWith({
    String? icon,
    String? contentName,
    int? maxCount,
    int? currentCount,
    int? maxRestGauge,
    int? currentRestGauge,
    int? priority,
  }) {
    return ContentModel(
      icon: icon ?? this.icon,
      contentName: contentName ?? this.contentName,
      maxCount: maxCount ?? this.maxCount,
      currentCount: currentCount ?? this.currentCount,
      maxRestGauge: maxRestGauge ?? this.maxRestGauge,
      currentRestGauge: currentRestGauge ?? this.currentRestGauge,
      priority: priority ?? this.priority,
    );
  }

  @override
  String toString() {
    return 'countentName : $contentName, maxCount : $maxCount, currentCount : $currentCount, maxRestGauge : $maxRestGauge, currentRestGauge : $currentRestGauge';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentModel &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          contentName == other.contentName &&
          maxCount == other.maxCount &&
          currentCount == other.currentCount &&
          maxRestGauge == other.maxRestGauge &&
          currentRestGauge == other.currentRestGauge &&
          clearedStage == other.clearedStage &&
          maxStage == other.maxStage &&
          priority == other.priority;

  @override
  int get hashCode =>
      icon.hashCode ^
      contentName.hashCode ^
      maxCount.hashCode ^
      currentCount.hashCode ^
      maxRestGauge.hashCode ^
      currentRestGauge.hashCode ^
      clearedStage.hashCode ^
      maxStage.hashCode ^
      priority.hashCode;
}
