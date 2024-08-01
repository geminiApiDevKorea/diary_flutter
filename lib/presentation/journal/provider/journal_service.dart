import 'dart:convert';
import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/provider/chats_repository_provider.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:collection/collection.dart';

part 'journal_service.g.dart';

// JournalState 상태를 정의하는 sealed class입니다.
sealed class JournalState {
  const JournalState();
}

// 초기 상태를 나타내는 클래스입니다.
class JournalInitial extends JournalState {
  const JournalInitial();
}

// 저널이 로드된 상태를 나타내는 클래스입니다.
class JournalLoaded extends JournalState {
  final Journal? journal;
  const JournalLoaded(this.journal);
}

// 오류 상태를 나타내는 클래스입니다.
class JournalError extends JournalState {
  final String message;
  const JournalError(this.message);
}

// // 새로운 상태: 피드백 제출 완료
// class JournalFeedbackSubmitted extends JournalState {
//   final Journal? journal;
//   const JournalFeedbackSubmitted(this.journal);
// }

// Riverpod의 @riverpod 어노테이션을 사용하여 저널 서비스를 정의합니다.
@riverpod
class JournalService extends _$JournalService {
  static const String journalKey = 'journals';
  static const String idTokenKey = 'id_token';
  // Journal? _tempJournalBackup; // 상태 백업을 위한 변수
  // build 메서드는 초기 상태로 JournalInitial을 반환합니다.
  @override
  AsyncValue<JournalState> build({
    required JournalType journalType,
    // required DateTime date,
    // required String idToken,
  }) {
    ref.listen<AsyncValue<ChatsFeedbackState>>(chatsFeedbackNotifierProvider,
        (previous, next) {
      next.whenData((state) {
        // 피드백 제출이 완료되면 필요한 추가 작업을 수행할 수 있습니다.
        Print.green('Feedback submitted successfully');
      });
    });
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final idToken = persistanceStorage.getValue<String>(idTokenKey);
    if (idToken == null) {
      Print.red('No token found');
      return const AsyncValue.data(JournalError('No token found'));
    }
    final date = DateTime.now();
    return _initializeJournal(date, idToken);
    // return const AsyncValue.data(JournalInitial());
  }

  // 주어진 날짜와 idToken을 사용하여 저널 데이터를 초기화합니다.
  AsyncValue<JournalState> _initializeJournal(DateTime date, String idToken) {
    try {
      final storage = ref.read(persistanceStorageProvider);
      final journalsStringList = storage.getValue<List<String>>(journalKey);
      Print.yellow('journalsStringList: $journalsStringList');

      if (journalsStringList != null) {
        final journals = journalsStringList
            .map((jsonString) => Journal.fromJson(jsonDecode(jsonString)))
            .toList();
        final journal = journals.firstWhereOrNull(
          (journal) =>
              _isSameDay(journal.createdAt, date) && journal.idToken == idToken,
        );
        if (journal == null) {
          return const AsyncValue.data(JournalLoaded(null));
        }
        Print.white('journal: $journal');
        if (journal.song != null || journal.music != null) {
          return AsyncValue.data(JournalLoaded(journal));
        }
        return AsyncValue.data(JournalLoaded(journal));
      } else {
        Print.white('No journals found');
        return const AsyncValue.data(JournalLoaded(null));
      }
    } catch (e) {
      Print.red('Error in _initializeJournal: $e');
      return AsyncValue.data(JournalError(e.toString()));
    }
  }

  // 두 날짜가 같은 날인지 확인하는 메서드입니다.
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // 사용자의 입력을 설정하는 메서드입니다.
  Future<void> setUserInput(String input) async {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final idToken = persistanceStorage.getValue<String>(idTokenKey);
    final now = DateTime.now();

    state.whenData((journalState) {
      if (journalState is JournalLoaded) {
        final updatedJournal = (journalState.journal ??
                Journal(
                    idToken: idToken!,
                    createdAt: now,
                    journalType: journalType))
            .copyWith(userInput: input);
        state = AsyncValue.data(
            JournalLoaded(updatedJournal)); // 업데이트된 저널을 상태로 설정합니다.
      }
    });
  }

  // 저널의 히스토리를 설정하는 메서드입니다.
  Future<void> setHistories(List<History> histories) async {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final idToken = persistanceStorage.getValue<String>(idTokenKey);
    final now = DateTime.now();

    state.whenData((journalState) {
      if (journalState is JournalLoaded) {
        final updatedJournal = (journalState.journal ??
                Journal(
                    idToken: idToken!,
                    createdAt: now,
                    journalType: journalType))
            .copyWith(history: histories);
        state = AsyncValue.data(
            JournalLoaded(updatedJournal)); // 업데이트된 저널을 상태로 설정합니다.
      }
    });
  }

  // 현재 저널을 저장하는 메서드입니다.
  Future<void> saveJournal() async {
    state.whenData((journalState) async {
      if (journalState is JournalLoaded) {
        final now = DateTime.now();
        final persistanceStorage = ref.read(persistanceStorageProvider);
        final idToken = persistanceStorage.getValue<String>(idTokenKey);
        // Print.white(idToken ?? 'No token found');
        if (idToken == null) {
          state = const AsyncValue.data(JournalError('No token found'));
          return;
        }
        final updatedJournal = (journalState.journal ??
                Journal(
                  idToken: idToken,
                  createdAt: now,
                  journalType: journalType,
                ))
            .copyWith(
          createdAt: now,
        );
        Print.blue(updatedJournal.toString());
        await _saveJournalToStorage(updatedJournal);
      }
    });
  }

  // 저널을 저장소에 저장하는 실제 메서드입니다.
  Future<void> _saveJournalToStorage(Journal journal) async {
    try {
      final storage = ref.read(persistanceStorageProvider); // 저장소 인스턴스를 가져옵니다.
      final journalsStringList = storage.getValue<List<String>>(journalKey) ??
          []; // 저장소에서 저널 리스트를 가져옵니다.

      // 가져온 저널 리스트를 디코딩하여 Journal 객체 리스트로 변환합니다.
      List<Journal> journals = journalsStringList
          .map((jsonString) => Journal.fromJson(jsonDecode(jsonString)))
          .toList();

      // 동일한 날짜와 idToken을 가진 저널의 인덱스를 찾습니다.
      final index = journals.indexWhere((j) =>
          _isSameDay(j.createdAt, journal.createdAt) &&
          j.idToken == journal.idToken);

      // 동일한 저널이 있으면 업데이트하고, 없으면 새로 추가합니다.
      if (index != -1) {
        journals[index] = journal;
      } else {
        journals.add(journal);
      }

      // 업데이트된 저널 리스트를 JSON 문자열 리스트로 변환합니다.
      final updatedJournalsStringList =
          journals.map((j) => jsonEncode(j.toJson())).toList();

      // 저장소에 업데이트된 저널 리스트를 저장합니다.
      storage.setValue<List<String>>(journalKey, updatedJournalsStringList);
      Print.cyan(journal.toString());
      state = AsyncValue.data(JournalLoaded(journal)); // 상태를 업데이트된 저널로 설정합니다.
    } catch (e) {
      Print.red(
          'Error in _saveJournalToStorage: $e'); // 오류가 발생하면 오류 메시지를 출력합니다.
      state = AsyncValue.data(JournalError(e.toString())); // 상태를 오류로 설정합니다.
    }
  }

  // 현재 저널을 삭제하는 메서드입니다.
  Future<void> deleteJournal() async {
    state.whenData((journalState) {
      if (journalState is JournalLoaded && journalState.journal != null) {
        // 저널을 저장소에서 삭제합니다.
        _deleteJournalFromStorage(journalState.journal!);
      }
    });
  }

  // 저널을 저장소에서 삭제하는 실제 메서드입니다.
  Future<void> _deleteJournalFromStorage(Journal journal) async {
    try {
      final storage = ref.read(persistanceStorageProvider); // 저장소 인스턴스를 가져옵니다.
      final journalsStringList = storage.getValue<List<String>>(journalKey) ??
          []; // 저장소에서 저널 리스트를 가져옵니다.

      // 가져온 저널 리스트를 디코딩하여 Journal 객체 리스트로 변환합니다.
      List<Journal> journals = journalsStringList
          .map((jsonString) => Journal.fromJson(jsonDecode(jsonString)))
          .toList();

      // 동일한 날짜와 idToken을 가진 저널을 리스트에서 제거합니다.
      journals.removeWhere((j) =>
          _isSameDay(j.createdAt, journal.createdAt) &&
          j.idToken == journal.idToken);

      // 업데이트된 저널 리스트를 JSON 문자열 리스트로 변환합니다.
      final updatedJournalsStringList =
          journals.map((j) => jsonEncode(j.toJson())).toList();

      // 저장소에 업데이트된 저널 리스트를 저장합니다.
      storage.setValue<List<String>>(journalKey, updatedJournalsStringList);
      state = const AsyncValue.data(JournalLoaded(null)); // 상태를 null로 설정합니다.
    } catch (e) {
      Print.red(
          'Error in _deleteJournalFromStorage: $e'); // 오류가 발생하면 오류 메시지를 출력합니다.
      state = AsyncValue.data(JournalError(e.toString())); // 상태를 오류로 설정합니다.
    }
  }

  /// 수동으로 Journal 객체를 저장합니다.
  ///
  /// [journal] 저장할 Journal 객체
  ///
  /// 이 메서드는 주어진 Journal 객체를 그대로 저장소에 저장합니다.
  /// 기존에 동일한 날짜와 ID를 가진 저널이 있다면 덮어씁니다.
  void saveManualJournal(Journal journal) {
    try {
      _saveJournalToStorage(journal);
      state = AsyncValue.data(JournalLoaded(journal));
    } catch (e) {
      Print.red('Error in saveManualJournal: $e');
      state = AsyncValue.data(JournalError(e.toString()));
    }
  }

  /// ID와 DateTime을 수동으로 지정하여 Journal을 삭제합니다.
  ///
  /// [idToken] 삭제할 저널의 고유 ID
  /// [dateTime] 삭제할 저널의 생성 날짜 및 시간
  ///
  /// 이 메서드는 주어진 ID와 DateTime에 해당하는 Journal을 찾아 삭제합니다.
  /// 해당하는 저널이 없는 경우, 작업은 무시되고 상태는 변경되지 않습니다.
  /// 삭제 성공 시 상태는 JournalLoaded(null)로 업데이트됩니다.
  void deleteJournalByIdAndDate({
    required String idToken,
    required DateTime dateTime,
  }) {
    try {
      final storage = ref.read(persistanceStorageProvider);
      final journalsStringList =
          storage.getValue<List<String>>(journalKey) ?? [];

      List<Journal> journals = journalsStringList
          .map((jsonString) => Journal.fromJson(jsonDecode(jsonString)))
          .toList();

      final initialLength = journals.length;
      journals.removeWhere(
          (j) => _isSameDay(j.createdAt, dateTime) && j.idToken == idToken);

      if (journals.length < initialLength) {
        // 저널이 삭제되었음
        final updatedJournalsStringList =
            journals.map((j) => jsonEncode(j.toJson())).toList();

        storage.setValue<List<String>>(journalKey, updatedJournalsStringList);
        state = const AsyncValue.data(JournalLoaded(null));
        Print.green('Journal deleted successfully');
      } else {
        // 삭제할 저널을 찾지 못함
        Print.yellow('No journal found with the given ID and date');
      }
    } catch (e) {
      Print.red('Error in deleteJournalByIdAndDate: $e');
      state = AsyncValue.data(JournalError(e.toString()));
    }
  }

  Future<void> submitJournal() async {
    // 1. 먼저 현재 저널을 저장합니다.
    await saveJournal();

    // 2. 상태를 로딩으로 변경합니다.
    state = const AsyncValue.loading();

    final repository = ref.read(chatsRepositoryProvider);
    final persistanceStorage = ref.read(persistanceStorageProvider);

    try {
      final idToken = persistanceStorage.getValue<String>(idTokenKey);
      if (idToken == null) {
        state = const AsyncValue.data(JournalError('No token found'));
        return;
      }

      // 3. 현재 시간을 기준으로 저장된 저널을 가져옵니다.
      final now = DateTime.now();
      final journalsStringList =
          persistanceStorage.getValue<List<String>>(journalKey) ?? [];
      final journals = journalsStringList
          .map((jsonString) => Journal.fromJson(jsonDecode(jsonString)))
          .toList();

      final currentJournal = journals.firstWhereOrNull(
        (journal) =>
            _isSameDay(journal.createdAt, now) && journal.idToken == idToken,
      );

      if (currentJournal == null) {
        state =
            const AsyncValue.data(JournalError('Current journal not found'));
        return;
      }

      // 4. 가져온 저널 데이터로 피드백을 제출합니다.
      try {
        final body = currentJournal.toChatsRequestBody();
        Print.white(body.toString());
        final response = await repository.postChatsFeedback(
            bearerToken: 'Bearer $idToken',
            type: FeedbackType.post,
            body: currentJournal.toChatsRequestBody());

        final updatedJournal = currentJournal.copyWith(
            song: response.chatPromptResponse.song, music: response.music);

        Print.green(response.toString());

        // 5. updatedJournal을 저장합니다.
        await _saveJournalToStorage(updatedJournal);

        // 6. 성공적으로 피드백을 제출한 경우 상태를 업데이트합니다.
        state = AsyncValue.data(JournalLoaded(updatedJournal));
      } catch (e) {
        Print.red('Error in submitFeedback: $e');
        state = AsyncValue.data(JournalError(e.toString()));
        return;
      }
    } catch (e) {
      Print.red('Error in submitFeedback: $e');
      state = AsyncValue.data(JournalError(e.toString()));
    }
  }
}
