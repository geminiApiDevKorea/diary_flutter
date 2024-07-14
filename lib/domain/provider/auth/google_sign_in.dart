import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/data/provider/users_repository_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_sign_in.g.dart';

class SignInState {
  final bool isSignedIn;
  SignInState({required this.isSignedIn});
}

@Riverpod(keepAlive: true)
class GoogleSignIn extends _$GoogleSignIn {
  static const String key = "id_token";
  @override
  SignInState build() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final storedIdToken = persistanceStorage.getValue<String>(key);
    return SignInState(isSignedIn: storedIdToken?.isNotEmpty ?? false);
  }

  _storeIdToken(final String idToken) {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    persistanceStorage.setValue(key, idToken);
  }

  signIn() async {
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);
      user = userCredential.user;
      if (user != null) {
        final idToken = await user.getIdToken();
        if (idToken != null) {
          final resp = ref
              .read(usersRepositoryProvider)
              .createUser(bearerIdToken: "Bearer $idToken");
          print(resp.toString());
          _storeIdToken(idToken);
          // final resp = ref.read(usersRepositoryProvider).login(idToken);
          // print(resp.toString());

          state = SignInState(isSignedIn: true);
        }
        print('id token : $idToken');
      }
      print(user);
    } catch (e) {
      print(e);
    }
  }
}
