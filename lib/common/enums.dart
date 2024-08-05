import 'package:diary_flutter/data/model/journal.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'enums.g.dart';

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

enum FeedbackType {
  chat,
  post,
}

extension DateTimeFormatting on DateTime {
  /// 현재 날짜를 "월 일 서수" 형식으로 변환합니다.
  /// 예: "January 1st", "February 2nd", "March 3rd" 등
  ///
  /// ```dart
  /// DateTime date = DateTime(2023, 1, 1);
  /// print(date.toMonthDayOrdinal()); // January 1st
  ///
  /// DateTime anotherDate = DateTime(2023, 2, 2);
  /// print(anotherDate.toMonthDayOrdinal()); // February 2nd
  /// ```
  String toMonthDayOrdinal() {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    String ordinal(int day) {
      if (day >= 11 && day <= 13) {
        return '${day}th';
      }
      switch (day % 10) {
        case 1:
          return '${day}st';
        case 2:
          return '${day}nd';
        case 3:
          return '${day}rd';
        default:
          return '${day}th';
      }
    }

    return '${months[month - 1]} ${ordinal(day)}';
  }

  /// 현재 날짜를 "dd/M/yy HH:mm" 형식으로 변환합니다.
  /// 예: "01/1/23 14:30", "02/2/23 09:15" 등
  ///
  /// ```dart
  /// DateTime date = DateTime(2023, 1, 1, 14, 30);
  /// print(date.toCustomFormat()); // 01/1/23 14:30
  ///
  /// DateTime anotherDate = DateTime(2023, 2, 2, 9, 15);
  /// print(anotherDate.toCustomFormat()); // 02/2/23 09:15
  /// ```
  String toDDMYYHH() {
    return DateFormat('dd/M/yy HH:mm').format(this);
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
        Weekday.sun => '일',
        Weekday.mon => '월',
        Weekday.tue => '화',
        Weekday.wed => '수',
        Weekday.thu => '목',
        Weekday.fri => '금',
        Weekday.sat => '토',
      };
}

@JsonEnum(alwaysCreate: true)
enum Gender {
  @JsonValue('FEMALE')
  female,
  @JsonValue('MALE')
  male,
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
        return const Duration(milliseconds: 3000);
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
