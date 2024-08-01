import 'package:diary_flutter/common/enums.dart';
import 'package:flutter/widgets.dart';

class CalendarChangeNotifier extends ChangeNotifier {
  DateTime dateTime;

  int _startWeekday() {
    final year = dateTime.year;
    final month = dateTime.month;
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    return firstDayOfMonth.weekday % 7;
  }

  int _lastDay() {
    DateTime lastDayOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
    return lastDayOfMonth.day;
  }

  int weekdaysInMonth() {
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
    dateTime = DateTime(dateTime.year, dateTime.month - 1);
    notifyListeners();
  }

  void nextMonth() {
    dateTime = DateTime(dateTime.year, dateTime.month + 1);
    notifyListeners();
  }

  CalendarChangeNotifier({required this.dateTime});
}

class CalendarInheritedNotifier
    extends InheritedNotifier<CalendarChangeNotifier> {
  const CalendarInheritedNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static CalendarChangeNotifier watch(BuildContext context) {
    final notifier = context
        .dependOnInheritedWidgetOfExactType<CalendarInheritedNotifier>()
        ?.notifier;
    assert(
        notifier != null, 'Cannot find CalendarInheritedNotifier in context.');
    return notifier!;
  }

  static CalendarChangeNotifier read(BuildContext context) {
    final notifier = context
        .findAncestorWidgetOfExactType<CalendarInheritedNotifier>()
        ?.notifier;
    assert(
        notifier != null, 'Cannot find CalendarInheritedNotifier in context.');
    return notifier!;
  }
}
