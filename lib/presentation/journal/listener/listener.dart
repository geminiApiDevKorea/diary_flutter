import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class ListenerCallback {
  void call(WidgetRef ref);
}

void useListeners(BuildContext context, WidgetRef ref,
    List<ListenerCallback> listeners, List<Object?> dependencies) {
  useEffect(() {
    for (final listener in listeners) {
      listener.call(ref);
    }
    return null;
  }, dependencies);
}

class ChatFeedbackListener implements ListenerCallback {
  final DateTime nowDate;

  ChatFeedbackListener(this.nowDate);

  @override
  void call(WidgetRef ref) {
    ref.listen<AsyncValue<ChatsFeedbackState>>(
      chatsFeedbackNotifierProvider,
      (previous, next) => _handleChatFeedbackStateChange(ref, next),
    );
  }

  void _handleChatFeedbackStateChange(
      WidgetRef ref, AsyncValue<ChatsFeedbackState> state) {
    state.whenData((data) async {
      if (data is ChatsFeedbackData) {
        await _updateJournalWithFeedbackData(ref, data);
      }
    });
  }

  Future<void> _updateJournalWithFeedbackData(
      WidgetRef ref, ChatsFeedbackData data) async {
    final journal =
        await ref.read(myJournalStoreProvider.notifier).read(nowDate);
    if (journal != null) {
      final updatedJournal = _createUpdatedJournal(journal, data);
      await ref
          .read(myJournalStoreProvider.notifier)
          .createOrUpdate(updatedJournal);
    }
  }

  Journal _createUpdatedJournal(Journal journal, ChatsFeedbackData data) {
    return journal.copyWith(
      music: data.data.music,
      song: data.data.feedbackResponse.song,
    );
  }
}
