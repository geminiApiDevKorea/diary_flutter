import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/my_info/my_info_option_detail.dart';
import 'package:diary_flutter/presentation/my_info/my_info_option_title.dart';
import 'package:diary_flutter/presentation/splash_screen.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyInfoOption extends ConsumerWidget {
  final MyInfoOptions option;
  const MyInfoOption({
    super.key,
    required this.option,
  });

  _onTap(BuildContext context, WidgetRef ref) {
    if (option == MyInfoOptions.privaryPolicy) {
      AgreementType.privacyPolicy.open();
    } else if (option == MyInfoOptions.termsOfUse) {
      AgreementType.termsOfService.open();
    } else if (option == MyInfoOptions.signOut) {
      ref.read(authProvider.notifier).signOut();
      context.pushReplacement(SplashScreen.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    return GestureDetector(
      onTap: option.isActionable ? () => _onTap(context, ref) : null,
      child: Column(
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
      ),
    );
  }
}
