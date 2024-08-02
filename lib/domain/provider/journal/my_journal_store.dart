import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/model/song.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/domain/provider/journal/stored_journal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_journal_store.g.dart';

@riverpod
class MyJournalStore extends _$MyJournalStore {
  String get _idToken =>
      ref.read(persistanceStorageProvider).getValue<String>("id_token") ?? "";
  @override
  List<Journal> build() {
    final persistanceStorage = ref.watch(persistanceStorageProvider);
    // _idToken = persistanceStorage.getValue<String>("id_token") ?? "";

    // storedJournalProvider의 변경을 감지
    ref.listen(storedJournalProvider(_idToken), (previous, next) {
      // 상태가 변경되면 프로바이더를 새로고침
      print("MyJournalStore: storedJournalProvider changed");
      ref.invalidateSelf();
    });

    return ref.watch(storedJournalProvider(_idToken));
  }

  Future<void> createOrUpdate(Journal journal) async {
    ref.read(storedJournalProvider(_idToken).notifier).createOrUpdate(journal);
    ref.invalidateSelf();
  }

  Future<Journal?> read(DateTime date) async {
    return ref
        .read(storedJournalProvider(_idToken).notifier)
        .read(_idToken, date);
  }

  Future<void> delete(DateTime date) async {
    ref.read(storedJournalProvider(_idToken).notifier).delete(_idToken, date);
    ref.invalidateSelf();
  }

  Future<void> createOrUpdateUserInput(
      DateTime date, String newUserInput, JournalType journalType) async {
    ref
        .read(storedJournalProvider(_idToken).notifier)
        .createOrUpdateUserInput(_idToken, date, newUserInput, journalType);
    ref.invalidateSelf();
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
}
