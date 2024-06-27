import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/setting_notifier.dart';
import 'package:diary_flutter/presentation/diary/home_diary_tab.dart';
import 'package:diary_flutter/presentation/home/home_temporary_tab.dart';
import 'package:diary_flutter/presentation/write/home_write_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(settingNotifierProvider);
    if (setting.homeNavigation == HomeNavigations.write) {
      return const HomeWriteTab();
    } else if (setting.homeNavigation == HomeNavigations.diary) {
      return const HomeDiaryTab();
    } else {
      return HomeTemporaryTab(homeNavigations: setting.homeNavigation);
    }
  }
}
