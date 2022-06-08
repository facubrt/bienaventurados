import 'package:bienaventurados/src/data/local/local_db.dart';
import 'package:bienaventurados/src/models/avioncito_model.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:webfeed/webfeed.dart';

class PaperplaneProvider with ChangeNotifier {
  late Avioncito _paperplane;
  List<Avioncito> _paperplanesSaved = [];
  List<Avioncito> _paperplanes = [];
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

  Future<bool> getPaperplanesFromLocal() async {
    generateUniquePaperplane();
    paperplanesBox = _localDB.getAvioncitos();
    if (paperplanesBox!.isEmpty) {
      await getPaperplanesFromFirestore().then((listo) {
        if (listo) {
          // nAvioncito = Random().nextInt(_avioncitos.length);
          _paperplane = _localDB.getAvioncitoHoy();
          _paperplane.fecha = DateTime.now();
          _localDB.setAvioncitoHoy(_paperplane);
          _localDB.deleteAvioncitoHoy();
          return true;
        }
      });
    } else {
      _paperplane = _localDB.getAvioncitoHoy();
      _paperplane.fecha = DateTime.now();
      _paperplane.visto = true;
      _localDB.setAvioncitoHoy(_paperplane);
      _localDB.deleteAvioncitoHoy();
    }
    return true;
  }

  Future<bool> getPaperplanesFromFirestore() async {
    _paperplanes.clear();
    bool retVal = false;
    await _fireDB
        .collection('datosApp')
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
        Avioncito av = Avioncito.fromFirestore(snapshot.docs[i]);
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
    return _localDB.guardadosBox!;
  }

  Future<bool> savePaperplane(Avioncito paperplane) async {
    if (paperplane.id == _paperplane.id) {
      _localDB.guardarAvioncito(true);
    }
    paperplane.guardado = true;
    _localDB.setGuardados(paperplane.id, paperplane);
    notifyListeners();
    return true;
  }

  Future<bool> dontSavePaperplane(Avioncito paperplane) async {
    if (paperplane.id == _paperplane.id) {
      _paperplane.guardado = false;
      _localDB.guardarAvioncito(false);
    }
    paperplane.guardado = false;
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

  // LECTURA DEL DIA
  /*
  Future<bool> getLectura() async {
    String _day = DateTime.now().day.toString().padLeft(2, '0');
    String _month = DateTime.now().month.toString().padLeft(2, '0');
    String _year = DateTime.now().year.toString();
    String feedURL =
        'http://feed.evangelizo.org/v2/reader.php?date=20220101&lang=SP&type=all';
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(feedURL));
      _lectura = RssFeed.parse(response.body).toString();
      notifyListeners();
    } catch (e) {
      //
    }
    return true;
  }
*/

  /*
  Future<bool> getTiempoLiturgico() async {
    String _day = DateTime.now().day.toString().padLeft(2, '0');
    String _month = DateTime.now().month.toString().padLeft(2, '0');
    String _year = DateTime.now().year.toString();
    String url =
        'http://feed.evangelizo.org/v2/reader.php?date=$_year$_month$_day&lang=SP&type=liturgic_t&content=FR';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      _tiempoLiturgico = response.body;
      notifyListeners();
    } else {
      throw Exception();
    }

    return true;
  }
  */

  set compartirAvioncito(bool compartirAvioncito) {
    _sharePaperplane = compartirAvioncito;
    notifyListeners();
  }

  bool get compartirAvioncito => _sharePaperplane;
  Avioncito? get paperplane => _paperplane;
  String get liturgicalTime => _liturgicalTime;
  String get gospel => _gospel;
  String get gospelTitle => _gospelTitle;
  List<Avioncito> get paperplanesSaved => _paperplanesSaved;
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
        Avioncito av = Avioncito.fromFirestore(snapshot.docs[i]);
        _buildPaperplane(av);
      }
      retVal = true;
    });
    return retVal;
  }

  void _buildPaperplane(Avioncito av) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference pplanesRef = _db
        .collection('appData')
        .doc('pplanesData')
        .collection('pplanes')
        .doc();
    generateUniquePaperplane();
    pplanesRef.set({
      'id': pplanesRef.id,
      'quote': av.frase,
      'source': av.santo,
      'inspiration': av.reflexion,
      'illustration': {
        'background': _background,
        'base': _base,
        'detail': _detail,
        'pattern': _pattern,
        'stamp': _stamp,
        'wings': _wings
      },
      'category': av.tag,
      'user': av.usuario,
    });
  }
  ////////////////////////////////////////
}
