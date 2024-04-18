import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:provider/provider.dart';

class EditContentProvider extends ChangeNotifier {
  bool validation = true;

  TextEditingController currentCountTextEditingController =
      TextEditingController();
  TextEditingController currentRestGaugeTextEditingController =
      TextEditingController();
  TextEditingController clearedStageTextEditingController =
      TextEditingController();

  EditContentProvider(BuildContext context) {
    debugPrint('editContent');
  }

  //텍스트필드 유효성 검사
  setValidation(bool valid) {
    validation = valid;
    notifyListeners();
  }

  //컨텐츠 추가, 수정
  editContent(
    BuildContext context, {
    required int type, //0: 일일 컨텐츠, 1: 주간 컨텐츠
    required int mode, //0: 추가, 1: 수정
    required ContentModel contentModel,
  }) async {
    context.read<CommonProvider>().onLoad();

    late ContentModel edittedContentModel;

    DocumentReference<Map<String, dynamic>> characterDB =
        context.read<CommonProvider>().characterDB;

    if (type == 0) {
      final dayContentsDB = characterDB.collection('dayContents');

      int currentCount = int.parse(currentCountTextEditingController.text);
      int currentRestGauge = currentRestGaugeTextEditingController.text != ''
          ? int.parse(currentRestGaugeTextEditingController.text)
          : 0;

      //추가
      if (mode == 0) {
        final data = {
          'icon': contentModel.icon,
          'contentName': contentModel.contentName,
          'maxCount': contentModel.maxCount,
          'currentCount': currentCount,
          'maxRestGauge': contentModel.maxRestGauge,
          'currentRestGauge': currentRestGauge,
          'priority': contentModel.priority,
        };

        if ((await dayContentsDB
                .where('contentName', isEqualTo: contentModel.contentName)
                .get())
            .docs
            .isEmpty) {
          await dayContentsDB.add(data);
        } else {
          //중복된 컨텐츠
          //토스트 메세지 추가 예정
          print('이미 존재하는 컨텐츠입니다.');
        }
      }
      //수정
      else {
        final content = (await dayContentsDB
                .where('contentName', isEqualTo: contentModel.contentName)
                .get())
            .docs
            .first
            .reference;

        await content.update({
          'currentCount': currentCount,
          'currentRestGauge': currentRestGauge
        });
      }

      edittedContentModel = contentModel.copyWith(
        currentCount: currentCount,
        currentRestGauge: currentRestGauge,
      );
    } else if (type == 1) {
      final weekContentsDB = characterDB.collection('weekContents');

      int currentCount = currentCountTextEditingController.text != ''
          ? int.parse(currentCountTextEditingController.text)
          : 0;
      int clearedStage = clearedStageTextEditingController.text != ''
          ? int.parse(clearedStageTextEditingController.text)
          : 0;

      //추가
      if (mode == 0) {
        final data = {
          'icon': contentModel.icon,
          'contentName': contentModel.contentName,
          'maxCount': contentModel.maxCount,
          'currentCount': currentCount,
          'maxRestGauge': contentModel.maxRestGauge,
          'currentRestGauge': contentModel.currentRestGauge,
          'maxStage': contentModel.maxStage,
          'clearedStage': clearedStage,
          'priority': contentModel.priority,
        };

        if ((await weekContentsDB
                .where('contentName', isEqualTo: contentModel.contentName)
                .get())
            .docs
            .isEmpty) {
          await weekContentsDB.add(data);
        } else {
          //중복된 컨텐츠
          //토스트 메세지 추가 예정
          print('이미 존재하는 컨텐츠입니다.');
        }
      }
      //수정
      else {
        final content = (await weekContentsDB
                .where('contentName', isEqualTo: contentModel.contentName)
                .get())
            .docs
            .first
            .reference;

        await content.update({
          'currentCount': currentCount,
          'clearedStage': clearedStage,
        });
      }

      print('업뎃중');
      edittedContentModel = contentModel.copyWith(
        currentCount: currentCount,
        clearedStage: clearedStage,
      );
    } else {}

    Navigator.of(context).pop(edittedContentModel);
  }
}
