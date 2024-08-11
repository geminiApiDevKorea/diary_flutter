import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  static const _months = [
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

  static String _getOrdinal(int day) {
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

  String get yyyyMM => '$year-${month.toString().padLeft(2, '0')}';
  String get yyyyMMdd =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  DateTime get firstDayOfMonth => DateTime(year, month, 1);
  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// 예: "January 1st", "February 2nd", "March 3rd"
  String get monthDayOrdinal => '${_months[month - 1]} ${_getOrdinal(day)}';

  /// 예: "01/1/23 14:30", "02/2/23 09:15"
  String get ddMyyHHmm => DateFormat('dd/M/yy HH:mm').format(this);

  /// 예: "July 11th, 2024"
  String get fullDateOrdinal =>
      '${_months[month - 1]} ${_getOrdinal(day)}, $year';
}
