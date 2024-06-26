import 'package:diary_flutter/common/types.dart';
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
      builder: (context, value, child) {
        return Center(
          child: Text('Home Body : ${homeNavigationNotifier.value}'),
        );
      },
    );
  }
}
