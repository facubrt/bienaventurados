import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/models/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth;
  GoogleSignInAccount? _googleUser;
  Usuario _user = Usuario();
  late String _displayName;
  bool _constanciaRestablecida = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final LocalData _localDB = LocalData();
  bool? _sesionIniciada;
  Box? usuarioBox;

  AuthProvider.instance({bool? sesionIniciada}) : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      _sesionIniciada = false;
    } else {
      await getUsuarioFromLocal(firebaseUser.uid);
      _sesionIniciada = true;
      notifyListeners();
    }
  }

  Future<bool> getUsuarioFromLocal(String uid) async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        usuarioBox = _localDB.getUsuario();
        if (usuarioBox!.isEmpty) {
          print('USUARIO DESDE FIREBASE');
          DocumentSnapshot userSnap = await _db.collection('usuarios').doc(uid).get();
          _user.setFromFirestore(userSnap);
          _localDB.setUsuario(_user);
        } else {
          print('USUARIO DESDE LOCAL');
          _user = usuarioBox!.getAt(0);
        }
      }
    });
    return true;
  }

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    String? message = '';
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        auth.User user = authResult.user!;
        _sesionIniciada = true;
        await updateUserData();
        message = 'user-found';
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        message = e.code;
      } else if (e.code == 'wrong-password') {
        message = e.code;
      } else if (e.code == 'invalid-email') {
        message = e.code;
      } else {
        message = 'error';
      }
    }
    notifyListeners();
    return message;
  }

  Future<auth.User?> createUserWithEmailAndPassword(String nombre, String email, String password) async {
    auth.User? _user;
    try {
      final UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        auth.User user = authResult.user!;
        _sesionIniciada = true;
        _displayName = nombre;
        await createUserData(user);
        _user = user;
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        _user = null;
      }
    }
    notifyListeners();
    return _user;
  }

  Future<auth.User?> googleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      _googleUser = googleUser;

      final AuthCredential credential = GoogleAuthProvider.credential(
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
    DocumentReference userRef = _db.collection('usuarios').doc(user.uid);
    final currentUser = _auth.currentUser;

    await userRef.set({
      'uid': user.uid,
      'correo': user.email,
      'clase': 'bienaventurado',
      'ultimaConexion': DateTime.now(),
      'primeraConexion': DateTime.now(),
      'nombre': _displayName,
    }, SetOptions(merge: true));
    currentUser!.updateDisplayName(_displayName);

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  Future<DocumentSnapshot> updateUserData() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection('usuarios').doc(user!.uid);

    await userRef.set({
      'ultimaConexion': DateTime.now(),
      'actual-constancia': 1,
    }, SetOptions(merge: true));

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  Future<bool> actualizarNombre(String nombre) async {
    DocumentReference userRef = _db.collection('usuarios').doc(_user.uid);
    final currentUser = _auth.currentUser;

    await userRef.set({
      'nombre': nombre,
    }, SetOptions(merge: true));

    _user.nombre = nombre;
    currentUser!.updateDisplayName(_displayName);
    notifyListeners();

    return true;
  }

  Future<bool> actualizarCorreo(String correo) async {
    DocumentReference userRef = _db.collection('usuarios').doc(_user.uid);
    final currentUser = _auth.currentUser;

    if (currentUser!.providerData[0].providerId == 'google.com') {
      print('CUENTA DE GOOGLE');
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = auth.GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      UserCredential authResult = await _auth.signInWithCredential(credential);
      final currentUser = authResult.user;
    }

    await userRef.set({
      'correo': correo,
    }, SetOptions(merge: true));
    _user.correo = correo;
    currentUser.updateEmail(correo);
    notifyListeners();

    return true;
  }

  Future<bool> actualizarContrasena(String contrasenaAnterior, String contrasenaNueva) async {
    final credential;
    final user = _auth.currentUser;
    if (user!.providerData[0].providerId == 'google.com') {
      print('CUENTA DE GOOGLE');
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      credential = auth.GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      user.reauthenticateWithCredential(credential);
      //UserCredential authResult = await _auth.signInWithCredential(credential);
      //final currentUser = authResult.user;
    } else if (user.providerData[0].providerId == 'email') {
      credential = EmailAuthProvider.credential(email: user.email!, password: contrasenaAnterior);
      user.reauthenticateWithCredential(credential);
    }
    user.updatePassword(contrasenaNueva).then((result) {
      user.updatePassword(contrasenaNueva);
    });
    user.reload();
    notifyListeners();

    return true;
  }

  Future<bool> recuperarCuenta(String correo) async {
    try {
      await _auth.sendPasswordResetEmail(email: correo);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      auth.User usuario = _auth.currentUser!;
      DocumentReference userRef = _db.collection('usuarios').doc(usuario.uid);
      userRef.delete();
      usuario.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // ESTADISTICAS DE USUARIO
  Future<void> actualizarCompartidos() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection('usuarios').doc(user!.uid);

    _user.avCompartidos = _user.avCompartidos! + 1;
    _localDB.setUsuario(_user);

    await userRef.set({
      'av-compartidos': _user.avCompartidos,
    }, SetOptions(merge: true));

    notifyListeners();
  }

  Future<void> actualizarConstruidos() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection('usuarios').doc(user!.uid);

    _user.avConstruidos = _user.avConstruidos! + 1;
    _localDB.setUsuario(_user);

    await userRef.set({
      'av-construidos': _user.avConstruidos,
    }, SetOptions(merge: true));

    notifyListeners();
  }

  void actualizarConstancia() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection('usuarios').doc(user!.uid);

    _user.actualConstancia = _user.actualConstancia! + 1;

    if (_user.actualConstancia! > _user.mejorConstancia!) {
      _user.mejorConstancia = _user.actualConstancia;
      await userRef.set({
        'actual-constancia': _user.actualConstancia,
        'mejor-constancia': _user.mejorConstancia,
      }, SetOptions(merge: true));
    } else {
      await userRef.set({
        'actual-constancia': _user.actualConstancia,
      }, SetOptions(merge: true));
    }

    _localDB.setUsuario(_user);

    notifyListeners();
  }

  void restablecerConstancia() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection('usuarios').doc(user!.uid);

    _user.actualConstancia = 1;
    _localDB.setUsuario(_user);

    await userRef.set({
      'actual-constancia': _user.actualConstancia,
    }, SetOptions(merge: true));
    _constanciaRestablecida = false;
    notifyListeners();
  }

  bool? get sesionIniciada => _sesionIniciada;

  //GETTER AND SETTERS
  bool get constanciaRestablecida => _constanciaRestablecida;

  set constanciaRestablecida(bool constanciaRestablecida) {
    _constanciaRestablecida = constanciaRestablecida;
  }

  Usuario get usuario => _user;
  GoogleSignInAccount? get googleUser => _googleUser;
}
