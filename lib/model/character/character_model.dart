import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_template/model/content/content_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  @JsonKey(name: 'ServerName')
  final String serverName;
  @JsonKey(name: 'CharacterName')
  final String characterName;
  @JsonKey(name: 'CharacterLevel')
  final int characterLevel;
  @JsonKey(name: 'CharacterClassName')
  final String characterClassName;
  @JsonKey(name: 'ItemAvgLevel')
  final String itemAvgLevel;
  @JsonKey(name: 'ItemMaxLevel')
  final String itemMaxLevel;
  late int? idx;

  CharacterModel({
    required this.serverName,
    required this.characterName,
    required this.characterLevel,
    required this.characterClassName,
    required this.itemAvgLevel,
    required this.itemMaxLevel,
    this.idx,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}
