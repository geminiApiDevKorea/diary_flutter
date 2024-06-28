import 'package:flutter/material.dart';

enum HomeNavigations {
  main,
  calendar,
  write,
  diary,
  setting,
}

extension HomeNavigationsExtension on HomeNavigations {
  String get name => switch (this) {
        HomeNavigations.main => 'Home',
        HomeNavigations.calendar => 'Calendar',
        HomeNavigations.write => 'Write',
        HomeNavigations.diary => 'Diary',
        HomeNavigations.setting => 'Setting',
      };
  IconData get iconData => switch (this) {
        HomeNavigations.main => Icons.home_outlined,
        HomeNavigations.calendar => Icons.calendar_month_outlined,
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
