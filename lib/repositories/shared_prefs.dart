import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static void guardarPrefs(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else {
      print('Invalid Type');
    }
  }

  static Future<bool> consultarPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<dynamic> obtenerPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static Future<bool> eliminarPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> limpiarPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}

