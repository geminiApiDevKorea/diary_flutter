import 'package:diary_flutter/data/model/user_response.dart';
import 'package:diary_flutter/data/provider/users_repository_provider.dart';
import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_me_notifier.g.dart';

@riverpod
Future<UserResponse> userMeNotifier(UserMeNotifierRef ref) async {
  final user = ref.read(authProvider).value;
  if (user != null && user is SignedInState) {
    return ref.read(usersRepositoryProvider).getCurrentUser(
          bearerToken: 'Bearer ${user.idToken}',
        );
  } else {
    throw Exception('User not signed in');
  }
}
