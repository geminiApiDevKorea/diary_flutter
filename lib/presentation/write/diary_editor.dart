import 'package:diary_flutter/data/model/diary.dart';
import 'package:diary_flutter/domain/provider/archived_diaries.dart';
import 'package:diary_flutter/domain/provider/temporary_diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryEditor extends ConsumerStatefulWidget {
  const DiaryEditor({super.key});

  @override
  ConsumerState<DiaryEditor> createState() => _DiaryEditorState();
}

class _DiaryEditorState extends ConsumerState<DiaryEditor> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    final temporaryDiary = ref.read(temporaryDiaryProvider);
    _textEditingController =
        TextEditingController(text: temporaryDiary.content);
    _textEditingController.addListener(_onChangedText);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onChangedText);
    _textEditingController.dispose();
    super.dispose();
  }

  _onChangedText() {
    ref
        .read(temporaryDiaryProvider.notifier)
        .update(content: _textEditingController.text);
  }

  _archive(BuildContext context) {
    ref.read(archivedDiariesProvider.notifier).archive();
    _textEditingController.clear();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your day has been archived'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temporayDiary = ref.watch(temporaryDiaryProvider);
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: 'Write about your day',
            counterText: '${temporayDiary.contentLength}/${Diary.maxLength}',
          ),
          maxLength: Diary.maxLength,
          maxLines: null,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: temporayDiary.isEmpty ? null : () => _archive(context),
          child: const SizedBox(
            width: double.infinity,
            height: 48,
            child: Center(
              child: Text('Archive your day'),
            ),
          ),
        ),
      ],
    );
  }
}
