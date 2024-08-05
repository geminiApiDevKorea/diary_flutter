import 'package:diary_flutter/common/extension/date_time_extension.dart';
import 'package:diary_flutter/data/provider/diary_repository_provider.dart';
import 'package:diary_flutter/data/repository/diary_repository.dart';
import 'package:diary_flutter/domain/provider/auth/get_my_id_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'diary_use_cases.g.dart';

@riverpod
Future<List<MusicDiary>> getDiaries(
  GetDiariesRef ref,
  DateTime dateTime,
) async {
  final diaryRepository = ref.read(diaryRepositoryProvider);
  final idToken = ref.read(getMyIdTokenProvider);
  final response = await diaryRepository.getDiary(
    bearerToken: 'Bearer $idToken',
    yyyyMM: dateTime.yyyyMM,
  );

  return response.diary;
}
