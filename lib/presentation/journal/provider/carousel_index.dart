import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'carousel_index.g.dart';

@riverpod
class CarouselIndex extends _$CarouselIndex {
  @override
  int build() {
    return 0; // 초기 인덱스 값
  }

  void setIndex(int newIndex) {
    state = newIndex;
  }

  void nextIndex() {
    state = state + 1;
  }

  void previousIndex() {
    if (state > 0) {
      state = state - 1;
    }
  }
}
