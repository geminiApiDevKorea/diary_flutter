import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/domain/provider/auth/get_my_name.dart';
import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyInfoOptionDetail extends ConsumerWidget {
  final MyInfoOptions option;
  const MyInfoOptionDetail({
    super.key,
    required this.option,
  });

  String _getDetail(WidgetRef ref) {
    if (option == MyInfoOptions.name) {
      return ref.read(getMyNameProvider);
    } else if (option == MyInfoOptions.gender) {
      final authState = ref.read(authProvider).value;
      if (authState is SignedInState) {
        return authState.gender ?? '';
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    return Row(
      children: [
        Text(
          _getDetail(ref),
          style: textStyle.paragraph.withColor(colors.caption),
        ),
        const SizedBox(width: 20),
        if (option.hasDetail) GenAssets.images.iconMyInfoDetail.image(scale: 2),
      ],
    );
  }
}
