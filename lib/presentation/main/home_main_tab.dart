import 'package:diary_flutter/domain/provider/generate_feedback.dart';
import 'package:diary_flutter/presentation/main/home_main_generative_text.dart';
import 'package:diary_flutter/presentation/main/home_main_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';

class HomeMainTab extends ConsumerStatefulWidget {
  const HomeMainTab({super.key});

  @override
  ConsumerState<HomeMainTab> createState() => _HomeMainTabState();
}

class _HomeMainTabState extends ConsumerState<HomeMainTab> {
  final TextEditingController _controller = TextEditingController(text: '''
어제 새벽까지 개발을 하느라 엄청 피곤해. 개발자들 만나 모각코도 해야하고, 공모전 프로젝트의 킥오프를 제대로 해야 하는데, 이 컨디션을 잘 할 수 있을까?
''');

  @override
  Widget build(BuildContext context) {
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
            Consumer(
              builder: (_, ref, child) =>
                  switch (ref.watch(generateFeedbackProvider)) {
                LoadingFeedbackState _ => const HomeMainLoading(),
                ReceivedFeedbackState state =>
                  HomeMainGenerativeText(state.message),
                _ => const Nil(),
              },
            ),
          ],
        ),
      ),
    );
  }
}
