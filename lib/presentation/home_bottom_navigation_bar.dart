import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/chats/stored_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeBottomNavigationBar extends ConsumerStatefulWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  ConsumerState<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState
    extends ConsumerState<HomeBottomNavigationBar> {
  _onTap(int index) {
    ref
        .read(storedSettingProvider.notifier)
        .update(homeNavigation: HomeNavigations.values[index]);
  }

  @override
  Widget build(BuildContext context) {
    final setting = ref.watch(storedSettingProvider);
    return BottomNavigationBar(
      onTap: _onTap,
      currentIndex: setting.homeNavigation.index,
      items: HomeNavigations.values
          .map((e) =>
              BottomNavigationBarItem(icon: Icon(e.iconData), label: e.name))
          .toList(),
    );
  }
}
