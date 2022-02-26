import 'dart:convert';
import 'package:bienaventurados/src/core/app_config.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/providers.dart';
import 'package:bienaventurados/src/logic/providers/theme_provider.dart';
import 'package:bienaventurados/src/logic/services/local_notifications.dart';
import 'package:bienaventurados/src/logic/services/messaging_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bienaventurados extends StatefulWidget {
  final AppConfig config;
  final bool _sesionIniciada;
  Bienaventurados(this.config, this._sesionIniciada);

  @override
  _BienaventuradosState createState() => _BienaventuradosState();
}

class _BienaventuradosState extends State<Bienaventurados> {
  final prefs = PreferenciasUsuario();
  int? _actualConexion;
  int? _ultimaConexion;
  String? _versionApp;
  bool _coleccionDesbloqueada = false;
  final LocalNotifications noti = LocalNotifications();

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
    MessagingService.initialize(onSelectNotification).then(
      (value) => firebaseCloudMessagingListeners(),
    );
    noti.init();
    if (prefs.momentoNotificaciones != 0) {
      print('NOTIFICACIONES A LAS 9AM');
      noti.scheduleDaily9AMNotification(prefs.momentoNotificaciones);
    } else {
      noti.cancelAllNotification();
    }
    comprobacionDia();
    super.initState();
  }

  void comprobacionDia() async {
    //final infoProvider = Provider.of<InfoProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context, listen: false);
    final coleccionesProvider = Provider.of<ColeccionesProvider>(context, listen: false);
    final logroProvider = Provider.of<LogroProvider>(context, listen: false);
    _actualConexion = DateTime.now().day.toInt();
    _ultimaConexion = prefs.ultimaConexion;
    _versionApp = prefs.versionApp;
    //print(_versionApp);
    if (_ultimaConexion != null) {
      if (_actualConexion == _ultimaConexion) {
        print('MISMO DIA');
        _coleccionDesbloqueada = prefs.coleccionDesbloqueada;
        await avioncitoProvider.mismoAvioncito();
        await coleccionesProvider.getColeccionDesbloqueada();
        logroProvider.abrirLogros();
        await coleccionesProvider.abrirColecciones();
        //authProvider.actualizarConstancia(); // PARA PROBAR CONSTANCIA
      } else {
        print('NUEVO DIA');
        //authProvider.updateUserData();
        //infoProvider.actualizarInformacionApp('restaurar');
        final ultimoDia = DateTime(DateTime.now().year, DateTime.now().month, _ultimaConexion!);
        final nuevoDia = DateTime(DateTime.now().year, DateTime.now().month, _actualConexion!);
        if (ultimoDia.month == nuevoDia.month || ultimoDia.month + 1 == nuevoDia.month) {
          if (ultimoDia.day + 1 == nuevoDia.day || 1 == nuevoDia.day) {
            //print('CONSTANCIA AUMENTADA');
            logroProvider.comprobacionLogros('constancia');
            authProvider.actualizarConstancia();
          } else {
            //print('CONSTANCIA RESTABLECIDA');
            logroProvider.restablecerConstancia();
            authProvider.constanciaRestablecida = true;
          }
        }
        prefs.ultimaConexion = _actualConexion;
        await avioncitoProvider.nuevoAvioncito();
        coleccionesProvider.abrirColecciones();
        logroProvider.abrirLogros();
        coleccionesProvider.comprobacionColecciones();
      }
    } else {
      print('PRIMERA VEZ');
      prefs.ultimaConexion = _actualConexion;
      await avioncitoProvider.primerInicio();
      coleccionesProvider.crearColecciones();
      logroProvider.iniciarLogros();
      coleccionesProvider.comprobacionColecciones();
      logroProvider.comprobacionLogros('Primer Inicio');
    }
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
      initialRoute: widget._sesionIniciada ? dashboardPage : bienaventuradosPage,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
