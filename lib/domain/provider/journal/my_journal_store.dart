import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/model/song.dart';
import 'package:diary_flutter/domain/provider/auth/get_my_id_token.dart';
import 'package:diary_flutter/domain/provider/journal/stored_journal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_journal_store.g.dart';

@riverpod
class MyJournalStore extends _$MyJournalStore {
  String get _idToken => ref.read(getMyIdTokenProvider);

  @override
  List<Journal> build() {
    // Print.white('MyJournalStore build');
    return ref.watch(storedJournalProvider(_idToken));
  }

  Future<void> createOrUpdate(Journal journal) async {
    ref.read(storedJournalProvider(_idToken).notifier).createOrUpdate(journal);
  }

  Future<Journal?> read(DateTime date) async {
    return ref
        .read(storedJournalProvider(_idToken).notifier)
        .read(_idToken, date);
  }

  Future<void> delete(DateTime date) async {
    await ref
        .read(storedJournalProvider(_idToken).notifier)
        .delete(_idToken, date);
  }

  Future<void> createOrUpdateUserInput(
      DateTime date, String newUserInput, JournalType journalType) async {
    ref
        .read(storedJournalProvider(_idToken).notifier)
        .createOrUpdateUserInput(_idToken, date, newUserInput, journalType);
  }

  Future<void> updateSong(DateTime date, Song newSong) async {
    ref
        .read(storedJournalProvider(_idToken).notifier)
        .updateSong(_idToken, date, newSong);
  }

  Future<void> addHistory(DateTime date, History history) async {
    ref
        .read(storedJournalProvider(_idToken).notifier)
        .addHistory(_idToken, date, history);
  }

  Future<void> updateHistory(
      DateTime date, int index, History newHistory) async {
    ref
        .read(storedJournalProvider(_idToken).notifier)
        .updateHistory(_idToken, date, index, newHistory);
  }

  Future<void> deleteHistory(DateTime date, int index) async {
    ref
        .read(storedJournalProvider(_idToken).notifier)
        .deleteHistory(_idToken, date, index);
  }

  Future<Journal?> createDummyJournal() async {
    return ref
        .read(storedJournalProvider(_idToken).notifier)
        .createDummyJournal(_idToken);
  }

  Future<void> deleteAllJournals() async {
    await ref
        .read(storedJournalProvider(_idToken).notifier)
        .deleteAllJournals(_idToken);
  }

  Future<void> createOrUpdateTitle(
      DateTime date, String newTitle, JournalType journalType) async {
    await ref
        .read(storedJournalProvider(_idToken).notifier)
        .createOrUpdateTitle(_idToken, date, newTitle, journalType);
  }
}
