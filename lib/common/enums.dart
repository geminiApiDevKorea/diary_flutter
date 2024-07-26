import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum HomeNavigations {
  main,
  chat,
  write,
  diary,
  setting,
}

extension HomeNavigationsExtension on HomeNavigations {
  String get name => switch (this) {
        HomeNavigations.main => 'Home',
        HomeNavigations.chat => 'Chat',
        HomeNavigations.write => 'Write',
        HomeNavigations.diary => 'Diary',
        HomeNavigations.setting => 'Setting',
      };
  IconData get iconData => switch (this) {
        HomeNavigations.main => Icons.home_outlined,
        HomeNavigations.chat => Icons.chat_rounded,
        HomeNavigations.write => Icons.add_outlined,
        HomeNavigations.diary => Icons.book_outlined,
        HomeNavigations.setting => Icons.settings_outlined,
      };
}

enum Moods {
  happy,
  sad,
  angry,
  neutral,
}

extension MoodsExtension on Moods {
  String get name => switch (this) {
        Moods.happy => 'Happy',
        Moods.sad => 'Sad',
        Moods.angry => 'Angry',
        Moods.neutral => 'Neutral'
      };
  IconData get iconData => switch (this) {
        Moods.happy => Icons.sentiment_very_satisfied,
        Moods.sad => Icons.sentiment_neutral,
        Moods.angry => Icons.sentiment_very_dissatisfied,
        Moods.neutral => Icons.sentiment_satisfied
      };
}

enum GeminiModels {
  flash,
}

extension GeminiModelsExtension on GeminiModels {
  String get name => switch (this) {
        GeminiModels.flash => 'gemini-1.5-flash-latest',
      };
}

enum GeminiResponseMimeTypes {
  text,
  json,
}

extension GeminiResponseMimeTypesExtension on GeminiResponseMimeTypes {
  String get parameter => switch (this) {
        GeminiResponseMimeTypes.text => 'text/plain',
        GeminiResponseMimeTypes.json => 'application/json',
      };
}

enum Role {
  @JsonValue('assistant')
  assistant,
  @JsonValue('user')
  user,
}
