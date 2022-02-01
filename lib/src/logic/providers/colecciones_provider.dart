import 'package:bienaventurados/src/data/datasources/local/colecciones_data.dart';
import 'package:bienaventurados/src/data/datasources/local/colecciones_data.dart';
import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/models/coleccion_model.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ColeccionesProvider with ChangeNotifier {

  String? _actualConexion;
  String? _ultimaConexion;
  int? _dia;
  int? _mes;
  bool _coleccionDesbloqueada = false;
  Coleccion? _coleccion;
  final LocalData _localDB = LocalData();
  final prefs = PreferenciasUsuario();

  Future<void> configuracionInicial () async {
    await _localDB.initLocalData().then((iniciado) {
      if (iniciado) {
        //comprobacionRacha();
        comprobacionDia();
      }
    });
  }

  Future<void> comprobacionDia() async {
    _actualConexion = DateTime.now().day.toString();
    _ultimaConexion = prefs.ultimaConexion;
    if (_ultimaConexion != null) {
      if (_actualConexion == _ultimaConexion) {
        print('MISMO DIA');
        _coleccionDesbloqueada = prefs.coleccionDesbloqueada;
      } else {
        print('NUEVO DIA');
        prefs.ultimaConexion = _actualConexion;
        comprobacionColecciones();
      }
    } else {
      print('PRIMERA VEZ');
      prefs.ultimaConexion = _actualConexion;
      crearColecciones();
    }
  }

  void crearColecciones() {
    for (var i = 0; i < Colecciones.colecciones.length - 1; i++) {
      _localDB.setColecciones(i, Colecciones.colecciones[i], false);
    }
    int _nColecciones = _localDB.getColecciones()!.length;
    print('TENES $_nColecciones COLECCIONES');
  }

  void comprobacionColecciones() {
    _dia = DateTime.now().day;
    _mes = DateTime.now().month;

    for (var i = 0; i < Colecciones.colecciones.length - 1; i++) {
        if((_dia == Colecciones.colecciones[i].dia) && (_mes == Colecciones.colecciones[i].mes)) {
          print('DESBLOQUEASTE LA COLECCION ${Colecciones.colecciones[i].titulo}');
          //setColeccion(i, Colecciones.colecciones[i], true);
          prefs.coleccionDesbloqueada = true;
          _coleccionDesbloqueada = true;
          _coleccion = Colecciones.colecciones[i];
        } 
      }
  }

  Future<bool> setColeccion(int index, Coleccion coleccion, bool desbloqueado) async {
    _localDB.setColecciones(index, coleccion, desbloqueado);
    notifyListeners();
    return true;
  }

  Box getColeccion() {
    return _localDB.coleccionesBox!;
  }

  Coleccion? get coleccion => _coleccion ?? null;
  bool get coleccionDesbloqueada => _coleccionDesbloqueada;
  set setColeccionDesbloqueada(bool desbloqueado) {
    _coleccionDesbloqueada = desbloqueado;
    notifyListeners();
  }
}