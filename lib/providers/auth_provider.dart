
import 'package:bienaventurados/models/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier{

  final FirebaseAuth _auth;
  //GoogleSignInAccount? _googleUser;
  Usuario _user = Usuario();
  late final _displayName;

  //final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool? _sesionIniciada;

  // Usuario? _userFromFirebase(auth.User? user) {
  //   if (user == null) {
  //     return null;
  //   }
  //   return Usuario(uid: user.uid, correo: user.email, nombre: user.displayName);
  // }

  // Stream<Usuario?>? get user{
  //   return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  // }

  AuthProvider.instance({bool? sesionIniciada}) : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged( auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      _sesionIniciada = false;
    } else {
      DocumentSnapshot userSnap = await _db
        .collection('usuarios')
        .doc(firebaseUser.email)
        .get();

      _user.setFromFirestore(userSnap);
      _sesionIniciada = true;
      notifyListeners();
    }

  }

  // Future<User?> signInWithEmailAndPassword(String email, String password) async {
  //   final credential = await _firebaseAuth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   return _userFromFirebase(credential.user);
  // }

  Future<auth.User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        auth.User user = authResult.user!;
        print('USUARIO EXISTENTE');
        _sesionIniciada = true;
        await updateUserData(user);
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  Future<auth.User?> createUserWithEmailAndPassword(String nombre, String email, String password) async {
    try {
      final UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        auth.User user = authResult.user!;
        _sesionIniciada = true;
        _displayName = nombre;
        await createUserData(user);
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }
  // Future<auth.User?> createUserWithEmailAndPassword(String email, String password) async {
  //   final credential = await _firebaseAuth.createUserWithEmailAndPassword(
  //     email: email, 
  //     password: password
  //   );
  //   return _userFromFirebase(credential.user);
  // }

  Future<DocumentSnapshot> createUserData(auth.User user) async {
    DocumentReference userRef = _db
      .collection('usuarios')
      .doc(user.email);

    await userRef.set({
      'uid': user.uid,
      'correo': user.email,
      'clase': 'bienaventurado',
      'ultimaConexion': DateTime.now(),
      'primeraConexion': DateTime.now(),
      'nombre': _displayName,
    }, SetOptions(merge: true));

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  Future<DocumentSnapshot> updateUserData(auth.User user) async {
    DocumentReference userRef = _db
      .collection('usuarios')
      .doc(user.email);

    await userRef.set({
      'ultimaConexion': DateTime.now(),
    }, SetOptions(merge: true));

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }


  Future<void> signOut() async {
    return await _auth.signOut();
  }

  bool? get sesionIniciada => _sesionIniciada;
  Usuario get usuario => _user;
  //GoogleSignInAccount? get googleUser => _googleUser;
}