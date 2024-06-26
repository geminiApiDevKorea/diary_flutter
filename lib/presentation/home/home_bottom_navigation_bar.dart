import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/types.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final HomeNavigationNotifier homeNavigationNotifier;
  const HomeBottomNavigationBar({
    super.key,
    required this.homeNavigationNotifier,
  });

  _onTap(int index) {
    final selectedTap = HomeNavigations.values[index];
    // log인 경우 일기 작성창을 modal로 띄우고 나머지는 화면 갱신
    if (selectedTap != HomeNavigations.log) {
      homeNavigationNotifier.value = selectedTap;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeNavigationNotifier,
      builder: (context, value, child) {
        return BottomNavigationBar(
          onTap: _onTap,
          currentIndex: homeNavigationNotifier.value.index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_outlined),
              label: 'Log',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Diary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Setting',
            ),
          ],
        );
      },
    );
  }
}