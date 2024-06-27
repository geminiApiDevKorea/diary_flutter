import 'dart:convert';

import 'package:diary_flutter/data/model/diary.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/domain/provider/temporary_diary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'archived_diaries.g.dart';

@Riverpod(keepAlive: true)
class ArchivedDiaries extends _$ArchivedDiaries {
  static const String key = "archived_diaries";

  void archive() {
    final temporaryDiary = ref.read(temporaryDiaryProvider);
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final archivedDiaries =
        persistanceStorage.getValue<List<String>>(key) ?? [];
    archivedDiaries.add(jsonEncode(temporaryDiary.toJson()));
    persistanceStorage.setValue(key, archivedDiaries);
    ref.read(temporaryDiaryProvider.notifier).clear();
    state = [
      ...state,
      temporaryDiary,
    ];
  }

  @override
  List<Diary> build() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final storedDiaries = persistanceStorage.getValue<List<String>>(key);
    if (storedDiaries != null) {
      return storedDiaries.map((e) => Diary.fromJson(jsonDecode(e))).toList();
    } else {
      return [];
    }
  }
}
