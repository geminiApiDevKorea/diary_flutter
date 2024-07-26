import 'package:diary_flutter/domain/provider/generate_feedback.dart';
import 'package:diary_flutter/presentation/main/home_main_generative_text.dart';
import 'package:diary_flutter/presentation/main/home_main_loading.dart';
import 'package:diary_flutter/presentation/main/home_main_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeMainTab extends ConsumerStatefulWidget {
  const HomeMainTab({super.key});

  @override
  ConsumerState<HomeMainTab> createState() => _HomeMainTabState();
}

class _HomeMainTabState extends ConsumerState<HomeMainTab> {
  final TextEditingController _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final generateFeedbackState = ref.watch(generateFeedbackProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '일기를 작성하고 음악을 추천받아 보세요.',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => ref
                      .read(generateFeedbackProvider.notifier)
                      .generate(diary: _controller.text),
                  child: const Text('음악 추천'),
                ),
              ],
            ),
            if (generateFeedbackState is LoadingFeedbackState)
              const HomeMainLoading(),
            if (generateFeedbackState is ReceivedFeedbackState) ...[
              HomeMainGenerativeText(generateFeedbackState.content),
              HomeMainMusic(feedback: generateFeedbackState.content),
            ],
          ],
        ),
      ),
    );
  }
}
