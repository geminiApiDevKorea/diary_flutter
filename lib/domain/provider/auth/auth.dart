import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/provider/google_auth_repository_provider.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/data/provider/users_repository_provider.dart';
import 'package:diary_flutter/data/repository/users_repository.dart';
import 'package:diary_flutter/data/storage/persistance_storage.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

enum SignInState {
  unsignedIn,
  signedInCompleted,
  needAgreement,
}

sealed class AuthState {}

class NeedSigninState extends AuthState {}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final Exception exception;
  ErrorAuthState({required this.exception});
}

class SignedInState extends AuthState {
  final bool isAgreed;
  final String idToken;
  final String name;
  final String? gender;
  SignedInState({
    required this.idToken,
    required this.isAgreed,
    required this.name,
    this.gender,
  });
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  static const String key = "id_token";
  static const String _defaultNickName = 'anonymous';

  PersistanceStorage get _persistanceStorage =>
      ref.read(persistanceStorageProvider);

  @override
  FutureOr<AuthState> build() async {
    final storedIdToken = _persistanceStorage.getValue<String>(key);
    if (storedIdToken?.isEmpty ?? true) {
      return NeedSigninState();
    }

    try {
      return currentUser(idToken: storedIdToken!);
    } on Exception catch (e) {
      return ErrorAuthState(exception: e);
    }
  }

  signOut() {
    _persistanceStorage.removeValue(key);
    state = AsyncValue.data(NeedSigninState());
  }

  Future<SignInState> signIn() async {
    final user =
        await ref.read(googleAuthRepositoryProvider).signInWithGoogle();
    if (user == null) {
      Print.yellow('user is null');
      return SignInState.unsignedIn;
    }
    Print.yellow('uid: ${user.uid}');
    final idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      return SignInState.unsignedIn;
    }
    _persistanceStorage.setValue(key, idToken);

    final authState = await postUser(
      idToken: idToken,
      nickname: user.displayName ?? _defaultNickName,
      gender: Gender.others,
    );
    state = AsyncValue.data(authState);
    if (authState is SignedInState) {
      return authState.isAgreed
          ? SignInState.signedInCompleted
          : SignInState.needAgreement;
    } else {
      return SignInState.unsignedIn;
    }
  }

  Future<bool> agree() async {
    try {
      final currentState = state.value;
      if (currentState is SignedInState) {
        final response =
            await ref.read(usersRepositoryProvider).putUsersAgreement(
                  bearerToken: 'Bearer ${currentState.idToken}',
                  body: UsersAgreementBody(agreement: true),
                );
        state = AsyncValue.data(
          SignedInState(
            idToken: currentState.idToken,
            isAgreed: response.isAgreed,
            name: response.name,
            gender: response.gender,
          ),
        );
        return true;
      } else {
        return false;
      }
    } on Exception catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<AuthState> postUser({
    required String idToken,
    required String nickname,
    required Gender gender,
  }) async {
    try {
      final response = await ref.read(usersRepositoryProvider).postUsers(
            bearerToken: 'Bearer $idToken',
            body: UsersRequestBody(
              nickname: nickname,
              gender: gender,
            ),
          );

      return SignedInState(
        idToken: idToken,
        isAgreed: response.isAgreed,
        name: response.name,
        gender: response.gender,
      );
    } on Exception catch (e) {
      return ErrorAuthState(exception: e);
    }
  }

  Future<AuthState> currentUser({
    required String idToken,
  }) async {
    try {
      final response = await ref.read(usersRepositoryProvider).getCurrentUser(
            bearerToken: 'Bearer $idToken',
          );

      return SignedInState(
        idToken: idToken,
        isAgreed: response.isAgreed,
        name: response.name,
        gender: response.gender,
      );
    } on Exception catch (e) {
      return ErrorAuthState(exception: e);
    }
  }
}
