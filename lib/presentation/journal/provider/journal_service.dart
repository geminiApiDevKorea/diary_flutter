import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:diary_flutter/data/model/journal.dart';

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

  late DateTime _date;
  @override
  JournalState build({
    required JournalType journalType,
  }) {
    _date = DateTime.now();
    return const JournalInitial();
  }

  // onList 메서드 구현
  Future<void> onList() async {
    switch (journalType) {
      case JournalType.post:
        ref.read(myJournalStoreProvider.notifier).createOrUpdateUserInput(
            _date, ref.read(postTextInputProvider) ?? '', journalType);
      case JournalType.chat:
        ref.read(myJournalStoreProvider.notifier).createOrUpdateUserInput(
            _date, ref.read(postTextInputProvider) ?? '', journalType);
    }
  }

  // onDelete 메서드 구현
  Future<void> onDelete() async {
    switch (journalType) {
      case JournalType.post:
        ref.read(myJournalStoreProvider.notifier).delete(_date);

      case JournalType.chat:
        ref.read(myJournalStoreProvider.notifier).delete(_date);
    }
  }

  // onFinish 메서드 구현
  Future<void> onFinish() async {
    switch (journalType) {
      case JournalType.post:
        ref.read(myJournalStoreProvider.notifier).createOrUpdateUserInput(
            _date, ref.read(postTextInputProvider) ?? '', journalType);
        final journal =
            await ref.read(myJournalStoreProvider.notifier).read(_date);
        if (journal == null) {
          state = const JournalError('Journal not found');
          return;
        }
        state = JournalLoading();
        await ref.read(chatsFeedbackNotifierProvider.notifier).postFeedback(
            type: FeedbackType.post, body: journal.toChatsRequestBody());

        Print.blue('Finishing Post journal');
      case JournalType.chat:
        Print.blue('Finishing Chat journal');
    }
  }
}
