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
              //setLogro(logro, true);
              actualizarLogro(logro);
            }
            break;
          case 'constancia':
            constancia(box);
            break;
          case 'guardados':
            Logro logro = box!.getAt(4);
            if (logro.desbloqueado) {
              logro = box.getAt(5);
              if (logro.desbloqueado) {
                logro = box.getAt(6);
                if (logro.desbloqueado) {
                  break;
                } else {
                  actualizarLogro(logro);
                  break;
                }
              } else {
                actualizarLogro(logro);
                break;
              }
            }
            actualizarLogro(logro);
            break;
          case 'calificar-app':
            Logro logro = box!.getAt(7);
            if (logro.desbloqueado) {
              print('LOGRO YA DESBLOQUEADO');
            } else {
              print('LOGRO NO DESBLOQUEADO');
              //setLogro(logro, true);
              actualizarLogro(logro);
            }
            break;
          case 'compartidos':
            print('LOGRO COMPARTIDOS');
            Logro logro = box!.getAt(8);
            if (logro.desbloqueado) {
              print('PRIMERA VEZ DESBLOQUEADO');
              logro = box.getAt(9);
              if (logro.desbloqueado) {
                print('SEGUNDA VEZ DESBLOQUEADO');
                logro = box.getAt(10);
                if (logro.desbloqueado) {
                  print('TERCERA VEZ DESBLOQUEADO');
                  break;
                } else {
                  actualizarLogro(logro);
                  break;
                }
              } else {
                actualizarLogro(logro);
                break;
              }
            }
            actualizarLogro(logro);
            break;
          case 'compartir-app':
            Logro logro = box!.getAt(11);
            if (logro.desbloqueado) {
              print('LOGRO YA DESBLOQUEADO');
            } else {
              print('LOGRO NO DESBLOQUEADO');
              //setLogro(logro, true);
              actualizarLogro(logro);
            }
            break;
          case 'construidos':
            Logro logro = box!.getAt(12);
            if (logro.desbloqueado) {
              logro = box.getAt(13);
              if (logro.desbloqueado) {
                logro = box.getAt(14);
                if (logro.desbloqueado) {
                  break;
                } else {
                  actualizarLogro(logro);
                  break;
                }
              } else {
                actualizarLogro(logro);
                break;
              }
            }
            actualizarLogro(logro);
            break;
          case 'modo-noche':
            Logro logro = box!.getAt(15);
            if (logro.desbloqueado) {
              print('LOGRO YA DESBLOQUEADO');
            } else {
              print('LOGRO NO DESBLOQUEADO');
              //setLogro(logro, true);
              actualizarLogro(logro);
            }
            break;
        }
      }
    });
  }

  void constancia(Box? box) {
    Logro logro = box!.getAt(1);
    if (logro.desbloqueado) {
      print('PRIMERA VEZ DESBLOQUEADO');
      logro = box.getAt(2);
      if (logro.desbloqueado) {
        print('SEGUNDA VEZ DESBLOQUEADO');
        logro = box.getAt(3);
        if (logro.desbloqueado) {
          print('TERCERA VEZ DESBLOQUEADO');
        }
      }
    }
    logro.n += 1;
    print('ACCION REALIZADA ${logro.n}');
    actualizarLogro(logro);
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

  void actualizarLogro(Logro logro) {
    if (logro.n == logro.maximo) {
      setLogro(logro, true);
      mostrarMensaje(logro);
    } else {
      setLogro(logro, false);
    }
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
