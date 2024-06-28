import 'package:diary_flutter/data/model/diary.dart';
import 'package:flutter/material.dart';

class ArchivedDiaryItemHeader extends StatelessWidget {
  final Diary diary;
  const ArchivedDiaryItemHeader({
    super.key,
    required this.diary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${diary.dateTime.year}-${diary.dateTime.month}-${diary.dateTime.day}',
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        Text(
          diary.mood?.name ?? '',
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
