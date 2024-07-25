import 'package:diary_flutter/data/provider/dio_provider.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:diary_flutter/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chats_repository_provider.g.dart';

@riverpod
ChatsRepository chatsRepository(ChatsRepositoryRef ref) {
  final dio = ref.watch(dioProvider(baseUrl: Env.baseUrl));
  return ChatsRepository(dio);
}
