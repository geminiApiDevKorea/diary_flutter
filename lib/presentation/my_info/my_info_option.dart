import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/presentation/my_info/my_info_option_detail.dart';
import 'package:diary_flutter/presentation/my_info/my_info_option_title.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyInfoOption extends ConsumerWidget {
  final MyInfoOptions option;
  const MyInfoOption({
    super.key,
    required this.option,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16).copyWith(bottom: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyInfoRowTitle(
                title: option.title,
                isPrimary: option.isPrimary,
              ),
              if (option.hasDetail) MyInfoOptionDetail(option: option),
            ],
          ),
        ),
        Container(
          height: 1,
          color: colors.grayScale70,
        ),
      ],
    );
  }
}
