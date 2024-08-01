import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:flutter/material.dart';

class CalendarJournalMusicChip extends StatelessWidget {
  const CalendarJournalMusicChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 146,
        height: 29,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F5EC),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          children: [
            GenAssets.images.music.image(scale: 2),
            const SizedBox(
              width: 5,
            ),
            const Expanded(
              child: Text(
                'It\'s Raining, So What - Epik High',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
