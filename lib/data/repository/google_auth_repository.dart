import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();

  Future<User?> signIn() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(_googleAuthProvider);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }
}
