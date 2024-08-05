import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/provider/diary_repository_provider.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'journal_use_cases.g.dart';

/// 1. 내 최신 저널 얻기
@riverpod
Journal? getMyLatestJournal(GetMyLatestJournalRef ref) {
  final myJournals = ref.watch(myJournalStoreProvider);
  if (myJournals.isEmpty) return null;

  return myJournals.reduce((a, b) => a.createdAt.isAfter(b.createdAt) ? a : b);
}

/// 2. 내 저널 전부 얻기
@riverpod
List<Journal> getAllMyJournals(GetAllMyJournalsRef ref) {
  return ref.watch(myJournalStoreProvider);
}

/// 3. 특정 날짜의 내 저널 얻기
@riverpod
Journal? getMyJournalByDate(GetMyJournalByDateRef ref, DateTime date) {
  final myJournals = ref.watch(myJournalStoreProvider);
  return myJournals.firstWhereOrNull(
    (j) => _isSameDay(j.createdAt, date),
  );
}

/// 4. 내 저널의 길이 알기
@riverpod
int getMyJournalCount(GetMyJournalCountRef ref) {
  return ref.watch(myJournalStoreProvider).length;
}

/// 5. 특정 날짜의 내 저널 내 히스토리 알기
@riverpod
List<History>? getMyJournalHistoryByDate(
    GetMyJournalHistoryByDateRef ref, DateTime date) {
  final myJournals = ref.watch(myJournalStoreProvider);
  final journal = myJournals.firstWhereOrNull(
    (j) => _isSameDay(j.createdAt, date),
  );
  return journal?.history;
}

/// 6. music과 Song이 있는 내 저널 모두 받기
@riverpod
List<Journal> getJournalsWithMusicAndSong(GetJournalsWithMusicAndSongRef ref) {
  final myJournals = ref.watch(myJournalStoreProvider);
  return myJournals
      .where((journal) => journal.music != null && journal.song != null)
      .toList();
}

/// 7. music과 Song이 있는 내 저널 갯수 받기
@riverpod
int getJournalsWithMusicAndSongCount(GetJournalsWithMusicAndSongCountRef ref) {
  final myJournals = ref.watch(myJournalStoreProvider);
  return myJournals
      .where((journal) => journal.music != null && journal.song != null)
      .length;
}

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
