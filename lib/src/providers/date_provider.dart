import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:flutter/cupertino.dart';

class DateProvider with ChangeNotifier {
  int? _conection;
  int? _lastConection;
  String? _versionApp;

  void comprobacionDia() async {
    final prefs = UserPreferences();
    _conection = DateTime.now().day.toInt();
    _lastConection = prefs.ultimaConexion;
    _versionApp = prefs.versionApp;
    if (_versionApp != '1.4.1') {
      prefs.versionApp = '1.4.1';
      _versionApp = prefs.versionApp;
      print('ESTAS USANDO LA VERSION $_versionApp');
      //logroProvider.iniciarLogros();
    }
    //print(_versionApp);
    if (_lastConection != null) {
      if (_conection == _lastConection) {
        print('MISMO DIA');
      } else {
        print('NUEVO DIA');
        final lastDate = DateTime(DateTime.now().year, DateTime.now().month, _lastConection!);
        final date = DateTime(DateTime.now().year, DateTime.now().month, _conection!);
        if (lastDate.month == date.month || lastDate.month + 1 == date.month) {
          if (lastDate.day + 1 == date.day || 1 == date.day) {
            print('CONSTANCIA AUMENTADA');
          } else {
            print('CONSTANCIA RESTABLECIDA');
          }
        }
        prefs.ultimaConexion = _conection;
      }
    } else {
      print('PRIMERA VEZ');
      prefs.ultimaConexion = _conection;
    }
  }
}
