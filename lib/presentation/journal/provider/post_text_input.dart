import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_text_input.g.dart';

@riverpod
class PostTextInput extends _$PostTextInput {
  @override
  String? build() => null;

  Future<void> setText(String? newText) async {
    state = newText;
  }

  Future<void> clear() async {
    state = null;
  }
}
