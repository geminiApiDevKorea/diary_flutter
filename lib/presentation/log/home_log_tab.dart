import 'package:diary_flutter/presentation/log/diary_editor.dart';
import 'package:diary_flutter/presentation/log/mood_items.dart';
import 'package:diary_flutter/presentation/log/music_items.dart';
import 'package:flutter/material.dart';

class HomeLogTab extends StatefulWidget {
  const HomeLogTab({super.key});

  @override
  State<HomeLogTab> createState() => _HomeLogTabState();
}

class _HomeLogTabState extends State<HomeLogTab> {
  final TextEditingController _textEditingController = TextEditingController();
  final int maxLength = 100;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onChangedText);
  }

  _onChangedText() {
    setState(
      () {
        if (_textEditingController.text.length > maxLength) {
          _textEditingController.text =
              _textEditingController.text.substring(0, maxLength);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎵 Music Diary',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            DiaryEditor(
              textEditingController: _textEditingController,
              maxLength: maxLength,
            ),
            const SizedBox(height: 32),
            Text(
              'How are you feeling today?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const MoodItems(),
            const SizedBox(height: 32),
            Text(
              'Your Mood Playlist',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const MusicItems(),
          ],
        ),
      ),
    );
  }
}
