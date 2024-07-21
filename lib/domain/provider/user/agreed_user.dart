import 'package:diary_flutter/data/model/user.dart';
import 'package:diary_flutter/data/provider/users_repository_provider.dart';
import 'package:diary_flutter/data/repository/users_repository.dart';
import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agreed_user.g.dart';

@Riverpod(keepAlive: true)
class AgreedUser extends _$AgreedUser {
  @override
  User build() {
    return User();
  }

  agree() async {
    try {
      final user = ref.read(authProvider).value;
      if (user != null && user is SignedInState) {
        final response =
            await ref.read(usersRepositoryProvider).putUsersAgreement(
                  bearerToken: 'Bearer ${user.idToken}',
                  body: UsersAgreementBody(agreement: true),
                );
        state = state.copyWith(isAgreed: response.isAgreed);
      }
    } catch (e) {
      print(e);
    }
  }
}
