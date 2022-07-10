import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

void connectionCheck(BuildContext context) async {
  int? connection;
  int? lastConnection;
  String? appVersion;
  final prefs = UserPreferences();

  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final paperplaneProvider =
      Provider.of<PaperplaneProvider>(context, listen: false);
  final collectionProvider =
      Provider.of<CollectionProvider>(context, listen: false);
  final achievementProvider =
      Provider.of<AchievementProvider>(context, listen: false);
  appVersion = await getAppVersion();
  connection = DateTime.now().day.toInt();
  lastConnection = prefs.lastConnection;

  if (lastConnection != null) {
    if (prefs.appVersion != appVersion) {
      print('INICIANDO MIGRACION DE USUARIO');
      await authProvider.migrateUserDB().then((result) {
        if (result) {
          print('USUARIOS MIGRADOS CORRECTAMENTE');
        } else {
          print('ERROR');
        }
      });
      // para evitar que se vuelva a ejecutar este bloque
      prefs.appVersion = appVersion;
    }

    if (connection == lastConnection) {
      print('MISMO DIA');
      await paperplaneProvider.isToday();
      await collectionProvider.getCollectibleUnlocked();
      achievementProvider.openAchievements();
      await collectionProvider.openCollectionsBox();
    } else {
      print('NUEVO DIA');
      final lastDay =
          DateTime(DateTime.now().year, DateTime.now().month, lastConnection);
      final newDay =
          DateTime(DateTime.now().year, DateTime.now().month, connection);
      if (lastDay.month == newDay.month || lastDay.month + 1 == newDay.month) {
        if (lastDay.day + 1 == newDay.day || 1 == newDay.day) {
          print('CONSTANCIA AUMENTADA');
          achievementProvider.achievementsCheck('constancia');
          authProvider.increaseConstancy = true;
        } else {
          print('CONSTANCIA RESTABLECIDA');
          achievementProvider.restoreConstancy();
          authProvider.restartConstancy = true;
        }
      }
      prefs.lastConnection = connection;
      await paperplaneProvider.isNewDay();
      collectionProvider.openCollectionsBox();
      achievementProvider.openAchievements();
      collectionProvider.collectionsCheck();
    }
  } else {
    print('PRIMERA VEZ');
    lastConnection = connection;
    prefs.lastConnection = connection;
    // para evitar que el codigo unico de cambio de version se ejecute en nuevos usuarios
    prefs.appVersion = await getAppVersion();
    await paperplaneProvider.firstTime();
    collectionProvider.getAllCollections();
    achievementProvider.initAchievements();
    collectionProvider.collectionsCheck();
    achievementProvider.achievementsCheck('primer-inicio');
  }
}
