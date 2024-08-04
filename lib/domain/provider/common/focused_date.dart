import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'focused_date.g.dart';

@Riverpod(keepAlive: true)
class FocusedDate extends _$FocusedDate {
  @override
  DateTime build() {
    return DateTime.now();
  }

  Future<void> updateDate(DateTime newDate) async {
    state = newDate;
  }

  Future<void> resetToToday() async {
    state = DateTime.now();
  }

  String toQueryString() {
    return state.toIso8601String();
  }

  void fromQueryString(String? dateString) {
    if (dateString != null) {
      final parsedDate = DateTime.tryParse(dateString);
      if (parsedDate != null) {
        state = parsedDate;
      }
    }
  }

  bool isToday() {
    final now = DateTime.now();
    return state.year == now.year &&
        state.month == now.month &&
        state.day == now.day;
  }

  Future<void> setTonextDay() async {
    state = state.add(const Duration(days: 1));
  }

  Future<void> setTopreviousDay() async {
    state = state.subtract(const Duration(days: 1));
  }
}
