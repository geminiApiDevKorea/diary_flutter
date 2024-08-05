import 'package:diary_flutter/data/provider/dio_provider.dart';
import 'package:diary_flutter/data/repository/diary_repository.dart';
import 'package:diary_flutter/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'diary_repository_provider.g.dart';

@riverpod
DiaryRepository diaryRepository(DiaryRepositoryRef ref) {
  final dio = ref.watch(dioProvider(baseUrl: Env.baseUrl));
  return DiaryRepository(dio);
}
