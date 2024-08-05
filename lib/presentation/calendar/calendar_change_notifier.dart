import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/extension/date_time_extension.dart';
import 'package:flutter/material.dart';

class CalendarChangeNotifier extends ChangeNotifier {
  DateTime selectedDateTime;

  int _startWeekday() {
    DateTime firstDayOfMonth = selectedDateTime.firstDayOfMonth;
    // weekday가 1은 월요일이라 7인 일요일을 0으로 만들기 위해 7로 나눈 나머지를 반환
    return firstDayOfMonth.weekday % 7;
  }

  int _lastDay() {
    DateTime lastDayOfMonth =
        DateTime(selectedDateTime.year, selectedDateTime.month + 1, 0);
    return lastDayOfMonth.day;
  }

  int get weekdaysInMonth {
    int startWeekday = _startWeekday();
    int lastDay = _lastDay();
    int totalCells = startWeekday + lastDay;
    int rows = (totalCells / 7).ceil();
    return rows;
  }

  int? dayInMonth(int row, Weekday weekday) {
    int startWeekday = _startWeekday();
    int dayIndex = row * 7 + weekday.index - startWeekday + 1;

    if (dayIndex < 1 || dayIndex > _lastDay()) {
      return null;
    } else {
      return dayIndex;
    }
  }

  void previousMonth() {
    selectedDateTime =
        DateTime(selectedDateTime.year, selectedDateTime.month - 1);
    notifyListeners();
  }

  void nextMonth() {
    selectedDateTime =
        DateTime(selectedDateTime.year, selectedDateTime.month + 1);
    notifyListeners();
  }

  CalendarChangeNotifier({required this.selectedDateTime});
}
