import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/content/common_day_content_model.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:flutter_template/views/widgets/common_contents/edit_common_contents_dialog.dart';
import 'package:provider/provider.dart';

class CommonContentsProvider extends ChangeNotifier {
  TextEditingController currentCountTextEditingController =
      TextEditingController();

  CommonContentsProvider() {
    debugPrint('commonContents');
  }

  showEditCommonDayContentDialog(BuildContext context,
      {required int mode, CommonDayContentModel? commonDayContentModel}) {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: this,
        child: Dialog(
            child: EditCommonDayContentDialog(
          mode: mode,
        )),
      ),
    ).then((value) async {
      if (value == null) {
        return;
      }

      if (value['result'] == true) {
        //공통 일일 컨텐츠 추가, 수정
        await editCommonDayContent(
            context: context,
            mode: value['mode'],
            commonDayContentModel: value['content']);
      }

      // currentCountTextEditingController.clear();
      // restGaugeTextEditingController.clear();
    });
  }

  //공통 일일 컨텐츠 추가, 수정
  editCommonDayContent(
      {required BuildContext context,
      required int mode,
      required CommonDayContentModel commonDayContentModel}) async {
    var data;

    final userDB = context.read<CommonProvider>().userDB;

    // final dayContent = characterDB
    //     .collection('dayContents')
    //     .where('contentName', isEqualTo: dayContentModel.contentName);

    //일일 컨텐츠 생성
    if (mode == 0) {
      data = {
        'contentName': commonDayContentModel.contentName,
        'maxCount': commonDayContentModel.maxCount,
        'currentCount': int.parse(currentCountTextEditingController.text),
        'priority': commonDayContentModel.priority,
      };

      await userDB.collection('commonDayContents').add(data);

      //이미 존재하는 컨텐츠라면
      // if ((await dayContent.get()).docs.isEmpty == true) {
      //   await characterDB.collection('dayContents').add(data);
      // } else {
      //   debugPrint('중복된 컨텐츠');
      // }
    }

    //일일 컨텐츠 수정
    // else {
    //   final currentRestGauge = restGaugeTextEditingController.text.isEmpty
    //       ? 0
    //       : int.parse(restGaugeTextEditingController.text);

    //   (await dayContent.get()).docs.first.reference.update({
    //     'currentCount': int.parse(currentCountTextEditingController.text),
    //     'currentRestGauge': currentRestGauge,
    //   });
    // }
  }

  //공통 일일 컨텐츠 불러오기
  Stream<QuerySnapshot> getCommonDayContents(BuildContext context) async* {
    final userDB = context.read<CommonProvider>().userDB;

    Stream<QuerySnapshot> stream =
        userDB.collection('commonDayContents').orderBy('priority').snapshots();

    await for (QuerySnapshot snapshot in stream) {
      yield snapshot;
    }
  }

  //공통 일일 컨텐츠 1회 완료
  completeCommonDayContent(
    BuildContext context, {
    required CommonDayContentModel commonDayContentModel,
  }) async {
    final content = (await context
            .read<CommonProvider>()
            .userDB
            .collection('commonDayContents')
            .where('contentName', isEqualTo: commonDayContentModel.contentName)
            .get())
        .docs[0];

    if (content['currentCount'] == 0) {
      return;
    }

    await content.reference.update({
      'currentCount': content['currentCount'] - 1,
    });
  }
}
