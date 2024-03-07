import 'package:flutter_template/model/character/character_model.dart';
import 'package:flutter_template/model/content/content_model.dart';

class Character {
  final CharacterModel characterModel;
  final List<ContentModel> dayContentsList;

  Character({
    required this.characterModel,
    required this.dayContentsList,
  });
}
