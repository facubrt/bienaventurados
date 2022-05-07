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
  int get notificationsHour {
    return _prefs.getInt('momentoNotificaciones') ?? 9;
  }

  set notificationsHour(int momento) {
    _prefs.setInt('momentoNotificaciones', momento);
  }

  // GET y SET del tema
  bool get darkMode {
    return _prefs.getBool('modoNoche') ?? false;
  }

  set darkMode(bool mode) {
    _prefs.setBool('modoNoche', mode);
  }

  // GET y SET de sesionIniciada

  bool get isLoggedIn {
    return _prefs.getBool('sesionIniciada') ?? false;
  }

  set isLoggedIn(bool isLoggedIn) {
    _prefs.setBool('sesionIniciada', isLoggedIn);
  }

  // GET y SET ultimaConexion
  int? get lastConnection {
    return _prefs.getInt('ultimaConexion') ?? null;
  }

  set lastConnection(int? lastConnection) {
    _prefs.setInt('ultimaConexion', lastConnection!);
  }

  // GET y SET versionApp
  String? get appVersion {
    return _prefs.getString('versionApp') ?? '';
  }

  set appVersion(String? appVersion) {
    _prefs.setString('versionApp', appVersion!);
  }

  // GET y SET imagenPerfil
  int get imgProfile {
    return _prefs.getInt('imagenPerfil') ?? 0;
  }

  set imgProfile(int imgProfile) {
    _prefs.setInt('imagenPerfil', imgProfile);
  }

  // GET y SET coleccionDesbloqueada
  bool get collectionUnlocked {
    return _prefs.getBool('coleccionDesbloqueada') ?? false;
  }

  set collectionUnlocked(bool unlocked) {
    _prefs.setBool('coleccionDesbloqueada', unlocked);
  }

  Future<bool> cleanPrefs() async {
    return _prefs.clear();
  }
}
