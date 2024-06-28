import 'package:diary_flutter/data/model/diary.dart';
import 'package:flutter/material.dart';

class ArchivedDiaryItemContent extends StatelessWidget {
  final Diary diary;
  const ArchivedDiaryItemContent({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    return Text(
      diary.content,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    );
  }
}
