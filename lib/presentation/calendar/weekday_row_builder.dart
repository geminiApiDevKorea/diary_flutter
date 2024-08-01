import 'package:diary_flutter/common/enums.dart';
import 'package:flutter/material.dart';

typedef WeekdayRowItemBuilder = Widget Function(
    BuildContext context, Weekday weekday);

class WeekdayRowBuilder extends StatelessWidget {
  final WeekdayRowItemBuilder itemBuilder;
  const WeekdayRowBuilder({
    super.key,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...Weekday.values.map(
            (weekday) => itemBuilder(context, weekday),
          ),
        ],
      ),
    );
  }
}
