import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart'; // Make sure to add this dependency in your pubspec.yaml

class DateHeaderDisplay extends ConsumerWidget {
  final DateTime date;
  const DateHeaderDisplay({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          date.toMonthDayOrdinal(),
          style: textStyle.h1.withColor(colors.grayScale0),
        ),
        const SizedBox(height: 12),
        Text(
          'From   ${date.toDDMYYHH()}' '   Post',
          style: textStyle.paragraph.withColor(colors.grayScale60),
        ),
        const SizedBox(height: 10),
        Divider(
          color: colors.grayScale80,
          thickness: 1,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
