import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary_flutter/data/repository/diary_repository.dart';
import 'package:flutter/material.dart';

class CalendarMusicDay extends StatelessWidget {
  final MusicDiary musicDiary;
  final GestureTapCallback onTap;
  const CalendarMusicDay({
    super.key,
    required this.musicDiary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: CachedNetworkImage(
              imageUrl: musicDiary.musicThumbnailImageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
