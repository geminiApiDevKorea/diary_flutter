import 'dart:math';

import 'package:diary_flutter/data/model/diary.dart';
import 'package:diary_flutter/presentation/diary/archived_diary_item_content.dart';
import 'package:diary_flutter/presentation/diary/archived_diary_item_header.dart';
import 'package:diary_flutter/presentation/diary/archived_diary_item_playlist.dart';
import 'package:flutter/material.dart';

class ArchivedDiaryItem extends StatelessWidget {
  final Diary diary;
  const ArchivedDiaryItem({
    super.key,
    required this.diary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArchivedDiaryItemHeader(diary: diary),
          const SizedBox(height: 8),
          ArchivedDiaryItemContent(diary: diary),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ListView.separated(
              itemCount: Random().nextInt(4) + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  const ArchiviedDiaryItemPlayList(),
              separatorBuilder: (context, index) => const SizedBox(width: 16),
            ),
          ),
        ],
      ),
    );
  }
}
