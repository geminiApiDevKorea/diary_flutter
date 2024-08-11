import 'dart:math';

import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/music.dart';
import 'package:diary_flutter/data/model/song.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'journal.g.dart';

@JsonSerializable(explicitToJson: true)
class Journal {
  final String? title;
  final String idToken;
  final DateTime createdAt;
  final String? userInput;
  final Music? music;
  final Song? song;
  final List<String> tags;
  final List<History> history;
  @JsonKey(name: 'type')
  final FeedbackType feedbackType;

  static Journal createDummy({
    required String idToken,
    required DateTime createdAt,
    required bool hasTitle,
    required bool hasMusicAndSong,
  }) {
    final random = Random();
    final index = random.nextInt(201); // 0-200 사이의 난수

    return Journal(
      title: hasTitle
          ? "Sample Journal Entry for ${createdAt.toString().split(' ')[0]}"
          : null,
      idToken: idToken,
      createdAt: createdAt,
      userInput:
          "This is a sample journal entry for ${createdAt.toString().split(' ')[0]}.",
      music: hasMusicAndSong
          ? Music(
              id: "music_$index",
              url: "https://example.com/music/$index",
              title: "Sample Music $index",
              description: "This is a sample music description",
              thumbnailUrl: "https://picsum.photos/200/200?random=$index",
            )
          : null,
      song: hasMusicAndSong
          ? Song(
              "Sample Song $index",
              "Sample Singer $index",
              "This is a sample reason for choosing this song",
            )
          : null,
      feedbackType: FeedbackType.post,
    );
  }

  Journal({
    this.title,
    required this.idToken,
    required this.createdAt,
    this.userInput,
    this.music,
    this.song,
    List<String>? tags,
    List<History>? history,
    required this.feedbackType,
  })  : tags = tags ?? [],
        history = history ?? [];

  factory Journal.fromJson(Map<String, dynamic> json) =>
      _$JournalFromJson(json);
  Map<String, dynamic> toJson() => _$JournalToJson(this);

  ChatsRequestBody toChatsRequestBody() {
    return ChatsRequestBody(
      userInput: userInput ?? '',
      histories: history,
    );
  }

  Journal copyWith({
    String? title,
    String? idToken,
    DateTime? createdAt,
    String? userInput,
    Music? music,
    Song? song,
    List<String>? tags,
    List<History>? history,
    FeedbackType? type,
  }) {
    return Journal(
      title: title ?? this.title,
      idToken: idToken ?? this.idToken,
      createdAt: createdAt ?? this.createdAt,
      userInput: userInput ?? this.userInput,
      music: music ?? this.music,
      song: song ?? this.song,
      tags: tags ?? this.tags,
      history: history ?? this.history,
      feedbackType: type ?? feedbackType,
    );
  }

  @override
  String toString() {
    return 'Journal(title: $title,  idToken: $idToken, createdAt: $createdAt, userInput: $userInput, music: $music, song: $song, tags: $tags, history: $history, type: $feedbackType)';
  }
}
