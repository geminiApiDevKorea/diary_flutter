extension DateTimeExtension on DateTime {
  String get yyyyMM => '$year-${month.toString().padLeft(2, '0')}';
}
