import 'package:diary_flutter/common/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable()
class Setting {
  HomeNavigations homeNavigation;
  Setting(this.homeNavigation);

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);
  Map<String, dynamic> toJson() => _$SettingToJson(this);

  Setting copyWith({HomeNavigations? homeNavigation}) {
    return Setting(
      homeNavigation ?? this.homeNavigation,
    );
  }
}
