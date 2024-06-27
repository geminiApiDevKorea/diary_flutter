import 'dart:convert';

import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/setting.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_notifier.g.dart';

@Riverpod(keepAlive: true)
class SettingNotifier extends _$SettingNotifier {
  static String key = "setting";

  @override
  Setting build() {
    final storedSetting =
        ref.read(persistanceStorageProvider).getValue<String>(key);
    if (storedSetting == null) {
      return Setting(HomeNavigations.home);
    } else {
      return Setting.fromJson(jsonDecode(storedSetting));
    }
  }

  void update({required HomeNavigations homeNavigation}) {
    final updatedSetting = state.copyWith(homeNavigation: homeNavigation);
    ref
        .read(persistanceStorageProvider)
        .setValue(key, jsonEncode(updatedSetting.toJson()));
    state = updatedSetting;
  }
}
