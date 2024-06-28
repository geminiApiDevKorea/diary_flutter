import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ArchiviedDiaryItemPlayList extends StatelessWidget {
  const ArchiviedDiaryItemPlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.music_note),
          AutoSizeText(
            '사운드 오브 뮤직 OST',
            style: TextStyle(
              fontSize: 10,
            ),
            minFontSize: 5,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
