import 'dart:convert';
import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/diary.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temporary_diary.g.dart';

@Riverpod(keepAlive: false)
class TemporaryDiary extends _$TemporaryDiary {
  static const String key = "temporary_diary";

  @override
  Diary build() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final storedDiary = persistanceStorage.getValue<String>(key);
    if (storedDiary != null) {
      return Diary.fromJson(jsonDecode(storedDiary));
    } else {
      return Diary(DateTime.now(), "", null, null);
    }
  }

  void clear() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    persistanceStorage.removeValue(key);
    state = Diary(DateTime.now(), "", null, null);
  }

  void change({required Moods mood}) {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final updatedDiary = state.copyWith(mood: mood);
    persistanceStorage.setValue(key, jsonEncode(updatedDiary.toJson()));
    state = updatedDiary;
  }

  void update({required String content}) {
    if (content.length <= Diary.maxLength) {
      final persistanceStorage = ref.read(persistanceStorageProvider);
      final updatedDiary = state.copyWith(
        content: content,
        dateTime: DateTime.now(),
      );
      persistanceStorage.setValue(key, jsonEncode(updatedDiary.toJson()));
      state = updatedDiary;
    }
  }
}
