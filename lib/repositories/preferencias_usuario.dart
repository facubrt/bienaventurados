import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:
  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...
*/

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del momento de las notificaciones
  int get momentoNotificaciones {
    return _prefs.getInt('momentoNotificaciones') ?? 9;
  }

  set momentoNotificaciones( int momento ) {
    _prefs.setInt('momentoNotificaciones', momento);
  }
  

  // GET y SET del tema
  bool get modoNoche {
    return _prefs.getBool('modoNoche') ?? false;
  }

  set modoNoche(bool modo) {
    _prefs.setBool('modoNoche', modo);
  }

  // GET y SET de sesionIniciada

  bool get sesionIniciada {
    return _prefs.getBool('sesionIniciada') ?? false;
  }

  set sesionIniciada(bool sesionIniciada) {
    _prefs.setBool('sesionIniciada', sesionIniciada);
  }

  // GET y SET ultimaConexion
  String? get ultimaConexion {
    return _prefs.getString('ultimaConexion') ?? null;
  }

  set ultimaConexion(String? ultimaConexion) {
    _prefs.setString('ultimaConexion', ultimaConexion!);
  }

  Future<bool> limpiarPrefs() async {
    return _prefs.clear();
  }

}