import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FireauthRepository {
  final FirebaseAuth _auth;
  bool? _sesionIniciada = false;

  FireauthRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      _sesionIniciada = false;
    } else {
      _sesionIniciada = true;
    }
  }
}
