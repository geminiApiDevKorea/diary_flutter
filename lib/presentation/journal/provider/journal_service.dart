import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/diary/diary_use_cases.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/journal/provider/feedback_active.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_service.g.dart';

// JournalState 상태를 정의하는 sealed class입니다.
sealed class JournalState {
  const JournalState();
}

// 초기 상태를 나타내는 클래스입니다.
class JournalInitial extends JournalState {
  const JournalInitial();
}

// 저널이 로딩 상태를 나타내는 클래스입니다.
class JournalLoading extends JournalState {}

// 오류 상태를 나타내는 클래스입니다.
class JournalError extends JournalState {
  final String message;
  const JournalError(this.message);
}

@riverpod
class JournalService extends _$JournalService {
  static const String journalKey = 'journals';
  static const String idTokenKey = 'id_token';
  // Journal? _tempJournalBackup; // 상태 백업을 위한 변수
  // build 메서드는 초기 상태로 JournalInitial을 반환합니다.

  @override
  JournalState build({
    required FeedbackType feedbackType,
    required DateTime focusedDate,
  }) {
    return const JournalInitial();
  }

  // onList 메서드 구현
  Future<void> onList() async {
    switch (feedbackType) {
      case FeedbackType.post:
        final hasFeedback = ref.read(hasFeedbackProvider(focusedDate));
        if (hasFeedback) return;
        ref.read(myJournalStoreProvider.notifier).createOrUpdateUserInput(
            focusedDate, ref.read(postTextInputProvider) ?? '', feedbackType);
      case FeedbackType.chat:
        final hasFeedback = ref.read(hasFeedbackProvider(focusedDate));
        if (hasFeedback) return;
        ref.read(myJournalStoreProvider.notifier).createOrUpdateUserInput(
            focusedDate, ref.read(postTextInputProvider) ?? '', feedbackType);
    }
  }

  // onDelete 메서드 구현
  Future<void> onDelete() async {
    switch (feedbackType) {
      case FeedbackType.post:
        ref.read(myJournalStoreProvider.notifier).delete(focusedDate);

      case FeedbackType.chat:
        ref.read(myJournalStoreProvider.notifier).delete(focusedDate);
    }
  }

  // onSave 메서드 구현
  Future<void> onSave(
      {required String newTitle, required FeedbackType feedbackType}) async {
    switch (feedbackType) {
      case FeedbackType.post:
        await ref.read(myJournalStoreProvider.notifier).createOrUpdateUserInput(
            focusedDate, ref.read(postTextInputProvider) ?? '', feedbackType);
        await ref
            .read(myJournalStoreProvider.notifier)
            .createOrUpdateTitle(focusedDate, newTitle, feedbackType);
        final journal =
            await ref.read(myJournalStoreProvider.notifier).read(focusedDate);
        Print.yellow('Journal: $journal');
        if (journal == null) {
          state = const JournalError('Journal not found');
          return;
        }
        state = JournalLoading();
        final isFeedbackActive = ref.read(feedbackActiveProvider);
        if (!isFeedbackActive) {
          state = const JournalInitial();
          return;
        }
        final response =
            await ref.read(chatsFeedbackNotifierProvider.notifier).postFeedback(
                  type: FeedbackType.post,
                  body: journal.toChatsRequestBody(),
                );
        if (response != null) {
          ref.read(
            postDiaryProvider(
              chatsFeedbackResponse: response,
              journal: journal,
            ),
          );
        }

        Print.blue('Finishing Post journal');
      case FeedbackType.chat:
        await ref
            .read(myJournalStoreProvider.notifier)
            .createOrUpdateUserInput(focusedDate, 'yes, please', feedbackType);
        await ref
            .read(myJournalStoreProvider.notifier)
            .createOrUpdateTitle(focusedDate, newTitle, feedbackType);
        final journal =
            await ref.read(myJournalStoreProvider.notifier).read(focusedDate);
        Print.yellow('Journal: $journal');
        if (journal == null) {
          state = const JournalError('Journal not found');
          return;
        }
        state = JournalLoading();
        final isFeedbackActive = ref.read(feedbackActiveProvider);
        if (!isFeedbackActive) {
          state = const JournalInitial();
          return;
        }
        final response = await ref
            .read(chatsFeedbackNotifierProvider.notifier)
            .postFeedback(
              type: FeedbackType.post,
              body: journal.toChatsRequestBody(),
            )
            .then((value) => value);
        if (response != null) {
          ref.read(
            postDiaryProvider(
              chatsFeedbackResponse: response,
              journal: journal,
            ),
          );
        }
    }
  }
}
