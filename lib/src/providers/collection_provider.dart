import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/data/local/collections_data.dart';
import 'package:bienaventurados/src/data/local/local_db.dart';
import 'package:bienaventurados/src/models/coleccion_model.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CollectionProvider with ChangeNotifier {
  // String? _actualConexion;
  // String? _ultimaConexion;
  int? _day;
  int? _month;
  bool _collectibleUnlocked = false;
  Coleccion? _collectible;
  final LocalData _localDB = LocalData();
  final prefs = UserPreferences();

  Future<void> getAllCollections() async {
    /*
    TODO 1.4.5 - PASO 6 - CARGA DE COLECCIONES DESDE FIRESTORE
    */
    await _localDB.openBox().then((result) async {
      if (result) {
        print('longitud de Colecciones ${Collections.allCollections.length}');
        for (var i = 0; i < Collections.allCollections.length; i++) {
          _localDB.setColecciones(Collections.allCollections[i], false);
        }
      }
    });
  }

  Future<bool> openCollectionsBox() async {
    bool result = false;
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        result = true;
      }
    });
    return result;
  }

  /*
    TODO 1.4.5 - PASO 4 - ACTUALIZACION DE COLECCIONES FIRESTORE
  */
  Future<void> collectionsCheck() async {
    _day = DateTime.now().day;
    _month = DateTime.now().month;
    _collectibleUnlocked = false;
    prefs.collectionUnlocked = false;
    await _localDB.openBox().then((result) async {
      if (result) {
        for (var i = 0; i < Collections.allCollections.length - 1; i++) {
          if ((_day == Collections.allCollections[i].dia) &&
              (_month == Collections.allCollections[i].mes)) {
            //setColeccion(i, Colecciones.colecciones[i], true);
            prefs.collectionUnlocked = true;
            _collectibleUnlocked = true;
            _collectible = Collections.allCollections[i];
            _localDB.setColeccionDesbloqueada(_collectible!);
          }
        }
      }
    });
    if (_collectibleUnlocked) {
      print('DESBLOQUEASTE UNA COLECCION ${_collectible!.titulo}');
    } else {
      print('NO HAY NADA PARA DESBLOQUEAR');
    }
    notifyListeners();
  }

  Future<bool> getCollectibleUnlocked() async {
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        //print('OBTENIENDO AVIONCITO DE HOY');
        _collectible = await _localDB.getColeccionDesbloqueada()!.get(0);
        _collectibleUnlocked = true;
        notifyListeners();
      }
    });
    return true;
  }

  Future<bool> setCollectible(Coleccion collectible, bool isUnlocked) async {
    _localDB.setColecciones(collectible, isUnlocked);
    notifyListeners();
    return true;
  }

  Box getCollections() {
    return _localDB.coleccionesBox!;
  }

  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4
  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4
  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4

  Future<bool> updateAllCollectionData(String uid, Map collections) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(uid);
    userRef.set({
      'collections': collections,
    }, SetOptions(merge: true));
    return true;
  }

  ////////////////////////////////////////
  ////////////////////////////////////////
  ////////////////////////////////////////

  Coleccion? get collectible => _collectible ?? null;
  bool get collectibleUnlocked => _collectibleUnlocked;
  set setCollectibleUnlocked(bool isUnlocked) {
    _collectibleUnlocked = isUnlocked;
    prefs.collectionUnlocked = isUnlocked;
    notifyListeners();
  }
}
