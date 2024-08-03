import 'dart:convert';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/model/song.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'stored_journal.g.dart';

/// 영구 저장소에 저널 데이터를 저장하고 관리하는 클래스입니다.
@riverpod
class StoredJournal extends _$StoredJournal {
  static const String key = "journals";

  /// 두 날짜가 같은 날인지 확인합니다.
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// 저널을 생성하거나 업데이트합니다.
  ///
  /// [journal] - 생성하거나 업데이트할 저널 객체
  Future<void> createOrUpdate(Journal journal) async {
    final allJournals = _getAllJournals();
    final index = allJournals.indexWhere((j) =>
        j.idToken == journal.idToken &&
        _isSameDay(j.createdAt, journal.createdAt));

    if (index != -1) {
      allJournals[index] = journal;
    } else {
      allJournals.add(journal);
    }

    _saveToStorage(allJournals);
  }

  /// 특정 날짜와 ID 토큰에 해당하는 저널을 읽습니다.
  ///
  /// [idToken] - 저널의 ID 토큰
  /// [date] - 저널의 생성 날짜
  ///
  /// 반환값: 해당 날짜와 ID 토큰에 해당하는 저널 객체 또는 null
  Future<Journal?> read(String idToken, DateTime date) async {
    final allJournals = _getAllJournals();
    return allJournals.firstWhereOrNull(
      (j) => j.idToken == idToken && _isSameDay(j.createdAt, date),
    );
  }

  /// 특정 날짜와 ID 토큰에 해당하는 저널을 삭제합니다.
  ///
  /// [idToken] - 저널의 ID 토큰
  /// [date] - 저널의 생성 날짜
  Future<void> delete(String idToken, DateTime date) async {
    final allJournals = _getAllJournals();
    allJournals.removeWhere(
        (j) => j.idToken == idToken && _isSameDay(j.createdAt, date));
    _saveToStorage(allJournals);
  }

  /// 특정 날짜와 ID 토큰에 해당하는 저널의 사용자 입력을 생성하거나 업데이트합니다.
  ///
  /// [idToken] - 저널의 ID 토큰
  /// [date] - 저널의 생성 날짜
  /// [newUserInput] - 업데이트할 사용자 입력
  /// [journalType] - 저널의 타입
  Future<void> createOrUpdateUserInput(String idToken, DateTime date,
      String? newUserInput, JournalType journalType) async {
    final allJournals = _getAllJournals();
    final index = allJournals.indexWhere(
        (j) => j.idToken == idToken && _isSameDay(j.createdAt, date));

    if (index != -1) {
      // 기존 저널이 존재하면 userInput 업데이트
      allJournals[index] = allJournals[index].copyWith(userInput: newUserInput);
    } else {
      // 해당 날짜의 저널이 없으면 새로 생성
      allJournals.add(Journal(
        idToken: idToken,
        createdAt: date,
        userInput: newUserInput ?? '',
        journalType: journalType, // 기본 타입으로 설정
      ));
    }

    _saveToStorage(allJournals);
  }

  /// 특정 날짜와 ID 토큰에 해당하는 저널의 노래 정보를 업데이트합니다.
  ///
  /// [idToken] - 저널의 ID 토큰
  /// [date] - 저널의 생성 날짜
  /// [newSong] - 업데이트할 새로운 노래 정보
  Future<void> updateSong(String idToken, DateTime date, Song newSong) async {
    final allJournals = _getAllJournals();
    final index = allJournals.indexWhere(
        (j) => j.idToken == idToken && _isSameDay(j.createdAt, date));
    if (index != -1) {
      allJournals[index] = allJournals[index].copyWith(song: newSong);
      _saveToStorage(allJournals);
    }
  }

  /// 특정 날짜와 ID 토큰에 해당하는 저널의 히스토리를 추가합니다.
  ///
  /// [idToken] - 저널의 ID 토큰
  /// [date] - 저널의 생성 날짜
  /// [history] - 추가할 히스토리 객체
  Future<void> addHistory(
      String idToken, DateTime date, History history) async {
    final allJournals = _getAllJournals();
    final index = allJournals.indexWhere(
        (j) => j.idToken == idToken && _isSameDay(j.createdAt, date));
    if (index != -1) {
      final updatedHistory = [...?allJournals[index].history, history];
      allJournals[index] = allJournals[index].copyWith(history: updatedHistory);
      _saveToStorage(allJournals);
    }
  }

  /// 특정 날짜와 ID 토큰에 해당하는 저널의 특정 인덱스의 히스토리를 업데이트합니다.
  ///
  /// [idToken] - 저널의 ID 토큰
  /// [date] - 저널의 생성 날짜
  /// [index] - 업데이트할 히스토리의 인덱스
  /// [newHistory] - 새로운 히스토리 객체
  Future<void> updateHistory(
      String idToken, DateTime date, int index, History newHistory) async {
    final allJournals = _getAllJournals();
    final journalIndex = allJournals.indexWhere(
        (j) => j.idToken == idToken && _isSameDay(j.createdAt, date));
    if (journalIndex != -1 &&
        allJournals[journalIndex].history != null &&
        index < allJournals[journalIndex].history!.length) {
      final updatedHistory =
          List<History>.from(allJournals[journalIndex].history!);
      updatedHistory[index] = newHistory;
      allJournals[journalIndex] =
          allJournals[journalIndex].copyWith(history: updatedHistory);
      _saveToStorage(allJournals);
    }
  }

  /// 특정 날짜와 ID 토큰에 해당하는 저널의 특정 인덱스의 히스토리를 삭제합니다.
  ///
  /// [idToken] - 저널의 ID 토큰
  /// [date] - 저널의 생성 날짜
  /// [index] - 삭제할 히스토리의 인덱스
  Future<void> deleteHistory(String idToken, DateTime date, int index) async {
    final allJournals = _getAllJournals();
    final journalIndex = allJournals.indexWhere(
        (j) => j.idToken == idToken && _isSameDay(j.createdAt, date));
    if (journalIndex != -1 &&
        allJournals[journalIndex].history != null &&
        index < allJournals[journalIndex].history!.length) {
      final updatedHistory =
          List<History>.from(allJournals[journalIndex].history!);
      updatedHistory.removeAt(index);
      allJournals[journalIndex] =
          allJournals[journalIndex].copyWith(history: updatedHistory);
      _saveToStorage(allJournals);
    }
  }

  /// 주어진 저널 리스트를 영구 저장소에 저장합니다.
  ///
  /// [journals] - 저장할 저널 리스트
  Future<void> _saveToStorage(List<Journal> journals) async {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    persistanceStorage.setValue(
      key,
      journals.map((journal) => jsonEncode(journal.toJson())).toList(),
    );

    /// 영구 저장소에 저장된 데이터가 변경되었음을 알립니다.
    /// 중요! 이 메서드는 반드시 호출되어야 합니다.
    ref.invalidateSelf();
  }

  /// 영구 저장소에서 모든 저널을 가져옵니다.
  ///
  /// 반환값: 모든 저널 리스트
  List<Journal> _getAllJournals() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final journalJsonList = persistanceStorage.getValue<List<String>>(key);
    if (journalJsonList == null) {
      return [];
    } else {
      return journalJsonList
          .map((jsonString) => Journal.fromJson(jsonDecode(jsonString)))
          .toList();
    }
  }

  /// 주어진 ID 토큰에 해당하는 모든 저널을 가져옵니다.
  ///
  /// [idToken] - 저널의 ID 토큰
  ///
  /// 반환값: 주어진 ID 토큰에 해당하는 모든 저널 리스트
  @override
  List<Journal> build(String idToken) {
    return _getAllJournals()
        .where((journal) => journal.idToken == idToken)
        .toList();
  }
}
