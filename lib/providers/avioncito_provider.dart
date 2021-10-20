import 'dart:math';
import 'package:bienaventurados/data/local/local_db.dart';
import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bienaventurados/repositories/shared_prefs.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AvioncitoProvider with ChangeNotifier {
  late Avioncito _avioncito;
  late Avioncito _avioncitoGuardado;
  List<Avioncito> _avioncitosGuardados = [];
  late int _dia;
  bool _avioncitoListo = false;
  bool _nuevoDia = false;
  String? _actualConexion;
  String? _ultimaConexion;

  final FirebaseFirestore _fireDB = FirebaseFirestore.instance;
  final LocalData _localDB = LocalData();

  void configuracionInicial() async {
    await _localDB.initLocalData().then((iniciado) {
      if(iniciado){
        _dia = DateTime.now().difference(DateTime(DateTime.now().year,1,1,0,0)).inDays;
        comprobacionDia();
     }
    });
  }

  Future<void> comprobacionDia() async {
    
    _actualConexion = DateTime.now().day.toString();
    _ultimaConexion = await (SharedPrefs.obtenerPrefs('ultimaConexion'));
    print('ultima conexion el dia $_ultimaConexion');
    if (_ultimaConexion != null) {
      if (_actualConexion != _ultimaConexion) {
        print('REUTILIZANDO AVIONCITO DE HOY');
        //getAvioncitosFromLocal();
        
        await getAvioncitoHoy().then((listo) {
          if(listo){
            _avioncitoListo = true;
            notifyListeners();
          }
        });
      } else {
        print('es un dia nuevo!');
        SharedPrefs.guardarPrefs('ultimaConexion', _actualConexion);
        getAvioncitosFromFirestore().then((avioncitosListos) {
          if(avioncitosListos){
            
            print('AVIONCITOS LISTOS');
            _localDB.actualizarAvioncito(0, _avioncito);
          } else {
                print('ERROR AL CARGAR AVIONCITOS');
          }    
        });
      } 
    } else {
      print('PRIMERA VEZ QUE SE INICIA LA APP');
      SharedPrefs.guardarPrefs('ultimaConexion', _actualConexion);
      getAvioncitosFromFirestore().then((avioncitosListos) {
        if(avioncitosListos){
          print('AVIONCITOS LISTOS');
          _avioncitoListo = true;
          _localDB.setAvioncito(_avioncito);
          notifyListeners();
        } else {
          print('ERROR AL CARGAR AVIONCITOS');
        }
      });
    }
  }

  Future<bool> getAvioncitosFromFirestore() async {
    bool retVal = false;
    await _fireDB.collection('datosApp').get().then((QuerySnapshot snapshot) async {
      int n = Random().nextInt(snapshot.docs.length);
      for (var i= 0; i < snapshot.docs.length; i++) {
        _avioncito = Avioncito.fromFirestore(snapshot.docs[n]);
        _avioncito.fecha = DateTime.now();
      }
      print('AVIONCITOS LISTOS');
      retVal = true;
      _avioncitoListo = true;
      notifyListeners();
    });
    return retVal;
  }

  Future<bool> getAvioncitosFromLocal() async {
    bool retVal = false;
    // await DB.avioncitos().then((avioncitos) {
    //   print(avioncitos.length);
    //   _avioncito = avioncitos[0];
    //   print(_avioncito!.frase);
    //   retVal = true;
    // });
    return retVal;
  }

  // Future<bool> getAvioncitosUsuariosFromFirestore() async {
  //   bool retVal = false;
  //   await _fireDB.collection('datosUsuarios').get().then((QuerySnapshot snapshot) async {
  //     for (var i= 0; i < snapshot.docs.length; i++) {
  //       _avioncito = Avioncito.fromFirestore(snapshot.docs[n]);
  //     }
  //     print('AVIONCITOS LISTOS');
  //     retVal = true;
  //     _avioncitoListo = true;
  //     notifyListeners();
  //   });
  //   return retVal;
  // }

  Future<bool> getAvioncitoHoy() async {
    _avioncito = await _localDB.getAvioncitos()!.get(0);
    return true;
  }

  // Future<bool> getGuardadosFromLocal() async {
  //   for (var i= 0; i < _localDB.guardadosBox!.length; i++) {
  //     Guardados av = _localDB.guardadosBox!.getAt(i);
  //     _avioncitosGuardados.add(av);
  //   }
  //   return true;
  // }
    Box getGuardadosFromLocal() {
    return _localDB.guardadosBox!;
  }

  Future<bool> guardarAvioncito() async {
    _localDB.guardarAvioncito(true);
    _avioncitoGuardado = Avioncito(id: _avioncito.id, fecha: _avioncito.fecha, frase: _avioncito.frase, santo: _avioncito.santo, reflexion: _avioncito.reflexion, tag: _avioncito.tag, guardado: true, visto: true);
    print('Guardado el avioncito ${_avioncito.id}');
    _localDB.setGuardados(_avioncito.id, _avioncitoGuardado);
    print(_localDB.guardadosBox!.length);
    notifyListeners();
    return true;
  }

  Future<bool> noGuardarAvioncito(String id) async {
    _localDB.guardarAvioncito(false);
    _localDB.deleteGuardado(id);
    print('Borrado el avioncito $id');
    print(_localDB.guardadosBox!.length);
    notifyListeners();
    return true;
  }

  Future<bool> eliminarDB() async {
    await _localDB.deleteData();
    print('Database eliminada');
    return true;
  }

  Avioncito? get avioncito => _avioncito;
  List<Avioncito> get avioncitosGuardados => _avioncitosGuardados;
  bool get avioncitoListo => _avioncitoListo;
  bool get nuevoDia => _nuevoDia;
  set setNuevoDia(bool estado) {
    _nuevoDia = estado;
  }

}