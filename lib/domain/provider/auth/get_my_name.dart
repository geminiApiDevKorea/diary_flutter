import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_my_name.g.dart';

@riverpod
String getMyName(GetMyNameRef ref) {
  final authState = ref.watch(authProvider);

  return authState.maybeWhen(
    data: (state) {
      if (state is SignedInState) {
        return state.name;
      } else {
        throw Exception('User not signed in');
      }
    },
    orElse: () => throw Exception('User not signed in'),
  );
}
