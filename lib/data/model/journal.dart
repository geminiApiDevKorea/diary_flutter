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

  static List<Journal> createTutorial({required String idToken}) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final availableDays = List.generate(daysInMonth, (index) => index + 1)
      ..remove(now.day);
    availableDays.shuffle();

    final tutorialData = [
      {
        "title": "A Splash of Color",
        "content":
            "Today, I experimented with vibrant color palettes for a new app design. The blend of neon and pastel was challenging but thrilling. It's amazing how colors can evoke emotions.",
        "url": "https://www.youtube.com/watch?v=CWYA99Zb13Y"
      },
      {
        "title": "Video Inspiration",
        "content":
            "Watched a documentary about retro film techniques. The use of grain and light leaks sparked ideas for a nostalgic UI theme. I'm excited to incorporate these elements into my next project.",
        "url": "https://www.youtube.com/watch?v=NwFVSclD_uc"
      },
      {
        "title": "Tech Meets Fashion",
        "content":
            "Attended a fashion-tech conference. The integration of smart fabrics into everyday wear was mind-blowing. It made me rethink how we could blend technology with aesthetics in UI design.",
        "url": "https://www.youtube.com/watch?v=u0cS1FaKPWY"
      },
      {
        "title": "Daily Dose of Coffee",
        "content":
            "Stopped by my favorite café for a quick coffee. The minimalist interior always inspires clean, crisp design ideas. Sometimes, simplicity truly is the ultimate sophistication.",
        "url": "https://www.youtube.com/watch?v=ik_BQYbbZ5U"
      },
      {
        "title": "Sketching New Ideas",
        "content":
            "Spent the afternoon sketching new interface concepts on my tablet. The fluidity of digital drawing tools never ceases to amaze me. A few rough ideas are already turning into something tangible.",
        "url": "https://www.youtube.com/watch?v=13EifDb4GYs"
      }
    ];

    return List.generate(5, (index) {
      final day = availableDays[index];
      final data = tutorialData[index];
      return Journal(
        title: data["title"],
        idToken: idToken,
        createdAt: DateTime(now.year, now.month, day),
        userInput: data["content"],
        music: Music(
          id: "music_$index",
          url: data["url"]!,
          title: "Tutorial Music ${index + 1}",
          description: "Music for ${data["title"]}",
          thumbnailUrl:
              "https://img.youtube.com/vi/${data["url"]!.split('v=')[1]}/0.jpg",
        ),
        song: Song(
          "Tutorial Song ${index + 1}",
          "Tutorial Artist",
          "This song matches the mood of your journal entry.",
        ),
        feedbackType: FeedbackType.post,
        tags: ["tutorial", "design", "inspiration"],
      );
    });
  }

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
