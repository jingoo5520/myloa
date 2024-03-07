import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/content/common_day_content_model.dart';
import 'package:flutter_template/providers/common_contents/common_contents_provider.dart';
import 'package:flutter_template/resources/constants/constants.dart';
import 'package:flutter_template/views/widgets/common_contents/common_day_content_card.dart';
import 'package:provider/provider.dart';

class CommonContentsPage extends StatelessWidget {
  const CommonContentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: context
                  .read<CommonContentsProvider>()
                  .getCommonDayContents(context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('에러 발생'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(child: SizedBox());
                }

                if (!snapshot.hasData) {
                  return Center(child: Text('데이터 없음'));
                }

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children:
                          List.generate(snapshot.data!.docs.length, (index) {
                        final data = snapshot.data!.docs;

                        return CommonDayContentCard(
                            commonDayContentModel: CommonDayContentModel(
                                icon: commonDayContents[index].icon,
                                contentName: data[index]['contentName'],
                                maxCount: data[index]['maxCount'],
                                currentCount: data[index]['currentCount'],
                                priority: data[index]['priority']));
                      }),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<CommonContentsProvider>()
                      .showEditCommonDayContentDialog(context, mode: 0);
                },
                child: Text('+')),
          ],
        ),
      ),
    );
  }
}
