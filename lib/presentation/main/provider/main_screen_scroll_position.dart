import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_screen_scroll_position.g.dart';

@riverpod
class MainScrollPosition extends _$MainScrollPosition {
  @override
  double build() {
    return 0.0;
  }

  void updateScrollPosition(double position) {
    state = position;
  }
}
