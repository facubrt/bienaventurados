import 'dart:convert';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/auth_provider.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/logic/providers/compartir_provider.dart';
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
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent)); // statusbar transparente
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]); // orientacion vertical
  //await SystemChrome.setEnabledSystemUIOverlays([]); // fullscreen

  await Firebase.initializeApp();
  //FirebaseCrashlytics.instance.crash(); // simula una falla para Crashlytics

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  final localDB = new LocalData();
  await localDB.init();
  await localDB.openBox();
  _sesionIniciada = prefs.sesionIniciada;
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) => AuthProvider.instance(),),
      ChangeNotifierProvider(create: (BuildContext context) => ThemeProvider(activarModoNoche: prefs.modoNoche)),
      ChangeNotifierProvider(create: (BuildContext context) => AvioncitoProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => CompartirProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => LogroProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => ColeccionesProvider()),
    ],
    child: Bienaventurados(),
  ));
}

class Bienaventurados extends StatefulWidget {
  @override
  _BienaventuradosState createState() => _BienaventuradosState();
}

class _BienaventuradosState extends State<Bienaventurados> {
  void _firebaseCrash() async {
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }

  @override
  void initState() {
    _firebaseCrash();
    MessagingService.initialize(onSelectNotification).then((value) => firebaseCloudMessagingListeners(),);
    super.initState();
  }

  void firebaseCloudMessagingListeners() async {
    MessagingService.onMessage.listen(MessagingService.invokeLocalNotification);
    MessagingService.onMessageOpenedApp.listen(_pageOpenForOnLaunch);
  }

  _pageOpenForOnLaunch(RemoteMessage remoteMessage) {
    final Map<String, dynamic> message = remoteMessage.data;
    onSelectNotification(jsonEncode(message));
  }

  Future onSelectNotification(String? payload) async {
    print(payload);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Ser Eucaristía',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme,
      initialRoute: _sesionIniciada
        ? dashboardPage
        : bienaventuradosPage, //basePage : bienaventuradosPage,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
