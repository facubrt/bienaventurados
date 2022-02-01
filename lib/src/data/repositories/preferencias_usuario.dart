import 'package:bienaventurados/src/domain/repositories/ipreferencias_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario extends IPreferenciasUsuario {

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

  // GET y SET imagenPerfil
  int get imagenPerfil {
    return _prefs.getInt('imagenPerfil') ?? 0;
  }

  set imagenPerfil(int imagenPerfil) {
    _prefs.setInt('imagenPerfil', imagenPerfil);
  }

  // GET y SET coleccionDesbloqueada
  bool get coleccionDesbloqueada {
    return _prefs.getBool('coleccionDesbloqueada') ?? false;
  }

  set coleccionDesbloqueada(bool desbloqueada) {
    _prefs.setBool('coleccionDesbloqueada', desbloqueada);
  }
  Future<bool> limpiarPrefs() async {
    return _prefs.clear();
  }

}