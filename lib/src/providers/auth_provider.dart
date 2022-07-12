import 'package:bienaventurados/src/data/local/local_db.dart';
import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/models/models.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth;
  GoogleSignInAccount? _googleUser;
  LocalUser _user = LocalUser();
  late String _displayName;
  bool restartConstancy = false;
  bool increaseConstancy = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final LocalData _localDB = LocalData();
  bool? _isLoggedIn;
  Box? userBox;

  AuthProvider.instance({bool? isLoggedIn}) : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      _isLoggedIn = false;
    } else {
      await getUserData(firebaseUser.uid);
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  Future<bool> getUserData(String uid) async {
    await _localDB.openBox().then((result) async {
      if (result) {
        final prefs = UserPreferences();

        //TODO 1.4.4 - PASO 3 usuario - MIGRACION DE USUARIO FIRESTORE Y LOCAL
        if (!prefs.migratedUser) {
          // MIGRACION DE USUARIO FIRESTORE
          print('INICIANDO MIGRACION DE USUARIO FIRESTORE');
          await migrateUserDB().then((result) {
            if (result) {
              print('USUARIOS MIGRADOS CORRECTAMENTE');
            } else {
              print('ERROR');
            }
          });
          // MIGRACION DE USUARIO LOCAL
          print('MIGRACION DE USUARIO LOCAL');
          DocumentSnapshot userSnap = await _db
              .collection(COLLECTION_USERS)
              .doc(_auth.currentUser!.uid)
              .get();
          _user.setFromFirestore(userSnap);
          _localDB.setUser(_user);

          prefs.migratedUser = true;
        } else {
          ///
          userBox = _localDB.getUser();
          if (userBox!.isEmpty) {
            print('USUARIO DESDE FIREBASE');
            DocumentSnapshot userSnap =
                await _db.collection(COLLECTION_USERS).doc(uid).get();
            _user.setFromFirestore(userSnap);
            _localDB.setUser(_user);
          } else {
            print('USUARIO DESDE LOCAL');
            _user = userBox!.getAt(0);
          }
        }
      }
    });

    return true;
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    String? message = '';
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        //auth.User user = authResult.user!;
        _isLoggedIn = true;
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

  Future<auth.User?> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    auth.User? _user;
    try {
      final UserCredential authResult = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        auth.User user = authResult.user!;
        _isLoggedIn = true;
        _displayName = name;
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
      _isLoggedIn = true;
      _displayName = user.displayName!.split(' ')[0].toString();
      if (authResult.additionalUserInfo!.isNewUser) {
        print('ESTE USUARIO ES NUEVO');
        await createUserData(user);
      } else {
        print('ESTE USUARIO YA TENIA CUENTA');
        await updateUserData();
      }

      return user;
    } catch (e) {
      print('error $e');
      return null;
    }
  }

  Future<DocumentSnapshot> createUserData(auth.User user) async {
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(user.uid);
    final currentUser = _auth.currentUser;

    userRef.set({
      'uid': user.uid,
      'username': _displayName,
      'email': user.email,
      'role': 'bienaventurado',
      'img': 'perfil-01',
      'type': 'bienaventurado',
      'connection': {
        'firstConnection': DateTime.now(),
        'lastConnection': DateTime.now(),
      },
      'level': 1,
      'stats': {
        'total-xp': 0,
        'action': 0,
        'formation': 0,
        'devotion': 0,
        'prayer': 0,
        'pplanes-builded': 0,
        'pplanes-shared': 0,
        'constancy': 1,
        'best-constancy': 1,
      },
    }, SetOptions(merge: true));

    currentUser!.updateDisplayName(_displayName);

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  Future<DocumentSnapshot> updateUserData() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(user!.uid);

    await userRef.set({
      'connection': {
        'lastConnection': DateTime.now(),
      },
      'stats': {
        'constancy': 1,
      }
    }, SetOptions(merge: true));

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  Future<bool> updateUsername(String username) async {
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(_user.uid);
    final currentUser = _auth.currentUser;

    await userRef.set({
      'username': username,
    }, SetOptions(merge: true));

    _user.username = username;
    currentUser!.updateDisplayName(_displayName);
    notifyListeners();

    return true;
  }

  Future<bool> updateEmail(String email) async {
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(_user.uid);
    final currentUser = _auth.currentUser;

    if (currentUser!.providerData[0].providerId == GOOGLE_DOMAIN) {
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = auth.GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await _auth.signInWithCredential(credential);
    }

    await userRef.set({
      'email': email,
    }, SetOptions(merge: true));
    _user.email = email;
    currentUser.updateEmail(email);
    notifyListeners();

    return true;
  }

  Future<bool> updatePassword(String password, String newPassword) async {
    final credential;
    final user = _auth.currentUser;
    if (user!.providerData[0].providerId == GOOGLE_DOMAIN) {
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      credential = auth.GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      user.reauthenticateWithCredential(credential);
      //UserCredential authResult = await _auth.signInWithCredential(credential);
      //final currentUser = authResult.user;
    } else if (user.providerData[0].providerId == EMAIL_DOMAIN) {
      credential =
          EmailAuthProvider.credential(email: user.email!, password: password);
      user.reauthenticateWithCredential(credential);
    }
    user.updatePassword(newPassword).then((result) {
      user.updatePassword(newPassword);
    });
    user.reload();
    notifyListeners();

    return true;
  }

  Future<bool> restorePassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      auth.User user = _auth.currentUser!;
      DocumentReference userRef =
          _db.collection(COLLECTION_USERS).doc(user.uid);
      userRef.delete();
      user.delete();
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
  Future<void> updatePaperplanesShared() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(user!.uid);

    _user.pplanesShared = _user.pplanesShared! + 1;
    _localDB.setUser(_user);

    await userRef.set({
      'stats': {
        'pplanes-shared': _user.pplanesShared,
      }
    }, SetOptions(merge: true));

    notifyListeners();
  }

  Future<void> updatePaperplanesBuilded() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(user!.uid);

    _user.pplanesBuilded = _user.pplanesBuilded! + 1;
    _localDB.setUser(_user);

    await userRef.set({
      'stats': {
        'pplanes-builded': _user.pplanesBuilded,
      }
    }, SetOptions(merge: true));

    notifyListeners();
  }

  void updateConstancy() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(user!.uid);

    _user.bestConstancy = _user.bestConstancy! + 1;

    if (_user.constancy! > _user.bestConstancy!) {
      _user.bestConstancy = _user.constancy;
      await userRef.set({
        'stats': {
          'constancy': _user.constancy,
          'best-constancy': _user.bestConstancy,
        }
      }, SetOptions(merge: true));
    } else {
      await userRef.set({
        'stats': {
          'best-constancy': _user.constancy,
        }
      }, SetOptions(merge: true));
    }
    increaseConstancy = false;
    _localDB.setUser(_user);

    notifyListeners();
  }

  void restoreConstancy() async {
    final user = _auth.currentUser;
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(user!.uid);

    _user.constancy = 1;
    _localDB.setUser(_user);

    await userRef.set({
      'stats': {
        'constancy': _user.constancy,
      }
    }, SetOptions(merge: true));
    restartConstancy = false;
    notifyListeners();
  }

  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4
  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4
  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4

  Future<bool> migrateUserDB() async {
    final user = _auth.currentUser;
    await _db.collection('usuarios').doc(user!.uid).get().then((userResult) {
      if (userResult.exists) {
        migrateUser(userResult);
        _db.collection('usuarios').doc(user.uid).delete();
        print("ELIMINACION DE DOCUMENTO ${user.uid} EN DB USUARIOS");
      } else {
        print('ESTE USUARIO YA FUE MIGRADO');
      }
    });
    return true;
  }

  void migrateUser(DocumentSnapshot usuarioDoc) async {
    Map usuarioData = usuarioDoc.data()! as Map;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference userRef = _db.collection('users').doc(usuarioDoc.id);

    userRef.set({
      'uid': usuarioDoc.id,
      'username': usuarioData['nombre'],
      'email': usuarioData['correo'],
      'role': usuarioData['clase'],
      'img': 'perfil-01',
      'type': 'bienaventurado',
      'connection': {
        'firstConnection': usuarioData['primeraConexion'],
        'lastConnection': usuarioData['ultimaConexion'],
      },
      'level': 1,
      'stats': {
        'total-xp': 0,
        'action': 0,
        'formation': 0,
        'devotion': 0,
        'prayer': 0,
        'pplanes-builded': usuarioData['av-construidos'] ?? 0,
        'pplanes-shared': usuarioData['av-compartidos'] ?? 0,
        'constancy': usuarioData['actual-constancia'] ?? 1,
        'best-constancy': usuarioData['mejor-constancia'] ?? 1,
      },
    }, SetOptions(merge: true));
  }

  ////////////////////////////////////////
  ////////////////////////////////////////
  ////////////////////////////////////////

  /*
    TODO 1.4.5 - PASO 1 - CARGA DE COLECCIONES FIRESTORE
  */
  Future<bool> updateCollectionData(String collectible, bool condition) async {
    final auth = FirebaseAuth.instance;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference userRef =
        _db.collection('users').doc(auth.currentUser!.uid);
    print('HOLA USUARIO ${auth.currentUser!.uid}');
    userRef.set({
      'collections': {
        '$collectible': condition,
      },
    }, SetOptions(merge: true));
    return true;
  }

  /*
    TODO 1.4.5 - PASO 1 - CARGA DE INSIGNIAS FIRESTORE
  */
  Future<bool> updateAchievementData(String achievement, bool condition) async {
    final auth = FirebaseAuth.instance;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference userRef =
        _db.collection('users').doc(auth.currentUser!.uid);
    print('HOLA USUARIO ${auth.currentUser!.uid}');
    userRef.set({
      'achievements': {
        '$achievement': condition,
      },
    }, SetOptions(merge: true));
    return true;
  }

  bool? get isLoggedIn => _isLoggedIn;

  LocalUser get user => _user;
  GoogleSignInAccount? get googleUser => _googleUser;
}
