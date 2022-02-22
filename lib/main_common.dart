import 'dart:convert';
import 'package:bienaventurados/src/core/app.dart';
import 'package:bienaventurados/src/core/app_config.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/auth_provider.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/logic/providers/compartir_provider.dart';
import 'package:bienaventurados/src/logic/providers/info_provider.dart';
import 'package:bienaventurados/src/logic/providers/logro_provider.dart';
import 'package:bienaventurados/src/logic/providers/theme_provider.dart';
import 'package:bienaventurados/src/logic/services/messaging_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

late bool _sesionIniciada;
Future<void> mainCommon(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  // statusbar transparente
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // orientacion vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  //await SystemChrome.setEnabledSystemUIOverlays([]); // fullscreen

  await Firebase.initializeApp();
  // simula una falla para Crashlytics
  //FirebaseCrashlytics.instance.crash();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  final localDB = new LocalData();
  await localDB.init();
  await localDB.openBox();
  _sesionIniciada = prefs.sesionIniciada;

  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => AuthProvider.instance(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) =>
            ThemeProvider(activarModoNoche: prefs.modoNoche),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => AvioncitoProvider(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => CompartirProvider(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => LogroProvider(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => ColeccionesProvider(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => InfoProvider()..cargarInfoApp(),
      ),
    ],
    child: Bienaventurados(config, _sesionIniciada),
  ));
}


