import 'package:diary_flutter/data/model/llm_feedback.dart';
import 'package:diary_flutter/presentation/main/home_generative_text_seperator.dart';
import 'package:flutter/material.dart';

class HomeMainGenerativeText extends StatelessWidget {
  final LLMFeedback feedback;
  const HomeMainGenerativeText(this.feedback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(feedback.comment),
          const HomeGenerativeTextSeperator(),
          SelectableText('🎤 ${feedback.song.singer}'),
          const HomeGenerativeTextSeperator(),
          SelectableText('🎵 ${feedback.song.title}'),
          const HomeGenerativeTextSeperator(),
          SelectableText('😇 ${feedback.song.reason}'),
        ],
      ),
    );
  }
}
