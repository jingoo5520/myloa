import 'package:flutter/material.dart';
import 'package:flutter_template/model/content/common_day_content_model.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/model/content/week_content_model.dart';

List<CommonDayContentModel> commonDayContents = [
  CommonDayContentModel(
    icon: 'assets/platinum_field.png',
    contentName: '생활',
    maxCount: 1,
    currentCount: 0,
    priority: 0,
  ),
  CommonDayContentModel(
    icon: 'assets/island.png',
    contentName: '모험섬',
    maxCount: 1,
    currentCount: 0,
    priority: 1,
  ),
  CommonDayContentModel(
    icon: 'assets/chaos_gate.png',
    contentName: '카오스게이트',
    maxCount: 1,
    currentCount: 0,
    priority: 2,
  ),
  CommonDayContentModel(
    icon: 'assets/field_boss.png',
    contentName: '필드보스',
    maxCount: 1,
    currentCount: 0,
    priority: 3,
  ),
  CommonDayContentModel(
    icon: 'assets/likeability.png',
    contentName: '호감도',
    maxCount: 1,
    currentCount: 0,
    priority: 4,
  ),
  //생활
  //모험섬
  //카오스게이트
  //필드 보스
  //점령전
  //호감도작
];

List<String> commonWeekContents = [
  '도가토',
  '도비스',
];

//일일 컨텐츠
List<ContentModel> dayContents = [
  ContentModel(
    icon: 'ephona',
    contentName: '에포나 의뢰',
    maxCount: 3,
    currentCount: 3,
    maxRestGauge: 100,
    currentRestGauge: 100,
    priority: 0,
  ),
  ContentModel(
    icon: 'chaos_dungeon',
    contentName: '카오스 던전',
    maxCount: 2,
    currentCount: 2,
    maxRestGauge: 100,
    currentRestGauge: 100,
    priority: 1,
  ),
  ContentModel(
    icon: 'guardian_raid',
    contentName: '가디언 토벌',
    maxCount: 1,
    currentCount: 1,
    maxRestGauge: 100,
    currentRestGauge: 100,
    priority: 2,
  ),
  ContentModel(
    icon: 'guild',
    contentName: '길드 출석',
    maxCount: 1,
    currentCount: 1,
    maxRestGauge: 0,
    currentRestGauge: 0,
    priority: 3,
  ),
];

//주간 컨텐츠
List<WeekContentModel> weekContents = [
  WeekContentModel(
    iconData: Icons.person,
    contentName: '주간 에포나',
    maxStage: 3,
    clearedStage: 0,
    priority: 0,
  ),
  WeekContentModel(
    iconData: Icons.people,
    contentName: '발탄',
    maxStage: 2,
    clearedStage: 0,
    priority: 1,
  ),
  WeekContentModel(
    iconData: Icons.people,
    contentName: '비아키스',
    maxStage: 2,
    clearedStage: 0,
    priority: 2,
  ),
  WeekContentModel(
    iconData: Icons.person,
    contentName: '쿠크세이튼',
    maxStage: 3,
    clearedStage: 0,
    priority: 3,
  ),
  WeekContentModel(
    iconData: Icons.people,
    contentName: '아브렐슈드',
    maxStage: 4,
    clearedStage: 0,
    priority: 4,
  ),
  WeekContentModel(
    iconData: Icons.person,
    contentName: '카양겔',
    maxStage: 3,
    clearedStage: 0,
    priority: 5,
  ),
  WeekContentModel(
    iconData: Icons.person,
    contentName: '상아탑',
    maxStage: 4,
    clearedStage: 0,
    priority: 6,
  ),
];

List<WeekContentModel> weekCommonContents = [
  //이벤트 상점 교환
  //시련의 빛 교환
  //군단장 레이드 교환
  //도가토
  //도비스
  //로웬 주간퀘
  //균열의 조각 교환
];
