import 'package:bienaventurados/models/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier{

  final FirebaseAuth _auth;
  GoogleSignInAccount? _googleUser;
  Usuario _user = Usuario();
  late final _displayName;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool? _sesionIniciada;

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

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        auth.User user = authResult.user!;
        _sesionIniciada = true;
        await updateUserData(user);
        return 'user-found';
      }
    } on FirebaseAuthException catch(e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        return e.code;
      } else if (e.code == 'wrong-password') {
        return e.code;
      } else {
        return 'error';
      }

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
    } on FirebaseAuthException catch(e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        return null;
      }
    }
    notifyListeners();
  }
  
    Future<auth.User?> googleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      _googleUser = googleUser;

      final AuthCredential credential = GoogleAuthProvider
        .credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      auth.User user = authResult.user!;
      _sesionIniciada = true;
      _displayName = user.displayName!.split(' ')[0].toString();
  
      await createUserData(user);
      return user;
    } catch (e) {
      print('error $e');
      return null;
    }
  }

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

  Future<bool> actualizarNombre(String nombre) async {
    DocumentReference userRef = _db.collection('usuarios').doc(_user.correo);

    await userRef.set({
      'nombre': nombre,
    }, SetOptions(merge: true));
    _user.nombre = nombre;
    notifyListeners();

    return true;
  }

  Future deleteUser() async {
    try {
      auth.User usuario = _auth.currentUser!;
      //AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);
      print(usuario);
      //UserCredential authResult = await user.reauthenticateWithCredential(credentials);
      //auth.User usuario = authResult.user!;
      // await DatabaseService(uid: usuario.uid).deleteuser(); // called from database class
      DocumentReference userRef = _db.collection('usuarios').doc(usuario.email);
      userRef.delete();
      usuario.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  bool? get sesionIniciada => _sesionIniciada;
  Usuario get usuario => _user;
  GoogleSignInAccount? get googleUser => _googleUser;
}