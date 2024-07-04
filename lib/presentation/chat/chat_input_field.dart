import 'package:diary_flutter/presentation/chat/chat_input_text_field.dart';
import 'package:diary_flutter/presentation/chat/chat_submit_button.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _textEditingController = TextEditingController();

  bool get _isExistInputText => _textEditingController.text.isNotEmpty;

  @override
  initState() {
    super.initState();
    _textEditingController.addListener(() => setState(() {}));
  }

  _onSubmit() {
    // var text = _textEditingController.text;
    _textEditingController.clear();
    // ChatInheritedNotifier.read(context).submit(message: text);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 8.0,
          ),
          child: Row(
            children: [
              ChatInputTextField(
                textEditingController: _textEditingController,
                onSubmit: _onSubmit,
              ),
              const SizedBox(width: 16),
              ChatSubmitButton(
                isEnable: _isExistInputText,
                onSubmit: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
