import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalData {
  var initialized = false;
  Box? avioncitosBox;
  Box? diasBox;

  Future<bool> initLocalData() async {
    
    var path = await getApplicationDocumentsDirectory();
    if(!initialized){
      Hive.init(path.path);
      Hive.registerAdapter(AvioncitoAdapter());
      initialized = true;
      //Hive.registerAdapter(DiaAdapter());
    }
    
    avioncitosBox = await Hive.openBox('avioncitos');
    //diasBox = await Hive.openBox('dias');
    return true;
  }

  Box? getAvioncitos() {
    return avioncitosBox;
  }

  void actualizarAvioncito(int index, Avioncito avioncito) {
    avioncitosBox!.putAt(index, avioncito);
  }

  void setAvioncito(Avioncito avioncito) {
    avioncitosBox!.put(0, avioncito);
  }

  void deleteAvioncito(int index) {
    avioncitosBox!.deleteAt(index);
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

  void deleteData() {
    //avioncitosBox.clear();
    //diasBox.clear();
    Hive.deleteFromDisk();
    initialized = false;
  }

}