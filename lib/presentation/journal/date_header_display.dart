import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/extension/date_time_extension.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DateHeaderDisplay extends ConsumerWidget {
  final DateTime date;
  final FeedbackType feedbackType;
  const DateHeaderDisplay({
    super.key,
    required this.feedbackType,
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
          date.monthDayOrdinal,
          style: textStyle.h1.withColor(colors.grayScale0),
        ),
        const SizedBox(height: 12),
        Text(
          'From   ${date.ddMyyHHmm}    ${feedbackType.value.capitalize()}',
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
