import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/temporary_diary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temporary_mood.g.dart';

@riverpod
Moods? temporaryMood(TemporaryMoodRef ref) {
  return ref.watch(temporaryDiaryProvider.select((diary) => diary.mood));
}
