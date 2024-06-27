import 'package:diary_flutter/common/enums.dart';
import 'package:flutter/material.dart';

class HomeTemporaryTab extends StatelessWidget {
  final HomeNavigations homeNavigations;
  const HomeTemporaryTab({
    super.key,
    required this.homeNavigations,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '🚧 Under Construction : $homeNavigations 🚧',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
