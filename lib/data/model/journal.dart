import 'package:diary_flutter/data/model/music.dart';
import 'package:json_annotation/json_annotation.dart';

part 'journal.g.dart';

abstract class Journal {
  final DateTime createdAt;
  final String title;

  ///있으면 Fisnish를 한것 없으면 아직 드래프트상태
  final Music? music;
  final List<String>? tags;

  const Journal({
    required this.createdAt,
    required this.title,
    this.music,
    this.tags,
  });

  ///오버라이드용
  Map<String, dynamic> toJson();
}

@JsonSerializable(explicitToJson: true)
class MusicJournal implements Journal {
  @override
  final DateTime createdAt;
  @override
  final String title;
  @override
  final Music? music;
  @override
  final List<String>? tags;

  const MusicJournal({
    required this.createdAt,
    required this.title,
    this.music,
    this.tags,
  });

  factory MusicJournal.fromJson(Map<String, dynamic> json) =>
      _$MusicJournalFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MusicJournalToJson(this);

  @override
  String toString() {
    return 'MusicJournal(createdAt: $createdAt, title: $title, music: $music, tags: $tags)';
  }
}

@JsonSerializable(explicitToJson: true)
class PostJournal implements Journal {
  @override
  final DateTime createdAt;
  @override
  final String title;
  @override
  final Music? music;
  @override
  final List<String>? tags;
  final String? post;

  const PostJournal({
    required this.createdAt,
    required this.title,
    this.music,
    this.tags,
    this.post,
  });

  factory PostJournal.fromJson(Map<String, dynamic> json) =>
      _$PostJournalFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PostJournalToJson(this);

  @override
  String toString() {
    return 'PostJournal(createdAt: $createdAt, title: $title, music: $music, tags: $tags, post: $post)';
  }
}
