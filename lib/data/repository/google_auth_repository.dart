import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();

  // 웹에서만 동작함
  Future<User?> signIn() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(_googleAuthProvider);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      const List<String> scopes = <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ];
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: scopes).signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }
}
