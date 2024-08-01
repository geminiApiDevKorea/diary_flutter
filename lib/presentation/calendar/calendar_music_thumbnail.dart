import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:flutter/material.dart';

class CalendarMusicThumbnail extends StatelessWidget {
  const CalendarMusicThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: GenAssets.images.newjeans.image(scale: 2),
      ),
    );
  }
}
