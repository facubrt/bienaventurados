import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/models/guardados_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalData {
  var initialized = false;
  Box? avioncitosBox;
  Box? guardadosBox;

  Future<bool> initLocalData() async {
    
    var path = await getApplicationDocumentsDirectory();
    if(!initialized){
      Hive.init(path.path);
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(AvioncitoAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(GuardadosAdapter());
      }
      
      initialized = true;
      //Hive.registerAdapter(DiaAdapter());
    }
    
    avioncitosBox = await Hive.openBox('avioncitos');
    guardadosBox = await Hive.openBox('guardados');
    //diasBox = await Hive.openBox('dias');
    return true;
  }

  Box? getAvioncitos() {
    return avioncitosBox;
  }

  void actualizarAvioncito(int index, Avioncito avioncito) {
    avioncitosBox!.putAt(index, avioncito);
  }

  void guardarAvioncito(bool guardado) {
    Avioncito av = avioncitosBox!.get(0);
    av.guardado = guardado;
    avioncitosBox!.putAt(0, av);
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

  void setGuardados(String? id, Guardados avioncitoGuardado) {
    //guardadosBox!.putAt(index, avioncitoGuardado);
    guardadosBox!.put(id, avioncitoGuardado);
  }

  void deleteGuardado(String? id) {
    guardadosBox!.delete(id);
    //guardadosBox!.deleteAt(index);
  }

  // void actualizarDia(String key, Dia? dia) {
  //   diasBox!.put(key, dia);
  // }

  // Box? getDias(){
  //   return diasBox;
  // }

  // void setAvioncitos(List<Avioncito?> avioncitos) {
  //   avioncitosBox!.addAll(avioncitos);
  // }

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
    Hive.deleteFromDisk();
    initialized = false;
  }

}