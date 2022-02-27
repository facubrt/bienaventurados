import 'package:bienaventurados/src/data/datasources/local/colecciones_data.dart';
import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/models/coleccion_model.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ColeccionesProvider with ChangeNotifier {
  // String? _actualConexion;
  // String? _ultimaConexion;
  int? _dia;
  int? _mes;
  bool _coleccionDesbloqueada = false;
  Coleccion? _coleccion;
  final LocalData _localDB = LocalData();
  final prefs = PreferenciasUsuario();

  // Future<void> configuracionInicial() async {
  //   await _localDB.openBox().then((iniciado) {
  //     if (iniciado) {
  //       //comprobacionRacha();
  //       comprobacionDia();
  //     }
  //   });
  // }

  Future<void> crearColecciones() async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        print('longitud de Colecciones ${Colecciones.colecciones.length}');
        for (var i = 0; i < Colecciones.colecciones.length; i++) {
          _localDB.setColecciones(Colecciones.colecciones[i], false);
        }
        int _nColecciones = _localDB.getColecciones()!.length;
        print('TENES $_nColecciones COLECCIONES');
      }
    });
  }

  Future<void> abrirColecciones() async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        int _nColecciones = _localDB.getColecciones()!.length;
        //print('TENES $_nColecciones COLECCIONES');
      }
    });
  }

  Future<void> comprobacionColecciones() async {
    _dia = DateTime.now().day;
    _mes = DateTime.now().month;
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        for (var i = 0; i < Colecciones.colecciones.length - 1; i++) {
          if ((_dia == Colecciones.colecciones[i].dia) && (_mes == Colecciones.colecciones[i].mes)) {
            print('DESBLOQUEASTE LA COLECCION ${Colecciones.colecciones[i].titulo}');
            //setColeccion(i, Colecciones.colecciones[i], true);
            prefs.coleccionDesbloqueada = true;
            _coleccionDesbloqueada = true;
            _coleccion = Colecciones.colecciones[i];
            _localDB.setColeccionDesbloqueada(_coleccion!);
            notifyListeners();
          }
        }
      }
    });
  }

  Future<bool> getColeccionDesbloqueada() async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        //print('OBTENIENDO AVIONCITO DE HOY');
        _coleccion = await _localDB.getColeccionDesbloqueada()!.get(0);
        _coleccionDesbloqueada = true;
        notifyListeners();
      }
    });
    return true;
  }

  Future<bool> setColeccion(Coleccion coleccion, bool desbloqueado) async {
    _localDB.setColecciones(coleccion, desbloqueado);
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
    prefs.coleccionDesbloqueada = desbloqueado;
    notifyListeners();
  }
}
