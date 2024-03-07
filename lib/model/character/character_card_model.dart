import 'package:flutter_template/model/character/character_model.dart';
import 'package:flutter_template/model/content/content_model.dart';

class CharacterCardModel {
  final CharacterModel characterModel;
  final List<ContentModel> basicContents;
  final List<ContentModel> dayContentList;
  final List<ContentModel> weekContentList;

  CharacterCardModel({
    required this.characterModel,
    required this.basicContents,
    required this.dayContentList,
    required this.weekContentList,
  });

  CharacterCardModel copyWith({
    List<ContentModel>? basicContents,
    List<ContentModel>? dayContentList,
    List<ContentModel>? weekContentList,
  }) {
    return CharacterCardModel(
      characterModel: characterModel,
      basicContents: basicContents ?? this.basicContents,
      dayContentList: dayContentList ?? this.dayContentList,
      weekContentList: weekContentList ?? this.weekContentList,
    );
  }

  @override
  String toString() {
    return '$characterModel, $basicContents';
  }
}
