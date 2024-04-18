import 'package:flutter/material.dart';
import 'package:flutter_template/model/character/character_card_model.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/resources/constants/theme.dart';
import 'package:flutter_template/views/widgets/character/character_info_card.dart';
import 'package:flutter_template/views/widgets/character/day_contents_board.dart';
import 'package:flutter_template/views/widgets/character/week_contents_board.dart';
import 'package:flutter_template/views/widgets/common/confirm_appbar.dart';
import 'package:flutter_template/views/widgets/common/custom_appbar.dart';
import 'package:flutter_template/views/widgets/common/custom_tabbar.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CharacterPage extends StatefulWidget {
  final CharacterCardModel characterCardModel;

  const CharacterPage({required this.characterCardModel, super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    context.read<CharacterProvider>().tabController = TabController(
        length: context.read<CharacterProvider>().tabNames.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pop(context.read<CharacterProvider>().dayContentList);

        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Selector<CharacterProvider,
            Tuple3<List<ContentModel>?, List<ContentModel>?, int>>(
          selector: (p0, p1) =>
              Tuple3(p1.dayContentList, p1.weekContentList, p1.mode),
          builder: (context, value, child) {
            return Column(
              children: [
                Stack(
                  children: [
                    CharacterInfoCard(
                        characterModel:
                            widget.characterCardModel.characterModel),
                    Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top),
                        value.item3 == 0
                            ? CustomAppBar(
                                title: '캐릭터',
                                leadingIcon: 'assets/icons/arrow_left.png',
                                onTap: () {
                                  Navigator.of(context).pop(context
                                      .read<CharacterProvider>()
                                      .dayContentList);
                                },
                              )
                            : ConfirmAppBar(cancleOntap: () {
                                context
                                    .read<CharacterProvider>()
                                    .changeMode(type: 0, mode: 0);
                              }, confirmOntap: () {
                                context.read<CharacterProvider>().deleteContent(
                                    context,
                                    type: context
                                        .read<CharacterProvider>()
                                        .tabController
                                        .index);
                              }),
                      ],
                    )
                  ],
                ),
                CustomTabBar(
                    mode: value.item3,
                    tabController:
                        context.read<CharacterProvider>().tabController,
                    tabNames: context.read<CharacterProvider>().tabNames),
                Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller:
                          context.read<CharacterProvider>().tabController,
                      children: [
                        DayContentsBoard(
                            mode: value.item3,
                            characterName: widget.characterCardModel
                                .characterModel.characterName,
                            dayContentList: value.item1 ??
                                widget.characterCardModel.dayContentList),
                        WeekContentsBoard(
                          mode: value.item3,
                          characterName: widget
                              .characterCardModel.characterModel.characterName,
                          weekContentList: value.item2 ??
                              widget.characterCardModel.weekContentList,
                        ),
                      ]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
