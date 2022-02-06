import 'package:bienaventurados/src/data/models/avioncito_model.dart';
import 'package:bienaventurados/src/data/models/coleccion_model.dart';
import 'package:bienaventurados/src/data/models/logro_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalData {
  var initialized = false;
  Box? avioncitosBox;
  Box? guardadosBox;
  Box? coleccionesBox;
  Box? logrosBox;
  Box? hoyBox;
  Box? coleccionDesbloqueadaBox;

  Future<bool> init() async {
    var path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AvioncitoAdapter());
      Hive.registerAdapter(ColeccionAdapter());
      Hive.registerAdapter(LogroAdapter());
    }
    return true;
  }

  Future<bool> openBox() async {
    avioncitosBox = await Hive.openBox<Avioncito>('avioncitos');
    guardadosBox = await Hive.openBox<Avioncito>('guardados');
    hoyBox = await Hive.openBox<Avioncito>('hoy');
    coleccionDesbloqueadaBox =
        await Hive.openBox<Coleccion>('coleccionDesbloqueadaBox');
    coleccionesBox = await Hive.openBox<Coleccion>('colecciones');
    logrosBox = await Hive.openBox<Logro>('logros');
    //diasBox = await Hive.openBox('dias');
    return true;
  }

  Box? getAvioncitos() {
    return avioncitosBox;
  }

  Avioncito getAvioncitoHoy() {
    return avioncitosBox!.getAt(avioncitosBox!.length - 1);
  }

  void deleteAvioncitoHoy() {
    avioncitosBox!.deleteAt(avioncitosBox!.length - 1);
  }

  Box? getHoy() {
    return hoyBox;
  }

  void setAvioncitoHoy(Avioncito avioncito) {
    Avioncito _avioncito = Avioncito(
      id: avioncito.id,
      fecha: avioncito.fecha,
      frase: avioncito.frase,
      santo: avioncito.santo,
      reflexion: avioncito.reflexion,
      tag: avioncito.tag,
      pregunta: avioncito.pregunta,
      mision: avioncito.mision,
      usuario: avioncito.usuario,
      guardado: avioncito.guardado,
      visto: avioncito.visto,
    );
    hoyBox!.put(0, _avioncito);
  }

  void setColeccionDesbloqueada(Coleccion coleccion) {
    Coleccion _coleccion = Coleccion(
      id: coleccion.id,
      dia: coleccion.dia,
      mes: coleccion.mes,
      titulo: coleccion.titulo,
      img: coleccion.img,
      descripcion: coleccion.descripcion,
      tipo: coleccion.tipo,
      desbloqueado: coleccion.desbloqueado,
    );
    coleccionDesbloqueadaBox!.put(0, _coleccion);
  }

  Box? getColeccionDesbloqueada() {
    return coleccionDesbloqueadaBox;
  }

  void actualizarAvioncito(int index, Avioncito avioncito) {
    avioncitosBox!.putAt(index, avioncito);
  }

  void guardarAvioncito(bool guardado) {
    Avioncito av = hoyBox!.get(0);
    av.guardado = guardado;
    hoyBox!.putAt(0, av);
  }

  void setAvioncito(Avioncito avioncito) {
    avioncitosBox!.put(0, avioncito);
  }

  void deleteAvioncito(int index) {
    avioncitosBox!.deleteAt(index);
  }

  Box? getGuardados() {
    return guardadosBox;
  }

  void setGuardados(String? id, Avioncito avioncito) {
    //guardadosBox!.putAt(index, avioncitoGuardado);
    Avioncito _avioncito = Avioncito(
      id: avioncito.id,
      fecha: avioncito.fecha,
      frase: avioncito.frase,
      santo: avioncito.santo,
      reflexion: avioncito.reflexion,
      tag: avioncito.tag,
      pregunta: avioncito.pregunta,
      mision: avioncito.mision,
      usuario: avioncito.usuario,
      guardado: avioncito.guardado,
      visto: avioncito.visto,
    );
    guardadosBox!.put(id, _avioncito);
  }

  void deleteGuardado(String? id) {
    guardadosBox!.delete(id);
    //guardadosBox!.deleteAt(index);
  }

  // COLECCIONES
  Box? getColecciones() {
    return coleccionesBox;
  }

  void setColecciones(Coleccion coleccion, bool desbloqueado) {
    Coleccion _coleccion = Coleccion(
      id: coleccion.id,
      dia: coleccion.dia,
      mes: coleccion.mes,
      titulo: coleccion.titulo,
      img: coleccion.img,
      descripcion: coleccion.descripcion,
      tipo: coleccion.tipo,
      desbloqueado: desbloqueado,
    );
    coleccionesBox!.put(_coleccion.id, _coleccion);
  }
  //

  void deleteAvioncitoLocal(int index) {
    avioncitosBox!.delete(index);
  }

  // void actualizarDia(String key, Dia? dia) {
  //   diasBox!.put(key, dia);
  // }

  // Box? getDias(){
  //   return diasBox;
  // }

  void setAvioncitos(List<Avioncito> avioncitos) {
    Iterable<Avioncito> _avioncitos = avioncitos;
    avioncitosBox!.addAll(_avioncitos);
  }

  // void setDia(String key, Dia? dia) {
  //   diasBox!.put(key, dia);
  // }

  // void setMes(List<Dia> mes) {
  //   diasBox!.addAll(mes);
  // }

  void avioncitoVisto(int index, Avioncito avioncito) {
    // marcar avioncito visto para que no vuelva a utilizarse
  }

  Future<void> deleteData() async {
    // avioncitosBox.close();
    // avioncitosBox!.clear();
    // guardadosBox!.clear();
    Hive.deleteBoxFromDisk('avioncitosBox');
    Hive.deleteBoxFromDisk('guardadosBox');
    Hive.deleteBoxFromDisk('hoyBox');
    Hive.deleteBoxFromDisk('coleccionesBox');
    Hive.deleteBoxFromDisk('logrosBox');
    Hive.deleteFromDisk();
    initialized = false;
  }
}
