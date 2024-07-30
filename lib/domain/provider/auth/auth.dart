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
  FutureOr<AuthState> build() async {
    final storedIdToken = _persistanceStorage.getValue<String>(key);
    if (storedIdToken?.isEmpty ?? true) {
      return NeedSigninState();
    } else {
      return await _postUser(storedIdToken!);
    }
  }

  signIn() async {
    final user =
        await ref.read(googleAuthRepositoryProvider).signInWithGoogle();
    if (user == null) {
      return;
    }
    final idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      return;
    }
    _persistanceStorage.setValue(key, idToken);
    state = AsyncValue.data(await _postUser(idToken));
  }

  Future<AuthState> _postUser(String idToken) async {
    try {
      final response = await ref
          .read(usersRepositoryProvider)
          .postUsers(bearerToken: 'Bearer $idToken');
      return SignedInState(
        idToken: idToken,
        isAgreed: response.isAgreed,
      );
    } catch (e) {
      print(e);
      return NeedSigninState();
    }
  }
}
