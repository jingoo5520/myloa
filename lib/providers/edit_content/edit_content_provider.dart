import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:provider/provider.dart';

class EditContentProvider extends ChangeNotifier {
  final int mode; //0: 추가, 1: 수정
  final int type; //0: 일일 컨텐츠, 1: 주간 컨텐츠, 2:

  bool validation = true;

  //일일 컨텐츠용
  TextEditingController currentCountTextEditingController =
      TextEditingController();
  TextEditingController currentRestGaugeTextEditingController =
      TextEditingController();

  EditContentProvider(
    BuildContext context, {
    required this.type,
    required this.mode,
  }) {
    debugPrint('editContent');
  }

  //텍스트필드 유효성 검사
  setValidation(bool valid) {
    validation = valid;
    notifyListeners();
  }

  //일일 컨텐츠 추가, 수정
  editDayContent(
    BuildContext context, {
    required int mode,
    required ContentModel dayContentModel,
  }) async {
    context.read<CommonProvider>().onLoad();
    DocumentReference<Map<String, dynamic>> characterDB =
        context.read<CommonProvider>().characterDB;

    final dayContentsDB = characterDB.collection('dayContents');

    //추가
    if (mode == 0) {
      final data = {
        'icon': dayContentModel.icon,
        'contentName': dayContentModel.contentName,
        'maxCount': dayContentModel.maxCount,
        'currentCount': dayContentModel.currentCount,
        'maxRestGauge': dayContentModel.maxRestGauge,
        'currentRestGauge': dayContentModel.currentRestGauge,
        'priority': dayContentModel.priority,
      };

      if ((await dayContentsDB
              .where('contentName', isEqualTo: dayContentModel.contentName)
              .get())
          .docs
          .isEmpty) {
        await dayContentsDB.add(data);
      } else {
        //중복된 컨텐츠
        print('이미 존재하는 컨텐츠입니다.');
      }
    }
    //수정
    else {
      final content = (await dayContentsDB
              .where('contentName', isEqualTo: dayContentModel.contentName)
              .get())
          .docs
          .first
          .reference;

      await content.update({
        'currentCount': dayContentModel.currentCount,
        'currentRestGauge': dayContentModel.currentRestGauge,
      });
    }

    Navigator.of(context).pop(dayContentModel);
    context.read<CommonProvider>().offLoad();
  }

  //일일 컨텐츠 삭제
}
