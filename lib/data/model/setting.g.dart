// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      $enumDecode(_$HomeNavigationsEnumMap, json['homeNavigation']),
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'homeNavigation': _$HomeNavigationsEnumMap[instance.homeNavigation]!,
    };

const _$HomeNavigationsEnumMap = {
  HomeNavigations.home: 'home',
  HomeNavigations.calendar: 'calendar',
  HomeNavigations.write: 'write',
  HomeNavigations.diary: 'diary',
  HomeNavigations.setting: 'setting',
};
