import 'dart:convert';
import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/data/model/chat_metadata.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/domain/provider/chats/stored_feedback_target_chats.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stored_chats.g.dart';

@Riverpod(keepAlive: true)
class StoredChats extends _$StoredChats {
  static const String key = "chats";

  void store(Chat chat) {
    state = [
      ...state,
      chat,
    ];
    final persistanceStorage = ref.read(persistanceStorageProvider);
    persistanceStorage.setValue(
      key,
      state.map((e) => jsonEncode(e.toJson())).toList(),
    );

    ref.read(storedFeedbackTargetChatsProvider.notifier).storeOnlyUser(chat);
  }

  void accept(Chat chat, bool isAccept) {
    var chatMetadata = chat.chatMetadata;
    if (chatMetadata is AskFeedbackMetadata) {
      state = state.map((e) {
        if (e.createdAt == chat.createdAt) {
          return e.copyWith(
            chatMetadata: chatMetadata.copyWith(didAccept: isAccept),
          );
        } else {
          return e;
        }
      }).toList();
      final persistanceStorage = ref.read(persistanceStorageProvider);
      persistanceStorage.setValue(
        key,
        state.map((e) => jsonEncode(e.toJson())).toList(),
      );
    }
  }

  @override
  List<Chat> build() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final jsonStringList = persistanceStorage.getValue<List<String>>(key);
    if (jsonStringList == null) {
      return List.empty();
    } else {
      return jsonStringList
          .map((jsonString) => Chat.fromJson(jsonDecode(jsonString)))
          .toList();
    }
  }
}
