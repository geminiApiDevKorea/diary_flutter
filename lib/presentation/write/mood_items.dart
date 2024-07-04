import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/temporary_diary.dart';
import 'package:diary_flutter/domain/provider/temporary_mood.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodItem extends ConsumerWidget {
  final Moods mood;
  const MoodItem({
    super.key,
    required this.mood,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelectedMood = ref.watch(temporaryMoodProvider) == mood;
    return GestureDetector(
      onTap: () => ref.read(temporaryDiaryProvider.notifier).change(mood: mood),
      child: SizedBox(
        width: 60,
        height: 70,
        child: Column(
          children: [
            Icon(
              mood.iconData,
              size: 40,
              color: isSelectedMood ? Colors.blue : Colors.grey,
            ),
            Text(
              mood.name,
              style: TextStyle(
                color: isSelectedMood ? Colors.blue : Colors.grey,
                fontWeight: isSelectedMood ? FontWeight.w500 : FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
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
        MoodItem(mood: Moods.sad),
        MoodItem(mood: Moods.angry),
        MoodItem(mood: Moods.neutral),
      ],
    );
  }
}
