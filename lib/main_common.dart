import 'package:bienaventurados/src/app.dart';
import 'package:bienaventurados/src/app_config.dart';
import 'package:bienaventurados/src/data/local/local_db.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> mainCommon(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  // statusbar transparente
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // orientacion vertical
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //await SystemChrome.setEnabledSystemUIOverlays([]); // fullscreen

  await Firebase.initializeApp();
  // simula una falla para Crashlytics
  //FirebaseCrashlytics.instance.crash();

  final prefs = new UserPreferences();
  await prefs.initPrefs();
  final localDB = new LocalData();
  await localDB.init();
  await localDB.openBox();

  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthProvider.instance(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider(activarModoNoche: prefs.darkMode),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => PaperplaneProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ShareProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => AchievementProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CollectionProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => DrawerProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (BuildContext context) => InfoProvider()..cargarInfoApp(),
        // ),
      ],
      child: Bienaventurados(config),
    ),
  );
}
