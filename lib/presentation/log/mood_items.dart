import 'package:diary_flutter/common/enums.dart';
import 'package:flutter/material.dart';

class MoodItem extends StatelessWidget {
  final Moods mood;
  const MoodItem({
    super.key,
    required this.mood,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          mood.iconData,
          size: 32,
        ),
        Text(mood.name),
      ],
    );
  }
}

class MoodItems extends StatelessWidget {
  const MoodItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        MoodItem(mood: Moods.happy),
        SizedBox(width: 8),
        MoodItem(mood: Moods.sad),
        SizedBox(width: 8),
        MoodItem(mood: Moods.angry),
        SizedBox(width: 8),
        MoodItem(mood: Moods.neutral),
      ],
    );
  }
}
