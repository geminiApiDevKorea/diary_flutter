import 'package:flutter/material.dart';

class MusicItem extends StatelessWidget {
  const MusicItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.music_note),
          Text('Song Title'),
          Text('Artist Name'),
        ],
      ),
    );
  }
}

class MusicItems extends StatelessWidget {
  const MusicItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2,
      children: const [
        MusicItem(),
        MusicItem(),
        MusicItem(),
        MusicItem(),
      ],
    );
  }
}
