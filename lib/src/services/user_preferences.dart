import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static final UserPreferences _instance =
      new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del momento de las notificaciones
  int get momentoNotificaciones {
    return _prefs.getInt('momentoNotificaciones') ?? 9;
  }

  set momentoNotificaciones(int momento) {
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
  int? get ultimaConexion {
    return _prefs.getInt('ultimaConexion') ?? null;
  }

  set ultimaConexion(int? ultimaConexion) {
    _prefs.setInt('ultimaConexion', ultimaConexion!);
  }

  // GET y SET versionApp
  String? get versionApp {
    return _prefs.getString('versionApp') ?? '';
  }

  set versionApp(String? versionApp) {
    _prefs.setString('versionApp', versionApp!);
  }

  // GET y SET CambioVersion
  bool get cambioVersion {
    return _prefs.getBool('cambioVersion') ?? true;
  }

  set cambioVersion(bool cambioVersion) {
    _prefs.setBool('cambioVersion', cambioVersion);
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

  // GET y SET databaseIniciada
  bool get databaseIniciada {
    return _prefs.getBool('databaseIniciada') ?? false;
  }

  set databaseIniciada(bool iniciada) {
    _prefs.setBool('databaseIniciada', iniciada);
  }

  Future<bool> cleanPrefs() async {
    return _prefs.clear();
  }
}
