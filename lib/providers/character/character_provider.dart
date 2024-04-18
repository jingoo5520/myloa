import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/character/character_card_model.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:flutter_template/resources/routes.dart';
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
    getCharacterContents(context,
        characterName: characterCardModel.characterModel.characterName,
        type: 0);
    getCharacterContents(context,
        characterName: characterCardModel.characterModel.characterName,
        type: 1);
  }

  //일일, 주간 탭 선택
  changeTab(int tab) {
    if (this.tab != tab) {
      this.tab = tab;
      notifyListeners();
    }
  }

  //모드 변경
  changeMode({required int type, required int mode}) {
    this.mode = mode;
    List<bool> tempList;

    if (mode != 0) {
      tempList = List.filled(
          type == 0 ? dayContentList!.length : weekContentList!.length, false);
      temporaryDeleteState = tempList;
    } else {
      tempList = [];
      temporaryDeleteState = tempList;
    }

    notifyListeners();
  }

  //캐릭터 컨텐츠 불러오기
  getCharacterContents(
    BuildContext context, {
    required String characterName,
    required int type,
  }) async {
    List<ContentModel> tempList = [];

    final characterDB = context.read<CommonProvider>().characterDB;

    late QuerySnapshot<Map<String, dynamic>> contentsDB;

    if (type == 0) {
      contentsDB =
          await characterDB.collection('dayContents').orderBy('priority').get();
    } else if (type == 1) {
      contentsDB = await characterDB
          .collection('weekContents')
          .orderBy('priority')
          .get();
    } else {}

    for (var content in contentsDB.docs) {
      tempList.add(
        ContentModel(
          icon: content.data()['icon'],
          contentName: content.data()['contentName'],
          maxCount: content.data()['maxCount'],
          currentCount: content.data()['currentCount'],
          maxRestGauge: content.data()['maxRestGauge'],
          currentRestGauge: content.data()['currentRestGauge'],
          maxStage: content.data()['maxStage'],
          clearedStage: content.data()['clearedStage'],
          priority: content.data()['priority'],
        ),
      );
    }

    await Future.delayed(Duration.zero);

    if (type == 0) {
      dayContentList = tempList;
    } else if (type == 1) {
      weekContentList = tempList;
    } else {}

    notifyListeners();
  }

  //컨텐츠 화면 업데이트
  updateContents({
    required ContentModel contentModel,
    required int type,
  }) async {
    List<ContentModel> tempList;

    if (type == 0) {
      tempList = dayContentList!.map((dayContent) {
        if (dayContent.contentName == contentModel.contentName) {
          // 해당 모델의 이름이 일치하면 copyWith를 사용하여 정보 변경
          return dayContent.copyWith(
            currentCount: contentModel.currentCount,
            currentRestGauge: contentModel.currentRestGauge,
          );
        } else {
          return dayContent;
        }
      }).toList();

      dayContentList = tempList;
    } else if (type == 1) {
      tempList = weekContentList!.map((weekContent) {
        if (weekContent.contentName == contentModel.contentName) {
          // 해당 모델의 이름이 일치하면 copyWith를 사용하여 정보 변경
          return weekContent.copyWith(
            currentCount: contentModel.currentCount,
            clearedStage: contentModel.clearedStage,
          );
        } else {
          return weekContent;
        }
      }).toList();

      weekContentList = tempList;
    } else {}

    notifyListeners();
  }

  //컨텐츠 DB 업데이트
  updateContentsDB(
    BuildContext context, {
    required int type,
    required ContentModel contentModel,
    required characterName,
  }) async {
    final characterDB = context.read<CommonProvider>().characterDB;

    DocumentReference<Map<String, dynamic>> content = (await characterDB
            .collection(type == 0 ? 'dayContents' : 'weekContents')
            .where('contentName', isEqualTo: contentModel.contentName)
            .get())
        .docs
        .first
        .reference;

    if (timers[contentModel.contentName] != null) {
      timers[contentModel.contentName]!.cancel();
    }

    final timer = Timer(const Duration(milliseconds: 500), () async {
      if (type == 0) {
        await content.update({
          'currentCount': contentModel.currentCount,
          'currentRestGauge': contentModel.currentRestGauge,
        });
      } else if (type == 1) {
        await content.update({
          'currentCount': contentModel.currentCount,
          'clearedStage': contentModel.clearedStage,
        });
      } else {}

      timers.remove(contentModel.contentName);
    });

    timers[contentModel.contentName] = timer;
  }

  //캐릭터 컨텐츠 편집 다이얼로그
  showEditContentsBottomSheet(
    BuildContext context, {
    required int type,
  }) async {
    late int mode;

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
                      type = type;
                      Navigator.of(context).pop(true);
                    },
                  ),
                  BottomSheetItem(
                    title: '삭제하기',
                    color: const Color(0xffff6060),
                    ontap: () {
                      mode = 1;
                      type = type;
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
            ));

    if (result == true) {
      //삭제 모드
      if (mode == 1) {
        changeMode(type: type, mode: mode);
      }
      //추가, 수정 모드
      else {
        Navigator.of(context).pushNamed(AppRoutes.editContent, arguments: {
          'mode': mode,
          'type': type,
        }).then((value) async {
          if (value != null) {
            await getCharacterContents(context,
                characterName: characterCardModel.characterModel.characterName,
                type: type);
          }
          context.read<CommonProvider>().offLoad();
        });
      }
    }
  }

  //컨텐츠 임시 삭제
  temporaryDeleteContent(int index) {
    List<bool> temp = List.from(temporaryDeleteState);

    temp[index] = true;

    temporaryDeleteState = temp;

    notifyListeners();
  }

  //컨텐츠 삭제 완료
  deleteContent(BuildContext context, {required int type}) async {
    context.read<CommonProvider>().onLoad();

    final characterDB = context.read<CommonProvider>().characterDB;

    final contentsDB = await characterDB
        .collection(type == 0 ? 'dayContents' : 'weekContents')
        .orderBy('priority')
        .get();

    for (int i = 0; i < contentsDB.docs.length; i++) {
      if (temporaryDeleteState[i] == true) {
        await contentsDB.docs[i].reference.delete();
      }
    }

    await getCharacterContents(context,
        characterName: characterCardModel.characterModel.characterName,
        type: type);
    changeMode(type: type, mode: 0);
    context.read<CommonProvider>().offLoad();
  }
}
