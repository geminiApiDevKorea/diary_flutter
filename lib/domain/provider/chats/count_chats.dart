import 'package:diary_flutter/domain/provider/chats/stored_chats.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'count_chats.g.dart';

@riverpod
int countChats(CountChatsRef ref) {
  return ref.watch(storedChatsProvider.select((value) => value.length));
}
