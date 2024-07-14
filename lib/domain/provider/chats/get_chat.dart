import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/domain/provider/chats/stored_chats.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_chat.g.dart';

@riverpod
Chat getChat(GetChatRef ref, int index) {
  return ref.watch(storedChatsProvider.select((value) => value[index]));
}
