import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/types.dart';
import 'package:diary_flutter/presentation/home/home_temporary_tab.dart';
import 'package:diary_flutter/presentation/log/home_log_tab.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  final HomeNavigationNotifier homeNavigationNotifier;
  const HomeBody({
    super.key,
    required this.homeNavigationNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeNavigationNotifier,
      builder: (context, value, child) => switch (value) {
        HomeNavigations.log => const HomeLogTab(),
        _ => HomeTemporaryTab(homeNavigations: value),
      },
    );
  }
}
