import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserChatItem extends ConsumerWidget {
  final String message;

  const UserChatItem({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          message,
          style: textStyle.h2.withColor(colors.grayScale0),
        ),
        const SizedBox(height: 10),
        Divider(
          color: colors.grayScale80,
          thickness: 1,
        ),
      ],
    );
  }
}
