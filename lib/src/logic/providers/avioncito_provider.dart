import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/models/avioncito_model.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:webfeed/webfeed.dart';

class AvioncitoProvider with ChangeNotifier {
  late Avioncito _avioncito;
  List<Avioncito> _avioncitosGuardados = [];
  List<Avioncito> _avioncitos = [];
  // late int _dia;
  bool _avioncitoListo = false;
  bool _nuevoDia = false;
  late int nAvioncito;
  Box? avioncitosBox;
  // compartir avioncito
  bool _compartirAvioncito = false;
  String _tiempoLiturgico = '';
  String _lectura = '';
  String _tituloLectura = '';

  final FirebaseFirestore _fireDB = FirebaseFirestore.instance;
  final LocalData _localDB = LocalData();
  final prefs = PreferenciasUsuario();

  Future<void> primerInicio() async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        await getAvioncitoFromLocal().then((avioncitosListos) async {
          if (avioncitosListos) {
            await getAvioncitoHoy().then((listo) {
              if (listo) {
                _avioncitoListo = true;
                notifyListeners();
              }
            });
          }
        });
      }
    });
  }

  Future<void> mismoAvioncito() async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        await getAvioncitoHoy().then((listo) {
          if (listo) {
            _avioncitoListo = true;
            notifyListeners();
          }
        });
      }
    });
  }

  Future<void> nuevoAvioncito() async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        await getAvioncitoFromLocal().then((avioncitosListos) async {
          if (avioncitosListos) {
            await getAvioncitoHoy().then((listo) {
              if (listo) {
                _avioncitoListo = true;
                notifyListeners();
              }
            });
          }
        });
      }
    });
  }

  Future<bool> getAvioncitoFromLocal() async {
    avioncitosBox = _localDB.getAvioncitos();
    if (avioncitosBox!.isEmpty) {
      await getAvioncitosFromFirestore().then((listo) {
        if (listo) {
          // nAvioncito = Random().nextInt(_avioncitos.length);
          _avioncito = _localDB.getAvioncitoHoy();
          _avioncito.fecha = DateTime.now();
          _localDB.setAvioncitoHoy(_avioncito);
          _localDB.deleteAvioncitoHoy();
          return true;
        }
      });
    } else {
      _avioncito = _localDB.getAvioncitoHoy();
      _avioncito.fecha = DateTime.now();
      _avioncito.visto = true;
      _localDB.setAvioncitoHoy(_avioncito);
      _localDB.deleteAvioncitoHoy();
    }
    return true;
  }

  Future<bool> getAvioncitosFromFirestore() async {
    _avioncitos.clear();
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
        _avioncitos.add(av);
      }
      _avioncitos.shuffle();
      _localDB.setAvioncitos(_avioncitos);
      retVal = true;
    });
    return retVal;
  }

  Future<bool> getAvioncitoHoy() async {
    _avioncito = await _localDB.getHoy()!.get(0);
    return true;
  }

  Box getGuardadosFromLocal() {
    return _localDB.guardadosBox!;
  }

  Future<bool> guardarAvioncito(Avioncito avioncitoGuardado) async {
    if (avioncitoGuardado.id == _avioncito.id) {
      _localDB.guardarAvioncito(true);
    }
    avioncitoGuardado.guardado = true;
    _localDB.setGuardados(avioncitoGuardado.id, avioncitoGuardado);
    notifyListeners();
    return true;
  }

  Future<bool> noGuardarAvioncito(Avioncito avioncitoGuardado) async {
    if (avioncitoGuardado.id == _avioncito.id) {
      _avioncito.guardado = false;
      _localDB.guardarAvioncito(false);
    }
    avioncitoGuardado.guardado = false;
    _localDB.deleteGuardado(avioncitoGuardado.id);
    notifyListeners();
    return true;
  }

  Future<bool> eliminarDB() async {
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
    _compartirAvioncito = compartirAvioncito;
    notifyListeners();
  }
  bool get compartirAvioncito => _compartirAvioncito;
  Avioncito? get avioncito => _avioncito;
  String get tiepoLiturgico => _tiempoLiturgico;
  String get lectura => _lectura;
  String get tituloLectura => _tituloLectura;
  List<Avioncito> get avioncitosGuardados => _avioncitosGuardados;
  bool get avioncitoListo => _avioncitoListo;
  bool get nuevoDia => _nuevoDia;
  set setNuevoDia(bool estado) {
    _nuevoDia = estado;
  }
}
