import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/provider/chats_repository_provider.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chats_feedback_notifier.g.dart';

sealed class ChatsFeedbackState {
  const ChatsFeedbackState();
}

class ChatsFeedbackInitial extends ChatsFeedbackState {
  const ChatsFeedbackInitial();
}

class ChatsFeedbackData extends ChatsFeedbackState {
  final ChatsFeedbackResponse data;
  const ChatsFeedbackData(this.data);
}

class ChatsFeedbackError extends ChatsFeedbackState {
  final String error;
  final int? statusCode;
  const ChatsFeedbackError(this.error, this.statusCode);
}

@riverpod
class ChatsFeedbackNotifier extends _$ChatsFeedbackNotifier {
  static const String key = "id_token";

  @override
  AsyncValue<ChatsFeedbackState> build() {
    return const AsyncValue.data(ChatsFeedbackInitial());
  }

  Future<void> postFeedback({
    required FeedbackType type,
    required ChatsRequestBody body,
  }) async {
    state = const AsyncValue.loading();
    final repository = ref.read(chatsRepositoryProvider);
    final persistanceStorage = ref.read(persistanceStorageProvider);

    try {
      final token = persistanceStorage.getValue<String>(key); // 토큰을 스토리지에서 가져옴
      if (token == null) {
        state =
            const AsyncValue.data(ChatsFeedbackError('No token found', null));
        return;
      }

      final response = await repository.postChatsFeedback(
        bearerToken: 'Bearer $token',
        type: type,
        body: body,
      );

      state = AsyncValue.data(ChatsFeedbackData(response));
    } catch (e, stackTrace) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        state = AsyncValue.data(
            ChatsFeedbackError(e.message ?? '에러메시지없음', statusCode));
      } else {
        state = AsyncValue.error(e, stackTrace);
      }
    }
  }
}
