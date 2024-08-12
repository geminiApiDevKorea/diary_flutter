import 'package:diary_flutter/data/model/journal.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enums.g.dart';

enum HomeNavigations {
  main,
  chat,
  write,
  diary,
}

extension HomeNavigationsExtension on HomeNavigations {
  String get name => switch (this) {
        HomeNavigations.main => 'Home',
        HomeNavigations.chat => 'Chat',
        HomeNavigations.write => 'Write',
        HomeNavigations.diary => 'Diary',
      };
  IconData get iconData => switch (this) {
        HomeNavigations.main => Icons.home_outlined,
        HomeNavigations.chat => Icons.chat_rounded,
        HomeNavigations.write => Icons.add_outlined,
        HomeNavigations.diary => Icons.book_outlined,
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

@JsonEnum(alwaysCreate: true)
enum FeedbackType {
  @JsonValue('chat')
  chat,
  @JsonValue('post')
  post,
}

FeedbackType getFeedbackTypeFromString(String? value) {
  if (value == null) {
    throw Exception('Feedback type is not provided');
  }
  return FeedbackType.values.firstWhere(
    (type) => type.value == value,
    orElse: () => throw Exception('Invalid feedback type: $value'),
  );
}

extension FeedbackTypeExtension on FeedbackType {
  String get value {
    switch (this) {
      case FeedbackType.chat:
        return 'chat';
      case FeedbackType.post:
        return 'post';
      default:
        throw ArgumentError('Unknown FeedbackType: $this');
    }
  }
}

enum Weekday {
  sun,
  mon,
  tue,
  wed,
  thu,
  fri,
  sat,
}

extension WeekdayExtension on Weekday {
  String get name => switch (this) {
        Weekday.sun => 'Sun',
        Weekday.mon => 'Mon',
        Weekday.tue => 'Tue',
        Weekday.wed => 'Wed',
        Weekday.thu => 'Thu',
        Weekday.fri => 'Fri',
        Weekday.sat => 'Sat',
      };
}

@JsonEnum(alwaysCreate: true)
enum Gender {
  @JsonValue('FEMALE')
  female,
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  other,
}

enum TransitionDuration {
  @JsonValue(Duration(milliseconds: 300))
  short,
  @JsonValue(Duration(milliseconds: 600))
  medium,
  @JsonValue(Duration(milliseconds: 3000))
  long,
}

extension TransitionDurationExtension on TransitionDuration {
  Duration get value {
    switch (this) {
      case TransitionDuration.short:
        return const Duration(milliseconds: 300);
      case TransitionDuration.medium:
        return const Duration(milliseconds: 600);
      case TransitionDuration.long:
        return const Duration(milliseconds: 900);
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }

  String get formattedSongTitle {
    if (length <= 15) {
      return this;
    }
    return '${substring(0, 15)}...';
  }

  String get formattedSinger {
    final firstWord = split(' ').first;
    return firstWord;
  }
}

extension JournalListExtension on List<Journal> {
  List<Journal> sortByDateDescending() {
    if (isEmpty) return this; // 빈 리스트인 경우 그대로 반환
    return [...this]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  void sortByDateDescendingInPlace() {
    if (isEmpty) return; // 빈 리스트인 경우 아무 작업도 하지 않음
    sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}

enum SettingPhase {
  name,
  gender,
}

extension SettingPhaseExtension on SettingPhase {
  bool get isLastSettingPhase => this == SettingPhase.gender;
  String get title => switch (this) {
        SettingPhase.name => 'Please enter\nyour nick name',
        SettingPhase.gender => 'Please select\nyour gender',
      };
  String get description => switch (this) {
        SettingPhase.name => 'You can change it later.',
        SettingPhase.gender => 'We’ll recommend a playlist just for you.',
      };

  SettingPhase? get nextPhase => switch (this) {
        SettingPhase.name => SettingPhase.gender,
        SettingPhase.gender => null,
      };
}

enum MyInfoOptions {
  name,
  gender,
  openLicense,
  privaryPolicy,
  termsOfUse,
  signOut,
  deleteAccount,
}

extension MyInfoOptionsExtension on MyInfoOptions {
  String get title => switch (this) {
        MyInfoOptions.name => 'Name',
        MyInfoOptions.gender => 'Gender',
        MyInfoOptions.openLicense => 'Open License',
        MyInfoOptions.privaryPolicy => 'Privacy Policy',
        MyInfoOptions.termsOfUse => 'Terms of Use',
        MyInfoOptions.signOut => 'Sign out',
        MyInfoOptions.deleteAccount => 'Delete Account',
      };
  bool get isPrimary => switch (this) {
        MyInfoOptions.deleteAccount => true,
        _ => false,
      };

  bool get hasDetail => switch (this) {
        MyInfoOptions.name => true,
        MyInfoOptions.gender => true,
        _ => false,
      };
}
