import 'package:diary_flutter/presentation/common/text_theme_getter_mixin.dart';
import 'package:diary_flutter/presentation/write/diary_editor.dart';
import 'package:diary_flutter/presentation/write/mood_items.dart';
import 'package:diary_flutter/presentation/write/music_items.dart';
import 'package:flutter/material.dart';

class HomeWriteTab extends StatelessWidget with TextThemeGetterMixin {
  const HomeWriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text('🎵 Music Diary', style: textTheme(context).headlineMedium),
            const SizedBox(height: 16),
            const DiaryEditor(),
            const SizedBox(height: 32),
            Text(
              'How are you feeling today?',
              style: textTheme(context).headlineSmall,
            ),
            const SizedBox(height: 16),
            const MoodItems(),
            const SizedBox(height: 32),
            Text('Your Mood Playlist', style: textTheme(context).headlineSmall),
            const SizedBox(height: 16),
            const MusicItems(),
          ],
        ),
      ),
    );
  }
}
