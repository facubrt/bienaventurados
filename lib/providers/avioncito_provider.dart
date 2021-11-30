import 'package:bienaventurados/data/local/local_db.dart';
import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/repositories/preferencias_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AvioncitoProvider with ChangeNotifier {
  late Avioncito _avioncito;
  List<Avioncito> _avioncitosGuardados = [];
  List<Avioncito> _avioncitos = [];
  // late int _dia;
  bool _avioncitoListo = false;
  bool _nuevoDia = false;
  String? _actualConexion;
  String? _ultimaConexion;
  late int nAvioncito;
  Box? avioncitosBox;

  final FirebaseFirestore _fireDB = FirebaseFirestore.instance;
  final LocalData _localDB = LocalData();

  void configuracionInicial() async {
    await _localDB.initLocalData().then((iniciado) {
      if (iniciado) {
        // int _diasRestantes = DateTime(DateTime.now().year + 1, 1, 1, 0, 0).difference(DateTime.now()).inDays;
        // print('DIAS RESTANTES PARA FIN DE AÑO $_diasRestantes');
        // _dia = DateTime.now().difference(DateTime(DateTime.now().year + 1, 1, 1, 0, 0)).inDays;
        // _dia = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1, 0, 0)).inDays;
        // print('HOY ES EL DIA $_dia');
        // _localDB.avioncitosBox!.clear();
        // _localDB.hoyBox!.clear();
        comprobacionDia();
      }
    });
  }

  Future<void> comprobacionDia() async {
    final prefs = PreferenciasUsuario();
    _actualConexion = DateTime.now().day.toString();
    _ultimaConexion = prefs.ultimaConexion;
    if (_ultimaConexion != null) {
      if (_actualConexion == _ultimaConexion) {
        print('REUTILIZANDO AVIONCITO');
        await getAvioncitoHoy().then((listo) {
          if (listo) {
            _avioncitoListo = true;
            notifyListeners();
          }
        });
      } else {
        print('NUEVO DIA, NUEVO AVIONCITO!');
        prefs.ultimaConexion = _actualConexion;
        await getAvioncitoFromLocal().then((avioncitosListos) async {
          if (avioncitosListos) {
            print('AVIONCITOS LISTOS PARA NUEVO DIA');
            await getAvioncitoHoy().then((listo) {
              if (listo) {
                print('TODO LISTO');
                _avioncitoListo = true;
                notifyListeners();
              }
            });
          }
        });
      }
    } else {
      print('PRIMERA VEZ QUE SE INICIA LA APP');
      prefs.ultimaConexion = _actualConexion;
      await getAvioncitoFromLocal().then((avioncitosListos) async {
        if (avioncitosListos) {
          print('PRIMEROS AVIONCITOS LISTOS');
          await getAvioncitoHoy().then((listo) {
            if (listo) {
              print('TODO LISTO PRIMERA VEZ');
              _avioncitoListo = true;
              notifyListeners();
            }
          });
        } else {
          print('ERROR AL CARGAR PRIMER AVIONCITOS');
        }
      });
    }
  }

  Future<bool> getAvioncitoFromLocal() async {
    avioncitosBox = _localDB.getAvioncitos();
    print('HAY ${avioncitosBox!.length} AVIONCITOS EN LOCAL');
      // print('ENTRANDO EN TRY');
    if (avioncitosBox!.isEmpty) {
      print('NO QUEDAN AVIONCITOS LOCALES');
      await getAvioncitosFromFirestore().then((listo) {
        if (listo) {
          print('AVIONCITOS CARGADOS ${_avioncitos.length}');
          // nAvioncito = Random().nextInt(_avioncitos.length);
          _avioncito = _localDB.getAvioncitoHoy();
          _avioncito.fecha = DateTime.now();
          print('LA FRASE DE HOY ES ${_avioncito.frase}');
          _localDB.setHoy(_avioncito);
          // _localDB.deleteAvioncitoLocal(nAvioncito);
          _localDB.deleteAvioncitoHoy();
          print('SE ELIMINA AVIONCITO ${_avioncito.id}');
          print('AVIONCITOS RESTANTES ${_localDB.getAvioncitos()!.length}');
          return true;
        }
      });
    } else {
      print('LOCAL NO ESTÁ VACÍO');
      _avioncito = _localDB.getAvioncitoHoy();
      _avioncito.fecha = DateTime.now();
      _avioncito.visto = true;
      print('LA FRASE DE HOY ES ${_avioncito.frase}');
      
      _localDB.setHoy(_avioncito);
      _localDB.deleteAvioncitoHoy();
      print('SE ELIMINA AVIONCITO ${_avioncito.id}');
      print('AVIONCITOS RESTANTES ${_localDB.getAvioncitos()!.length}');
    }
    return true;  
  }

  Future<bool> getAvioncitosFromFirestore() async {
    print('CARGANDO AVIONCITOS DE FIRESTORE');
    _avioncitos.clear();
    bool retVal = false;
    await _fireDB.collection('datosApp').get().then((QuerySnapshot snapshot) async {
      print('${snapshot.docs.length} AVIONCITOS ENCONTRADOS EN FIRESTORE');
      int _diasRestantes = DateTime(DateTime.now().year + 1, 1, 1, 0, 0).difference(DateTime.now()).inDays;
      int _lenght = snapshot.docs.length;
      if (_diasRestantes < snapshot.docs.length) {
        print('DE ${snapshot.docs.length} SE CARGAN SOLO $_diasRestantes avioncitos');
        _lenght = _diasRestantes;
      }
      for (var i = 0; i < _lenght; i++) {
        Avioncito av = Avioncito.fromFirestore(snapshot.docs[i]);
        _avioncitos.add(av);
      }
      print('MEZCLANDO AVIONCITOS, PRIMER AVIONCITO ${_avioncitos[0].usuario}');
      _avioncitos.shuffle();
      _localDB.setAvioncitos(_avioncitos);
      print('AVIONCITOS AGREGADOS A LOCAL');
      retVal = true;
    });
    return retVal;
  }

  Future<bool> getAvioncitoHoy() async {
    print('OBTENIENDO AVIONCITO DE HOY');
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

  Avioncito? get avioncito => _avioncito;
  List<Avioncito> get avioncitosGuardados => _avioncitosGuardados;
  bool get avioncitoListo => _avioncitoListo;
  bool get nuevoDia => _nuevoDia;
  set setNuevoDia(bool estado) {
    _nuevoDia = estado;
  }
}
