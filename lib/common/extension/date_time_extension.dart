// extension DateTimeExtension on DateTime {
//   int weekdaysInMonth() {
//     DateTime firstDayOfMonth = DateTime(year, month, 1);
//     DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
//     int startWeekday = firstDayOfMonth.weekday % 7;
//     int lastDay = lastDayOfMonth.day;
//     int totalCells = startWeekday + lastDay;
//     int rows = (totalCells / 7).ceil();
//     return rows;
//   }
// }
