import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/extension/date_time_extension.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/provider/diary_repository_provider.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:diary_flutter/data/repository/diary_repository.dart';
import 'package:diary_flutter/domain/provider/auth/get_my_id_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'diary_use_cases.g.dart';

@riverpod
Future<DiaryRespons> getDiaries(
  GetDiariesRef ref,
  DateTime dateTime,
) {
  final diaryRepository = ref.read(diaryRepositoryProvider);
  final idToken = ref.read(getMyIdTokenProvider);
  return diaryRepository.getDiary(
    bearerToken: 'Bearer $idToken',
    yyyyMM: dateTime.yyyyMM,
  );
}

@riverpod
Future<MusicDiary?> getDiary(
  GetDiaryRef ref,
  DateTime dateTime,
) {
  return ref.watch(
    getDiariesProvider(dateTime.firstDayOfMonth).selectAsync(
      (response) {
        return response.diary.firstWhereOrNull(
          (diary) => diary.dateTime.isSameDay(dateTime),
        );
      },
    ),
  );
}

@riverpod
Future<void> postDiary(
  PostDiaryRef ref, {
  required Journal journal,
  required ChatsFeedbackResponse chatsFeedbackResponse,
}) async {
  final diaryRepository = ref.read(diaryRepositoryProvider);
  final idToken = ref.read(getMyIdTokenProvider);
  await diaryRepository.postDiary(
    bearerToken: 'Bearer $idToken',
    body: DiaryPostBody(
      dailyDiary: DailyDiary(
        type: journal.feedbackType,
        dateTime: journal.createdAt.yyyyMMdd,
        title: journal.title ?? '',
        contents: [
          ...journal.history,
          History(role: Role.user, message: journal.userInput ?? '')
        ],
        music: chatsFeedbackResponse.music,
      ),
    ),
  );
}
