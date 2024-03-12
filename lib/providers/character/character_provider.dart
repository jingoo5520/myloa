import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/character/character_card_model.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/model/content/week_content_model.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:flutter_template/resources/routes.dart';
import 'package:flutter_template/views/widgets/character/edit_week_content_dialog.dart';
import 'package:flutter_template/views/widgets/common/edit_bottom_sheet/bottom_sheet_item.dart';
import 'package:flutter_template/views/widgets/common/edit_bottom_sheet/edit_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CharacterProvider extends ChangeNotifier {
  CharacterCardModel characterCardModel;
  List<ContentModel>? dayContentList;
  List<ContentModel>? weekContentList;
  List<ContentModel>? tempList; //삭제용 dayContent 리스트
  List<bool> temporaryDeleteState = [];

  //일반, 삭제모드
  int mode = 0;

  //일일, 주간 탭
  int tab = 0;

  List<String> tabNames = ['일일', '주간'];

  //디바운스 서로 다른 컨텐츠 확인용
  ContentModel? previousContent;

  //탭바 컨트롤러
  late TabController tabController;

  //휴식 게이지 입력 텍스트필드
  TextEditingController restGaugeTextEditingController =
      TextEditingController();

  //남은 횟수 입력 텍스트필드
  TextEditingController currentCountTextEditingController =
      TextEditingController();

  //클리어 스테이지 입력 텍스트 필드
  TextEditingController clearedStageTextEditingController =
      TextEditingController();

  //함수 재호출 방지용 타이머
  Map<String, Timer?> timers = {};

  CharacterProvider(BuildContext context, {required this.characterCardModel}) {
    debugPrint('character');
    setPage(context);
  }

  setPage(BuildContext context) async {
    await context
        .read<CommonProvider>()
        .selectCharacterDB(characterCardModel.characterModel.characterName);
    getCharacterDayContents(
        context, characterCardModel.characterModel.characterName);
  }

  //일일, 주간 탭 선택
  changeTab(int tab) {
    if (this.tab != tab) {
      this.tab = tab;
      notifyListeners();
    }
  }

  //모드 변경
  changeMode(int mode) {
    this.mode = mode;
    List<bool> temp = List.filled(dayContentList!.length, false);

    temporaryDeleteState = temp;

    notifyListeners();
  }

  //캐릭터 일일 컨텐츠 최초 불러오기
  getCharacterDayContents(BuildContext context, String characterName) async {
    List<ContentModel> tempList = [];

    final characterDB = context.read<CommonProvider>().characterDB;

    final dayContentsDB =
        await characterDB.collection('dayContents').orderBy('priority').get();

    for (var dayContent in dayContentsDB.docs) {
      tempList.add(
        ContentModel(
          icon: dayContent.data()['icon'],
          contentName: dayContent.data()['contentName'],
          maxCount: dayContent.data()['maxCount'],
          currentCount: dayContent.data()['currentCount'],
          maxRestGauge: dayContent.data()['maxRestGauge'],
          currentRestGauge: dayContent.data()['currentRestGauge'],
          priority: dayContent.data()['priority'],
        ),
      );
    }

    await Future.delayed(Duration.zero);
    dayContentList = tempList;
    notifyListeners();
  }

  //컨텐츠 화면 업데이트
  updateContents(ContentModel model) async {
    List<ContentModel> tempList;

    tempList = dayContentList!.map((dayContent) {
      if (dayContent.contentName == model.contentName) {
        // 해당 모델의 이름이 일치하면 copyWith를 사용하여 정보 변경
        return dayContent.copyWith(
          currentCount: model.currentCount,
          currentRestGauge: model.currentRestGauge,
        );
      } else {
        return dayContent;
      }
    }).toList();

    dayContentList = tempList;
    notifyListeners();
  }

  //일일 컨텐츠 DB 업데이트
  updateDayContentsDB(
    BuildContext context, {
    required ContentModel dayContentModel,
    required characterName,
  }) async {
    final characterDB = context.read<CommonProvider>().characterDB;

    final content = (await characterDB
            .collection('dayContents')
            .where('contentName', isEqualTo: dayContentModel.contentName)
            .get())
        .docs
        .first
        .reference;

    if (timers[dayContentModel.contentName] != null) {
      timers[dayContentModel.contentName]!.cancel();
    }

    final timer = Timer(const Duration(milliseconds: 500), () async {
      await content.update({
        'currentCount': dayContentModel.currentCount,
        'currentRestGauge': dayContentModel.currentRestGauge,
      });

      timers.remove(dayContentModel.contentName);
    });

    timers[dayContentModel.contentName] = timer;
  }

  //캐릭터 일일 컨텐츠 편집 다이얼로그
  showEditDayContentsBottomSheet(
    BuildContext context,
  ) async {
    late int mode;
    late int type;
    bool? result = await showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
        //모서리 둥글게
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: EditBottomSheet(
                items: [
                  BottomSheetItem(
                    title: '추가하기',
                    color: const Color(0xffd7d7d7),
                    ontap: () {
                      mode = 0;
                      type = 0;
                      Navigator.of(context).pop(true);
                    },
                  ),
                  BottomSheetItem(
                    title: '삭제하기',
                    color: const Color(0xffff6060),
                    ontap: () {
                      mode = 1;
                      type = 0;
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
            ));

    if (result == true) {
      //삭제 모드
      if (mode == 1) {
        changeMode(1);
      }
      //추가, 수정 모드
      else {
        Navigator.of(context).pushNamed(AppRoutes.editContent, arguments: {
          'mode': mode,
          'type': type,
        }).then((value) async {
          print(value);
          if (value != null) {
            await getCharacterDayContents(
                context, characterCardModel.characterModel.characterName);
          }
        });
      }
    }
  }

  //컨텐츠 임시 삭제
  temporaryDeleteContent(int index) {
    List<bool> temp = List.from(temporaryDeleteState);

    temp[index] = true;
    // temporaryDeleteState[index] = true;
    // tempList!.removeAt(index);
    //print(dayContentList!.length);
    //print(tempList!.length);

    temporaryDeleteState = temp;

    notifyListeners();
  }

  //캐릭터 주간 컨텐츠 불러오기
  Stream<QuerySnapshot> getCharacterWeekContents(
      BuildContext context, String characterName) async* {
    final characterDB = await context.read<CommonProvider>().characterDB;

    Stream<QuerySnapshot> stream =
        characterDB.collection('weekContents').orderBy('priority').snapshots();

    await for (QuerySnapshot snapshot in stream) {
      yield snapshot;
    }
  }

  //주간 컨텐츠 추가, 수정 다이얼로그
  showEditWeekContentDialog(BuildContext context,
      {required String characterName,
      required int mode,
      WeekContentModel? weekContentModel}) {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: this,
        child: Dialog(
            child: EditWeekContentDialog(
          characterName: characterName,
          mode: mode,
          weekContentModel: weekContentModel,
        )),
      ),
    ).then((value) async {
      if (value == null) {
        return;
      }

      if (value['result'] == true) {
        await editWeekContent(
          context: context,
          characterName: characterName,
          mode: value['mode'],
          weekContentModel: value['weekContentModel'],
        );
      }
      clearedStageTextEditingController.clear();
    });
  }

  //주간 컨텐츠 추가
  editWeekContent(
      {required BuildContext context,
      required String characterName,
      required int mode,
      required WeekContentModel weekContentModel}) async {
    var data;

    final userDB = context.read<CommonProvider>().userDB;

    final userCharacterDB = (await userDB
            .collection('characters')
            .where('characterName', isEqualTo: characterName)
            .get())
        .docs
        .first
        .reference;

    final weekContent = userCharacterDB
        .collection('weekContents')
        .where('contentName', isEqualTo: weekContentModel.contentName);

    //주간 컨텐츠 생성
    if (mode == 0) {
      data = {
        'contentName': weekContentModel.contentName,
        'maxStage': weekContentModel.maxStage,
        'clearedStage': int.parse(clearedStageTextEditingController.text),
        'priority': weekContentModel.priority,
      };

      //이미 존재하는 컨텐츠라면
      if ((await weekContent.get()).docs.isEmpty == true) {
        await userCharacterDB.collection('weekContents').add(data);
      } else {
        debugPrint('중복된 컨텐츠');
      }
    } else {
      //주간 컨텐츠 수정
      final clearedStage = clearedStageTextEditingController.text.isEmpty
          ? 0
          : int.parse(clearedStageTextEditingController.text);

      (await weekContent.get()).docs.first.reference.update({
        'clearedStage': clearedStage,
      });
    }
  }
}
