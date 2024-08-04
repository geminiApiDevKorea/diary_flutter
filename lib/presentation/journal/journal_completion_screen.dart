import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/presentation/journal/icon_text_button.dart';
import 'package:diary_flutter/presentation/journal/journal_body_appbar.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalCompletionScreen extends HookConsumerWidget {
  static const String path = 'completion';
  static const String name = 'journal_completion';
  const JournalCompletionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;

    return Container(
      color: colors.grayScale90,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          floatingActionButton: SizedBox(
            height: 52,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'floating',
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    child: Text(
                      "Delete",
                      style: textStyle.button.copyWith(color: colors.error),
                    ),
                    onPressed: () => {},
                  ),
                  TextButton(
                      child: Text(
                        "Save",
                        style:
                            textStyle.button.copyWith(color: colors.primary50),
                      ),
                      onPressed: () => {}),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, kToolbarHeight, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'July 11th',
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text("Today's feedback from AI"),
                  subtitle: const Text('활성화하면 오늘에 대한 피드백을 받을 수 있습니다.'),
                  value: true,
                  onChanged: (bool value) {
                    // Handle change
                  },
                ),
                SwitchListTile(
                  title: const Text('Private'),
                  subtitle: const Text('공개하면 친구들이 내 음악 목록을 볼 수 있습니다.'),
                  value: false,
                  onChanged: (bool value) {
                    // Handle change
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
