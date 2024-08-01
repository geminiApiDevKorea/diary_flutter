import 'package:diary_flutter/presentation/calendar/calendar_change_notifier.dart';
import 'package:flutter/widgets.dart';

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
