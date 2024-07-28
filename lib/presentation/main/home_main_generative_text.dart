import 'package:diary_flutter/data/model/diary/generated_feedback_content.dart';
import 'package:diary_flutter/presentation/main/home_generative_text_seperator.dart';
import 'package:flutter/material.dart';

class HomeMainGenerativeText extends StatelessWidget {
  final GeneratedFeedbackContent feedback;
  const HomeMainGenerativeText(this.feedback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectionArea(child: Text(feedback.comment)),
          const HomeGenerativeTextSeperator(),
          SelectionArea(child: Text('🎤 ${feedback.song.singer}')),
          const HomeGenerativeTextSeperator(),
          SelectionArea(child: Text('🎵 ${feedback.song.title}')),
          const HomeGenerativeTextSeperator(),
          SelectionArea(child: Text('😇 ${feedback.song.reason}')),
          const HomeGenerativeTextSeperator(),
        ],
      ),
    );
  }
}
