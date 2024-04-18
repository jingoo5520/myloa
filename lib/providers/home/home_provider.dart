import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/character/character_card_model.dart';
import 'package:flutter_template/model/character/character_model.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:flutter_template/repository/user/user_repository.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/views/widgets/home/add_character_dialog/add_character_dialog.dart';
import 'package:flutter_template/views/widgets/common/edit_bottom_sheet/bottom_sheet_item.dart';
import 'package:flutter_template/views/widgets/common/edit_bottom_sheet/edit_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  //캐릭터 추가 다이얼로그 검색 텍스트필드
  TextEditingController searchCharacterNameTextEditingController =
      TextEditingController();
  late TabController tabController;

  List<CharacterCardModel> myCharacters = []; //일반 캐릭터카드 리스트
  List<CharacterCardModel> tempList = []; //수정, 삭제용 캐릭터카드 리스트
  List<bool> temporaryDeleteState = [];

  int mode = 0; //일반 모드, 순서 변경 모드, 삭제 모드

  List<String> tabNames = ['캐릭터', '원정대', '계산기'];

  HomeProvider(BuildContext context) {
    debugPrint('home');
    setPage(context);
  }

  setPage(BuildContext context) async {
    await getMyCharacters(context);
    context.read<CommonProvider>().offLoad();
  }
  // //로그아웃
  // signOut(BuildContext context) async {
  //   await context.read<CommonProvider>().auth.signOut();
  //   Navigator.of(context)
  //       .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  // }

  //캐릭터 추가 다이얼로그
  showAddCharacterDialog(BuildContext context) {
    searchCharacterNameTextEditingController.clear();
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
          value: this, child: AddCharacterDialog()),
    );
  }

  //캐릭터 추가하기
  addCharacter(BuildContext context, String characterName) async {
    final int lastIdx;

    final userDatabase = context.read<CommonProvider>().userDB;

    final UserRepository userRepository = UserRepository(
        context.read<CommonProvider>().dio,
        baseUrl: 'https://developer-lostark.game.onstove.com');

    final lastData = await userDatabase
        .collection('characters')
        .orderBy('idx', descending: true)
        .limit(1)
        .get();

    if (lastData.docs.isNotEmpty) {
      lastIdx = lastData.docs.first['idx'] + 1;
    } else {
      lastIdx = 0;
    }

    try {
      context.read<CommonProvider>().onLoad();
      final data =
          await userRepository.getCharacter(characterName: characterName);

      final character =
          data.firstWhere((element) => element.characterName == characterName);

      if ((await userDatabase
                  .collection('characters')
                  .where('characterName', isEqualTo: characterName)
                  .get())
              .docs
              .isEmpty ==
          false) {
        context.read<CommonProvider>().offLoad();
        return '이미 추가된 캐릭터 입니다.';
      } else {
        await userDatabase.collection('characters').add({
          'serverName': character.serverName,
          'characterName': character.characterName,
          'characterLevel': character.characterLevel,
          'characterClassName': character.characterClassName,
          'itemAvgLevel': character.itemAvgLevel,
          'itemMaxLevel': character.itemMaxLevel,
          'idx': lastIdx
        }).then((value) {
          //캐릭터 추가와 동시에 dayContents 컬렉션 자동 생성
          for (int i = 0; i < 3; i++) {
            value.collection('dayContents').add({
              'icon': dayContents[i].icon,
              'contentName': dayContents[i].contentName,
              'maxCount': dayContents[i].maxCount,
              'currentCount': dayContents[i].maxCount,
              'maxRestGauge': dayContents[i].maxRestGauge,
              'currentRestGauge': dayContents[i].maxRestGauge,
              'priority': dayContents[i].priority,
            });
          }
          value.collection('weekContents').add({
            'icon': weekContents[0].icon,
            'contentName': weekContents[0].contentName,
            'maxCount': weekContents[0].maxCount,
            'currentCount': weekContents[0].maxCount,
            'maxRestGauge': weekContents[0].maxRestGauge,
            'currentRestGauge': weekContents[0].maxRestGauge,
            'maxStage': weekContents[0].maxStage,
            'clearedStage': weekContents[0].clearedStage,
            'priority': weekContents[0].priority,
          });
        });

        await getMyCharacters(context);
        context.read<CommonProvider>().offLoad();
        Navigator.of(context).pop(true);

        notifyListeners();

        return;
      }
    } catch (e) {
      context.read<CommonProvider>().offLoad();
      return '존재하지 않는 캐릭터 입니다.';
    }
  }

  //캐릭터 카드 편집 다이얼로그
  showEditCharactersBottomSheet(BuildContext context) {
    showModalBottomSheet(
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
                      Navigator.of(context).pop();
                      showAddCharacterDialog(context);
                    },
                  ),
                  BottomSheetItem(
                    title: '순서 변경하기',
                    color: const Color(0xffd7d7d7),
                    ontap: () {
                      Navigator.of(context).pop();
                      changeMode(1);
                    },
                  ),
                  BottomSheetItem(
                    title: '삭제하기',
                    color: const Color(0xffff6060),
                    ontap: () {
                      Navigator.of(context).pop();
                      changeMode(2);
                    },
                  ),
                ],
              ),
            ));
  }

  //저장된 캐릭터 불러오기
  getMyCharacters(BuildContext context) async {
    List<CharacterCardModel> characterList = [];

    final charactersDB = await context
        .read<CommonProvider>()
        .userDB
        .collection('characters')
        .orderBy('idx', descending: true)
        .get();

    for (var character in charactersDB.docs) {
      List<ContentModel> tempBasicContentList = [];
      List<ContentModel> tempDayContentList = [];
      List<ContentModel> tempWeekContentList = [];
      final dayContentsDB = await character.reference
          .collection('dayContents')
          .orderBy('priority')
          .get();

      final weekContentDB = await character.reference
          .collection('weekContents')
          .orderBy('priority')
          .get();

      CharacterModel characterModel = CharacterModel(
          serverName: character.data()['serverName'],
          characterName: character.data()['characterName'],
          characterLevel: character.data()['characterLevel'],
          characterClassName: character.data()['characterClassName'],
          itemAvgLevel: character.data()['itemAvgLevel'],
          itemMaxLevel: character.data()['itemMaxLevel'],
          idx: character.data()['idx']);

      for (int i = 0; i < dayContentsDB.docs.length; i++) {
        if (i < 3) {
          tempBasicContentList.add(
            ContentModel(
              icon: dayContentsDB.docs[i]['icon'],
              contentName: dayContentsDB.docs[i]['contentName'],
              maxCount: dayContentsDB.docs[i]['maxCount'],
              currentCount: dayContentsDB.docs[i]['currentCount'],
              maxRestGauge: dayContentsDB.docs[i]['maxRestGauge'],
              currentRestGauge: dayContentsDB.docs[i]['currentRestGauge'],
              priority: dayContentsDB.docs[i]['priority'],
            ),
          );
        }

        tempDayContentList.add(
          ContentModel(
            icon: dayContentsDB.docs[i]['icon'],
            contentName: dayContentsDB.docs[i]['contentName'],
            maxCount: dayContentsDB.docs[i]['maxCount'],
            currentCount: dayContentsDB.docs[i]['currentCount'],
            maxRestGauge: dayContentsDB.docs[i]['maxRestGauge'],
            currentRestGauge: dayContentsDB.docs[i]['currentRestGauge'],
            priority: dayContentsDB.docs[i]['priority'],
          ),
        );
      }

      for (int i = 0; i < weekContentDB.docs.length; i++) {
        tempWeekContentList.add(
          ContentModel(
            icon: weekContentDB.docs[i]['icon'],
            contentName: weekContentDB.docs[i]['contentName'],
            maxCount: weekContentDB.docs[i]['maxCount'],
            currentCount: weekContentDB.docs[i]['currentCount'],
            maxRestGauge: weekContentDB.docs[i]['maxRestGauge'],
            currentRestGauge: weekContentDB.docs[i]['currentRestGauge'],
            maxStage: weekContentDB.docs[i]['maxStage'],
            clearedStage: weekContentDB.docs[i]['clearedStage'],
            priority: weekContentDB.docs[i]['priority'],
          ),
        );
      }

      characterList.add(CharacterCardModel(
        characterModel: characterModel,
        basicContents: tempBasicContentList,
        //수정 필요
        dayContentList: tempDayContentList,
        weekContentList: tempWeekContentList,
      ));
    }

    myCharacters = characterList;
    notifyListeners();
  }

  //필수 컨텐츠 수정 캐릭터 업데이트
  setCharacterContents(BuildContext context,
      {required String characterName,
      required List<ContentModel> dayContents}) {
    List<CharacterCardModel> tempList;

    tempList = myCharacters.map((character) {
      if (character.characterModel.characterName == characterName) {
        return character.copyWith(
            basicContents: dayContents.sublist(0, 3),
            dayContentList: dayContents);
      } else {
        return character;
      }
    }).toList();

    myCharacters = tempList;
    notifyListeners();
  }

  //모드 변경
  changeMode(int mode) {
    //일반, 순서변경, 삭제 모드
    this.mode = mode;

    if (mode != 0) {
      tempList = List.from(myCharacters);
      if (mode == 2) {
        temporaryDeleteState = List.filled(tempList.length, false);
      }
    }

    notifyListeners();
  }

  //캐릭터 순서 변경 완료
  changeCharacterIndex(BuildContext context) async {
    context.read<CommonProvider>().onLoad();

    final userDB = context.read<CommonProvider>().userDB;

    final charactersDB = await userDB
        .collection('characters')
        .orderBy('idx', descending: true)
        .get();

    for (var character in charactersDB.docs) {
      //리스트 역순대로 idx 업데이트
      final i = tempList.length -
          1 -
          tempList.indexWhere((element) =>
              element.characterModel.characterName ==
              character.data()['characterName']);

      if (character.data()['idx'] != i) {
        await userDB
            .collection('characters')
            .doc(character.id)
            .update({'idx': i});
      }
    }

    await getMyCharacters(context);
    changeMode(0);
    context.read<CommonProvider>().offLoad();
  }

  //캐릭터 임시 삭제
  temporaryDeleteCharacter(int index) {
    temporaryDeleteState[index] = true;
  }

  //캐릭터 삭제 완료
  deleteCharacter(BuildContext context) async {
    context.read<CommonProvider>().onLoad();

    final userDB = context.read<CommonProvider>().userDB;

    final charactersDB = await userDB
        .collection('characters')
        .orderBy('idx', descending: true)
        .get();

    for (int i = 0; i < charactersDB.docs.length; i++) {
      if (temporaryDeleteState[i] == true) {
        await userDB
            .collection('characters')
            .doc(charactersDB.docs[i].id)
            .delete();
      }
    }

    await getMyCharacters(context);
    changeMode(0);
    context.read<CommonProvider>().offLoad();
  }
}
