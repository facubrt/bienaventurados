import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/services/messaging_service.dart';
import 'package:bienaventurados/src/logic/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class Bienaventurados extends StatefulWidget {
  @override
  _BienaventuradosState createState() => _BienaventuradosState();
}

class _BienaventuradosState extends State<Bienaventurados> {

  void _firebaseCrash() async {
    if (kDebugMode) {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(true);
    }
  }

  @override
  void initState() {
    _firebaseCrash();
    MessagingService.initialize(onSelectNotification).then(
      (value) => firebaseCloudMessagingListeners(),
    );
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
    final prefs = PreferenciasUsuario();
    return MaterialApp(
      title: 'Ser Eucaristía',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme,
      initialRoute: prefs.sesionIniciada ? dashboardPage : bienaventuradosPage, //basePage : bienaventuradosPage,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}