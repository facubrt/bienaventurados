import 'package:bienaventurados/src/models/paperplane_model.dart';
import 'package:bienaventurados/src/models/coleccion_model.dart';
import 'package:bienaventurados/src/models/logro_model.dart';
import 'package:bienaventurados/src/models/local_user_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalData {
  var initialized = false;
  Box? paperplanesBox;
  Box? savedBox;
  Box? coleccionesBox;
  Box? logrosBox;
  Box? todayBox;
  Box? coleccionDesbloqueadaBox;
  Box? userBox;

  Future<bool> init() async {
    var path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PaperplaneAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ColeccionAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(LogroAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(LocalUserAdapter());
    }
    return true;
  }

  Future<bool> openBox() async {
    paperplanesBox = await Hive.openBox<Paperplane>('paperplanes');
    savedBox = await Hive.openBox<Paperplane>('saved');
    todayBox = await Hive.openBox<Paperplane>('today');
    coleccionDesbloqueadaBox =
        await Hive.openBox<Coleccion>('coleccionDesbloqueadaBox');
    coleccionesBox = await Hive.openBox<Coleccion>('colecciones');
    logrosBox = await Hive.openBox<Logro>('logros');
    userBox = await Hive.openBox<LocalUser>('user');
    //diasBox = await Hive.openBox('dias');
    return true;
  }

  Box? getPaperplanes() {
    return paperplanesBox;
  }

  Paperplane getTodayPaperplane() {
    return paperplanesBox!.getAt(paperplanesBox!.length - 1);
  }

  void deleteTodayPaperplane() {
    paperplanesBox!.deleteAt(paperplanesBox!.length - 1);
  }

  Box? getHoy() {
    return todayBox;
  }

  void setTodayPaperplane(Paperplane paperplane) {
    Paperplane _paperplane = Paperplane(
      id: paperplane.id,
      date: paperplane.date,
      quote: paperplane.quote,
      source: paperplane.source,
      inspiration: paperplane.inspiration,
      category: paperplane.category,
      user: paperplane.user,
      likes: paperplane.likes,
      saved: paperplane.saved,
      background: paperplane.background,
      base: paperplane.base,
      detail: paperplane.detail,
      pattern: paperplane.pattern,
      stamp: paperplane.stamp,
      wings: paperplane.wings,
    );
    todayBox!.put(0, _paperplane);
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

  void updatePaperplane(int index, Paperplane paperplane) {
    paperplanesBox!.putAt(index, paperplane);
  }

  void savePaperplane(bool isSaved) {
    Paperplane paperplane = todayBox!.get(0);
    paperplane.saved = isSaved;
    todayBox!.putAt(0, paperplane);
  }

  void setPaperplane(Paperplane paperplane) {
    paperplanesBox!.put(0, paperplane);
  }

  void deletePaperplane(int index) {
    paperplanesBox!.deleteAt(index);
  }

  Box? getSavedPaperplanes() {
    return savedBox;
  }

  void setSavedPaperplanes(String? id, Paperplane paperplane) {
    //guardadosBox!.putAt(index, avioncitoGuardado);
    Paperplane _paperplane = Paperplane(
      id: paperplane.id,
      date: paperplane.date,
      quote: paperplane.quote,
      source: paperplane.source,
      inspiration: paperplane.inspiration,
      category: paperplane.category,
      user: paperplane.user,
      likes: paperplane.likes,
      saved: paperplane.saved,
      background: paperplane.background,
      base: paperplane.base,
      detail: paperplane.detail,
      pattern: paperplane.pattern,
      stamp: paperplane.stamp,
      wings: paperplane.wings,
    );
    savedBox!.put(id, _paperplane);
  }

  void deleteGuardado(String? id) {
    savedBox!.delete(id);
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

  // LOGROS
  Box? getLogros() {
    return logrosBox;
  }

  void setLogro(Logro logro, bool desbloqueado) {
    Logro _logro = Logro(
      id: logro.id,
      titulo: logro.titulo,
      objetivo: logro.objetivo,
      img: logro.img,
      descripcion: logro.descripcion,
      n: logro.n,
      maximo: logro.maximo,
      desbloqueado: desbloqueado,
    );
    logrosBox!.put(_logro.id, _logro);
  }

  // USUARIO
  Box? getUser() {
    return userBox;
  }

  void setUser(LocalUser user) {
    LocalUser _user = LocalUser(
      uid: user.uid,
      username: user.username,
      email: user.email,
      role: user.role,
      type: user.type,
      level: user.level,
      totalXP: user.totalXP,
      action: user.action,
      formation: user.formation,
      devotion: user.devotion,
      prayer: user.prayer,
      pplanesBuilded: user.pplanesBuilded,
      pplanesShared: user.pplanesShared,
      constancy: user.constancy,
      bestConstancy: user.bestConstancy,
      firstConnection: user.firstConnection,
      lastConnection: user.lastConnection,
    );
    userBox!.put(0, _user);
  }

  void deleteAvioncitoLocal(int index) {
    paperplanesBox!.delete(index);
  }

  // void actualizarDia(String key, Dia? dia) {
  //   diasBox!.put(key, dia);
  // }

  // Box? getDias(){
  //   return diasBox;
  // }

  void setAvioncitos(List<Paperplane> avioncitos) {
    Iterable<Paperplane> _paperplanes = avioncitos;
    paperplanesBox!.addAll(_paperplanes);
  }

  // void setDia(String key, Dia? dia) {
  //   diasBox!.put(key, dia);
  // }

  // void setMes(List<Dia> mes) {
  //   diasBox!.addAll(mes);
  // }

  // void avioncitoVisto(int index, Avioncito avioncito) {
  //   // marcar avioncito base para que no vuelva a utilizarse
  // }

  Future<void> deleteAndMigrate() async {
    Hive.deleteBoxFromDisk('paperplanesBox');
    Hive.deleteBoxFromDisk('usuarioBox');
    print('DATOS AVIONCITOS Y USUARIO ELIMINADOS');
  }

  Future<void> deleteData() async {
    print('DATOS ELIMINADOS');
    Hive.deleteBoxFromDisk('paperplanesBox');
    Hive.deleteBoxFromDisk('guardadosBox');
    Hive.deleteBoxFromDisk('hoyBox');
    Hive.deleteBoxFromDisk('coleccionesBox');
    Hive.deleteBoxFromDisk('logrosBox');
    Hive.deleteBoxFromDisk('usuarioBox');
    Hive.deleteFromDisk();
    initialized = false;
  }
}
