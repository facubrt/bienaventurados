
abstract class IPreferenciasUsuario {
  Future<void> initPrefs();
  Future<bool> limpiarPrefs();
}