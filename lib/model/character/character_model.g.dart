// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      serverName: json['ServerName'] as String,
      characterName: json['CharacterName'] as String,
      characterLevel: json['CharacterLevel'] as int,
      characterClassName: json['CharacterClassName'] as String,
      itemAvgLevel: json['ItemAvgLevel'] as String,
      itemMaxLevel: json['ItemMaxLevel'] as String,
      idx: json['idx'] as int?,
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'ServerName': instance.serverName,
      'CharacterName': instance.characterName,
      'CharacterLevel': instance.characterLevel,
      'CharacterClassName': instance.characterClassName,
      'ItemAvgLevel': instance.itemAvgLevel,
      'ItemMaxLevel': instance.itemMaxLevel,
      'idx': instance.idx,
    };