import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onbording_notifier.g.dart';

sealed class OnboardingState {
  final String content;
  final int index;
  final int contentLength;
  final bool isLast;
  OnboardingState({
    required this.index,
    required this.contentLength,
    required this.content,
    this.isLast = false,
  });
}

class OnboardingContentState extends OnboardingState {
  OnboardingContentState({
    required super.index,
    required super.contentLength,
    required super.content,
    super.isLast = false,
  });
}

class OnboardingLoginState extends OnboardingState {
  OnboardingLoginState({
    required super.index,
    required super.contentLength,
    required super.content,
    super.isLast = false,
  });
  factory OnboardingLoginState.from(OnboardingState state) {
    return OnboardingLoginState(
      index: state.index,
      contentLength: state.contentLength,
      content: state.content,
      isLast: state.isLast,
    );
  }
}

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  static const List<String> _contents = [
    'Capture your daily\nmoments through\na gentle conversation\nwith Gemini.',
    'After recording your day,\na personalized playlist\nis created just for you.',
    'Embrace your emotions\nand reflect on your inner\nself through journaling.',
    'Now, open your heart\nand face your feelings with\nthe power of music.',
    'Now, Open your mind\nand face your feelings\nwith music',
  ];

  @override
  OnboardingState build() {
    return OnboardingContentState(
      index: 0,
      contentLength: _contents.length,
      content: _contents[0],
    );
  }

  finished() {
    state = OnboardingLoginState.from(state);
  }

  next() {
    final currentState = state;
    if (currentState is OnboardingContentState) {
      final currentIndex = currentState.index;
      final contentLength = _contents.length;
      if (currentIndex + 1 < contentLength) {
        state = OnboardingContentState(
          index: currentIndex + 1,
          contentLength: contentLength,
          content: _contents[currentIndex + 1],
          isLast: currentIndex + 1 == contentLength - 1,
        );
      }
    }
  }

  previous() {
    final currentState = state;
    if (currentState is OnboardingContentState) {
      final currentIndex = currentState.index;
      final contentLength = _contents.length;
      if (currentIndex - 1 >= 0) {
        state = OnboardingContentState(
          index: currentIndex - 1,
          contentLength: contentLength,
          content: _contents[currentIndex - 1],
          isLast: false,
        );
      }
    }
  }
}
