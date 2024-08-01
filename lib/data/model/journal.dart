import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/music.dart';
import 'package:diary_flutter/data/model/song.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'journal.g.dart';

@JsonEnum(alwaysCreate: true)
enum JournalType {
  @JsonValue('post')
  post,
  @JsonValue('chat')
  chat,
}

@JsonSerializable(explicitToJson: true)
class Journal {
  final String idToken;
  final DateTime createdAt;
  final String? userInput;
  final Music? music;
  final Song? song;
  final List<String>? tags;
  final List<History>? history;
  @JsonKey(name: 'type')
  final JournalType journalType;

  const Journal({
    required this.idToken,
    required this.createdAt,
    this.userInput,
    this.music,
    this.song,
    this.tags,
    this.history,
    required this.journalType,
  });

  factory Journal.fromJson(Map<String, dynamic> json) =>
      _$JournalFromJson(json);
  Map<String, dynamic> toJson() => _$JournalToJson(this);

  ChatsRequestBody toChatsRequestBody() {
    return ChatsRequestBody(
      userInput: userInput ?? '',
      histories: history ?? [],
    );
  }

  Journal copyWith({
    String? idToken,
    DateTime? createdAt,
    String? userInput,
    Music? music,
    Song? song,
    List<String>? tags,
    List<History>? history,
    JournalType? journalType,
  }) {
    return Journal(
      idToken: idToken ?? this.idToken,
      createdAt: createdAt ?? this.createdAt,
      userInput: userInput ?? this.userInput,
      music: music ?? this.music,
      song: song ?? this.song,
      tags: tags ?? this.tags,
      history: history ?? this.history,
      journalType: journalType ?? this.journalType,
    );
  }

  @override
  String toString() {
    return 'Journal(idToken: $idToken, createdAt: $createdAt, userInput: $userInput, music: $music, song: $song, tags: $tags, history: $history, type: $journalType)';
  }
}

// abstract class Journal {
//   final DateTime createdAt;
//   final String? userInput;
//   final List<String>? tags;

//   ///있으면 Fisnish를 한것 없으면 아직 드래프트상태
//   final Music? music;

//   const Journal({
//     required this.createdAt,
//     required this.userInput,
//     this.music,
//     this.tags,
//   });

//   ///오버라이드용
//   Map<String, dynamic> toJson();
// }

// @JsonSerializable(explicitToJson: true)
// class ChatJournal implements Journal {
//   @override
//   final DateTime createdAt;
//   @override
//   final String userInput;
//   @override
//   final Music? music;
//   @override
//   final List<String>? tags;
//   @override
//   final List<History>? history;

//   const ChatJournal({
//     required this.createdAt,
//     required this.userInput,
//     this.music,
//     this.tags,
//     this.history,
//   });

//   factory ChatJournal.fromJson(Map<String, dynamic> json) =>
//       _$ChatJournalFromJson(json);
//   @override
//   Map<String, dynamic> toJson() => _$ChatJournalToJson(this);

//   @override
//   String toString() {
//     return 'MusicJournal(createdAt: $createdAt, userInput: $userInput, music: $music, tags: $tags)';
//   }
// }

// @JsonSerializable(explicitToJson: true)
// class PostJournal implements Journal {
//   @override
//   final DateTime createdAt;
//   @override
//   final String userInput;
//   @override
//   final Music? music;
//   @override
//   final List<String>? tags;

//   const PostJournal({
//     required this.createdAt,
//     required this.userInput,
//     this.music,
//     this.tags,
//   });

//   factory PostJournal.fromJson(Map<String, dynamic> json) =>
//       _$PostJournalFromJson(json);
//   @override
//   Map<String, dynamic> toJson() => _$PostJournalToJson(this);

//   @override
//   String toString() {
//     return 'PostJournal(createdAt: $createdAt, userInput: $userInput, music: $music, tags: $tags)';
//   }
// }
