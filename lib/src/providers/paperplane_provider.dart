import 'dart:math';

import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/data/local/local_db.dart';
import 'package:bienaventurados/src/models/paperplane_model.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:webfeed/webfeed.dart';

class PaperplaneProvider with ChangeNotifier {
  late Paperplane _paperplane;
  List<Paperplane> _paperplanesSaved = [];
  List<Paperplane> _paperplanes = [];
  bool _isPaperplane = false;
  bool _newDay = false;
  late int nPaperplane;
  Box? paperplanesBox;
  // compartir avioncito
  bool _sharePaperplane = false;
  String _liturgicalTime = '';
  String _gospel = '';
  String _gospelTitle = '';
  // CREATOR
  String _background = 'background-01';
  String _pattern = 'pattern-01';
  String _base = 'base-01';
  String _wings = 'wings-01';
  String _stamp = 'stamp-01';
  String _detail = 'detail-01';

  final FirebaseFirestore _fireDB = FirebaseFirestore.instance;
  final LocalData _localDB = LocalData();
  final prefs = UserPreferences();

  Future<void> firstTime() async {
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        await getPaperplanesFromLocal().then((isPaperplanes) async {
          if (isPaperplanes) {
            await getPaperplaneToday().then((result) {
              if (result) {
                _isPaperplane = true;
                notifyListeners();
              }
            });
          }
        });
      }
    });
  }

  // MIGRACION DE AVIONCITOS LOCAL 1.4.4
  Future<void> migrateLocalPaperplanes() async {
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        await getPaperplanesFromFirestore().then((isPaperplanes) async {
          if (isPaperplanes) {
            await getPaperplaneToday().then((result) {
              if (result) {
                _isPaperplane = true;
                notifyListeners();
              }
            });
          }
        });
      }
    });
  }

  Future<void> isToday() async {
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        await getPaperplaneToday().then((result) {
          if (result) {
            _isPaperplane = true;
            notifyListeners();
          }
        });
      }
    });
  }

  Future<void> isNewDay() async {
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        await getPplaneFromFirestore().then((isPaperplane) async {
          print('AVIONCITO OBTENIDO DE FIRESTORE');
          // await getPaperplaneToday().then((result) {
          //   if (result) {
          //     _isPaperplane = true;
          //     notifyListeners();
          //   }
          // });
        });
        // await getPaperplanesFromLocal().then((isPaperplanes) async {
        //   if (isPaperplanes) {
        //     await getPaperplaneToday().then((result) {
        //       if (result) {
        //         _isPaperplane = true;
        //         notifyListeners();
        //       }
        //     });
        //   }
        // });
      }
    });
  }

  Future<bool> getPplaneFromFirestore() async {
    bool retVal = false;
    String idPplane;

    DocumentReference pplanesDataRef = _fireDB
        .collection(COLLECTION_APPDATA)
        .doc(COLLECTION_APPDATA_PPLANESDATA);
    pplanesDataRef.get().then((pplanesDoc) {
      Map pplanesData = pplanesDoc.data()! as Map;
      int nPplane = Random().nextInt(pplanesData['pplanes-builded']);
      idPplane = pplanesData['pplanes-list'][nPplane];
      print('TOCA EL AVIONCITO $nPplane que tiene el id $idPplane');
      pplanesDataRef
          .collection('pplanes')
          .doc(idPplane)
          .get()
          .then((pplaneResult) {
        if (pplaneResult.exists) {
          _paperplane = Paperplane.fromFirestore(pplaneResult);
          print(_paperplane.quote);
          _localDB.setTodayPaperplane(_paperplane);
        }
      });
    });

    return retVal;
  }

  // Future<bool> setPplaneLocal(int nPplane) async {}

  Future<bool> getPaperplanesFromLocal() async {
    //generateUniquePaperplane();
    paperplanesBox = _localDB.getPaperplanes();
    if (paperplanesBox!.isEmpty) {
      await getPaperplanesFromFirestore().then((listo) {
        if (listo) {
          // nAvioncito = Random().nextInt(_avioncitos.length);
          _paperplane = _localDB.getTodayPaperplane();
          _paperplane.date = DateTime.now();
          _localDB.setTodayPaperplane(_paperplane);
          _localDB.deleteTodayPaperplane();
          return true;
        }
      });
    } else {
      _paperplane = _localDB.getTodayPaperplane();
      _paperplane.date = DateTime.now();
      //_paperplane.visto = true;
      _localDB.setTodayPaperplane(_paperplane);
      _localDB.deleteTodayPaperplane();
    }
    return true;
  }

  Future<bool> getPaperplanesFromFirestore() async {
    _paperplanes.clear();
    bool retVal = false;
    await _fireDB
        .collection(COLLECTION_APPDATA)
        .doc(COLLECTION_APPDATA_PPLANESDATA)
        .collection(COLLECTION_APPDATA_PPLANESDATA_PPLANES)
        .get()
        .then((QuerySnapshot snapshot) async {
      print('${snapshot.docs.length} AVIONCITOS ENCONTRADOS EN FIRESTORE');
      int _diasRestantes = DateTime(DateTime.now().year + 1, 1, 1, 0, 0)
          .difference(DateTime.now())
          .inDays;
      int _lenght = snapshot.docs.length;
      if (_diasRestantes < snapshot.docs.length) {
        _lenght = _diasRestantes;
      }
      for (var i = 0; i < _lenght; i++) {
        Paperplane av = Paperplane.fromFirestore(snapshot.docs[i]);
        _paperplanes.add(av);
      }
      _paperplanes.shuffle();
      _localDB.setAvioncitos(_paperplanes);
      retVal = true;
    });
    return retVal;
  }

  Future<bool> getPaperplaneToday() async {
    _paperplane = await _localDB.getHoy()!.get(0);
    return true;
  }

  Box getSavedFromLocal() {
    return _localDB.savedBox!;
  }

  Future<bool> savePaperplane(Paperplane paperplane) async {
    _fireDB
        .collection(COLLECTION_APPDATA)
        .doc(COLLECTION_APPDATA_PPLANESDATA)
        .collection(COLLECTION_APPDATA_PPLANESDATA_PPLANES)
        .doc(paperplane.id)
        .update({'likes': FieldValue.increment(1)});

    _paperplane.likes = _paperplane.likes! + 1;
    if (paperplane.id == _paperplane.id) {
      _localDB.savePaperplane(true, 1);
    }
    paperplane.saved = true;
    _localDB.setSavedPaperplanes(paperplane.id, paperplane);
    notifyListeners();
    return true;
  }

  Future<bool> dontSavePaperplane(Paperplane paperplane) async {
    _fireDB
        .collection(COLLECTION_APPDATA)
        .doc(COLLECTION_APPDATA_PPLANESDATA)
        .collection(COLLECTION_APPDATA_PPLANESDATA_PPLANES)
        .doc(paperplane.id)
        .update({'likes': FieldValue.increment(-1)});

    _paperplane.likes = _paperplane.likes! - 1;
    if (paperplane.id == _paperplane.id) {
      _paperplane.saved = false;
      _localDB.savePaperplane(false, -1);
    }
    paperplane.saved = false;
    _localDB.deleteGuardado(paperplane.id);
    notifyListeners();
    return true;
  }

  void generateUniquePaperplane() {
    int _randBackground = getRandomInt(6);
    int _randPattern = getRandomInt(7);
    int _randBase = getRandomInt(6);
    int _randWings = getRandomInt(6);
    int _randStamp = getRandomInt(7);
    int _randDetail = getRandomInt(7);
    background = 'background-${_randBackground.toString().padLeft(2, '0')}';
    pattern = 'pattern-${_randPattern.toString().padLeft(2, '0')}';
    base = 'base-${_randBase.toString().padLeft(2, '0')}';
    wings = 'wings-${_randWings.toString().padLeft(2, '0')}';
    stamp = 'stamp-${_randStamp.toString().padLeft(2, '0')}';
    detail = 'detail-${_randDetail.toString().padLeft(2, '0')}';
  }

  Future<bool> deleteAllData() async {
    await _localDB.deleteData();
    return true;
  }

  set compartirAvioncito(bool compartirAvioncito) {
    _sharePaperplane = compartirAvioncito;
    notifyListeners();
  }

  bool get compartirAvioncito => _sharePaperplane;
  Paperplane? get paperplane => _paperplane;
  String get liturgicalTime => _liturgicalTime;
  String get gospel => _gospel;
  String get gospelTitle => _gospelTitle;
  List<Paperplane> get paperplanesSaved => _paperplanesSaved;
  bool get isPaperplane => _isPaperplane;
  bool get newDay => _newDay;
  set setNewDay(bool state) {
    _newDay = state;
  }

  //CREATOR

  String get background => _background;
  set background(String background) {
    _background = background;
    notifyListeners();
  }

  String get pattern => _pattern;
  set pattern(String pattern) {
    _pattern = pattern;
    notifyListeners();
  }

  String get base => _base;
  set base(String base) {
    _base = base;
    notifyListeners();
  }

  String get wings => _wings;
  set wings(String wings) {
    _wings = wings;
    notifyListeners();
  }

  String get stamp => _stamp;
  set stamp(String stamp) {
    _stamp = stamp;
    notifyListeners();
  }

  String get detail => _detail;
  set detail(String detail) {
    _detail = detail;
    notifyListeners();
  }

  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4
  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4
  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4
  Future<bool> createListPaperplanesDB() async {
    List<String> _listaAvioncitos = [];
    bool retVal = false;
    await _fireDB
        .collection('appData')
        .doc('pplanesData')
        .collection('pplanes')
        .get()
        .then((QuerySnapshot snapshot) async {
      print('${snapshot.docs.length} AVIONCITOS ENCONTRADOS EN FIRESTORE');
      int _lenght = snapshot.docs.length;
      for (var i = 0; i < _lenght; i++) {
        _listaAvioncitos.add(snapshot.docs[i].id);
      }
      uploadListPaperplane(_listaAvioncitos);
      print('${snapshot.docs.length} AVIONCITOS AGREGADOS A LA LISTA');
      retVal = true;
    });
    return retVal;
  }

  void uploadListPaperplane(List<String> lista) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference pplanesListRef;
    pplanesListRef =
        _db.collection(COLLECTION_APPDATA).doc(COLLECTION_APPDATA_PPLANESDATA);

    pplanesListRef.set({
      'pplanes-list': lista,
      'pplanes-builded': lista.length,
    }, SetOptions(merge: true));
  }

  Future<bool> migratePaperplanesDB() async {
    _paperplanes.clear();
    bool retVal = false;
    await _fireDB
        .collection('datosApp')
        .get()
        .then((QuerySnapshot snapshot) async {
      print('${snapshot.docs.length} AVIONCITOS ENCONTRADOS EN FIRESTORE');
      int _lenght = snapshot.docs.length;
      for (var i = 0; i < _lenght; i++) {
        Paperplane paperplane = Paperplane.fromFirestore(snapshot.docs[i]);
        buildPaperplane(
            paperplane.quote!,
            paperplane.source!,
            paperplane.inspiration!,
            paperplane.category!,
            paperplane.user!,
            true);
      }
      retVal = true;
    });
    return retVal;
  }
  ////////////////////////////////////////
  ////////////////////////////////////////
  ////////////////////////////////////////

  void buildPaperplane(String quote, String source, String inspiration,
      String category, String user, bool isAdmin) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference pplanesRef;
    if (isAdmin) {
      pplanesRef = _db
          .collection(COLLECTION_APPDATA)
          .doc(COLLECTION_APPDATA_PPLANESDATA)
          .collection(COLLECTION_APPDATA_PPLANESDATA_PPLANES)
          .doc();
    } else {
      pplanesRef = _db
          .collection(COLLECTION_USERSDATA)
          .doc(COLLECTION_USERSDATA_PPLANESBUILDED)
          .collection(COLLECTION_USERSDATA_PPLANESBUILDED_PPLANES)
          .doc();
    }
    generateUniquePaperplane();
    pplanesRef.set({
      'id': pplanesRef.id,
      'quote': quote,
      'source': source,
      'inspiration': inspiration,
      'illustration': {
        'background': _background,
        'base': _base,
        'detail': _detail,
        'pattern': _pattern,
        'stamp': _stamp,
        'wings': _wings
      },
      'category': category,
      'likes': 0,
      'user': user,
    });

    _db
        .collection(COLLECTION_APPDATA)
        .doc(COLLECTION_APPDATA_PPLANESDATA)
        .update({
      'pplanes-builded': FieldValue.increment(1),
      'pplanes-list': FieldValue.arrayUnion([pplanesRef.id]),
    });
  }

  void reportPaperplane(String id, String user) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference pplanesRef = _db
        .collection(COLLECTION_USERSDATA)
        .doc(COLLECTION_USERSDATA_PPLANESREPORTED)
        .collection(COLLECTION_USERSDATA_PPLANESREPORTED_PPLANES)
        .doc();
    pplanesRef.set({
      'id': id,
      'user': user,
    });
  }

  void deletePplanesUsersData(String? id) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference paperplaneRef = _db
        .collection(COLLECTION_USERSDATA)
        .doc(COLLECTION_USERSDATA_PPLANESBUILDED)
        .collection(COLLECTION_USERSDATA_PPLANESBUILDED_PPLANES)
        .doc(id);
    paperplaneRef.delete();
    print('SE ELIMINÓ AVIONCITO $id');
  }
}
