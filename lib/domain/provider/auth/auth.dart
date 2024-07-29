import 'package:diary_flutter/data/provider/google_auth_repository_provider.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/data/provider/users_repository_provider.dart';
import 'package:diary_flutter/data/storage/persistance_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

sealed class AuthState {}

class NeedSigninState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SignedInState extends AuthState {
  final bool isAgreed;
  final String idToken;
  SignedInState({required this.idToken, required this.isAgreed});
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  static const String key = "id_token";

  PersistanceStorage get _persistanceStorage =>
      ref.read(persistanceStorageProvider);

  @override
  AsyncValue<AuthState> build() {
    final storedIdToken = _persistanceStorage.getValue<String>(key);
    if (storedIdToken?.isEmpty ?? true) {
      return AsyncValue.data(NeedSigninState());
    } else {
      _postUser(storedIdToken!);
      return const AsyncValue.loading();
    }
  }

  signIn() async {
    final user = await ref.read(googleAuthRepositoryProvider).signIn();
    if (user == null) {
      return;
    }
    final idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      return;
    }
    _persistanceStorage.setValue(key, idToken);
    await _postUser(idToken);
  }

  _postUser(String idToken) async {
    try {
      final response = await ref
          .read(usersRepositoryProvider)
          .postUsers(bearerToken: 'Bearer $idToken');
      final signedInState = SignedInState(
        idToken: idToken,
        isAgreed: response.isAgreed,
      );
      state = AsyncValue.data(signedInState);
    } catch (e) {
      print(e);
    }
  }
}
