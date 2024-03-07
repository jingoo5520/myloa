import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/model/character/character_card_model.dart';
import 'package:flutter_template/providers/home/home_provider.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:flutter_template/views/widgets/home/character_card.dart';
import 'package:flutter_template/views/widgets/common/edit_bottom_sheet/edit_button.dart';
import 'package:flutter_template/views/widgets/home/home_appbar.dart';
import 'package:flutter_template/views/widgets/common/custom_tabbar.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().tabController = TabController(
        length: context.read<HomeProvider>().tabNames.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Selector<HomeProvider,
              Tuple3<List<CharacterCardModel>, List<CharacterCardModel>, int>>(
            selector: (p0, p1) => Tuple3(p1.myCharacters, p1.tempList, p1.mode),
            builder: (context, value, child) => Column(
              children: [
                value.item3 == 0
                    ? Column(
                        children: [
                          const HomeAppBar(),
                          SizedBox(height: 20.h),
                          CustomTabBar(
                              tabController:
                                  context.read<HomeProvider>().tabController,
                              tabNames: context.read<HomeProvider>().tabNames),
                        ],
                      )
                    : Container(
                        height: 56.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                context.read<HomeProvider>().changeMode(0);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Text(
                                  '취소',
                                  style: TextStyle(
                                    color: const Color(0xffF15A5A),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                value.item3 == 1
                                    ? context
                                        .read<HomeProvider>()
                                        .changeCharacterIndex(context)
                                    : context
                                        .read<HomeProvider>()
                                        .deleteCharacter(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Text(
                                  '완료',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: context.read<HomeProvider>().tabController,
                      children: [
                        //if (value.item1.isEmpty) return const SizedBox();

                        value.item3 == 0
                            ? SingleChildScrollView(
                                child: Column(children: [
                                  Column(children: [
                                    SizedBox(height: 24.h),
                                    ...List.generate(
                                      value.item1.length,
                                      (index) => CharacterCard(
                                        characterCardModel: value.item1[index],
                                        // basicContents:
                                        //     value.item1[index].basicContents,
                                        mode: value.item3,
                                        index: index,
                                      ),
                                    ),
                                  ]),
                                  EditButton(
                                      margin: 0.h,
                                      onTap: () {
                                        context
                                            .read<HomeProvider>()
                                            .showEditCharactersBottomSheet(
                                                context);
                                      })
                                ]),
                              )
                            : value.item3 == 1
                                ? Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: Overlay(
                                      initialEntries: [
                                        OverlayEntry(
                                          builder: (context) =>
                                              ReorderableListView(
                                            header: SizedBox(height: 24.h),
                                            buildDefaultDragHandles: false,
                                            children: List.generate(
                                              value.item2.length,
                                              (index) {
                                                return Container(
                                                  key: Key(index.toString()),
                                                  child: CharacterCard(
                                                    characterCardModel:
                                                        value.item2[index],
                                                    // basicContents: value
                                                    //     .item2[index]
                                                    //     .basicContents,
                                                    mode: value.item3,
                                                    index: index,
                                                  ),
                                                );
                                              },
                                            ),
                                            onReorder: (oldIndex, newIndex) {
                                              setState(() {
                                                if (oldIndex < newIndex) {
                                                  newIndex -= 1;
                                                }
                                                final item = value.item2
                                                    .removeAt(oldIndex);
                                                value.item2
                                                    .insert(newIndex, item);
                                              });
                                              // for (var i in value.item2) {
                                              //   print(
                                              //       '${i.characterModel.characterName}, ${i.characterModel.idx}');
                                              // }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Column(children: [
                                      SizedBox(height: 24.h),
                                      ...List.generate(
                                        value.item2.length,
                                        (index) => CharacterCard(
                                          characterCardModel:
                                              value.item2[index],
                                          // basicContents:
                                          //     value.item2[index].basicContents,
                                          mode: value.item3,
                                          index: index,
                                        ),
                                      ),
                                    ]),
                                  ),

                        const SizedBox(
                          child: Center(
                            child: Text('원정대'),
                          ),
                        ),
                        const SizedBox(
                          child: Center(
                            child: Text('계산기'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
