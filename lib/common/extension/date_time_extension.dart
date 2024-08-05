import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get yyyyMM => '$year-${month.toString().padLeft(2, '0')}';
  String get yyyyMMdd =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  DateTime get firstDayOfMonth => DateTime(year, month, 1);
  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
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
