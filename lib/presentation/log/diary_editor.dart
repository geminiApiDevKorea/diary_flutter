import 'package:flutter/material.dart';

class DiaryEditor extends StatelessWidget {
  final TextEditingController textEditingController;
  final int maxLength;
  const DiaryEditor({
    super.key,
    required this.textEditingController,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: 'Write about your day',
            counterText: '${textEditingController.text.length}/$maxLength',
          ),
          maxLength: maxLength,
          maxLines: 6,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: textEditingController.text.isEmpty ? null : () {},
          child: const SizedBox(
            width: double.infinity,
            height: 48,
            child: Center(
              child: Text(
                'Save Diary',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
