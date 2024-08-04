import 'package:diary_flutter/data/provider/chats_repository_provider.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chats_prompt_notifier.g.dart';

sealed class ChatsPromptState {
  const ChatsPromptState();
}

class ChatsPromptInitial extends ChatsPromptState {
  const ChatsPromptInitial();
}

class ChatsPromptData extends ChatsPromptState {
  final ChatsPromptResponse data;
  const ChatsPromptData(this.data);
}

class ChatsPromptError extends ChatsPromptState {
  final String error;
  final int? statusCode;
  const ChatsPromptError(this.error, this.statusCode);
}

@riverpod
class ChatsPromptNotifier extends _$ChatsPromptNotifier {
  static const String key = "id_token";

  @override
  AsyncValue<ChatsPromptState> build() {
    return const AsyncValue.data(ChatsPromptInitial());
  }

  Future<void> postPrompt({
    required ChatsRequestBody body,
  }) async {
    state = const AsyncValue.loading();
    final repository = ref.read(chatsRepositoryProvider);
    final persistanceStorage = ref.read(persistanceStorageProvider);

    try {
      final token = persistanceStorage.getValue<String>(key);
      if (token == null) {
        state = const AsyncValue.data(ChatsPromptError('No token found', null));
        return;
      }

      final response = await repository.postChatsPrompt(
        bearerToken: 'Bearer $token',
        body: body,
      );

      state = AsyncValue.data(ChatsPromptData(response));
    } catch (e, stackTrace) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        state = AsyncValue.data(
            ChatsPromptError(e.message ?? '에러메시지없음', statusCode));
      } else {
        state = AsyncValue.error(e, stackTrace);
      }
    }
  }
}
