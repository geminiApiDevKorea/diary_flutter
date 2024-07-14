import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/domain/provider/evaluate_feedback.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stored_feedback_target_chats.g.dart';

@Riverpod(keepAlive: true)
class StoredFeedbackTargetChats extends _$StoredFeedbackTargetChats {
  static const String key = "stored_feedback_target_chats";

  @override
  List<String> build() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    return persistanceStorage.getValue<List<String>>(key) ?? List.empty();
  }

  reset() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    persistanceStorage.removeValue(key);
    state = List.empty();
  }

  storeOnlyUser(Chat chat) {
    if (!chat.isUser) {
      return;
    }

    state = [
      ...state,
      chat.message,
    ];
    final persistanceStorage = ref.read(persistanceStorageProvider);
    persistanceStorage.setValue(
      key,
      state,
    );

    if (state.isNotEmpty) {
      ref.read(evaluateFeedbackProvider.notifier).generate(state);
    }
  }
}
