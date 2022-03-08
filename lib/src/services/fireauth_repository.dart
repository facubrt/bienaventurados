import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FireauthRepository {
  final FirebaseAuth _auth;
  bool isLoggedIn = false;

  FireauthRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<bool> _onAuthStateChanged(auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
    return isLoggedIn;
  }
}
