import 'dart:convert';
import 'package:bienaventurados/src/app_config.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/services/local_notifications.dart';
import 'package:bienaventurados/src/services/messaging_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bienaventurados extends StatefulWidget {
  final AppConfig config;
  Bienaventurados(this.config);

  @override
  _BienaventuradosState createState() => _BienaventuradosState();
}

class _BienaventuradosState extends State<Bienaventurados> {
  final prefs = UserPreferences();
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
    // if (prefs.momentoNotificaciones != 0) {
    //   print('NOTIFICACIONES A LAS 9AM');
    //   noti.scheduleDaily9AMNotification(prefs.momentoNotificaciones);
    // } else {
    //   noti.cancelAllNotification();
    // }
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
      title: TITLE_APP,
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme,
      initialRoute: prefs.isLoggedIn ? dashboardPage : bienaventuradosPage,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
