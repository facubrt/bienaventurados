import 'package:bienaventurados/src/core/theme/colores.dart';
import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/datasources/local/logros_data.dart';
import 'package:bienaventurados/src/data/models/logro_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LogroProvider with ChangeNotifier {
  final LocalData _localDB = LocalData();

  Future<void> iniciarLogros() async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        print('longitud de LOGROS ${Logros.logros.length}');
        for (var i = 0; i < Logros.logros.length; i++) {
          _localDB.setLogro(Logros.logros[i], false);
        }
        int _nLogros = _localDB.getLogros()!.length;
        print('TENES $_nLogros LOGROS');
      }
    });
  }

  Future<bool> setLogro(Logro logro, bool desbloqueado) async {
    _localDB.setLogro(logro, desbloqueado);
    notifyListeners();
    return true;
  }

  Future<void> comprobacionLogros(String titulo) async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        Box? box = _localDB.getLogros();
        switch (titulo) {
          case 'Primer Inicio':
            Logro logro = box!.getAt(0);
            if (logro.desbloqueado) {
              print('LOGRO YA DESBLOQUEADO');
            } else {
              print('LOGRO NO DESBLOQUEADO');
              setLogro(logro, true);
              mostrarMensaje(logro);
            }
            break;
          case 'constancia':
            break;
          case 'guardados':
            Logro logro = box!.getAt(4);
            if (!logro.desbloqueado) {
              actualizarLogro(titulo);
            }
            break;
        }
      }
    });
  }

  Future<void> abrirLogros() async {
    await _localDB.openBox().then((iniciado) async {
      if (iniciado) {
        int _nLogros = _localDB.getLogros()!.length;
        print('TENES $_nLogros LOGROS');
      }
    });
  }

  Box getLogros() {
    return _localDB.logrosBox!;
  }

  void actualizarLogro(String logro) {
    // ACA ABRIR BOX CONTADOR. VER CUANTO TIENE
    // SI TIENE SUFICIENTE, DESBLOQUEAR LOGRO. SINO AUMENTAR
  }

  void mostrarMensaje(Logro logro) {
    Fluttertoast.showToast(
        msg: "¡Felicidades! Has desbloqueado ${logro.titulo}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colores.acento,
        textColor: Colores.primarioDay,
        fontSize: 14.0);
  }

  //void desbloquearLogro(String logro) {}

  //void reiniciarLogros(String logro) {}
}
