import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'primitive_notifiers.g.dart';

@riverpod
class StringNotifier extends _$StringNotifier {
  @override
  String build({required String key}) {
    return '';
  }

  void setValue(String newValue) {
    state = newValue;
  }

  void clearValue() {
    state = '';
  }
}

@riverpod
class DoubleNotifier extends _$DoubleNotifier {
  @override
  double build({required String key}) {
    return 0.0;
  }

  void setValue(double newValue) {
    state = newValue;
  }

  void clearValue() {
    state = 0.0;
  }
}

@riverpod
class IntNotifier extends _$IntNotifier {
  @override
  int build({required String key}) {
    return 0;
  }

  void setValue(int newValue) {
    state = newValue;
  }

  void clearValue() {
    state = 0;
  }
}
